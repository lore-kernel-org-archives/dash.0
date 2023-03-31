Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C642C6FD18
	for <linux-dash@archiver.kernel.org>; Fri, 31 Mar 2023 12:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjCaMx3 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 31 Mar 2023 08:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjCaMxV (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 31 Mar 2023 08:53:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE2D20C3E
        for <dash@vger.kernel.org>; Fri, 31 Mar 2023 05:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680267125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=O66AWK8WDuk1k36Sf3keBx9bPZxLnzhdkrmYFq49tZI=;
        b=agknD8tc0XZ1oSCNBez/X52FLuUAO8ro4KEVhMXLTyOXon/IcR7X3arI4mm7qtwJoc37m9
        Gg2W/1PbdN4d52zx5Bbu3LieKpcLw7TeoWuwIlNgK3SkX61w1Mi4eSgrWV6EvSZWpXj2gd
        MITKf1mOmN4KQrzBzJ5UB4dttxkAkhM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-CqGZrIgtO8C3Zipk3pkYpA-1; Fri, 31 Mar 2023 08:52:01 -0400
X-MC-Unique: CqGZrIgtO8C3Zipk3pkYpA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 407E7857FB3;
        Fri, 31 Mar 2023 12:52:01 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.43.17.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1C084042AC0;
        Fri, 31 Mar 2023 12:51:59 +0000 (UTC)
From:   Denys Vlasenko <dvlasenk@redhat.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Denys Vlasenko <dvlasenk@redhat.com>, dash@vger.kernel.org
Subject: [PATCH] jobs: drop unused node parameter in makejob()
Date:   Fri, 31 Mar 2023 14:51:57 +0200
Message-Id: <20230331125158.26821-1-dvlasenk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

CC: dash@vger.kernel.org
CC: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
---
 src/eval.c | 6 +++---
 src/jobs.c | 6 +++---
 src/jobs.h | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/eval.c b/src/eval.c
index fa43b68..978a174 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -494,7 +494,7 @@ evalsubshell(union node *n, int flags)
 		forkreset();
 		goto nofork;
 	}
-	jp = makejob(n, 1);
+	jp = makejob(1);
 	if (forkshell(jp, n, backgnd) == 0) {
 		flags |= EV_EXIT;
 		if (backgnd)
@@ -571,7 +571,7 @@ evalpipe(union node *n, int flags)
 		pipelen++;
 	flags |= EV_EXIT;
 	INTOFF;
-	jp = makejob(n, pipelen);
+	jp = makejob(pipelen);
 	prevfd = -1;
 	for (lp = n->npipe.cmdlist ; lp ; lp = lp->next) {
 		prehash(lp->n);
@@ -637,7 +637,7 @@ evalbackcmd(union node *n, struct backcmd *result)
 
 	if (pipe(pip) < 0)
 		sh_error("Pipe call failed");
-	jp = makejob(n, 1);
+	jp = makejob(1);
 	if (forkshell(jp, n, FORK_NOJOB) == 0) {
 		FORCEINTON;
 		close(pip[0]);
diff --git a/src/jobs.c b/src/jobs.c
index f3b9ffc..5a0886e 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -749,7 +749,7 @@ err:
  */
 
 struct job *
-makejob(union node *node, int nprocs)
+makejob(int nprocs)
 {
 	int i;
 	struct job *jp;
@@ -780,7 +780,7 @@ makejob(union node *node, int nprocs)
 	if (nprocs > 1) {
 		jp->ps = ckmalloc(nprocs * sizeof (struct procstat));
 	}
-	TRACE(("makejob(0x%lx, %d) returns %%%d\n", (long)node, nprocs,
+	TRACE(("makejob(%d) returns %%%d\n", nprocs,
 	    jobno(jp)));
 	return jp;
 }
@@ -963,7 +963,7 @@ struct job *vforkexec(union node *n, char **argv, const char *path, int idx)
 	struct job *jp;
 	int pid;
 
-	jp = makejob(n, 1);
+	jp = makejob(1);
 
 	sigblockall(NULL);
 	vforked++;
diff --git a/src/jobs.h b/src/jobs.h
index 6ac6c56..2832d64 100644
--- a/src/jobs.h
+++ b/src/jobs.h
@@ -102,7 +102,7 @@ int jobscmd(int, char **);
 struct output;
 void showjobs(struct output *, int);
 int waitcmd(int, char **);
-struct job *makejob(union node *, int);
+struct job *makejob(int);
 int forkshell(struct job *, union node *, int);
 struct job *vforkexec(union node *n, char **argv, const char *path, int idx);
 int waitforjob(struct job *);
-- 
2.37.2

