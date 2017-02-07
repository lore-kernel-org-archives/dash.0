From: Adam Borowski <kilobyte@angband.pl>
Subject: [PATCH] Don't execute binary files if execve() returned ENOEXEC.
Date: Tue,  7 Feb 2017 09:33:07 +0100
Message-ID: <20170207083307.14881-1-kilobyte@angband.pl>
Return-path: <dash-owner@vger.kernel.org>
Received: from tartarus.angband.pl ([89.206.35.136]:58546 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbdBGIdV (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 7 Feb 2017 03:33:21 -0500
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Adam Borowski <kilobyte@angband.pl>

Both "dash -c foo" and "./foo" are supposed to be able to run hashbang-less
scripts, but attempts to execute common binary files tend to be nasty:
especially both ELF and PE tend to make dash create a bunch of files with
unprintable names, that in turn confuse some tools up to causing data loss.

Thus, let's read the first line and see if it looks like text.  This is a
variant of the approach used by bash and zsh; mksh instead checks for
signatures of a bunch of common file types.

POSIX says: "If the executable file is not a text file, the shell may bypass
this command execution.".

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
This has been applied in Debian.  While technically it's only a "may" issue
in dash itself, and is triggered by user error (trying to exec files you
shouldn't exec), the fallout is nasty enough that the bug was classified as
serious.

The usual failure mode is to create files with names such as:
(per submitter, a PE):
90 d4 f6
(an ELF):
01 b0 40 40 08 01 40 38 02 40 04 03 01 05 40 40 ed ed
01 b0 40 40 f8 40 38 02 40 04 03 01 05 40 40 da da

diff --git a/src/exec.c b/src/exec.c
index ec0eadd..19ae752 100644
--- a/src/exec.c
+++ b/src/exec.c
@@ -148,6 +148,36 @@ shellexec(char **argv, const char *path, int idx)
 }
 
 
+/*
+ * Check if an executable that just failed with ENOEXEC shouldn't be
+ * considered a script (wrong-arch ELF/PE, junk accidentally set +x, etc).
+ * We check only the first line to allow binaries encapsulated in a shell
+ * script without proper quoting.  The first line, if not a hashbang, is
+ * likely to contain comments; even ancient encodings, at least popular
+ * ones, don't use 0x7f nor values below 0x1f other than whitespace (\t,
+ * \n, \v, \f, \r), ISO/IEC 2022 can have SI, SO and \e.
+ */
+STATIC int file_is_binary(const char *cmd)
+{
+	char buf[128];
+	int fd = open(cmd, O_RDONLY|O_NOCTTY);
+	if (fd == -1)
+		return 1;
+	int len = read(fd, buf, sizeof(buf));
+	close(fd);
+	for (int i = 0; i < len; ++i) {
+		char c = buf[i];
+		if (c >= 0 && c <= 8 ||
+		    c >= 16 && c <= 31 && c != 27 ||
+		    c == 0x7f)
+			return 1;
+		if (c == '\n')
+			return 0;
+	}
+	return 0;
+}
+
+
 STATIC void
 tryexec(char *cmd, char **argv, char **envp)
 {
@@ -162,6 +192,8 @@ repeat:
 	execve(cmd, argv, envp);
 #endif
 	if (cmd != path_bshell && errno == ENOEXEC) {
+		if (file_is_binary(cmd))
+			return;
 		*argv-- = cmd;
 		*argv = cmd = path_bshell;
 		goto repeat;
-- 
2.11.0

