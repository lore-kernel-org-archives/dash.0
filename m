From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: "command -p" does not correctly limit search to a safe PATH
Date: Fri, 19 Jul 2013 23:49:31 +0200
Message-ID: <51E9B46B.10401@gigawatt.nl>
References: <CAL=-wemDL=2-7Rco761LTgGrFeAA_-zvz0ECpk4xZE7QJsGUEg@mail.gmail.com> <51E30212.3030901@gigawatt.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080102090707030906080204"
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter.csv-networks.nl ([84.244.149.121]:38818 "EHLO
	mailfilter.csv-networks.nl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751027Ab3GSVtr (ORCPT
	<rfc822;dash@vger.kernel.org>); Fri, 19 Jul 2013 17:49:47 -0400
In-Reply-To: <51E30212.3030901@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Craig Loomis <cploomis@gmail.com>, dash <dash@vger.kernel.org>

This is a multi-part message in MIME format.
--------------080102090707030906080204
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/07/13 21:54, Harald van Dijk wrote:
> On 10/07/13 20:18, Craig Loomis wrote:
>>   Dash (0.5.7 and git master) does not implement 'command -p'
>> according to the standard, and opens an intriguing security hole to
>> anyone trying this scheme.
>>[...]
>> the path that 'command -p cmd' uses is a compiled-in constant
>> from dash's src/var.c:defpathvar, which starts with
>> "/usr/local/sbin:/usr/local/bin".

So, how about this, to be applied on top of my previous patch? It
defaults to using confstr() if available and reporting a hard error at
run time if that fails, but it can be configured to not use confstr(),
and/or fall back to a path specified at configuration time:

Use confstr() only, fail to configure if confstr is unavailable, fail at
runtime if confstr() does not return any path:
  configure --enable-confstr

Use confstr(), fail to configure if confstr is unavailable, fall back to
/usr/bin:/bin if confstr() does not return any path:
  configure --enable-confstr \
    --with-fallback-standard-path='"/usr/bin:/bin"'

Use confstr() if available, use /usr/bin:/bin if confstr() is
unavailable or does not return any path:
  configure \
    --with-fallback-standard-path='"/usr/bin:/bin"'

Do no use confstr(), always use /usr/bin:/bin:
  configure --disable-confstr \
    --with-fallback-standard-path='"/usr/bin:/bin"'

Feedback welcome, there are several parts of this that I am not sure
about. Also, defpathvar is no longer used outside of var.c, so I made it
static and removed the references in var.h.

Cheers,
Harald

--------------080102090707030906080204
Content-Type: text/x-patch;
 name="dash-confstr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dash-confstr.patch"

commit 008118857bdb34ea885d76cbddbb56290706dcd2
Author: Harald van Dijk <harald@gigawatt.nl>
Date:   Fri Jul 19 23:29:55 2013 +0200

    command: use confstr() for -p to get a safe path

diff --git a/configure.ac b/configure.ac
index c6fb401..e595e99 100644
--- a/configure.ac
+++ b/configure.ac
@@ -40,6 +40,36 @@ AC_ARG_ENABLE(fnmatch, AS_HELP_STRING(--enable-fnmatch, \
 				      [Use fnmatch(3) from libc]))
 AC_ARG_ENABLE(glob, AS_HELP_STRING(--enable-glob, [Use glob(3) from libc]))
 
+AC_ARG_ENABLE([confstr],
+[AS_HELP_STRING([--enable-confstr], [Use confstr(3) from libc (default=auto)])],,
+[enable_confstr=auto])
+
+if test x"$enable_confstr" != x"no"; then
+	have_confstr=no
+	AC_CHECK_FUNCS([confstr],[have_confstr=yes])
+	have_decl_confstr=no
+	AC_CHECK_DECL([confstr],[have_decl_confstr=yes
+	AC_DEFINE([HAVE_DECL_CONFSTR], [1], [Define as 1 if you have a declaration of confstr()])])
+	have_decl_cs_path=no
+	AC_CHECK_DECL([_CS_PATH],[have_decl_cs_path=yes
+	AC_DEFINE([HAVE_DECL_CS_PATH], [1], [Define as 1 if you have a declaration of _CS_PATH])])
+
+	if test "$have_confstr:$have_decl_confstr:$have_decl_cs_path" != "yes:yes:yes"; then
+		if test x"$enable_confstr" = x"yes"; then
+			AC_MSG_ERROR([cannot use confstr])
+		fi
+	fi
+fi
+
+AC_ARG_WITH([fallback-standard-path],
+[AS_HELP_STRING([--with-fallback-standard-path=\"ARG\"],
+[use ARG for command -p path lookups if confstr does not return anything (default: none)])],,
+[with_fallback_standard_path=no])
+
+if test x"$with_fallback_standard_path" != x"no"; then
+	AC_DEFINE_UNQUOTED([FALLBACK_STANDARD_PATH], [$with_fallback_standard_path], [Define to the path to use for command -p path lookups (ignored if confstr() is used)])
+fi
+
 dnl Checks for libraries.
 
 dnl Checks for header files.
diff --git a/src/eval.c b/src/eval.c
index c7358a6..1dba165 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -644,7 +644,7 @@ parse_command_args(char **argv, const char **path)
 		do {
 			switch (c) {
 			case 'p':
-				*path = defpath;
+				*path = stdpath();
 				break;
 			default:
 				/* run 'typecmd' for other options */
diff --git a/src/exec.c b/src/exec.c
index e56e3f6..e32d48e 100644
--- a/src/exec.c
+++ b/src/exec.c
@@ -848,7 +848,7 @@ commandcmd(argc, argv)
 		else if (c == 'v')
 			verify |= VERIFY_BRIEF;
 		else if (c == 'p')
-			path = defpath;
+			path = stdpath();
 #ifdef DEBUG
 		else
 			abort();
@@ -860,3 +860,32 @@ commandcmd(argc, argv)
 
 	return 0;
 }
+
+const char *
+stdpath(void)
+{
+	static const char *path = NULL;
+
+#if HAVE_CONFSTR && HAVE_DECL_CONFSTR && HAVE_DECL_CS_PATH
+	if (path == NULL) {
+		size_t size = confstr(_CS_PATH, NULL, 0);
+		if (size != 0) {
+			char *newpath = ckmalloc(size);
+			confstr(_CS_PATH, newpath, size);
+			path = newpath;
+		}
+	}
+#endif
+
+#ifdef FALLBACK_STANDARD_PATH
+	if (path == NULL) {
+		path = FALLBACK_STANDARD_PATH;
+	}
+#endif
+
+	if (path == NULL) {
+		exerror(EXEXIT, "%s", "no path for standard utilities");
+	}
+
+	return path;
+}
diff --git a/src/exec.h b/src/exec.h
index 9ccb305..a3f9314 100644
--- a/src/exec.h
+++ b/src/exec.h
@@ -75,3 +75,4 @@ void defun(union node *);
 void unsetfunc(const char *);
 int typecmd(int, char **);
 int commandcmd(int, char **);
+const char *stdpath(void);
diff --git a/src/var.c b/src/var.c
index dc90249..653ba5b 100644
--- a/src/var.c
+++ b/src/var.c
@@ -73,7 +73,7 @@ struct localvar_list {
 
 MKINIT struct localvar_list *localvar_stack;
 
-const char defpathvar[] =
+static const char defpathvar[] =
 	"PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin";
 #ifdef IFS_BROKEN
 const char defifsvar[] = "IFS= \t\n";
diff --git a/src/var.h b/src/var.h
index 79ee71a..71b85c9 100644
--- a/src/var.h
+++ b/src/var.h
@@ -106,8 +106,6 @@ extern const char defifsvar[];
 #else
 extern const char defifs[];
 #endif
-extern const char defpathvar[];
-#define defpath (defpathvar + 5)
 
 extern int lineno;
 extern char linenovar[];

--------------080102090707030906080204--
