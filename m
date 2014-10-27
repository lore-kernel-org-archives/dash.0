From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5/9] [BUILTIN] Remove unnecessary restoration of format string in printf
Date: Mon, 27 Oct 2014 16:26:57 +0800
Message-ID: <E1Xifdh-0001ht-Vk@gondolin.me.apana.org.au>
References: <20141027082546.GA6447@gondor.apana.org.au>
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:50553 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbaJ0I1B (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 27 Oct 2014 04:27:01 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by fornost.hengli.com.au with esmtp (Exim 4.80 #3 (Debian))
	id 1Xifdi-0006J7-JC
	for <dash@vger.kernel.org>; Mon, 27 Oct 2014 19:26:58 +1100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Currently we try to preserve the format string which is stored in
argv after temporarily modifying it.  This is unnecessary as it's
only ever used once.  This patch gets rid of it.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 ChangeLog          |    1 +
 src/bltin/printf.c |    1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/ChangeLog b/ChangeLog
index 47ba519..026b47c 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -5,6 +5,7 @@
 	* Replace open-coded flushall in preadbuffer.
 	* Add likely tag in outmem.
 	* Add ifdefs around MEM_OUT handling in outmem.
+	* Remove unnecessary restoration of format string in printf.
 
 2014-10-13  Eric Blake <eblake@redhat.com>
 
diff --git a/src/bltin/printf.c b/src/bltin/printf.c
index 213025f..d1181e3 100644
--- a/src/bltin/printf.c
+++ b/src/bltin/printf.c
@@ -207,7 +207,6 @@ pc:
 				if (print_escape_str(start, param, array,
 						     getstr()))
 					goto out;
-				*fmt = 'b';
 				break;
 			case 'c': {
 				int p = getchr();
