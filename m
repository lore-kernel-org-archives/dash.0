From: Denys Vlasenko <dvlasenk@redhat.com>
Subject: [PATCH] Rename DOWAIT_NORMAL to DOWAIT_NONBLOCK
Date: Wed, 19 Feb 2020 11:30:08 +0100
Message-ID: <20200219103008.22230-1-dvlasenk@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <dash-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45945 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726270AbgBSKaS (ORCPT
        <rfc822;dash@vger.kernel.org>); Wed, 19 Feb 2020 05:30:18 -0500
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org
Cc: Denys Vlasenko <dvlasenk@redhat.com>

To make it clearer what it is doing: nonblocking wait()

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
---
 src/jobs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/jobs.c b/src/jobs.c
index 26a6248..d0cf708 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -77,7 +77,7 @@
 #define CUR_STOPPED 0
=20
 /* mode flags for dowait */
-#define DOWAIT_NORMAL 0
+#define DOWAIT_NONBLOCK 0
 #define DOWAIT_BLOCK 1
 #define DOWAIT_WAITCMD 2
=20
@@ -557,7 +557,7 @@ showjobs(struct output *out, int mode)
 	TRACE(("showjobs(%x) called\n", mode));
=20
 	/* If not even one one job changed, there is nothing to do */
-	dowait(DOWAIT_NORMAL, NULL);
+	dowait(DOWAIT_NONBLOCK, NULL);
=20
 	for (jp =3D curjob; jp; jp =3D jp->prev_job) {
 		if (!(mode & SHOW_CHANGED) || jp->changed)
@@ -1013,7 +1013,7 @@ waitforjob(struct job *jp)
 	int st;
=20
 	TRACE(("waitforjob(%%%d) called\n", jp ? jobno(jp) : 0));
-	dowait(jp ? DOWAIT_BLOCK : DOWAIT_NORMAL, jp);
+	dowait(jp ? DOWAIT_BLOCK : DOWAIT_NONBLOCK, jp);
 	if (!jp)
 		return exitstatus;
=20
@@ -1123,7 +1123,7 @@ out:
=20
 static int dowait(int block, struct job *jp)
 {
-	int pid =3D block =3D=3D DOWAIT_NORMAL ? gotsigchld : 1;
+	int pid =3D block =3D=3D DOWAIT_NONBLOCK ? gotsigchld : 1;
=20
 	while (jp ? jp->state =3D=3D JOBRUNNING : pid > 0) {
 		if (!jp)
--=20
2.25.0
