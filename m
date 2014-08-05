From: Chema Gonzalez <chema@google.com>
Subject: [PATCH dash] [BUILTIN] ensure LC_COLLATE is not overriden
Date: Tue,  5 Aug 2014 09:40:13 -0700
Message-ID: <1407256813-30944-1-git-send-email-chema@google.com>
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-vc0-f202.google.com ([209.85.220.202]:33992 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163AbaHEQkW (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 5 Aug 2014 12:40:22 -0400
Received: by mail-vc0-f202.google.com with SMTP id hq11so152868vcb.3
        for <dash@vger.kernel.org>; Tue, 05 Aug 2014 09:40:15 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org, Chema Gonzalez <chema@google.com>

If the user environment has either LC_ALL or LANG defined, the setting
of LC_COLLATE in src/mkbuiltins is overriden. With a non-POSIX locale,
the orders of dotcmd (remember that '.' is 0x2e in ascii) and truecmd
(':' is 0x3a in ascii) are reversed, which makes the ":" command fail
in the bsearch.

Tested:

Before this patch:

$ env |grep -e LANG -e LC_ALL
LC_ALL=en_US.ISO8859-15
LANG=en_US.iso885915
$ ./autogen.sh
...
$ ./configure
...
$ make clean; make -j 40
...
$ ./src/dash -c ":"
./src/dash: 1: :: not found
$ grep -A 3 'struct builtincmd builtincmd' src/builtins.c
const struct builtincmd builtincmd[] = {
        { ":", truecmd, 3 },
        { ".", dotcmd, 3 },
        { "[", testcmd, 0 },
$ make clean; LC_ALL= LANG= make -j 40
...
$ ./src/dash -c ":"
$ grep -A 3 'struct builtincmd builtincmd' src/builtins.c
const struct builtincmd builtincmd[] = {
        { ".", dotcmd, 3 },
        { ":", truecmd, 3 },
        { "[", testcmd, 0 },

After this patch:

env |grep -e LANG -e LC_ALL
LC_ALL=en_US.ISO8859-15
LANG=en_US.iso885915
$ ./autogen.sh
$ ./configure
...
$ make clean; make -j 40
...
$ ./src/dash -c ":"
$ grep -A 3 'struct builtincmd builtincmd' src/builtins.c
const struct builtincmd builtincmd[] = {
        { ".", dotcmd, 3 },
        { ":", truecmd, 3 },
        { "[", testcmd, 0 },

Signed-off-by: Chema Gonzalez <chema@google.com>
---
 src/mkbuiltins | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/mkbuiltins b/src/mkbuiltins
index f562ae2..ed79041 100644
--- a/src/mkbuiltins
+++ b/src/mkbuiltins
@@ -78,7 +78,7 @@ awk '{	for (i = 2 ; i <= NF ; i++) {
 		if ($i ~ /^-/)
 			line = $(++i) "\t" line
 		print line
-	}}' $temp | LC_COLLATE=C sort -k 1,1 | tee $temp2 | awk '{
+	}}' $temp | LC_ALL= LANG= LC_COLLATE=C sort -k 1,1 | tee $temp2 | awk '{
 		opt = ""
 		if (NF > 2) {
 			opt = substr($2, 2)
-- 
2.0.0.526.g5318336

