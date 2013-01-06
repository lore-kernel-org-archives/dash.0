From: Aleksey Cheusov <vle@gmx.net>
Subject: patch for dash
Date: Sun, 06 Jan 2013 19:30:54 +0300
Message-ID: <87a9sms281.fsf@asrock.chizhovka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:57451 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756017Ab3AFQbA (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 6 Jan 2013 11:31:00 -0500
Received: from mailout-de.gmx.net ([10.1.76.20]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0Me6KG-1TeE8447gs-00PtX9 for
 <dash@vger.kernel.org>; Sun, 06 Jan 2013 17:30:59 +0100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi. The following patch fixes dash build failure on Solaris
where /usr/bin/nl (which is in default PATH) is not POSIX compatible.
POSIX-ly correct version is in /usr/xpg4/bin but I think it's easier
to fix use of nl(1).

   [cheusov@pkgsrc-dev]$ /usr/bin/nl -ba -v0 <<< foo
     0  foo
   [cheusov@pkgsrc-dev]$ /usr/bin/nl -b a -v 0 <<< foo
   nl: a: No such file or directory
   [cheusov@pkgsrc-dev]$ uname -srm
   SunOS 5.11 i86pc
   [cheusov@pkgsrc-dev]$


--- src/mkbuiltins.orig	2011-03-15 07:18:06.000000000 +0000
+++ src/mkbuiltins
@@ -97,7 +97,7 @@ cat <<\!
  */
 
 !
-sed 's/	-[a-z]*//' $temp2 | nl -b a -v 0 | LC_COLLATE=C sort -u -k 3,3 |
+sed 's/	-[a-z]*//' $temp2 | nl -ba -v0 | LC_COLLATE=C sort -u -k 3,3 |
 tr abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ |
 	awk '{	printf "#define %s (builtincmd + %d)\n", $3, $1}'
 printf '\n#define NUMBUILTINS %d\n' $(wc -l < $temp2)

-- 
Best regards, Aleksey Cheusov.
