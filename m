From: =?UTF-8?q?Petr=20=C5=A0abata?= <contyk@redhat.com>
Subject: [PATCH] Fix build failure with gcc -Werror=format-security
Date: Tue, 24 Jun 2014 14:40:57 +0200
Message-ID: <1403613657-5859-1-git-send-email-contyk@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57850 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752802AbaFXMlG (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 24 Jun 2014 08:41:06 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5OCf4QO026092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dash@vger.kernel.org>; Tue, 24 Jun 2014 08:41:05 -0400
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: =?UTF-8?q?Petr=20=C5=A0abata?= <contyk@redhat.com>

This fix lets dash build with the abovementioned option.

Signed-off-by: Petr =C5=A0abata <contyk@redhat.com>
---
 src/jobs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/jobs.c b/src/jobs.c
index bf40204..f3af44d 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -427,7 +427,7 @@ sprint_status(char *s, int status, int sigonly)
 				goto out;
 #endif
 		}
-		col =3D fmtstr(s, 32, strsignal(st));
+		col =3D fmtstr(s, 32, "%s", strsignal(st));
 #ifdef WCOREDUMP
 		if (WCOREDUMP(status)) {
 			col +=3D fmtstr(s + col, 16, " (core dumped)");
--=20
1.9.3

