Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFAAC433DB
	for <linux-dash@archiver.kernel.org>; Tue, 12 Jan 2021 06:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E946722571
	for <linux-dash@archiver.kernel.org>; Tue, 12 Jan 2021 06:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731594AbhALGMK (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 12 Jan 2021 01:12:10 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:57736 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731183AbhALGMJ (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 12 Jan 2021 01:12:09 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kzCtj-00050T-QV; Tue, 12 Jan 2021 17:11:20 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 12 Jan 2021 17:11:19 +1100
Date:   Tue, 12 Jan 2021 17:11:19 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] jobs: Always reset SIGINT/SIGQUIT handlers
Message-ID: <20210112061119.GA1350@gondor.apana.org.au>
References: <20180518183844.zizl3xevlcm4gzsj@gondor.apana.org.au>
 <E1fJkIG-0005qH-BW@gondobar>
 <4bcabb9a-5684-98ee-e7ae-e162c985be0d@gigawatt.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bcabb9a-5684-98ee-e7ae-e162c985be0d@gigawatt.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Fri, Jan 08, 2021 at 08:55:41PM +0000, Harald van Dijk wrote:
> On 18/05/2018 19:39, Herbert Xu wrote:
> > This patch adds basic vfork support for the case of a simple command.
> > ...  @@ -879,17 +892,30 @@ forkchild(struct job *jp, union node *n, int
> > mode)
> >   		}
> >   	}
> >   	if (!oldlvl && iflag) {
> > -		setsignal(SIGINT);
> > -		setsignal(SIGQUIT);
> > +		if (mode != FORK_BG) {
> > +			setsignal(SIGINT);
> > +			setsignal(SIGQUIT);
> > +		}
> >   		setsignal(SIGTERM);
> >   	}
> > +
> > +	if (lvforked)
> > +		return;
> > +
> >   	for (jp = curjob; jp; jp = jp->prev_job)
> >   		freejob(jp);
> >   }
> 
> This leaves SIGQUIT ignored in background jobs in interactive shells.
> 
>   ENV= dash -ic 'dash -c "kill -QUIT \$\$; echo huh" & wait'
> 
> As of dash 0.5.11, this prints "huh". Before, the subprocess process killed
> itself before it could print anything. Other shells do not leave SIGQUIT
> ignored.
> 
> (In a few other shells, this also prints "huh", but in those other shells,
> that is because the inner shell chooses to ignore SIGQUIT, not because the
> outer shell leaves it ignored.)

Thanks for catching this.  I have no idea how that got in there
and it makes no sense whatsoever.  This patch removes the if
conditional.

Fixes: e94a964e7dd0 ("eval: Add vfork support")
Reported-by: Harald van Dijk <harald@gigawatt.nl>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/jobs.c b/src/jobs.c
index 516786f..08c4f13 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -892,10 +892,8 @@ static void forkchild(struct job *jp, union node *n, int mode)
 		}
 	}
 	if (!oldlvl && iflag) {
-		if (mode != FORK_BG) {
-			setsignal(SIGINT);
-			setsignal(SIGQUIT);
-		}
+		setsignal(SIGINT);
+		setsignal(SIGQUIT);
 		setsignal(SIGTERM);
 	}
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
