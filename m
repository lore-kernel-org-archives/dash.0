From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH 1/2] [INPUT] exit 127 if command_file is given but does not exist
Date: Tue, 29 Sep 2009 11:15:55 +0000
Message-ID: <20090929111555.19359.qmail@de3d04e6be5ad4.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from a.ns.smarden.org ([212.42.242.37]:1125 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750908AbZI2LWd (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 29 Sep 2009 07:22:33 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

This commit makes dash exit with return code 127 instead of 2 if
started as non-interactive shell with a non-existent command_file
specified as argument, as documented in
 http://www.opengroup.org/onlinepubs/009695399/utilities/sh.html#tag_04_128_14

The wrong exit code was reported by Clint Adams through
 http://bugs.debian.org/548743

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 src/input.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/src/input.c b/src/input.c
index e57ad76..c1e3e54 100644
--- a/src/input.c
+++ b/src/input.c
@@ -101,6 +101,7 @@ MKINIT struct parsefile basepf;	/* top level input file */
 MKINIT char basebuf[IBUFSIZ];	/* buffer for top level input file */
 struct parsefile *parsefile = &basepf;	/* current input file */
 int whichprompt;		/* 1 == PS1, 2 == PS2 */
+extern int exitstatus;
 
 #ifndef SMALL
 EditLine *el;			/* cookie for editline package */
@@ -408,7 +409,9 @@ setinputfile(const char *fname, int flags)
 	if ((fd = open(fname, O_RDONLY)) < 0) {
 		if (flags & INPUT_NOFILE_OK)
 			goto out;
-		sh_error("Can't open %s", fname);
+		sh_warnx("Can't open %s", fname);
+		exitstatus = 127;
+		exraise(EXEXIT);
 	}
 	if (fd < 10)
 		fd = savefd(fd, fd);
-- 
1.6.0.3

