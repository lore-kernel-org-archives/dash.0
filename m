Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCEBC433B4
	for <linux-dash@archiver.kernel.org>; Mon, 17 May 2021 07:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A019C61108
	for <linux-dash@archiver.kernel.org>; Mon, 17 May 2021 07:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhEQHUo (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 17 May 2021 03:20:44 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:51722 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232261AbhEQHUn (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 17 May 2021 03:20:43 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.89 #2 (Debian))
        id 1liXXB-0003Hu-4E; Mon, 17 May 2021 15:19:25 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1liXX9-000453-Fu; Mon, 17 May 2021 15:19:23 +0800
Date:   Mon, 17 May 2021 15:19:23 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Patrick =?iso-8859-1?Q?Br=FCnn?= <P.Bruenn@beckhoff.com>
Cc:     dash@vger.kernel.org
Subject: eval: Do not cache value of eflag in evaltree
Message-ID: <20210517071923.vv3qfm23mven7je3@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ee35167691c1b1e42100f91842f07cbe817b337.camel@beckhoff.com>
X-Newsgroups: apana.lists.os.linux.dash
Organization: Core
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Patrick Brünn <P.Bruenn@beckhoff.com> wrote:
> 
> Since we are migrating to Debian bullseye, we discovered a new behavior
> with our scripts, which look like this:
>>#!/bin/sh
>>cleanup() {
>>        set +e^M
>>        rmdir ""
>>}
>>set -eu
>>trap 'cleanup' EXIT INT TERM
>>echo 'Hello world!'
> 
> With old dash v0.5.10.2 this script would return 0 as we expected it.
> But since commit 62cf6955f8abe875752d7163f6f3adbc7e49ebae it returns
> the last exit code of our cleanup function.
> Reverting that commit gives a merge conflict, but it seems to fix _our_
> problem. As that topic appears too complex to us I want to ask the
> experts here:
> 
> Is this change in behavior intended, by dash?
> 
> Our workaround at the moment would be:
>>trap 'cleanup || true' EXIT INT TERM

Thanks for the report.  This is actually a fairly old bug with
set -e that's just been exposed by the exit status change.  What's
really happening is that cleanup itself is triggering a set -e
exit incorrectly because evaltree cached the value of eflag prior
to the function call.

This patch should fix the problem.

Reported-by: Patrick Brünn <P.Bruenn@beckhoff.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/eval.c b/src/eval.c
index 9476fbb..3337f71 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -252,18 +252,10 @@ evaltree(union node *n, int flags)
 			popredir(0);
 		goto setstatus;
 	case NCMD:
-#ifdef notyet
-		if (eflag && !(flags & EV_TESTED))
-			checkexit = ~0;
-		status = evalcommand(n, flags, (struct backcmd *)NULL);
-		goto setstatus;
-#else
 		evalfn = evalcommand;
 checkexit:
-		if (eflag && !(flags & EV_TESTED))
-			checkexit = ~0;
+		checkexit = ~flags & EV_TESTED;
 		goto calleval;
-#endif
 	case NFOR:
 		evalfn = evalfor;
 		goto calleval;
@@ -323,7 +315,7 @@ setstatus:
 out:
 	dotrap();
 
-	if (checkexit & status)
+	if (eflag && checkexit && status)
 		goto exexit;
 
 	if (flags & EV_EXIT) {
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
