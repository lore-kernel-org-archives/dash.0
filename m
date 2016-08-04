From: Kylie McClain <somasissounds@gmail.com>
Subject: [PATCH 1/2] mkbuiltins: Use a `while` loop rather than `nl`
Date: Thu,  4 Aug 2016 01:54:10 -0400
Message-ID: <20160804055411.23558-1-somasissounds@gmail.com>
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33717 "EHLO
	mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbcHDIUy (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 4 Aug 2016 04:20:54 -0400
Received: by mail-qt0-f196.google.com with SMTP id j37so12524085qta.0
        for <dash@vger.kernel.org>; Thu, 04 Aug 2016 01:20:40 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Kylie McClain <somasis@exherbo.org>

From: Kylie McClain <somasis@exherbo.org>

nl, while specified in POSIX, is rather obscure and isn't provided by small
coreutils implementations such as `busybox`. This while loop works just as
well for our purposes.
---
 src/mkbuiltins | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/mkbuiltins b/src/mkbuiltins
index b4d6f4e..a47bce8 100644
--- a/src/mkbuiltins
+++ b/src/mkbuiltins
@@ -101,7 +101,8 @@ cat <<\!
  */
 
 !
-sed 's/	-[a-z]*//' $temp2 | nl -ba -v0 |
+sed 's/	-[a-z]*//' $temp2 | while read line;do \
+	i=$(( ${i:--1} + 1 )); printf '%s %s\n' "${i}" "${line}";done |
 	LC_ALL= LC_COLLATE=C sort -u -k 3,3 |
 	tr abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ |
 	awk '{	printf "#define %s (builtincmd + %d)\n", $3, $1}'
-- 
2.9.0

