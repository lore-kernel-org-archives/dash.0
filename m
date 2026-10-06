Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742B1390230
	for <dash@vger.kernel.org>; Tue,  6 Oct 2026 22:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791326166; cv=none; b=Jg3H4shraT7xtLKi4j+hBDcsU18hs5oTM8po3mG5M21eKjV5q2Ec1g5imUfkAmI9M7YkEo/wTjSbikxT6NkIImQGMhL7S6QoAmihrWKAnttaVfWLbqoaQ+Toedr0SnIuoLbLZ7NAlB3iEp8YHjivV7ydBe59+2KoWjRyUzCoyDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791326166; c=relaxed/simple;
	bh=q6+7X1ix9V5z1vWmfA+qSH4UUrt4xyu5oFVqNo115HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WolF6eNrzEvCyNgkJ1WjmjxUwZWlzQjNBEPrePU2xg5WpEyykCDKZfqF3XS31scZ0kQXv7KuVLC0kbniFw5dgdLCDlHfOB1uiGvpHQWxbwhQpj9a66rIiZDc97rWcQrC2SbnUGx0cgoxn6kLs8dMeSFoTTf3zLzGVkGBqca8jdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RMD2lD0e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RMD2lD0e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791326164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W2IujRcyBOFmxWx5jmEjQyvvauPKuyLdyeD10VVa9jo=;
	b=RMD2lD0embwrPavb1nFN8XAb1CJmep4Lnm4p2q6DpiSwp78EIme4RqRq2cWVg2VHzE98gN
	kCC64n4l9/6cltQa3u+sxVnUN9Ckk9CkP7AyHoQOJKs82Wxi2LMGMWby+JPpp//T8VLsYa
	vUADbAiCqWSCuSMDFo3X0IgnEz09oUw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-QA5IR23SPCuclKmj14mY-A-1; Tue,
 06 Oct 2026 18:36:01 -0400
X-MC-Unique: QA5IR23SPCuclKmj14mY-A-1
X-Mimecast-MFC-AGG-ID: QA5IR23SPCuclKmj14mY-A_1791326160
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AB3E184B38C;
	Tue,  6 Oct 2026 22:36:00 +0000 (UTC)
Received: from d805.tpb.lab.eng.brq.redhat.com (unknown [10.44.48.2])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BD297180057F;
	Tue,  6 Oct 2026 22:35:58 +0000 (UTC)
From: Denys Vlasenko <dvlasenk@redhat.com>
To: dash@vger.kernel.org,
	Herbert Xu <herbert.xu@redhat.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>,
	Denys Vlasenko <vda.linux@googlemail.com>
Subject: [PATCH 5/5] jobs: rename DOWAIT_WAITCMD to DOWAIT_CHILD_OR_SIG
Date: Wed,  7 Oct 2026 00:34:59 +0200
Message-ID: <20261006223502.90879-5-dvlasenk@redhat.com>
In-Reply-To: <20261006223502.90879-1-dvlasenk@redhat.com>
References: <20261006223502.90879-1-dvlasenk@redhat.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

First two modes tell dowait() what to do:
do a nonblocking, or blocking wait3().

But DOWAIT_WAITCMD name uses a different convention.
Instead of telling dowait() what to do, it tells dowait()
*where the call came from*! So, what would dowait() do?
Code reader has no idea...

Rename it to DOWAIT_CHILD_OR_SIG instead,
so that it describes what dowait() will wait for.

While at it, rename "int err" in waitproc() to "pid".
It's a much more logically correct name.

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
---
 src/jobs.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/src/jobs.c b/src/jobs.c
index 0a4ba75..9bdb8af 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -79,9 +79,9 @@
 #define CUR_STOPPED 0
 
 /* mode flags for dowait */
-#define DOWAIT_NONBLOCK    0 /* waitpid() will use WNOHANG and won't wait for signals */
-#define DOWAIT_BLOCK       1 /* waitpid() will NOT use WNOHANG */
-#define DOWAIT_WAITCMD     2 /* waitpid() will use WNOHANG and if got 0, will wait for signals, then loop back */
+#define DOWAIT_NONBLOCK     0 /* waitpid() will use WNOHANG and won't wait for signals */
+#define DOWAIT_BLOCK        1 /* waitpid() will NOT use WNOHANG */
+#define DOWAIT_CHILD_OR_SIG 2 /* waitpid() will use WNOHANG and if got 0, will wait for signals, then loop back if SIGCLD */
 
 /* array of jobs */
 static struct job *jobtab;
@@ -629,7 +629,7 @@ waitcmd(int argc, char **argv)
 				jp->waited = 1;
 				jp = jp->prev_job;
 			}
-			if (!dowait(DOWAIT_WAITCMD, NULL))
+			if (!dowait(DOWAIT_CHILD_OR_SIG, NULL))
 				goto sigout;
 		}
 	}
@@ -651,7 +651,7 @@ start:
 		} else
 			job = getjob(*argv, 0);
 		/* loop until process terminated or stopped */
-		if (!dowait(DOWAIT_WAITCMD, job))
+		if (!dowait(DOWAIT_CHILD_OR_SIG, job))
 			goto sigout;
 		job->waited = 1;
 		retval = getstatus(job);
@@ -1065,7 +1065,7 @@ waitforjob(struct job *jp)
 
 /*
  * Do a wait system call.  If block is DOWAIT_NONBLOCK, we return -1 rather
- * than blocking.  If block is DOWAIT_WAITCMD, we return 0 when a signal
+ * than blocking.  If block is DOWAIT_CHILD_OR_SIG, we return 0 when a signal
  * other than SIGCHLD interrupted the wait.
  *
  * We use sigsuspend in conjunction with a non-blocking wait3 in
@@ -1083,7 +1083,7 @@ waitproc(int block, int *status)
 {
 	sigset_t oldmask;
 	int flags = block == DOWAIT_BLOCK ? 0 : WNOHANG;
-	int err;
+	int pid;
 
 #if JOBS
 	if (jobctl)
@@ -1094,21 +1094,20 @@ waitproc(int block, int *status)
 		gotsigchld = 0;
 		do
 #ifdef HAVE_WAIT3
-			err = wait3(status, flags, NULL);
+			pid = wait3(status, flags, NULL);
 #else
-			err = waitpid((pid_t)-1, status, flags);
+			pid = waitpid((pid_t)-1, status, flags);
 #endif
-		while (err < 0 && errno == EINTR);
+		while (pid < 0 && errno == EINTR);
 
-		if (err) /* wait3() returned PID or error? */
+		if (pid != 0) /* wait3() returned PID or error? */
 			break; /* return it */
 
-		/* We are here only if DOWAIT_NONBLOCK or DOWAIT_WAITCMD */
-
-		err = -!block;
-		if (err) /* block == DOWAIT_NONBLOCK (0)? */
-			break; /* return -1 */
+		/* We are here only if DOWAIT_NONBLOCK or DOWAIT_CHILD_OR_SIG */
+		if (block == DOWAIT_NONBLOCK)
+			return -1;
 
+		/* DOWAIT_CHILD_OR_SIG: children exist, wait for a signal */
 		sigblockall(&oldmask);
 
 		while (!gotsigchld && !pending_sig)
@@ -1123,7 +1122,7 @@ waitproc(int block, int *status)
 	 * -1 if DOWAIT_NONBLOCK
 	 * 0 if there were no waitable children and got a signal (not SIGCHLD)
 	 */
-	return err;
+	return pid;
 }
 
 /*
-- 
2.52.0

