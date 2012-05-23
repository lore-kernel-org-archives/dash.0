From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] avoid overflow for very long variable name
Date: Wed, 23 May 2012 22:37:48 +0200
Message-ID: <874nr6eiqr.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:44714 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758841Ab2EWUh5 (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 23 May 2012 16:37:57 -0400
Received: from mx.meyering.net (unknown [88.168.87.75])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 32A8FD480AF
	for <dash@vger.kernel.org>; Wed, 23 May 2012 22:37:49 +0200 (CEST)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id 5B3AA600CD
	for <dash@vger.kernel.org>; Wed, 23 May 2012 22:37:48 +0200 (CEST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org


Otherwise, this:
  $ perl -le 'print "v"x(2**31+1) ."=1"' | dash
provokes integer overflow:

  (gdb) bt
  #0  doformat (dest=0x61d580, f=0x416a08 "%s: %d: %s: ", ap=0x7fffffffd308)
      at output.c:310
  #1  0x00000000004128c1 in outfmt (file=0x61d580, fmt=0x416a08 "%s: %d: %s: ")
      at output.c:257
  #2  0x000000000040382e in exvwarning2 (msg=0x417339 "Out of space",
      ap=0x7fffffffd468) at error.c:125
  #3  0x000000000040387e in exverror (cond=1, msg=0x417339 "Out of space",
      ap=0x7fffffffd468) at error.c:156
  #4  0x0000000000403938 in sh_error (msg=0x417339 "Out of space") at error.c:172
  #5  0x000000000040c970 in ckmalloc (nbytes=18446744071562067984)
      at memalloc.c:57
  #6  0x000000000040ca78 in stalloc (nbytes=18446744071562067972)
      at memalloc.c:132
  #7  0x000000000040ece9 in grabstackblock (len=18446744071562067972)
      at memalloc.h:67
  #8  0x00000000004106b5 in readtoken1 (firstc=118, syntax=0x419522 "",
      eofmark=0x0, striptabs=0) at parser.c:1040
  #9  0x00000000004101a4 in xxreadtoken () at parser.c:826
  #10 0x000000000040fe1d in readtoken () at parser.c:697
  #11 0x000000000040edcc in parsecmd (interact=0) at parser.c:145
  #12 0x000000000040c679 in cmdloop (top=1) at main.c:224
  #13 0x000000000040c603 in main (argc=2, argv=0x7fffffffd9f8) at main.c:178

  #8  0x00000000004106b5 in readtoken1 (firstc=118, syntax=0x419522 "",
      eofmark=0x0, striptabs=0) at parser.c:1040
  1040    grabstackblock(len);
  (gdb) p len
  $30 = -2147483644

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 ChangeLog    | 5 +++++
 src/parser.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/ChangeLog b/ChangeLog
index 8686332..c84aa7e 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,8 @@
+2012-03-11  Jim Meyering  <meyering@redhat.com>
+
+	* Avoid overflow for very long variable name.
+	$ perl -le 'print "v"x(2**31+1) ."=1"' | dash
+
 2012-02-25  Herbert Xu <herbert@gondor.apana.org.au>

 	* Sanitise environment variable names on entry.
diff --git a/src/parser.c b/src/parser.c
index 6de2762..572cbcd 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -853,7 +853,7 @@ readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
 {
 	int c = firstc;
 	char *out;
-	int len;
+	size_t len;
 	struct nodelist *bqlist;
 	int quotef;
 	int dblquote;
--
1.7.10.2.552.gaa3bb87
