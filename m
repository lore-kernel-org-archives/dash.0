From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Line continuation and variables
Date: Mon, 29 Sep 2014 22:55:07 +0800
Message-ID: <20140929145507.GA3670@gondor.apana.org.au>
References: <1554581409055304@web13g.yandex.ru>
 <53FC7EE2.7000309@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:36636 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbaI2OzQ (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 29 Sep 2014 10:55:16 -0400
Content-Disposition: inline
In-Reply-To: <53FC7EE2.7000309@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: Oleg Bulatov <oleg@bulatov.me>, dash@vger.kernel.org

On Tue, Aug 26, 2014 at 12:34:42PM +0000, Eric Blake wrote:
> On 08/26/2014 06:15 AM, Oleg Bulatov wrote:
> > Hi!
> > 
> > While playing with sh generators I found that dash and bash have different
> > interpretations for <slash><newline> sequence.
> > 
> > $ dash -c 'EDIT=xxx; echo $EDIT\
> >> OR'
> > xxxOR
> 
> Buggy.
> 
> > $ bash -c 'EDIT=xxx; echo $EDIT\
> > OR'
> > /usr/bin/vim
> 
> Correct behavior.
> 
> > 
> > $ dash -c 'echo "$\
> > (pwd)"'
> > $(pwd)
> > 
> > Is it undefined behaviour in POSIX?
> 
> No, it's well-defined, and dash is buggy.  POSIX says:
> 
> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_03
> 
> "the shell shall break its input into tokens by applying the first
> applicable rule below to the next character in its input"
> 
> Rule 4 covers backslash handling, while rule 5 covers locating the end
> of a word to be subject to $ expansion.  Therefore, rule 4 should happen
> first.  Rule 4 defers to the section on quoting, with the caveat that
> <newline> joining is the only substitution that happens immediately as
> part of the parsing:
> 
> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_02
> 
> "If a <newline> follows the <backslash>, the shell shall interpret this
> as line continuation. The <backslash> and <newline> shall be removed
> before splitting the input into tokens. Since the escaped <newline> is
> removed entirely from the input and is not replaced by any white space,
> it cannot serve as a token separator."
> 
> So the fact that dash is treating the elided backslash-newline as a
> token separator, and parsing your input as if ${EDIT}OR instead of
> ${EDITOR} is a bug in dash.

I agree.  The following patch should fix this:

commit ef91d3d6a4c39421fd3a391e02cd82f9f3aee4a8
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Mon Sep 29 22:52:41 2014 +0800

    [PARSER] Handle backslash newlines properly after dollar sign
    
    On Tue, Aug 26, 2014 at 12:34:42PM +0000, Eric Blake wrote:
    > On 08/26/2014 06:15 AM, Oleg Bulatov wrote:
    > > Hi!
    > >
    > > While playing with sh generators I found that dash and bash have different
    > > interpretations for <slash><newline> sequence.
    > >
    > > $ dash -c 'EDIT=xxx; echo $EDIT\
    > >> OR'
    > > xxxOR
    >
    > Buggy.
    >
    > > $ bash -c 'EDIT=xxx; echo $EDIT\
    > > OR'
    > > /usr/bin/vim
    >
    > Correct behavior.
    >
    > >
    > > $ dash -c 'echo "$\
    > > (pwd)"'
    > > $(pwd)
    > >
    > > Is it undefined behaviour in POSIX?
    >
    > No, it's well-defined, and dash is buggy.  POSIX says:
    >
    > http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_03
    >
    > "the shell shall break its input into tokens by applying the first
    > applicable rule below to the next character in its input"
    >
    > Rule 4 covers backslash handling, while rule 5 covers locating the end
    > of a word to be subject to $ expansion.  Therefore, rule 4 should happen
    > first.  Rule 4 defers to the section on quoting, with the caveat that
    > <newline> joining is the only substitution that happens immediately as
    > part of the parsing:
    >
    > http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_02
    >
    > "If a <newline> follows the <backslash>, the shell shall interpret this
    > as line continuation. The <backslash> and <newline> shall be removed
    > before splitting the input into tokens. Since the escaped <newline> is
    > removed entirely from the input and is not replaced by any white space,
    > it cannot serve as a token separator."
    >
    > So the fact that dash is treating the elided backslash-newline as a
    > token separator, and parsing your input as if ${EDIT}OR instead of
    > ${EDITOR} is a bug in dash.
    
    I agree.  This patch should resolve this problem and similar ones
    affecting blackslash newlines after we encounter a dollar sign.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 0fbc514..398bd15 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,6 +1,7 @@
 2014-09-29  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Kill pgetc_macro.
+	* Handle backslash newlines properly after dollar sign.
 
 2014-09-28  Herbert Xu <herbert@gondor.apana.org.au>
 
diff --git a/src/parser.c b/src/parser.c
index c4eaae2..2b07437 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -827,6 +827,24 @@ breakloop:
 #undef RETURN
 }
 
+static int pgetc_eatbnl(void)
+{
+	int c;
+
+	while ((c = pgetc()) == '\\') {
+		if (pgetc() != '\n') {
+			pungetc();
+			break;
+		}
+
+		plinno++;
+		if (doprompt)
+			setprompt(2);
+	}
+
+	return c;
+}
+
 
 
 /*
@@ -1179,7 +1197,7 @@ parsesub: {
 	char *p;
 	static const char types[] = "}-+?=";
 
-	c = pgetc();
+	c = pgetc_eatbnl();
 	if (
 		(checkkwd & CHKEOFMARK) ||
 		c <= PEOA  ||
@@ -1188,7 +1206,7 @@ parsesub: {
 		USTPUTC('$', out);
 		pungetc();
 	} else if (c == '(') {	/* $(command) or $((arith)) */
-		if (pgetc() == '(') {
+		if (pgetc_eatbnl() == '(') {
 			PARSEARITH();
 		} else {
 			pungetc();
@@ -1200,25 +1218,25 @@ parsesub: {
 		STADJUST(1, out);
 		subtype = VSNORMAL;
 		if (likely(c == '{')) {
-			c = pgetc();
+			c = pgetc_eatbnl();
 			subtype = 0;
 		}
 varname:
 		if (is_name(c)) {
 			do {
 				STPUTC(c, out);
-				c = pgetc();
+				c = pgetc_eatbnl();
 			} while (is_in_name(c));
 		} else if (is_digit(c)) {
 			do {
 				STPUTC(c, out);
-				c = pgetc();
+				c = pgetc_eatbnl();
 			} while (is_digit(c));
 		}
 		else if (is_special(c)) {
 			int cc = c;
 
-			c = pgetc();
+			c = pgetc_eatbnl();
 
 			if (!subtype && cc == '#') {
 				subtype = VSLENGTH;
@@ -1227,7 +1245,7 @@ varname:
 					goto varname;
 
 				cc = c;
-				c = pgetc();
+				c = pgetc_eatbnl();
 				if (cc == '}' || c != '}') {
 					pungetc();
 					subtype = 0;
@@ -1245,7 +1263,7 @@ varname:
 			switch (c) {
 			case ':':
 				subtype = VSNUL;
-				c = pgetc();
+				c = pgetc_eatbnl();
 				/*FALLTHROUGH*/
 			default:
 				p = strchr(types, c);
@@ -1259,7 +1277,7 @@ varname:
 					int cc = c;
 					subtype = c == '#' ? VSTRIMLEFT :
 							     VSTRIMRIGHT;
-					c = pgetc();
+					c = pgetc_eatbnl();
 					if (c == cc)
 						subtype++;
 					else

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
