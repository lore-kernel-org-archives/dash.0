Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C855137923
	for <dash@vger.kernel.org>; Mon,  5 Oct 2026 02:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791168984; cv=none; b=WsvMYme2fTyJtG88vaFFSo5oSuJ+bUJyI+7DFymFFqL9Bjc77AzeIEIM2nBxYjaaMvzZI12dCZmPhZspkh2N3JMAqLLBkVAV1Hvw84k/fEWgQMI4CR6Ul+fiGCUTbYrbjGERMn+RSENDBGTWsHmEc9gk6MDW3bQBcOsEwMFFd/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791168984; c=relaxed/simple;
	bh=W6Srp8k5G/zcOxM37Ns94NZeiSz17wMBul7hqqtEigQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PdhmbUL4tYEfDZoxIjtX0tzL65EUkwpFZQ4B9NEBuWtL4rLfvpWcEo2Pf49ww3DKpykjGSs+iJBbAsrAHvIHruFQ3/pD4AXn0oSUZEhSCtSII6tDjQG8Ums6qpUfAiPNvZ/lhhmAqxHRQiWxQcRNqGkg39Hk/k721sSa87o9OIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WivnQVxk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WivnQVxk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791168982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oqT87ioRqJPoS9USY0xmyfayVSKPTSA7H1AtywqXH6Q=;
	b=WivnQVxksChUP/shx0/VSh7IfOvvpxGvO52qT/7gItP/HfsLB6QDhx/cu0Wgu8lpH04SGC
	bFj8NUKK5mkEBd6Isxg1PnoHiQmqyzhlVAQnLCyjYyEHkUCr849NBP+QlnGSfc2kgakJ4s
	pKAFBHd7vyVifGLtywSJPecZiwTAMjk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-UMnC1JEmPT6BKRg9KAG6QQ-1; Sun,
 04 Oct 2026 22:56:20 -0400
X-MC-Unique: UMnC1JEmPT6BKRg9KAG6QQ-1
X-Mimecast-MFC-AGG-ID: UMnC1JEmPT6BKRg9KAG6QQ_1791168980
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD190197905A;
	Mon,  5 Oct 2026 02:56:19 +0000 (UTC)
Received: from d805.tpb.lab.eng.brq.redhat.com (unknown [10.44.32.16])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 621CD30000E5;
	Mon,  5 Oct 2026 02:56:18 +0000 (UTC)
From: Denys Vlasenko <dvlasenk@redhat.com>
To: dash@vger.kernel.org,
	Herbert Xu <herbert.xu@redhat.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>,
	Denys Vlasenko <vda.linux@googlemail.com>
Subject: [PATCH 1/2] waitproc: unobfuscate and explain what the code does
Date: Mon,  5 Oct 2026 04:56:03 +0200
Message-ID: <20261005025606.75329-1-dvlasenk@redhat.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Also, the #ifdef'ed out waitpid() has extra argument, fix that.

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
---
 src/jobs.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/src/jobs.c b/src/jobs.c
index 914b383..51c94dc 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -1175,8 +1175,8 @@ static int dowait(int block, struct job *jp)
 }
 
 /*
- * Do a wait system call.  If block is zero, we return -1 rather than
- * blocking.  If block is DOWAIT_WAITCMD, we return 0 when a signal
+ * Do a wait system call.  If block is DOWAIT_NONBLOCK, we return -1 rather
+ * than blocking.  If block is DOWAIT_WAITCMD, we return 0 when a signal
  * other than SIGCHLD interrupted the wait.
  *
  * We use sigsuspend in conjunction with a non-blocking wait3 in
@@ -1189,7 +1189,6 @@ static int dowait(int block, struct job *jp)
  * children have been reaped.  Otherwise zombies may linger.
  */
 
-
 STATIC int
 waitproc(int block, int *status)
 {
@@ -1208,12 +1207,15 @@ waitproc(int block, int *status)
 #ifdef HAVE_WAIT3
 			err = wait3(status, flags, NULL);
 #else
-			err = waitpid((pid_t)-1, status, flags, NULL);
+			err = waitpid((pid_t)-1, status, flags);
 #endif
 		while (err < 0 && errno == EINTR);
 
-		if (err || (err = -!block))
-			break;
+		if (err) /* wait3() returned PID or error? */
+			break; /* return it */
+		err = -!block;
+		if (err) /* block == DOWAIT_NONBLOCK (0)? */
+			break; /* return -1 */
 
 		sigblockall(&oldmask);
 
@@ -1223,6 +1225,12 @@ waitproc(int block, int *status)
 		sigclearmask();
 	} while (gotsigchld);
 
+	/* Possible returns:
+	 * PID of successfully waited-for child.
+	 * -1 on wait3() error (can get ECHILD: no one to wait for)
+	 * -1 if DOWAIT_NONBLOCK
+	 * 0 if there were no waitable children and got a signal (not SIGCHLD)
+	 */
 	return err;
 }
 
-- 
2.52.0

