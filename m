From: Eric Blake <ebb9@byu.net>
Subject: avoid compiler warning
Date: Thu, 09 Jul 2009 06:55:25 -0600
Message-ID: <4A55E8BD.1090809@byu.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040501080004090602010808"
Return-path: <dash-owner@vger.kernel.org>
Received: from qmta07.emeryville.ca.mail.comcast.net ([76.96.30.64]:41413 "EHLO
	QMTA07.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757971AbZGIM5R (ORCPT
	<rfc822;dash@vger.kernel.org>); Thu, 9 Jul 2009 08:57:17 -0400
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

This is a multi-part message in MIME format.
--------------040501080004090602010808
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

ccache gcc -DHAVE_CONFIG_H -I. -I..  -include ../config.h -DBSD=1 -DSHELL
-DIFS_BROKEN  -Wall -gdwarf-2 -Wall -Werror -MT mystring.o -MD -MP -MF
.deps/mystring.Tpo -c -o mystring.o mystring.c
miscbltin.c: In function `umaskcmd':
miscbltin.c:201: warning: subscript has type `char'

isdigit is only defined over EOF and unsigned char values, so without this
patch, you can trigger undefined behavior.

Or you can pull from
$ git pull git://repo.or.cz/dash/ericb.git master

-- 
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net

--------------040501080004090602010808
Content-Type: text/plain;
 name="dash.patch1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dash.patch1"

From 4e9dc98029647880acc1992f36d12331872a818d Mon Sep 17 00:00:00 2001
From: Eric Blake <ebb9@byu.net>
Date: Thu, 9 Jul 2009 06:52:15 -0600
Subject: [PATCH] [BUILD] Avoid compiler warning

Pass correct type to ctype macro.

Signed-off-by: Eric Blake <ebb9@byu.net>
---
 ChangeLog       |    4 ++++
 src/miscbltin.c |    2 +-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/ChangeLog b/ChangeLog
index e6a1d26..5731f79 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2009-07-09  Eric Blake  <ebb9@byu.net>
+
+	* Avoid compiler warnings.
+
 2009-06-27  Herbert Xu <herbert@gondor.apana.org.au>

 	* Fix quoted pattern patch breakage.
diff --git a/src/miscbltin.c b/src/miscbltin.c
index 3f91bc3..65ff46d 100644
--- a/src/miscbltin.c
+++ b/src/miscbltin.c
@@ -198,7 +198,7 @@ umaskcmd(int argc, char **argv)
 	} else {
 		int new_mask;

-		if (isdigit(*ap)) {
+		if (isdigit((unsigned char) *ap)) {
 			new_mask = 0;
 			do {
 				if (*ap >= '8' || *ap < '0')
-- 
1.6.3.3.334.g916e1


--------------040501080004090602010808--
