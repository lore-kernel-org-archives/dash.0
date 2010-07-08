From: maximilian attems <max@stro.at>
Subject: [PATCH 1/2] [JOBS] Debug compile fix
Date: Thu,  8 Jul 2010 10:36:19 +0200
Message-ID: <1278578180-6969-1-git-send-email-max@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:58487 "EHLO
	baikonur.stro.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754175Ab0GHIl0 (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 8 Jul 2010 04:41:26 -0400
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org, klibc@zytor.com, maximilian attems <max@stro.at>

No point in tracing a no longer undeclared "ps->cmd", fixes:
jobs.c: In function =E2=80=98commandtext=E2=80=99:
jobs.c:1192: error: =E2=80=98ps=E2=80=99 undeclared (first use in this =
function)
jobs.c:1192: error: (Each undeclared identifier is reported only once
jobs.c:1192: error: for each function it appears in.)

Signed-off-by: maximilian attems <max@stro.at>
---
 src/jobs.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/src/jobs.c b/src/jobs.c
index 060187c..826a9af 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -1189,8 +1189,7 @@ commandtext(union node *n)
 	STARTSTACKSTR(cmdnextc);
 	cmdtxt(n);
 	name =3D stackblock();
-	TRACE(("commandtext: name %p, end %p\n\t\"%s\"\n",
-		name, cmdnextc, ps->cmd));
+	TRACE(("commandtext: name %p, end %p\n", name, cmdnextc));
 	return savestr(name);
 }
=20
--=20
1.7.1

