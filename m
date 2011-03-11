From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] [BUILTIN] Fix corruption of reads with byte 0x81
Date: Fri, 11 Mar 2011 11:40:52 +0800
Message-ID: <20110311034052.GB17646@gondor.apana.org.au>
References: <4D5C4EE2.9060504@gmail.com> <4D664470.7070707@gmail.com> <20110310130145.GF10824@gondor.apana.org.au> <20110311000425.GA64385@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:39275 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752833Ab1CKDk7 (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 10 Mar 2011 22:40:59 -0500
Content-Disposition: inline
In-Reply-To: <20110311000425.GA64385@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, dash@vger.kernel.org

On Fri, Mar 11, 2011 at 01:04:25AM +0100, Jilles Tjoelker wrote:
>
> That is not how ifsbreakup() works. As I have written in FreeBSD sh
> expand.c:

Thanks for catching this.  The following patch should fix it.
 
> Apart from that, there is corruption with byte 0x88, CTLQUOTEMARK. I
> think that can be fixed in the same way by prefixing with CTLESC.

And this too.

> By the way, in the data pointed to by NARG nodes, dash does use CTLESC
> for backslashed characters that should not be IFS splitting points,
> which is only relevant for WORD in ${VAR+WORD} and ${VAR-WORD}. A
> downside of this is that quoted and unquoted CTL* bytes cannot be
> distinguished; therefore I have solved this differently in FreeBSD.

Good point.  Please do let us know how you think we should fix this.

commit 6e1c8399e82c015f4e9d7d67e98d70541a3ef2d0
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Fri Mar 11 11:07:42 2011 +0800

    [BUILTIN] Fix backslash handling in read(1)
    
    The new read(1) implementation incorrectly assumes that ifsbreakup
    ignores characters escaped by CTLESC.  As such it fails to handle
    backslashes except for escaping newlines.
    
    This patch makes it use recordregion for every part that isn't
    escaped by a backslash.
    
    Reported-by: Jilles Tjoelker <jilles@stack.nl>
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 8a832bb..e96bdc4 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2011-03-11  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Fix backslash handling in read(1).
+
 2011-03-10  Jonathan Nieder <jrnieder@gmail.com>
 
 	* Dotcmd should exit with zero when doing nothing.
diff --git a/src/expand.c b/src/expand.c
index 6bee5c5..7a9b157 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -1597,7 +1597,6 @@ char *
 _rmescapes(char *str, int flag)
 {
 	char *p, *q, *r;
-	static const char qchars[] = { CTLESC, CTLQUOTEMARK, 0 };
 	unsigned inquotes;
 	int notescaped;
 	int globbing;
diff --git a/src/miscbltin.c b/src/miscbltin.c
index 800cbbb..f507381 100644
--- a/src/miscbltin.c
+++ b/src/miscbltin.c
@@ -71,21 +71,22 @@
  *  @param len length of line including trailing '\0'
  */
 static void
-readcmd_handle_line(char *line, char **ap, size_t len)
+readcmd_handle_line(char *s, char **ap)
 {
 	struct arglist arglist;
 	struct strlist *sl;
-	char *s, *backup;
+	char *backup;
+	char *line;
 
 	/* ifsbreakup will fiddle with stack region... */
-	s = grabstackstr(line + len);
+	line = stackblock();
+	s = grabstackstr(s);
 
 	/* need a copy, so that delimiters aren't lost
 	 * in case there are more fields than variables */
 	backup = sstrdup(line);
 
 	arglist.lastp = &arglist.list;
-	recordregion(0, len - 1, 0);
 	
 	ifsbreakup(s, &arglist);
 	*arglist.lastp = NULL;
@@ -137,11 +138,12 @@ int
 readcmd(int argc, char **argv)
 {
 	char **ap;
-	int backslash;
 	char c;
 	int rflag;
 	char *prompt;
 	char *p;
+	int startloc;
+	int newloc;
 	int status;
 	int i;
 
@@ -161,9 +163,12 @@ readcmd(int argc, char **argv)
 	}
 	if (*(ap = argptr) == NULL)
 		sh_error("arg count");
+
 	status = 0;
-	backslash = 0;
 	STARTSTACKSTR(p);
+
+	goto start;
+
 	for (;;) {
 		switch (read(0, &c, 1)) {
 		case 1:
@@ -178,26 +183,35 @@ readcmd(int argc, char **argv)
 		}
 		if (c == '\0')
 			continue;
-		if (backslash || c == CTLESC) {
+		if (newloc >= startloc) {
 			if (c == '\n')
 				goto resetbs;
-			STPUTC(CTLESC, p);
 			goto put;
 		}
 		if (!rflag && c == '\\') {
-			backslash++;
+			newloc = p - (char *)stackblock();
 			continue;
 		}
 		if (c == '\n')
 			break;
 put:
-		STPUTC(c, p);
+		CHECKSTRSPACE(2, p);
+		if (strchr(qchars, c))
+			USTPUTC(CTLESC, p);
+		USTPUTC(c, p);
+
+		if (newloc >= startloc) {
 resetbs:
-		backslash = 0;
+			recordregion(startloc, newloc, 0);
+start:
+			startloc = p - (char *)stackblock();
+			newloc = startloc - 1;
+		}
 	}
 out:
+	recordregion(startloc, p - (char *)stackblock(), 0);
 	STACKSTRNUL(p);
-	readcmd_handle_line(stackblock(), ap, p + 1 - (char *)stackblock());
+	readcmd_handle_line(p + 1, ap);
 	return status;
 }
 
diff --git a/src/mystring.c b/src/mystring.c
index ce48c82..bbb6b77 100644
--- a/src/mystring.c
+++ b/src/mystring.c
@@ -62,6 +62,7 @@ const char spcstr[] = " ";
 const char snlfmt[] = "%s\n";
 const char dolatstr[] = { CTLQUOTEMARK, CTLVAR, VSNORMAL, '@', '=',
 			  CTLQUOTEMARK, '\0' };
+const char qchars[] = { CTLESC, CTLQUOTEMARK, 0 };
 const char illnum[] = "Illegal number: %s";
 const char homestr[] = "HOME";
 
diff --git a/src/mystring.h b/src/mystring.h
index 2e0540a..3522523 100644
--- a/src/mystring.h
+++ b/src/mystring.h
@@ -41,6 +41,7 @@ extern const char snlfmt[];
 extern const char spcstr[];
 extern const char dolatstr[];
 #define DOLATSTRLEN 6
+extern const char qchars[];
 extern const char illnum[];
 extern const char homestr[];
 
Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
