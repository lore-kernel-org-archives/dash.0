Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD29637F739
	for <dash@vger.kernel.org>; Tue,  6 Oct 2026 22:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791326115; cv=none; b=po3IOXAfqcb8OYo/ld5FuF9oruNe2GHyp0QLKINgxV0oJOZCbyulCUyOcbltWm1c3vKjTHzltgEHnzRveeuAJwIN2sdiIhq6d3+Q8VNBgibkdOE1i1NyLiQg9WDOctO/0YgYFGxnW5i+AC8KmBx86394KLuDhk7Ej7+O/QCkH1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791326115; c=relaxed/simple;
	bh=zMUb3hTCS0mBy+bR4w6S0/yHQPrRgTmEK8lGL0yq9Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mc6NyiKi9pM++52J3ul9CrSb9yVSNveh8qcNOIov4/DYSvb0j5TiCVHYIkvlEUIfdK5odQTEmu1+ux4dpdZjxv9vCJgo7UivJz7/uMaRoWdLY6El0Ub/897IfBmoVXo827nFgMigNtZdZNR5GA7824ufC7YhFsWUFagi9LQYS/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OvFCTyTg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvFCTyTg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791326112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cf0rR8qMHlvmTfTKgTUrbUrdSaAoiEbh4HH3QAibP48=;
	b=OvFCTyTgeT8XvwpYmF3Asvge19oPWbjzRTIMykllIVCQIXAYjJS53S2pIsqMFOQ9GwgWkw
	GvCJPeo6CGev18EeJ/upaGq84YFU+5EDj08ymOBlaCkIrQQXHeMlkFYP3DtZu1utPEmTVi
	Gca+y3hjpHw8ynlLXup0AhHUDQozwR0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-qQDC6Vx3MReVyuEEIq9mkA-1; Tue,
 06 Oct 2026 18:35:08 -0400
X-MC-Unique: qQDC6Vx3MReVyuEEIq9mkA-1
X-Mimecast-MFC-AGG-ID: qQDC6Vx3MReVyuEEIq9mkA_1791326108
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03C82180136F;
	Tue,  6 Oct 2026 22:35:08 +0000 (UTC)
Received: from d805.tpb.lab.eng.brq.redhat.com (unknown [10.44.48.2])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7B3AD180057E;
	Tue,  6 Oct 2026 22:35:06 +0000 (UTC)
From: Denys Vlasenko <dvlasenk@redhat.com>
To: dash@vger.kernel.org,
	Herbert Xu <herbert.xu@redhat.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>,
	Denys Vlasenko <vda.linux@googlemail.com>
Subject: [PATCH 1/5] jobs: waitproc: unobfuscate and explain what the code does
Date: Wed,  7 Oct 2026 00:34:55 +0200
Message-ID: <20261006223502.90879-1-dvlasenk@redhat.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Also, the #ifdef'ed out waitpid() has extra argument, fix that.
No logic changes.

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

