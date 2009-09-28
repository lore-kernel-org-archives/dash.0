From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] don't read-uninitialized for \177 in a here-doc
Date: Mon, 28 Sep 2009 11:22:29 +0200
Message-ID: <87r5trbezu.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:35686 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbZI1JXZ (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 28 Sep 2009 05:23:25 -0400
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 71D5377C930
	for <dash@vger.kernel.org>; Mon, 28 Sep 2009 11:23:16 +0200 (CEST)
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 4CABA8180BC
	for <dash@vger.kernel.org>; Mon, 28 Sep 2009 11:22:31 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6F24F818085
	for <dash@vger.kernel.org>; Mon, 28 Sep 2009 11:22:29 +0200 (CEST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: 548493@bugs.debian.org

It was indeed a bug in dash.
I tracked it down and wrote the patch below:

From 53924ce6da7fece91e57b7238e6aa81a4df636a5 Mon Sep 17 00:00:00 2001
From: Jim Meyering <meyering@redhat.com>
Date: Mon, 28 Sep 2009 11:00:05 +0200
Subject: [PATCH] don't read-uninitialized for \177 in a here-doc

A DEL (0177, dec 127) byte in a here-document would cause dash to
access uninitialized memory at the end of one of the syntax.c tables,
since those tables are sized to accommodate a maximum index of
BASESYNTAX + 126.  Make the generated tables one byte larger.
printf ':<<\\E\n\200y\nE'|./dash
* src/mksyntax.c (filltable): Use 258, not 257 as the size,
so that BASESYNTAX(=130) + 127 is a valid index.
(print): Likewise.
Don't emit explicit array dimension in declaration.
---
 ChangeLog      |   13 +++++++++++++
 src/mksyntax.c |    6 +++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/ChangeLog b/ChangeLog
index d9dcb0c..fabb0e1 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,16 @@
+2009-09-28  Jim Meyering  <meyering@redhat.com>
+
+	don't read-uninitialized for \177 in a here-doc
+	A DEL (0177, dec 127) byte in a here-document would cause dash to
+	access uninitialized memory at the end of one of the syntax.c tables,
+	since those tables are sized to accommodate a maximum index of
+	BASESYNTAX + 126.  Make the generated tables one byte larger.
+	printf ':<<\\E\n\200y\nE'|./dash
+	* src/mksyntax.c (filltable): Use 258, not 257 as the size,
+	so that BASESYNTAX(=130) + 127 is a valid index.
+	(print): Likewise.
+	Don't emit explicit array dimension in declaration.
+
 2009-08-31  Eric Blake <ebb9@byu.net>

 	* Avoid compiler warnings on isdigit.
diff --git a/src/mksyntax.c b/src/mksyntax.c
index 7a8a9ae..a23c18c 100644
--- a/src/mksyntax.c
+++ b/src/mksyntax.c
@@ -223,7 +223,7 @@ filltable(char *dftval)
 {
 	int i;

-	for (i = 0 ; i < 257; i++)
+	for (i = 0 ; i < 258; i++)
 		syntax[i] = dftval;
 }

@@ -269,9 +269,9 @@ print(char *name)
 	int col;

 	fprintf(hfile, "extern const char %s[];\n", name);
-	fprintf(cfile, "const char %s[%d] = {\n", name, 257);
+	fprintf(cfile, "const char %s[] = {\n", name);
 	col = 0;
-	for (i = 0 ; i < 257; i++) {
+	for (i = 0 ; i < 258; i++) {
 		if (i == 0) {
 			fputs("      ", cfile);
 		} else if ((i & 03) == 0) {
--
1.6.5.rc2.177.ga9dd6
