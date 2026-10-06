Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8CC20B80B
	for <dash@vger.kernel.org>; Tue,  6 Oct 2026 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791326137; cv=none; b=fs0pS7MGw75RIJjevYgQT7ZivsZeSA+q4rjWjnTP5xGm+NnT/x5s8tAUYaIi44cfJ6L8oI+4QfbrmTTtlRtaeSzdZ7IJBvY/RebMJFbGZf0bI2Ea/ASEhppb91SZf78OuIFedozxESDNTcVh/IdfFEOErRTQTrohRyBHPm/xSCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791326137; c=relaxed/simple;
	bh=DIVc3jqLGYOzqBbt/je3+QX/vpuBjOhnMAzpCnkXQQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYeEZC32bq/G4R2slmmqSDznoyk6MaiJr6sGyGaF9W5dSv2qAdRt8AsorCNM/AcKVjXbMSAuILdAf+UjaNIY+m604TDBn/v2YtUQi/pCQ5tEBO/8H3Q0jec5tkhX/SSLj/CgRpD3HrEo1bAIGWJ8YYbKIXDqE8P2Z9vNvvHYKp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ErfNVjOA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErfNVjOA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791326135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=chddDqoB576gM92RsfrQujdHN+OyWockYGIKS3uDLds=;
	b=ErfNVjOAt8cSBhHqxNuoI00njnx0QsXtRzolQekmZzTby/xAm4unfp7qUBjuNqowddlKU+
	+6m+7XyGCi14qCwXkObBprdOO/Evl2+hz/wFxB/MzpSte7tcb/V7NrCpIl8hp3T527wHbE
	Z4UHf2S+0DJQlfUfoj95hC1DySu34O8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-2WRUprmgMD6BSME3B8Dafg-1; Tue,
 6 Oct 2026 22:35:31 +0000
X-MC-Unique: 2WRUprmgMD6BSME3B8Dafg-1
X-Mimecast-MFC-AGG-ID: 2WRUprmgMD6BSME3B8Dafg_1791326130
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7857196CDF2;
	Tue,  6 Oct 2026 22:35:30 +0000 (UTC)
Received: from d805.tpb.lab.eng.brq.redhat.com (unknown [10.44.48.2])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5207C18004D4;
	Tue,  6 Oct 2026 22:35:29 +0000 (UTC)
From: Denys Vlasenko <dvlasenk@redhat.com>
To: dash@vger.kernel.org,
	Herbert Xu <herbert.xu@redhat.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>,
	Denys Vlasenko <vda.linux@googlemail.com>
Subject: [PATCH 3/5] jobs: add comments explaining waiting machinery
Date: Wed,  7 Oct 2026 00:34:57 +0200
Message-ID: <20261006223502.90879-3-dvlasenk@redhat.com>
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

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
---
 src/jobs.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/src/jobs.c b/src/jobs.c
index 568ffd4..008978f 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -79,9 +79,9 @@
 #define CUR_STOPPED 0
 
 /* mode flags for dowait */
-#define DOWAIT_NONBLOCK 0
-#define DOWAIT_BLOCK 1
-#define DOWAIT_WAITCMD 2
+#define DOWAIT_NONBLOCK    0 /* waitpid() will use WNOHANG and won't wait for signals */
+#define DOWAIT_BLOCK       1 /* waitpid() will NOT use WNOHANG */
+#define DOWAIT_WAITCMD     2 /* waitpid() will use WNOHANG and if got 0, will wait for signals, then loop back */
 #define DOWAIT_WAITCMD_ALL 4
 
 /* array of jobs */
@@ -1137,9 +1137,9 @@ static int waitone(int block, struct job *job)
 	int state;
 
 	INTOFF;
-	TRACE(("dowait(%d) called\n", block));
+	TRACE(("waitone(%d) called\n", block));
 	pid = waitproc(block, &status);
-	TRACE(("wait returns pid %d, status=%d\n", pid, status));
+	TRACE(("waitproc returns pid %d, status=%d\n", pid, status));
 	if (pid <= 0)
 		goto out;
 
@@ -1219,6 +1219,22 @@ static int dowait(int block, struct job *jp)
 
 	rpid = 1;
 
+	/* In what cases we loop here:
+	 * = If we waited in blocking mode and got pid > 0,
+	 * but the job we waiting for is still running
+	 * (jp->state == JOBRUNNING), we have to wait in blocking mode again,
+	 * until it's not JOBRUNNING.
+	 * The user is waitforjob(jp) -> dowait(DOWAIT_BLOCK, jp).
+	 * = If we waited in non-blocking mode and got pid > 0,
+	 * we should see whether more processes have terminated,
+	 * we have to wait in non-blocking mode again.
+	 * The users are
+	 *  showjobs() -> dowait(DOWAIT_NONBLOCK)
+	 *  waitforjob(NULL) -> dowait(DOWAIT_NONBLOCK)
+	 * waitcmd() does its own looping while it sees at least one JOBRUNNING
+	 * job, it does not need us to loop here - only to do
+	 * one nonblocking wait and if it gives nothing, wait for signals.
+	 */
 	do {
 		pid = waitone(block, jp);
 		rpid &= !!pid;
@@ -1226,8 +1242,9 @@ static int dowait(int block, struct job *jp)
 		block &= ~DOWAIT_WAITCMD_ALL;
 		if (!pid || (jp && jp->state != JOBRUNNING))
 			block = DOWAIT_NONBLOCK;
-	} while (pid >= 0);
+	} while (pid >= 0); //WRONG? should be "pid > 0"
 
+	/* Return: 0 if seen a signal, 1 otherwise */
 	return rpid;
 }
 
-- 
2.52.0

