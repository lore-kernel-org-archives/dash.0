From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] [SHELL] Allow building without LINEO support.
Date: Tue, 16 Aug 2011 20:12:54 -0500
Message-ID: <20110817011235.GA22867@elie.gateway.2wire.net>
References: <20110816.174502.2209127983953431973.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42894 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543Ab1HQBNE (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 16 Aug 2011 21:13:04 -0400
Received: by yxj19 with SMTP id 19so400227yxj.19
        for <dash@vger.kernel.org>; Tue, 16 Aug 2011 18:13:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110816.174502.2209127983953431973.davem@davemloft.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: dash@vger.kernel.org, herbert@gondor.hengli.com.au

David Miller wrote:

> [Subject: [SHELL] Allow building without LINEO support.]

Thanks!  Debian has been using something like this (but unconditional)
to convince autoconf not to use dash as CONFIG_SHELL, to work around
bugs in various configure scripts[1].  I imagine other users might
want the same thing, so a patch like this seems like a good idea.

I think LINEO should be LINENO in the subject line.

[1] http://bugs.debian.org/582952

[...]
> --- a/configure.ac
> +++ b/configure.ac
> @@ -131,5 +131,10 @@ if test "$use_libedit" != "yes"; then
>  else
>  	export LIBS="$LIBS -ledit"
>  fi
> +AC_ARG_ENABLE(lineno, AS_HELP_STRING(--disable-lineno, \
> +				     [Disable LINENO support]))
> +if test "$enable_lineno" != "no"; then
> +	AC_DEFINE([WITH_LINENO], 1, [Define if you build with -DWITH_LINENO])
> +fi

This produces the following in config.h:

	/* Define if you build with -DWITH_LINENO */
	#define WITH_LINENO 1

Something like "Define if you want support for the LINENO variable"
might be a little more satisfying.

> --- a/src/var.c
> +++ b/src/var.c
> @@ -101,7 +101,9 @@ struct var varinit[] = {
>  	{ 0,	VSTRFIXED|VTEXTFIXED,		"PS2=> ",	0 },
>  	{ 0,	VSTRFIXED|VTEXTFIXED,		"PS4=+ ",	0 },
>  	{ 0,	VSTRFIXED|VTEXTFIXED,		"OPTIND=1",	getoptsreset },
> +#ifdef WITH_LINENO
>  	{ 0,	VSTRFIXED|VTEXTFIXED,		linenovar,	0 },
> +#endif
>  #ifndef SMALL
>  	{ 0,	VSTRFIXED|VTEXTFIXED|VUNSET,	"TERM\0",	0 },
[etc]

Makes sense.  The following on top trims away some code in the
!WITH_LINENO case, though it's kind of ugly.  Maybe something like

	#ifndef WITH_LINENO
	static void update_lineno(void) { }
	#else
	static void update_lineno(void)
	{
		lineno = errlinno;
		if (funcline)
			lineno -= funcline - 1;
	}
	#endif

would make it more palatable.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 src/eval.c |   25 ++++++++++++++++++++-----
 src/var.c  |    2 ++
 src/var.h  |    4 ++++
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/src/eval.c b/src/eval.c
index c7358a62..1184ff10 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -213,9 +213,12 @@ evaltree(union node *n, int flags)
 		status = !exitstatus;
 		goto setstatus;
 	case NREDIR:
-		errlinno = lineno = n->nredir.linno;
+		errlinno = n->nredir.linno;
+#ifdef WITH_LINENO
+		lineno = errlinno;
 		if (funcline)
 			lineno -= funcline - 1;
+#endif
 		expredir(n->nredir.redirect);
 		pushredir(n->nredir.redirect);
 		status = redirectsafe(n->nredir.redirect, REDIR_PUSH);
@@ -374,9 +377,12 @@ evalfor(union node *n, int flags)
 	struct strlist *sp;
 	struct stackmark smark;
 
-	errlinno = lineno = n->nfor.linno;
+	errlinno = n->nfor.linno;
+#ifdef WITH_LINENO
+	lineno = errlinno;
 	if (funcline)
 		lineno -= funcline - 1;
+#endif
 
 	setstackmark(&smark);
 	arglist.lastp = &arglist.list;
@@ -419,9 +425,12 @@ evalcase(union node *n, int flags)
 	struct arglist arglist;
 	struct stackmark smark;
 
-	errlinno = lineno = n->ncase.linno;
+	errlinno = n->ncase.linno;
+#ifdef WITH_LINNO
+	lineno = errlinno;
 	if (funcline)
 		lineno -= funcline - 1;
+#endif
 
 	setstackmark(&smark);
 	arglist.lastp = &arglist.list;
@@ -454,9 +463,12 @@ evalsubshell(union node *n, int flags)
 	int backgnd = (n->type == NBACKGND);
 	int status;
 
-	errlinno = lineno = n->nredir.linno;
+	errlinno = n->nredir.linno;
+#ifdef WITH_LINENO
+	lineno = errlinno;
 	if (funcline)
 		lineno -= funcline - 1;
+#endif
 
 	expredir(n->nredir.redirect);
 	if (!backgnd && flags & EV_EXIT && !have_traps())
@@ -689,9 +701,12 @@ evalcommand(union node *cmd, int flags)
 	int status;
 	char **nargv;
 
-	errlinno = lineno = cmd->ncmd.linno;
+	errlinno = cmd->ncmd.linno;
+#ifdef WITH_LINENO
+	lineno = errlinno;
 	if (funcline)
 		lineno -= funcline - 1;
+#endif
 
 	/* First expand the arguments. */
 	TRACE(("evalcommand(0x%lx, %d) called\n", (long)cmd, flags));
diff --git a/src/var.c b/src/var.c
index 027beff1..8e125701 100644
--- a/src/var.c
+++ b/src/var.c
@@ -81,8 +81,10 @@ const char defifsvar[] = "IFS= \t\n";
 const char defifs[] = " \t\n";
 #endif
 
+#ifdef WITH_LINENO
 int lineno;
 char linenovar[sizeof("LINENO=")+sizeof(int)*CHAR_BIT/3+1] = "LINENO=";
+#endif
 
 /* Some macros in var.h depend on the order, add new variables to the end. */
 struct var varinit[] = {
diff --git a/src/var.h b/src/var.h
index 79ee71a6..533ee0de 100644
--- a/src/var.h
+++ b/src/var.h
@@ -109,8 +109,10 @@ extern const char defifs[];
 extern const char defpathvar[];
 #define defpath (defpathvar + 5)
 
+#ifdef WITH_LINENO
 extern int lineno;
 extern char linenovar[];
+#endif
 
 /*
  * The following macros access the values of the above variables.
@@ -127,7 +129,9 @@ extern char linenovar[];
 #define ps2val()	(vps2.text + 4)
 #define ps4val()	(vps4.text + 4)
 #define optindval()	(voptind.text + 7)
+#ifdef WITH_LINENO
 #define linenoval()	(vlineno.text + 7)
+#endif
 #ifndef SMALL
 #define histsizeval()	(vhistsize.text + 9)
 #define termval()	(vterm.text + 5)
-- 
1.7.6

