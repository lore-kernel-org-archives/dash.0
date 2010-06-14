From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] [INPUT] exit 127 if command_file is given but doesn't exist
Date: Mon, 14 Jun 2010 09:54:51 +0000
Message-ID: <20100614095451.26362.qmail@43559bb7971308.315fe32.mid.smarden.org>
References: <20100605160651.GA60028@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from a.ns.smarden.org ([109.68.224.7]:50485 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755908Ab0FNJyx (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 14 Jun 2010 05:54:53 -0400
Content-Disposition: inline
In-Reply-To: <20100605160651.GA60028@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

This commit makes dash exit with return code 127 instead of 2 if
started as non-interactive shell with a non-existent command_file
specified as argument (or a directory), as documented in
 http://www.opengroup.org/onlinepubs/009695399/utilities/sh.html#tag_04_128_14

The wrong exit code was reported by Clint Adams and Jari Aalto through
 http://bugs.debian.org/548743
 http://bugs.debian.org/548687

Signed-off-by: Gerrit Pape <pape@smarden.org>
---

On Sat, Jun 05, 2010 at 06:06:51PM +0200, Jilles Tjoelker wrote:
> Debian's dash package has some local changes which cause an exit with
> code 127, as required by POSIX, if a script (passed with dash
> <filename>) cannot be opened or cannot be read because it is a
> directory.
>
> Unfortunately, these patches also affect the . builtin (if the
> pathname
> contains a slash) and use EXEXIT, which means such errors always cause
> the shell to exit, even in interactive mode or if the builtin's
> specialness has been disabled using command.

Hi Jilles, thanks for the hint, I didn't notice.  I hope this patch does
better, it replaces these two
 http://article.gmane.org/gmane.comp.shells.dash/198
 http://article.gmane.org/gmane.comp.shells.dash/199

Regards, Gerrit.

 src/error.h |    1 +
 src/input.c |    7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/error.h b/src/error.h
index 3162e15..c75cb2c 100644
--- a/src/error.h
+++ b/src/error.h
@@ -69,6 +69,7 @@ extern int exception;
 #define EXSHELLPROC 2	/* execute a shell procedure */
 #define EXEXEC 3	/* command execution failed */
 #define EXEXIT 4	/* exit the shell */
+#define EXIFILE 5	/* inputfile cannot be opened or is a directory */
 
 
 /*
diff --git a/src/input.c b/src/input.c
index e57ad76..a43a7b9 100644
--- a/src/input.c
+++ b/src/input.c
@@ -54,6 +54,7 @@
 #include "parser.h"
 #include "main.h"
 #include "var.h"
+#include "eval.h"
 #ifndef SMALL
 #include "myhistedit.h"
 #endif
@@ -405,11 +406,13 @@ setinputfile(const char *fname, int flags)
 	int fd;
 
 	INTOFF;
-	if ((fd = open(fname, O_RDONLY)) < 0) {
+	if ((fd = open(fname, O_RDWR)) < 0) {
 		if (flags & INPUT_NOFILE_OK)
 			goto out;
-		sh_error("Can't open %s", fname);
+		exitstatus = 127;
+		exerror(EXIFILE, "Can't open %s", fname);
 	}
+	fcntl(fd, F_SETFL, O_RDONLY);
 	if (fd < 10)
 		fd = savefd(fd, fd);
 	setinputfd(fd, flags & INPUT_PUSH_FILE);
-- 
1.6.0.3

