From: Eric Blake <eblake@redhat.com>
Subject: [PATCH] [BUILTIN] cd: support drive letters on Cygwin
Date: Mon, 13 Oct 2014 12:59:17 -0600
Message-ID: <1413226757-4311-1-git-send-email-eblake@redhat.com>
Return-path: <dash-owner@vger.kernel.org>
Received: from resqmta-ch2-11v.sys.comcast.net ([69.252.207.43]:54194 "EHLO
	resqmta-ch2-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754326AbaJMTHf (ORCPT
	<rfc822;dash@vger.kernel.org>); Mon, 13 Oct 2014 15:07:35 -0400
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

The Cygwin platform supports DOS style drive-letter paths such
as "C:\\dir", even though the preferred form is a POSIX-style
"/cygdrive/c/dir".  This can be seen by doing things such as
chdir("c:") (which succeeds) followed by getcwd(NULL, 0) (which
returns the normalized "/cygdrive/c").  However, dash was trying
to perform local manipulations on the argument to 'cd' prior to
calling into libc, in order to update the state of $PWD and
friends; these manipulations were assuming that the user meant
to change to a relative subdirectory of the current location,
as in './c:', instead of honoring the drive letter.  None of
the other dash builtins take a filename and manipulate it to
affect shell state (some, like 'test', take a file name, but as
stat("c:") works just fine, there is no need to normalize).

This patch has no impact outside of cygwin; on cygwin, it takes
advantage of a native function call to canonicalize any
incoming name into preferred form before updating shell state.

Pre-patch:
$ dash -c 'cd c: && echo $PWD'
dash: 1: cd: can't cd to c:

Post-patch:
$ dash -c 'cd c: && echo $PWD'
/cygdrive/c

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 ChangeLog |  4 ++++
 src/cd.c  | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/ChangeLog b/ChangeLog
index a466a7f..a745fe7 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2014-10-13  Eric Blake  <eblake@redhat.com>
+
+	* cd: support drive letters on Cygwin.
+
 2014-09-26  Herbert Xu <herbert@gondor.apana.org.au>

 	* Small optimisation of command -pv change.
diff --git a/src/cd.c b/src/cd.c
index 2d9d4b5..a4e024d 100644
--- a/src/cd.c
+++ b/src/cd.c
@@ -38,6 +38,9 @@
 #include <string.h>
 #include <unistd.h>
 #include <limits.h>
+#ifdef __CYGWIN__
+#include <sys/cygwin.h>
+#endif

 /*
  * The cd and pwd commands.
@@ -194,6 +197,17 @@ updatepwd(const char *dir)
 	char *cdcomppath;
 	const char *lim;

+#ifdef __CYGWIN__
+	/* On cygwin, thanks to drive letters, some absolute paths do
+	   not begin with slash; but cygwin includes a function that
+	   forces normalization to the posix form */
+	char pathbuf[PATH_MAX];
+	if (cygwin_conv_path(CCP_WIN_A_TO_POSIX | CCP_RELATIVE, dir, pathbuf,
+			     sizeof(pathbuf)) < 0)
+		sh_error("can't normalize %s", dir);
+	dir = pathbuf;
+#endif
+
 	cdcomppath = sstrdup(dir);
 	STARTSTACKSTR(new);
 	if (*dir != '/') {
-- 
1.9.3

