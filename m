From: =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <zenczykowski@gmail.com>
Subject: [PATCH] fix two compile time warnings
Date: Wed, 20 Oct 2010 02:59:35 -0700
Message-ID: <1287568775-2556-1-git-send-email-zenczykowski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:42490 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251Ab0JTJ7o (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 20 Oct 2010 05:59:44 -0400
Received: by pxi16 with SMTP id 16so823181pxi.19
        for <dash@vger.kernel.org>; Wed, 20 Oct 2010 02:59:44 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, maximillian attems <max@stro.at>
Cc: =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>

=46rom: Maciej =C5=BBenczykowski <maze@google.com>

jobs.c: In function 'sprint_status':
jobs.c:427: warning: format not a string literal and no format argument=
s

trap.c: In function 'exitshell':
trap.c:354: warning: variable 'status' might be clobbered by 'longjmp' =
or 'vfork'

Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
---
 src/jobs.c |    2 +-
 src/trap.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/jobs.c b/src/jobs.c
index 826a9af..44a6401 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -425,7 +425,7 @@ sprint_status(char *s, int status, int sigonly)
 				goto out;
 #endif
 		}
-		col =3D fmtstr(s, 32, strsignal(st));
+		col =3D fmtstr(s, 32, "%s", strsignal(st));
 		if (WCOREDUMP(status)) {
 			col +=3D fmtstr(s + col, 16, " (core dumped)");
 		}
diff --git a/src/trap.c b/src/trap.c
index 7bd60ab..a3c4397 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -369,7 +369,7 @@ exitshell(void)
 {
 	struct jmploc loc;
 	char *p;
-	int status;
+	volatile int status;
=20
 #ifdef HETIO
 	hetio_reset_term();
--=20
1.7.1

