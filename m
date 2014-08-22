From: Chema Gonzalez <chema@google.com>
Subject: [PATCH dash v2] [BUILTIN] ensure LC_COLLATE is not overriden
Date: Fri, 22 Aug 2014 16:08:16 -0700
Message-ID: <1408748896-27824-1-git-send-email-chema@google.com>
References: <1407256813-30944-1-git-send-email-chema@google.com>
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-ob0-f201.google.com ([209.85.214.201]:61866 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326AbaHVXIv (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 22 Aug 2014 19:08:51 -0400
Received: by mail-ob0-f201.google.com with SMTP id va2so1746100obc.0
        for <dash@vger.kernel.org>; Fri, 22 Aug 2014 16:08:50 -0700 (PDT)
In-Reply-To: <1407256813-30944-1-git-send-email-chema@google.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Jeremie <jca@wxcvbn.org>, dash@vger.kernel.org, Chema Gonzalez <chema@google.com>

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

$ env |grep -e LANG -e LC_ALL
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
index f562ae2..70308bd 100644
--- a/src/mkbuiltins
+++ b/src/mkbuiltins
@@ -78,7 +78,7 @@ awk '{	for (i = 2 ; i <= NF ; i++) {
 		if ($i ~ /^-/)
 			line = $(++i) "\t" line
 		print line
-	}}' $temp | LC_COLLATE=C sort -k 1,1 | tee $temp2 | awk '{
+	}}' $temp | LC_ALL=C sort -k 1,1 | tee $temp2 | awk '{
 		opt = ""
 		if (NF > 2) {
 			opt = substr($2, 2)
-- 
2.1.0.rc2.206.gedb03e5

