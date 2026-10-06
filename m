Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EA337F739
	for <dash@vger.kernel.org>; Tue,  6 Oct 2026 22:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791326153; cv=none; b=FTi3t3YqZUvFrcyqce2ZRLuBRdWJeeMKrs10bKlD7sOlhggRrsovpCaTjVAknrdCoSd5onUDu3aGeUeDv9I292R4xMTNG7+pa4bEXfT6F1VpNtIE0KmAnuWWiAlbUiyuVBmqViL9DA0DMcqIonfY3vVR/9eNCcdzyBGI0QFPt8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791326153; c=relaxed/simple;
	bh=QqIhes/gD1J3iodJBs1X95ZZ81YLHSNoVtJPDZc0E3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xr3yM+DAw8Wl8bMPNI6Nmgw3w+PKkfXYUGnzvzXOHGdAjxAiPTayl5dWEK1ydQwrSPrQ5X5QQdeG1ezuWrp7zUFszkWfrAvjK4TZKt7RDa0mAg3duN5DDHV6fu5IktjRo4aRc1PzR/dn1RnT58mUn08SRCjN8DqlBsa/hVYUQOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GpzkpNDE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GpzkpNDE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791326148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jAuXL8fjRLCJfWvQ9VHzLt8LarZRF+UOwIdvE8bcjsU=;
	b=GpzkpNDE6LD3xVvSvdyUWyF0Cplvt1SBk9Zv6TfNhj5+b5BnwMx00s51TLp6dL8UM4MpRr
	weG0HfBQrMRKF03Wj6iAt6/GqXgiQoorbPUYJGmelgyfTSlgoyhp6+T539zl4AuF5Ymtcx
	J76laGKlAWfzMJvZz19Fhoq8N7YgAcM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-cVdlU7D-Ol60qQo6T_LXxQ-1; Tue,
 06 Oct 2026 18:35:45 -0400
X-MC-Unique: cVdlU7D-Ol60qQo6T_LXxQ-1
X-Mimecast-MFC-AGG-ID: cVdlU7D-Ol60qQo6T_LXxQ_1791326144
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9437E196CDE5;
	Tue,  6 Oct 2026 22:35:44 +0000 (UTC)
Received: from d805.tpb.lab.eng.brq.redhat.com (unknown [10.44.48.2])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4681F180057E;
	Tue,  6 Oct 2026 22:35:43 +0000 (UTC)
From: Denys Vlasenko <dvlasenk@redhat.com>
To: dash@vger.kernel.org,
	Herbert Xu <herbert.xu@redhat.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>,
	Denys Vlasenko <vda.linux@googlemail.com>
Subject: [PATCH 4/5] jobs: dowait: remove incorrect looping, DOWAIT_WAITCMD_ALL not needed after this
Date: Wed,  7 Oct 2026 00:34:58 +0200
Message-ID: <20261006223502.90879-4-dvlasenk@redhat.com>
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

Prev code:

         rpid = 1;
         do {
                 pid = waitone(block, jp);
                 rpid &= !!pid; <<<<<<<<<<<<<<<<<< HERE
                 block &= ~DOWAIT_WAITCMD_ALL;
                 if (!pid || (jp && jp->state != JOBRUNNING))
                         block = DOWAIT_NONBLOCK;
         } while (pid >= 0);
         return rpid;

If we got pid == 0, it happens in exactly one case:
we did waitpid(WNOHANG), got 0 ("children exist but none yet
changed its state"), then waited for a signal and got one,
which wasn't SIGCHLD.

The above behavior is requested by only one caller: waitcmd()
- the "wait" builtin.

"wait" builtin is required to be interruptible by signals and
to set exitcode to (128 + sig).

Therefore, if we got pid == 0, we don't need to wait
for any more processes. We need to return to waitcmd()
and let it set $? accordingly.

Instead, we do yet another loop.

I'm not saying that we know
that there are no more processes that finished.

I'm saying we don't care at this point: we know
that we are "wait" builtin and we got interrupted by a signal.

Fix this by not looping if "pid == 0" indicates we got a signal.
ONLY loop if we got a pid > 0 and we either do not wait for a specific job,
or this scpecific job is still RUNNING.

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
---
 src/jobs.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/src/jobs.c b/src/jobs.c
index 008978f..0a4ba75 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -82,7 +82,6 @@
 #define DOWAIT_NONBLOCK    0 /* waitpid() will use WNOHANG and won't wait for signals */
 #define DOWAIT_BLOCK       1 /* waitpid() will NOT use WNOHANG */
 #define DOWAIT_WAITCMD     2 /* waitpid() will use WNOHANG and if got 0, will wait for signals, then loop back */
-#define DOWAIT_WAITCMD_ALL 4
 
 /* array of jobs */
 static struct job *jobtab;
@@ -630,7 +629,7 @@ waitcmd(int argc, char **argv)
 				jp->waited = 1;
 				jp = jp->prev_job;
 			}
-			if (!dowait(DOWAIT_WAITCMD_ALL, 0))
+			if (!dowait(DOWAIT_WAITCMD, NULL))
 				goto sigout;
 		}
 	}
@@ -1103,6 +1102,9 @@ waitproc(int block, int *status)
 
 		if (err) /* wait3() returned PID or error? */
 			break; /* return it */
+
+		/* We are here only if DOWAIT_NONBLOCK or DOWAIT_WAITCMD */
+
 		err = -!block;
 		if (err) /* block == DOWAIT_NONBLOCK (0)? */
 			break; /* return -1 */
@@ -1208,7 +1210,6 @@ out:
 static int dowait(int block, struct job *jp)
 {
 	int gotchld = *(volatile int *)&gotsigchld;
-	int rpid;
 	int pid;
 
 	if (jp && jp->state != JOBRUNNING)
@@ -1217,8 +1218,6 @@ static int dowait(int block, struct job *jp)
 	if (block == DOWAIT_NONBLOCK && !gotchld)
 		return 1;
 
-	rpid = 1;
-
 	/* In what cases we loop here:
 	 * = If we waited in blocking mode and got pid > 0,
 	 * but the job we waiting for is still running
@@ -1229,23 +1228,24 @@ static int dowait(int block, struct job *jp)
 	 * we should see whether more processes have terminated,
 	 * we have to wait in non-blocking mode again.
 	 * The users are
-	 *  showjobs() -> dowait(DOWAIT_NONBLOCK)
-	 *  waitforjob(NULL) -> dowait(DOWAIT_NONBLOCK)
+	 *  showjobs() -> dowait(DOWAIT_NONBLOCK, NULL)
+	 *  waitforjob(NULL) -> dowait(DOWAIT_NONBLOCK, NULL)
 	 * waitcmd() does its own looping while it sees at least one JOBRUNNING
 	 * job, it does not need us to loop here - only to do
 	 * one nonblocking wait and if it gives nothing, wait for signals.
 	 */
 	do {
 		pid = waitone(block, jp);
-		rpid &= !!pid;
-
-		block &= ~DOWAIT_WAITCMD_ALL;
-		if (!pid || (jp && jp->state != JOBRUNNING))
-			block = DOWAIT_NONBLOCK;
-	} while (pid >= 0); //WRONG? should be "pid > 0"
+		if (pid == 0)
+			return 0; /* got a signal */
+		if (jp && jp->state != JOBRUNNING) {
+			/* no more running procs in this job, stop waiting */
+			return 1; /* did not get a signal */
+		}
+		/* if we saw a process changing state, wait again (is there more?) */
+	} while (pid > 0);
 
-	/* Return: 0 if seen a signal, 1 otherwise */
-	return rpid;
+	return 1;  /* did not get a signal */
 }
 
 /*
-- 
2.52.0

