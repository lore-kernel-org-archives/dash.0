From: Fredrik Fornwall <fredrik@fornwall.net>
Subject: [PATCH] Set LC_ALL instead LC_COLLATE in mkbuiltins
Date: Mon, 18 May 2015 01:15:51 +0200
Message-ID: <CAOhdH0uf7Kj2noz4vnuLo_06W2HZ4Xwh_Bm5vKC71VHfeswD_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:36595 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbbEQXPx (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 17 May 2015 19:15:53 -0400
Received: by lagv1 with SMTP id v1so194577232lag.3
        for <dash@vger.kernel.org>; Sun, 17 May 2015 16:15:51 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

In mkbuiltins LC_COLLATE is set, but since "The value of the LC_ALL
environment variable has precedence over any of the other environment
variables starting with LC_"
(http://pubs.opengroup.org/onlinepubs/7908799/xbd/envvar.html), this
has no effect when LC_ALL is set.

This breaks when having e.g. LC_ALL=en_US.UTF-8 during make, which
causes the test case
    dash -c :
to fail, probably due to broken ordering in builtins.c. The patch
corrects that by setting LC_ALL instead of LC_COLLATE.

Fredrik

diff -u -r ../dash-0.5.8/src/mkbuiltins ./src/mkbuiltins
--- ../dash-0.5.8/src/mkbuiltins 2014-09-28 04:19:32.000000000 -0400
+++ ./src/mkbuiltins 2015-05-17 19:08:00.076452891 -0400
@@ -78,7 +78,7 @@
  if ($i ~ /^-/)
  line = $(++i) "\t" line
  print line
- }}' $temp | LC_COLLATE=C sort -k 1,1 | tee $temp2 | awk '{
+ }}' $temp | LC_ALL=C sort -k 1,1 | tee $temp2 | awk '{
  opt = ""
  if (NF > 2) {
  opt = substr($2, 2)
@@ -97,7 +97,7 @@
  */

 !
-sed 's/ -[a-z]*//' $temp2 | nl -b a -v 0 | LC_COLLATE=C sort -u -k 3,3 |
+sed 's/ -[a-z]*//' $temp2 | nl -b a -v 0 | LC_ALL=C sort -u -k 3,3 |
 tr abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ |
  awk '{ printf "#define %s (builtincmd + %d)\n", $3, $1}'
 printf '\n#define NUMBUILTINS %d\n' $(wc -l < $temp2)
$ diff -u -r ../dash-0.5.8/ .
