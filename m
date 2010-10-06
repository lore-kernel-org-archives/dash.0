From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] [INPUT] Catch attempts to run a directory as a script
Date: Wed, 6 Oct 2010 05:08:04 -0500
Message-ID: <20101006100804.GB361@burratino>
References: <20100605160651.GA60028@stack.nl>
 <20100614095451.26362.qmail@43559bb7971308.315fe32.mid.smarden.org>
 <20100628065326.GA25667@gondor.apana.org.au>
 <20101006100420.GA361@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54606 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab0JFKLZ (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 6 Oct 2010 06:11:25 -0400
Received: by iwn5 with SMTP id 5so9556747iwn.19
        for <dash@vger.kernel.org>; Wed, 06 Oct 2010 03:11:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101006100420.GA361@burratino>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Gerrit Pape <pape@smarden.org>, dash@vger.kernel.org, "Krzysztof A. Sobiecki" <sobkas@gmail.com>, Jari Aalto <jari.aalto@cante.net>

open() succeeds, though read() fails later, when a pathname
passed as argv[0] on the command line points to a directory,
which somehow results in dash thinking everything is okay:

 $ sh dir/
 $ echo $?
 0

But POSIX makes it clear enough that in "sh command_file",
command_file is supposed to be a file, not a directory.  So
diagnose this with an error message and exit with status 2.

Reported-by: Jari Aalto <jari.aalto@cante.net>
Fixes: http://bugs.debian.org/548687
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Applies on top of the previous patch, which is based on
master.

Thanks to Gerrit and Krzysztof for your help so far.

 src/input.c |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/src/input.c b/src/input.c
index e57ad76..d68d441 100644
--- a/src/input.c
+++ b/src/input.c
@@ -395,6 +395,19 @@ popstring(void)
 }
 
+/*
+ * Is fd a directory file descriptor?
+ */
+
+static int
+isdir(const char *fname, int fd)
+{
+	struct stat64 statb;
+	if (fstat64(fd, &statb) < 0)
+		sh_error("Can't stat %s", fname);
+	return S_ISDIR(statb.st_mode);
+}
+
 /*
  * Set the input to take input from a file.  If push is set, push the
  * old input onto the stack first.
  */
@@ -405,7 +418,13 @@ setinputfile(const char *fname, int flags)
 	int fd;
 
 	INTOFF;
-	if ((fd = open(fname, O_RDONLY)) < 0) {
+	fd = open(fname, O_RDONLY);
+	if (isdir(fname, fd)) {
+		close(fd);
+		fd = -1;
+		errno = EISDIR;
+	}
+	if (fd < 0) {
 		if (flags & INPUT_NOFILE_OK)
 			goto out;
 		sh_error("Can't open %s", fname);
-- 
1.7.2.3

