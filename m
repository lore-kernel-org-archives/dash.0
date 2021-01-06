Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B0FC433DB
	for <linux-dash@archiver.kernel.org>; Wed,  6 Jan 2021 04:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC06E22D01
	for <linux-dash@archiver.kernel.org>; Wed,  6 Jan 2021 04:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbhAFEqI (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 5 Jan 2021 23:46:08 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:59424 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbhAFEqI (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 5 Jan 2021 23:46:08 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kx0h6-0007Le-It; Wed, 06 Jan 2021 15:45:13 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 06 Jan 2021 15:45:12 +1100
Date:   Wed, 6 Jan 2021 15:45:12 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     steffen@sdaoden.eu, dash@vger.kernel.org, vda.linux@googlemail.com,
        jilles@stack.nl
Subject: [PATCH] jobs: Block signals during tcsetpgrp
Message-ID: <20210106044512.GA28191@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bb6fbb5-20e1-eae1-0144-67a4c7e20496@gigawatt.nl>
X-Newsgroups: apana.lists.os.linux.dash
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Harald van Dijk <harald@gigawatt.nl> wrote:
> On 19/12/2020 22:21, Steffen Nurpmeso wrote:
>> Steffen Nurpmeso wrote in
>>   <20201219172838.1B-WB%steffen@sdaoden.eu>:
>>   |Long story short, after falsely accusing BSD make of not working
>> 
>> After dinner i shortened it a bit more, and attach it again, ok?
>> It is terrible, but now less redundant than before.
>> Sorry for being so terse, that problem crosses my head for about
>> a week, and i was totally mislead and if you bang your head
>> against the wall so many hours bugs or misbehaviours in a handful
>> of other programs is not the expected outcome.
> 
> I think a minimal test case is simply
> 
> all:
>         $(SHELL) -c 'trap "echo TTOU" TTOU; set -m; echo all good'
> 
> unless I accidentally oversimplified.
> 
> The SIGTTOU is caused by setjobctl's xtcsetpgrp(fd, pgrp) call to make 
> its newly started process group the foreground process group when job 
> control is enabled, where xtcsetpgrp is a wrapper for tcsetpgrp. (That's 
> in dash, the other variants may have some small differences.) tcsetpgrp 
> has this little bit in its specification:
> 
>        Attempts to use tcsetpgrp() from a process which is a member of
>        a background process group on a fildes associated with its con‐
>        trolling  terminal  shall  cause the process group to be sent a
>        SIGTTOU signal. If the calling thread is blocking SIGTTOU  sig‐
>        nals  or  the  process is ignoring SIGTTOU signals, the process
>        shall be allowed to perform the operation,  and  no  signal  is
>        sent.
> 
> Ordinarily, when job control is enabled, SIGTTOU is ignored. However, 
> when a trap action is specified for SIGTTOU, the signal is not ignored, 
> and there is no blocking in place either, so the tcsetpgrp() call is not 
> allowed.
> 
> The lowest impact change to make here, the one that otherwise preserves 
> the existing shell behaviour, is to block signals before calling 
> tcsetpgrp and unblocking them afterwards. This ensures SIGTTOU does not 
> get raised here, but also ensures that if SIGTTOU is sent to the shell 
> for another reason, there is no window where it gets silently ignored.
> 
> Another way to fix this is by not trying to make the shell start a new 
> process group, or at least not make it the foreground process group. 
> Most other shells appear to not try to do this.

This patch implements the blocking of SIGTTOU (and everything else)
while we call tcsetpgrp.

Reported-by: Steffen Nurpmeso <steffen@sdaoden.eu>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/jobs.c b/src/jobs.c
index 516786f..809f37c 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -1512,7 +1512,13 @@ showpipe(struct job *jp, struct output *out)
 STATIC void
 xtcsetpgrp(int fd, pid_t pgrp)
 {
-	if (tcsetpgrp(fd, pgrp))
+	int err;
+
+	sigblockall(NULL);
+	err = tcsetpgrp(fd, pgrp);
+	sigclearmask();
+
+	if (err)
 		sh_error("Cannot set tty process group (%s)", strerror(errno));
 }
 #endif
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
