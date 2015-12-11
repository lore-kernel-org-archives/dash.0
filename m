From: Jonathan Perkin <jperkin@joyent.com>
Subject: [PATCH] [SHELL] Fix build on Solaris 9
Date: Fri, 11 Dec 2015 11:56:43 +0000
Message-ID: <20151211115623.GA54973@joyent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35371 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752902AbbLKL4s (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 11 Dec 2015 06:56:48 -0500
Received: by mail-wm0-f41.google.com with SMTP id l68so9955991wml.0
        for <dash@vger.kernel.org>; Fri, 11 Dec 2015 03:56:47 -0800 (PST)
Received: from joyent.com (host86-144-234-20.range86-144.btcentralplus.com. [86.144.234.20])
        by smtp.gmail.com with ESMTPSA id s11sm3096126wmb.14.2015.12.11.03.56.45
        for <dash@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 Dec 2015 03:56:46 -0800 (PST)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Ensure dash can build in a default Solaris 9 or older environment:

 - Execute scripts with $SHELL rather than /bin/sh, the latter does not
   support e.g. "if ! .." used by mkbuiltins.

 - /bin/awk does not support ?: syntax, use explicit statements instead.

 - /bin/nl requires no spaces between options and arguments.
---
 src/Makefile.am |  4 ++--
 src/mkbuiltins  | 12 ++++++++----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/src/Makefile.am b/src/Makefile.am
index 120ffa2..139355e 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -46,13 +46,13 @@ EXTRA_DIST = \
 	mknodes.c nodetypes nodes.c.pat mksyntax.c mksignames.c
 
 token.h token_vars.h: mktokens
-	sh $^
+	$(SHELL) $^
 
 builtins.def: builtins.def.in $(top_builddir)/config.h
 	$(COMPILE) -E -x c -o $@ $<
 
 builtins.c builtins.h: mkbuiltins builtins.def
-	sh $^
+	$(SHELL) $^
 
 init.c: mkinit $(dash_CFILES)
 	./$^
diff --git a/src/mkbuiltins b/src/mkbuiltins
index 8c74d6b..b4d6f4e 100644
--- a/src/mkbuiltins
+++ b/src/mkbuiltins
@@ -84,9 +84,13 @@ awk '{	for (i = 2 ; i <= NF ; i++) {
 			opt = substr($2, 2)
 			$2 = $3
 		}
-		printf "\t{ \"%s\", %s, %d },\n", $1,
-			(opt ~ /n/) ? "NULL" : $2,
-			(opt ~ /s/) + (opt ~ /[su]/) * 2 + (opt ~ /a/) * 4
+		mask = 0
+		cmd = $2
+		if (opt ~ /n/) { cmd = "NULL" }
+		if (opt ~ /s/) { mask += 1 }
+		if (opt ~ /[su]/) { mask += 2 }
+		if (opt ~ /a/) { mask += 4 }
+		printf "\t{ \"%s\", %s, %d },\n", $1, cmd, mask
 	}'
 echo '};'
 
@@ -97,7 +101,7 @@ cat <<\!
  */
 
 !
-sed 's/	-[a-z]*//' $temp2 | nl -b a -v 0 |
+sed 's/	-[a-z]*//' $temp2 | nl -ba -v0 |
 	LC_ALL= LC_COLLATE=C sort -u -k 3,3 |
 	tr abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ |
 	awk '{	printf "#define %s (builtincmd + %d)\n", $3, $1}'
-- 
2.4.9 (Apple Git-60)

-- 
Jonathan Perkin  -  Joyent, Inc.  -  www.joyent.com
