Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEA7C433FE
	for <linux-dash@archiver.kernel.org>; Fri, 22 Apr 2022 22:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbiDVWWK (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbiDVWWC (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 22 Apr 2022 18:22:02 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70CD338253
        for <dash@vger.kernel.org>; Fri, 22 Apr 2022 14:12:50 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v12so5915664wrv.10
        for <dash@vger.kernel.org>; Fri, 22 Apr 2022 14:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisn.me.uk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ademG7SZXF2h4AnJg075pDYfcVwh2CxMKwCLJMs4jg=;
        b=B/svTO8V+Lkp2OTFfnZtWrJLVCJEpd1+pDXdfkR8N/vmWmweyvTirgoOwO4gBEgrJ6
         9c1M18gNlYva80wK/wfgJf4oXOv7YzHYDVP5ttURiVFShOC2CAUS3+kV5bNYGTsmZtoQ
         9tacD9ukaIUg+KAntSc4QK1+iiMNgTZef4ejA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ademG7SZXF2h4AnJg075pDYfcVwh2CxMKwCLJMs4jg=;
        b=tXQhV5+N2B5+N64HvI8UO5H4X6weT0QLN+reabemOoeZhfG5JOmsVyzNvfvcA37vl0
         rUDAry6jIFGbgLo4v+933cM7c5zpbdkMBQzNHmher7JZS5KOUK+Kj4HjGhi4oxHuFmWy
         50/EoB4GVOD67oyv9qSWMIzVeZN9Gm1VvKUV5WFHdog66VJDGkudxwrbbq5XIYIYv9X1
         aKRcOXYcoKbmBTIbNiyXC7dVymiG2boDPT4RjzmJZz8m1SBWULTpbFTDdnrJUbVJyygv
         pg+9o/17LNe882pAxupXifQk8rXErtPQF2eRjS4hU0Ii+gH1eLLgkXn3aVeaSoCyfjrA
         mj8A==
X-Gm-Message-State: AOAM533ocyEdiITBUMGopsvqzAPXXetVXlKtpkDvSYX9rgUxPQkmfxfK
        fy/eft+k6JERd1NDoj9/ZEMdk0uY40sx7g==
X-Google-Smtp-Source: ABdhPJw7fuJgXNiuYgkm7uHxwxVeBTue6MeZ5YVhE5HQvVFvZL51FZcMpsXcl0JCXBwXZlIOSMk3ZA==
X-Received: by 2002:adf:d4ce:0:b0:20a:b38e:ff7f with SMTP id w14-20020adfd4ce000000b0020ab38eff7fmr5053483wrk.276.1650661969348;
        Fri, 22 Apr 2022 14:12:49 -0700 (PDT)
Received: from localhost.localdomain (cpc83467-wolv18-2-0-cust127.16-1.cable.virginm.net. [82.32.92.128])
        by smtp.gmail.com with ESMTPSA id z14-20020a7bc14e000000b00392a3e62b66sm2346985wmi.33.2022.04.22.14.12.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Apr 2022 14:12:48 -0700 (PDT)
From:   Chris Novakovic <chris@chrisn.me.uk>
To:     dash@vger.kernel.org
Cc:     Chris Novakovic <chris@chrisn.me.uk>
Subject: [PATCH] jobs: Implement pipefail option
Date:   Fri, 22 Apr 2022 22:10:13 +0100
Message-Id: <20220422211013.18195-1-chris@chrisn.me.uk>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

With the pipefail option set, a pipeline's exit status is the exit
status of the rightmost command that failed, or zero if all commands
succeeded.

This is planned for inclusion in the next revision of POSIX [1],
although the details are yet to be finalised. The semantics of this
implementation are the same as those proposed in [2], which have also
been adopted by the BSD shells.

[1] https://www.austingroupbugs.net/view.php?id=789
[2] https://www.austingroupbugs.net/view.php?id=789#c4115
---
 src/dash.1    | 31 ++++++++++++++++++++++++-------
 src/jobs.c    |  9 ++++++++-
 src/options.c |  2 ++
 src/options.h |  5 +++--
 4 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/src/dash.1 b/src/dash.1
index ff02237..7a7b162 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -553,13 +553,17 @@ by redirection operators that are part of the command.
 If the pipeline is not in the background (discussed later), the shell
 waits for all commands to complete.
 .Pp
-If the reserved word ! does not precede the pipeline, the exit status is
-the exit status of the last command specified in the pipeline.
-Otherwise, the exit status is the logical NOT of the exit status of the
-last command.
-That is, if the last command returns zero, the exit status
-is 1; if the last command returns greater than zero, the exit status is
-zero.
+If the
+.Em pipefail
+option was enabled when the shell began execution of the pipeline, the
+pipeline's exit status is the exit status of the last command specified in
+the pipeline that exited with non-zero status, or zero if all commands in
+the pipeline exited with a status of zero. If the
+.Em pipefail
+option was not enabled, the pipeline's exit status is the exit status of
+the last command specified in the pipeline; the exit statuses of any other
+commands are not used. If the reserved word ! precedes the pipeline, its
+exit status is the logical NOT of the exit status described above.
 .Pp
 Because pipeline assignment of standard input or standard output or both
 takes place before redirection, it can be modified by redirection.
@@ -1791,6 +1795,19 @@ if the option is +o,
 the settings are printed in a format suitable for
 reinput to the shell to affect the same option settings.
 .Pp
+In addition to the option names listed in the
+.Sx Argument List Processing
+section, the following options may be specified as arguments
+to -o or +o:
+.Bl -tag -width pipefail
+.It Em pipefail
+Derive the exit status of a pipeline from the exit statuses of all
+of the commands in the pipeline, not just the last command, as
+described in the
+.Sx Pipelines
+section.
+.El
+.Pp
 The third use of the set command is to set the values of the shell's
 positional parameters to the specified args.
 To change the positional
diff --git a/src/jobs.c b/src/jobs.c
index f3b9ffc..78c7bc6 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -1526,8 +1526,15 @@ STATIC int
 getstatus(struct job *job) {
 	int status;
 	int retval;
+	struct procstat *ps;
+
+	ps = job->ps + job->nprocs - 1;
+	status = ps->status;
+	if (pipefail) {
+		while (status == 0 && --ps >= job->ps)
+			status = ps->status;
+	}
 
-	status = job->ps[job->nprocs - 1].status;
 	retval = WEXITSTATUS(status);
 	if (!WIFEXITED(status)) {
 #if JOBS
diff --git a/src/options.c b/src/options.c
index a46c23b..cc0f70d 100644
--- a/src/options.c
+++ b/src/options.c
@@ -80,6 +80,7 @@ static const char *const optnames[NOPTS] = {
 	"notify",
 	"nounset",
 	"nolog",
+	"pipefail",
 	"debug",
 };
 
@@ -101,6 +102,7 @@ const char optletters[NOPTS] = {
 	'u',
 	0,
 	0,
+	0,
 };
 
 char optlist[NOPTS];
diff --git a/src/options.h b/src/options.h
index 975fe33..f421316 100644
--- a/src/options.h
+++ b/src/options.h
@@ -60,9 +60,10 @@ struct shparam {
 #define	bflag optlist[13]
 #define	uflag optlist[14]
 #define	nolog optlist[15]
-#define	debug optlist[16]
+#define	pipefail optlist[16]
+#define	debug optlist[17]
 
-#define NOPTS	17
+#define NOPTS	18
 
 extern const char optletters[NOPTS];
 extern char optlist[NOPTS];
-- 
2.30.0

