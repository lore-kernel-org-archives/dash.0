From: <kabe@sra-tohoku.co.jp>
Subject: [PATCH] create builtins.c properly on old cpp
Date: Mon, 22 Dec 2014 14:50:23 +0900
Message-ID: <2410222201414.mjQV5WR4491251$@sra-tohoku.co.jp.msg>
Content-Type: text/plain
Return-path: <dash-owner@vger.kernel.org>
Received: from vega.sra-tohoku.jp ([58.12.125.173]:58631 "EHLO
	vega.sra-tohoku.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbaLVGGE (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 22 Dec 2014 01:06:04 -0500
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: kabe@sra-tohoku.co.jp

Encontered this on ancient gcc-2.95.3 environment;
src/builtins.def.in -> src/builtins.def generation emitted
^ $
lines (likely by /* */), which where NOT ignored by 
src/mkbuiltins and generating bogus builtins.c.

-- kabe

diff -U6 -p dash-0.5.8/src/mkbuiltins.dist dash-0.5.8/src/mkbuiltins
--- dash-0.5.8/src/mkbuiltins.dist	Sun Sep 28 17:19:32 2014
+++ dash-0.5.8/src/mkbuiltins	Mon Dec 22 14:36:43 2014
@@ -66,13 +66,13 @@ cat <<\!
  */
 
 #include "shell.h"
 #include "builtins.h"
 
 !
-< $builtins sed '/^#/d; /^$/d' > $temp
+< $builtins sed '/^#/d; /^ *$/d' > $temp
 awk '{	printf "int %s(int, char **);\n", $1}' $temp
 echo '
 const struct builtincmd builtincmd[] = {'
 awk '{	for (i = 2 ; i <= NF ; i++) {
 		line = $i "\t" $1
 		if ($i ~ /^-/)
