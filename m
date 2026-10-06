Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC4F37F739
	for <dash@vger.kernel.org>; Tue,  6 Oct 2026 22:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791326125; cv=none; b=BPdcTx4F6O9OPSY3tzHUKs6IVLTkJ1naeIOW/3gsKVNYHACXhAYgIF7CskG8NDSnhDG+9ma3eLRPmZfAv8QVKn2WXPc8EM21TChJko9iJGlM8/ZgIYffx+3Uyh6hKKvTGF71rxFMZnShJ/qmjtw0TEUsob7GtcepGSShyEfPYVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791326125; c=relaxed/simple;
	bh=TdndJbLSQBB5Kpy8RFGJEjMtZ0+DYhZessh1Ifp86HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4LKp9wnKIhrUIkS6/0ZraMqLvQB92ZaJUBdMA98nZcxZEZEQQk5Njw8DcLNKEvttFOaLZk1E1SJeIEMGXknTbcO2d7L9VA1hPHXvFFpXFQfjvPcOXGECAK7MDW4Tyoq1Tt4BOPJE6zfJBOGC4TBAXWa11Eu9dLG1lZvcUY69Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OJYDepJm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJYDepJm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791326123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cwZIPhmKp74kLW9asLYSH2Mfh3WLchQM3oegJ7QhN4s=;
	b=OJYDepJm0u8Mabw02T4WwijkAypHNWzydMKb0Xhyia7UoG1b3kxJJ5515O+fVjLzuMbmIt
	4fN/OoTXQI9J7sKJtWHvTEBD189xBPm43y/iWdnayLSY4ouuSc1fjS42spsapxZDJEeTZh
	/OU19jjJ3WdUc7HGZBz7JvsWTe5+UUA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-RBWSKxj8NjW2VpIWJ-XqRg-1; Tue,
 06 Oct 2026 18:35:20 -0400
X-MC-Unique: RBWSKxj8NjW2VpIWJ-XqRg-1
X-Mimecast-MFC-AGG-ID: RBWSKxj8NjW2VpIWJ-XqRg_1791326119
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45D9B195421D;
	Tue,  6 Oct 2026 22:35:19 +0000 (UTC)
Received: from d805.tpb.lab.eng.brq.redhat.com (unknown [10.44.48.2])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BDFFB180057E;
	Tue,  6 Oct 2026 22:35:17 +0000 (UTC)
From: Denys Vlasenko <dvlasenk@redhat.com>
To: dash@vger.kernel.org,
	Herbert Xu <herbert.xu@redhat.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>,
	Denys Vlasenko <vda.linux@googlemail.com>
Subject: [PATCH 2/5] jobs: reorder wait-related functions. Pure block move, no code changes
Date: Wed,  7 Oct 2026 00:34:56 +0200
Message-ID: <20261006223502.90879-2-dvlasenk@redhat.com>
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

Placing them in the "callees first" order:

waitproc() {...}
waitone() {...}  // calls waitproc
dowait() {...}   // calls waitone

instead of current semi-random one:

waitone() {...}
dowait() {...}
waitproc() {...}

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
---
 src/jobs.c | 119 ++++++++++++++++++++++++++---------------------------
 1 file changed, 58 insertions(+), 61 deletions(-)

diff --git a/src/jobs.c b/src/jobs.c
index 51c94dc..568ffd4 100644
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
@@ -1065,7 +1064,65 @@ waitforjob(struct job *jp)
 	return st;
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
 
 /*
  * Wait for a process to terminate.
@@ -1174,66 +1231,6 @@ static int dowait(int block, struct job *jp)
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

