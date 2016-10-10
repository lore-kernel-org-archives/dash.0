From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: dash tested against ash testsuite: 17 failures
Date: Mon, 10 Oct 2016 22:20:07 +0200
Message-ID: <503584db-0131-3264-397e-0bc784eed58d@gigawatt.nl>
References: <CAK1hOcMma=uH2R=vWX1Z6r2xf9PcW7MPSEPYOk76Zn97LD-7Jw@mail.gmail.com>
 <7d291bb2-a968-471d-d2a0-87adfd0bc38d@inlv.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------A40A70E4B58CBDCB1B24AE14"
Return-path: <dash-owner@vger.kernel.org>
Received: from home.gigawatt.nl ([83.163.3.213]:54174 "EHLO home.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751821AbcJJU1V (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 10 Oct 2016 16:27:21 -0400
In-Reply-To: <7d291bb2-a968-471d-d2a0-87adfd0bc38d@inlv.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Martijn Dekker <martijn@inlv.org>, dash@vger.kernel.org

This is a multi-part message in MIME format.
--------------A40A70E4B58CBDCB1B24AE14
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/10/16 21:42, Martijn Dekker wrote:
> Op 01-10-16 om 19:17 schreef Denys Vlasenko:
>> ash-vars/var_unbackslash.tests
>
> ITYM ash-vars/var_unbackslash1.tests
>
>>     echo Forty two:$\
>>     (\
>>     (\
>>     42\
>>     )\
>>     )
>>     dash says: Syntax error: Missing '))'
>
> Yes, but it's not clear to me that it shouldn't.
>
> Hmm... maybe this is indeed a bug:
> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_02_01
> "A <backslash> that is not quoted shall preserve the literal value of
> the following character, with the exception of a <newline>. If a
> <newline> follows the <backslash>, the shell shall interpret this as
> line continuation. The <backslash> and <newline> shall be removed before
> splitting the input into tokens. Since the escaped <newline> is removed
> entirely from the input and is not replaced by any white space, it
> cannot serve as a token separator."
>
> So, unless I'm misreading this, it looks like backslashes need to be
> parsed before *any* other kind of lexical analysis.

There does appear to be one exception: a comment may end with a 
backslash. This does not cause the next line to be treated as a comment: 
once a # is seen, the remaining characters on the line are not subjected 
to the regular lexical analysis, so the above does not apply.

I would have expected another exception to be in alias expansions that 
end in a backslash. Shells are not entirely in agreement there, but most 
appear to treat this the regular way, meaning

   dash -c 'alias bs=\\
   bs
   '

prints nothing.

dash has a pgetc_eatbnl function already in parser.c which skips any 
backslash-newline combinations. It's not used everywhere it could be. 
There is also some duplicated backslash-newline handling elsewhere in 
parser.c. Replacing all the calls to pgetc() to call pgetc_eatbnl() 
instead, with the exception of the one that handles comments, and 
removing the duplicated backslash-newline handling, lets this test case 
work, as well as several other similar ones, such as:

   : &\
   & :

   : \
   <\
   <\
   EO\
   F
   123
   E\
   OF

A nice benefit is that the removal of the duplicated BSNL handling 
causes a reduction in code size.

There are probably a few corner cases I'm not handling correctly in this 
patch, though. Feedback welcome.

Cheers,
Harald van Dijk

--------------A40A70E4B58CBDCB1B24AE14
Content-Type: text/x-patch;
 name="parser-bnl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="parser-bnl.patch"

--- a/src/parser.c
+++ b/src/parser.c
@@ -106,6 +106,7 @@ STATIC void parseheredoc(void);
 STATIC int peektoken(void);
 STATIC int readtoken(void);
 STATIC int xxreadtoken(void);
+STATIC int pgetc_eatbnl();
 STATIC int readtoken1(int, char const *, char *, int);
 STATIC void synexpect(int) __attribute__((__noreturn__));
 STATIC void synerror(const char *) __attribute__((__noreturn__));
@@ -656,7 +657,7 @@ parseheredoc(void)
 		if (needprompt) {
 			setprompt(2);
 		}
-		readtoken1(pgetc(), here->here->type == NHERE? SQSYNTAX : DQSYNTAX,
+		readtoken1(pgetc_eatbnl(), here->here->type == NHERE? SQSYNTAX : DQSYNTAX,
 				here->eofmark, here->striptabs);
 		n = (union node *)stalloc(sizeof (struct narg));
 		n->narg.type = NARG;
@@ -782,7 +783,7 @@ xxreadtoken(void)
 		setprompt(2);
 	}
 	for (;;) {	/* until token or start of word found */
-		c = pgetc();
+		c = pgetc_eatbnl();
 		switch (c) {
 		case ' ': case '\t':
 		case PEOA:
@@ -791,30 +792,23 @@ xxreadtoken(void)
 			while ((c = pgetc()) != '\n' && c != PEOF);
 			pungetc();
 			continue;
-		case '\\':
-			if (pgetc() == '\n') {
-				nlprompt();
-				continue;
-			}
-			pungetc();
-			goto breakloop;
 		case '\n':
 			nlnoprompt();
 			RETURN(TNL);
 		case PEOF:
 			RETURN(TEOF);
 		case '&':
-			if (pgetc() == '&')
+			if (pgetc_eatbnl() == '&')
 				RETURN(TAND);
 			pungetc();
 			RETURN(TBACKGND);
 		case '|':
-			if (pgetc() == '|')
+			if (pgetc_eatbnl() == '|')
 				RETURN(TOR);
 			pungetc();
 			RETURN(TPIPE);
 		case ';':
-			if (pgetc() == ';')
+			if (pgetc_eatbnl() == ';')
 				RETURN(TENDCASE);
 			pungetc();
 			RETURN(TSEMI);
@@ -822,11 +816,9 @@ xxreadtoken(void)
 			RETURN(TLP);
 		case ')':
 			RETURN(TRP);
-		default:
-			goto breakloop;
 		}
+		break;
 	}
-breakloop:
 	return readtoken1(c, BASESYNTAX, (char *)NULL, 0);
 #undef RETURN
 }
@@ -903,7 +895,7 @@ readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
 			attyline();
 			if (syntax == BASESYNTAX)
 				return readtoken();
-			c = pgetc();
+			c = pgetc_eatbnl();
 			goto loop;
 		}
 #endif
@@ -916,7 +908,7 @@ readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
 					goto endword;	/* exit outer loop */
 				USTPUTC(c, out);
 				nlprompt();
-				c = pgetc();
+				c = pgetc_eatbnl();
 				goto loop;		/* continue outer loop */
 			case CWORD:
 				USTPUTC(c, out);
@@ -997,7 +989,7 @@ quotemark:
 					USTPUTC(c, out);
 					--parenlevel;
 				} else {
-					if (pgetc() == ')') {
+					if (pgetc_eatbnl() == ')') {
 						USTPUTC(CTLENDARI, out);
 						if (!--arinest)
 							syntax = prevsyntax;
@@ -1025,7 +1017,7 @@ quotemark:
 					USTPUTC(c, out);
 				}
 			}
-			c = pgetc();
+			c = pgetc_eatbnl();
 		}
 	}
 endword:
@@ -1132,7 +1124,7 @@ parseredir: {
 	np = (union node *)stalloc(sizeof (struct nfile));
 	if (c == '>') {
 		np->nfile.fd = 1;
-		c = pgetc();
+		c = pgetc_eatbnl();
 		if (c == '>')
 			np->type = NAPPEND;
 		else if (c == '|')
@@ -1145,7 +1137,7 @@ parseredir: {
 		}
 	} else {	/* c == '<' */
 		np->nfile.fd = 0;
-		switch (c = pgetc()) {
+		switch (c = pgetc_eatbnl()) {
 		case '<':
 			if (sizeof (struct nfile) != sizeof (struct nhere)) {
 				np = (union node *)stalloc(sizeof (struct nhere));
@@ -1154,7 +1146,7 @@ parseredir: {
 			np->type = NHERE;
 			heredoc = (struct heredoc *)stalloc(sizeof (struct heredoc));
 			heredoc->here = np;
-			if ((c = pgetc()) == '-') {
+			if ((c = pgetc_eatbnl()) == '-') {
 				heredoc->striptabs = 1;
 			} else {
 				heredoc->striptabs = 0;
@@ -1336,21 +1328,12 @@ parsebackq: {
 			if (needprompt) {
 				setprompt(2);
 			}
-			switch (pc = pgetc()) {
+			switch (pc = pgetc_eatbnl()) {
 			case '`':
 				goto done;
 
 			case '\\':
-                                if ((pc = pgetc()) == '\n') {
-					nlprompt();
-					/*
-					 * If eating a newline, avoid putting
-					 * the newline into the new character
-					 * stream (via the STPUTC after the
-					 * switch).
-					 */
-					continue;
-				}
+                                pc = pgetc_eatbnl();
                                 if (pc != '\\' && pc != '`' && pc != '$'
                                     && (!dblquote || pc != '"'))
                                         STPUTC('\\', pout);
@@ -1529,7 +1512,7 @@ expandstr(const char *ps)
 	saveprompt = doprompt;
 	doprompt = 0;
 
-	readtoken1(pgetc(), DQSYNTAX, FAKEEOFMARK, 0);
+	readtoken1(pgetc_eatbnl(), DQSYNTAX, FAKEEOFMARK, 0);
 
 	doprompt = saveprompt;
 

--------------A40A70E4B58CBDCB1B24AE14--
