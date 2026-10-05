Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030F2274641
	for <dash@vger.kernel.org>; Mon,  5 Oct 2026 02:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791168988; cv=none; b=EmeqdINBx0ftsvTyF+ER4TD1GoJRZn1Z9ShAnukBeyuO2OD9MKc8UvN4UHiD+x4rUiv5TIhZZ47yXwZUBhj7ugGIql8cLvtwdrBiDudZ6+3RaePs4X+RIdOWhilbUASo5NHMShMVmz708m6uHttxx71Mn2tJPaZYhWRA/ybN+s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791168988; c=relaxed/simple;
	bh=bbjdFDjKDSHP5N5aKWFB/VHGCO0BdySSh/i3QzVAoGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AlVR8hE0sS3T/uFIWKqU5siBkCVfDGCBC0oeoJJOQG4I7M61UCgyMfp7Ce8fS60LffL+SjQnRxfJ8czl4xcqhrVYDEfiIBPVauGdPUr6YV4tME2NTAsQNG4Gn45ooKI3MNRul/kutvtEMTkQ/Hy05L0+RCxsXevc14tUCPH51V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HPCnZO7d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPCnZO7d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791168985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nYc7Q7g3/KiPkB96kYN5tAS/Vv+R1+Vlv7EgyTZ2iug=;
	b=HPCnZO7dhGAn1zS1KBO12Is6XwoUIb6gOmLZF75EGmFPCkJBEZlaruPXieTPVWrMLYtiW0
	QsdZncD7pExnhvqJy7qwuklQTrdlCvbvz4yAP+gZ5SPgrKF5X6pZcfqWmFNsQK6JACEFYS
	2PQRcBhfwKMuMdfvYZkP8EZGWh54EuQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-HqiVd2iMMlaR1OlWBcHhRg-1; Sun,
 04 Oct 2026 22:56:24 -0400
X-MC-Unique: HqiVd2iMMlaR1OlWBcHhRg-1
X-Mimecast-MFC-AGG-ID: HqiVd2iMMlaR1OlWBcHhRg_1791168983
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 860551955E86;
	Mon,  5 Oct 2026 02:56:23 +0000 (UTC)
Received: from d805.tpb.lab.eng.brq.redhat.com (unknown [10.44.32.16])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A8BF30000E5;
	Mon,  5 Oct 2026 02:56:22 +0000 (UTC)
From: Denys Vlasenko <dvlasenk@redhat.com>
To: dash@vger.kernel.org,
	Herbert Xu <herbert.xu@redhat.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>,
	Denys Vlasenko <vda.linux@googlemail.com>
Subject: [PATCH 2/2] Reorder wait-related functions. Pure block move, no code changes
Date: Mon,  5 Oct 2026 04:56:04 +0200
Message-ID: <20261005025606.75329-2-dvlasenk@redhat.com>
In-Reply-To: <20261005025606.75329-1-dvlasenk@redhat.com>
References: <20261005025606.75329-1-dvlasenk@redhat.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Palcing them in the "callees first" order:

waitproc() {...}
waitone() {...}  // calls waitproc
dowait() {...}   // calls waitone

instead of current semi-random one:

waitone() {...}
dowait() {...}
waitproc() {...}

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
---
 src/jobs.c | 121 ++++++++++++++++++++++++++---------------------------
 1 file changed, 60 insertions(+), 61 deletions(-)

diff --git a/src/jobs.c b/src/jobs.c
index 51c94dc..3313599 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -116,7 +116,6 @@ STATIC int dowait(int, struct job *);
 #ifdef SYSV
 STATIC int onsigchild(void);
 #endif
-STATIC int waitproc(int, int *);
 STATIC char *commandtext(union node *);
 STATIC void cmdtxt(union node *);
 STATIC void cmdlist(union node *, int);
@@ -1013,6 +1012,66 @@ struct job *vforkexec(union node *n, char **argv, const char *path, int idx)
 	return jp;
 }
 
+/*
+ * Do a wait system call.  If block is DOWAIT_NONBLOCK, we return -1 rather
+ * than blocking.  If block is DOWAIT_WAITCMD, we return 0 when a signal
+ * other than SIGCHLD interrupted the wait.
+ *
+ * We use sigsuspend in conjunction with a non-blocking wait3 in
+ * order to ensure that waitcmd exits promptly upon the reception
+ * of a signal.
+ *
+ * For code paths other than waitcmd we either use a blocking wait3
+ * or a non-blocking wait3.  For the latter case the caller of dowait
+ * must ensure that it is called over and over again until all dead
+ * children have been reaped.  Otherwise zombies may linger.
+ */
+
+STATIC int
+waitproc(int block, int *status)
+{
+	sigset_t oldmask;
+	int flags = block == DOWAIT_BLOCK ? 0 : WNOHANG;
+	int err;
+
+#if JOBS
+	if (jobctl)
+		flags |= WUNTRACED;
+#endif
+
+	do {
+		gotsigchld = 0;
+		do
+#ifdef HAVE_WAIT3
+			err = wait3(status, flags, NULL);
+#else
+			err = waitpid((pid_t)-1, status, flags);
+#endif
+		while (err < 0 && errno == EINTR);
+
+		if (err) /* wait3() returned PID or error? */
+			break; /* return it */
+		err = -!block;
+		if (err) /* block == DOWAIT_NONBLOCK (0)? */
+			break; /* return -1 */
+
+		sigblockall(&oldmask);
+
+		while (!gotsigchld && !pending_sig)
+			sigsuspend(&oldmask);
+
+		sigclearmask();
+	} while (gotsigchld);
+
+	/* Possible returns:
+	 * PID of successfully waited-for child.
+	 * -1 on wait3() error (can get ECHILD: no one to wait for)
+	 * -1 if DOWAIT_NONBLOCK
+	 * 0 if there were no waitable children and got a signal (not SIGCHLD)
+	 */
+	return err;
+}
+
 /*
  * Wait for job to finish.
  *
@@ -1174,66 +1233,6 @@ static int dowait(int block, struct job *jp)
 	return rpid;
 }
 
-/*
- * Do a wait system call.  If block is DOWAIT_NONBLOCK, we return -1 rather
- * than blocking.  If block is DOWAIT_WAITCMD, we return 0 when a signal
- * other than SIGCHLD interrupted the wait.
- *
- * We use sigsuspend in conjunction with a non-blocking wait3 in
- * order to ensure that waitcmd exits promptly upon the reception
- * of a signal.
- *
- * For code paths other than waitcmd we either use a blocking wait3
- * or a non-blocking wait3.  For the latter case the caller of dowait
- * must ensure that it is called over and over again until all dead
- * children have been reaped.  Otherwise zombies may linger.
- */
-
-STATIC int
-waitproc(int block, int *status)
-{
-	sigset_t oldmask;
-	int flags = block == DOWAIT_BLOCK ? 0 : WNOHANG;
-	int err;
-
-#if JOBS
-	if (jobctl)
-		flags |= WUNTRACED;
-#endif
-
-	do {
-		gotsigchld = 0;
-		do
-#ifdef HAVE_WAIT3
-			err = wait3(status, flags, NULL);
-#else
-			err = waitpid((pid_t)-1, status, flags);
-#endif
-		while (err < 0 && errno == EINTR);
-
-		if (err) /* wait3() returned PID or error? */
-			break; /* return it */
-		err = -!block;
-		if (err) /* block == DOWAIT_NONBLOCK (0)? */
-			break; /* return -1 */
-
-		sigblockall(&oldmask);
-
-		while (!gotsigchld && !pending_sig)
-			sigsuspend(&oldmask);
-
-		sigclearmask();
-	} while (gotsigchld);
-
-	/* Possible returns:
-	 * PID of successfully waited-for child.
-	 * -1 on wait3() error (can get ECHILD: no one to wait for)
-	 * -1 if DOWAIT_NONBLOCK
-	 * 0 if there were no waitable children and got a signal (not SIGCHLD)
-	 */
-	return err;
-}
-
 /*
  * return 1 if there are stopped jobs, otherwise 0
  */
-- 
2.52.0

