Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FCFC433FE
	for <linux-dash@archiver.kernel.org>; Mon, 21 Nov 2022 15:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbiKUPYx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 21 Nov 2022 10:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiKUPYe (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 21 Nov 2022 10:24:34 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2692980B
        for <dash@vger.kernel.org>; Mon, 21 Nov 2022 07:24:20 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 14D1482130A;
        Mon, 21 Nov 2022 15:24:20 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2D13A821462;
        Mon, 21 Nov 2022 15:24:19 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1669044259; a=rsa-sha256;
        cv=none;
        b=4FbxJ/dhSkoViiRcWvO4RO4t4XbddtHJWEOXtVKbkgH3daVaIkuvrFxMzVmppt2Nrvx6QT
        YRNqCmVTsm+4cerPB2Ddxg8fQ/1C/I58o2gg31EtSlbAZpVifgDRelJ9NJjGwQEEBaDuwb
        wqwFZrqUpqLziKEkZqXE+Cg6jW4pcLcLLpsfap6WG+nSM4kysbWJKUxpjZrh2TSOnn6zUb
        4u9nuTQqUKa2yZntjPWf8fMPd/vqAg1vzj54mPUUy5H4Rx7YoLBpMkxRxiI20AkTKwHXMX
        1MlyuRF9Z1WK2a4LW/kWUdiFEHB8po5WvaswCYtD8XnYLkobkGsvZyGlBuzLjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1669044259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mLJuXiIe7bhQMGvBARgSZ4nSSNwUxDV9gEk6QUTnPrU=;
        b=7WoqfahPcUnsoel1rodjBNJmWSEiBMfWKxWieAhA0frJnwQJt/sVJxNzN6vbd+d56I5h0d
        IXaJfx7LFrwzfjZg08+B3wCOYTFP9QwYSVjS85ANDcKcjyauTsWEObAfkIHfVhWbesD/4L
        fhkHmU77QCu8w0MfuE1YE/5DnZ2xn6qUHxxUVxdt+uYAWLu1ERYXg3x1wtx2c61PwZokb5
        faqDgeibd/domgfAB1Xb0c2IWgMFnvpMeVxFrDhp3PJKeQ9UcgR0L7ltVw4rff7v7B5jkg
        QCd+LQ2anvXN3i1g09UXj1b8E+Ucw6ZGRQfBCsGmDglk6Q7Jicx9wEzUrgPEuA==
ARC-Authentication-Results: i=1;
        rspamd-64c57ffbcf-wvgmc;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Cold-Callous: 0a6b97185ad8db62_1669044259815_3335327382
X-MC-Loop-Signature: 1669044259815:1257925289
X-MC-Ingress-Time: 1669044259815
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.109.196.246 (trex/6.7.1);
        Mon, 21 Nov 2022 15:24:19 +0000
Received: from p57b04dfc.dip0.t-ipconnect.de ([87.176.77.252]:32982 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1ox8eb-00064X-4I;
        Mon, 21 Nov 2022 15:24:17 +0000
Message-ID: <b03e330140ee8f8bd963ed7de0abb7cc55028797.camel@scientia.org>
Subject: Re: segfault with invalid shell script
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     dash@vger.kernel.org
Date:   Mon, 21 Nov 2022 16:24:12 +0100
In-Reply-To: <6af07303-357f-6274-6c16-df00835c7f6c@gigawatt.nl>
References: <b2e298215b3d51d8284296484caa138faddaa0e4.camel@scientia.org>
         <6af07303-357f-6274-6c16-df00835c7f6c@gigawatt.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.1-1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hey Harald

On Mon, 2022-11-21 at 13:08 +0000, Harald van Dijk wrote:
> 
> This is intentionally accepted, like all non-standard 
> substitutions, during parsing, but is supposed to raise a
> substitution 
> error at runtime, so that scripts can do
> 
>    if shell_supports_subst; then
>      echo ${var//a/b}
>    else
>      echo $var | sed s/a/b/g
>    fi
> 
> Parsing this if statement requires parsing both sides of the branch, 
> even ${var//a/b} will never be evaluated.

Well, while I can understand the merit of this... it may also have some
drawbacks.


> Actually performing this substitution should result in an error:
> 
>    $ dash -c 'echo ${$//1/2}'
>    dash: 1: Bad substitution

It does here, too.

> What the intended behaviour here is though, is unclear. The
> substitution 
> containing ${...//...} is evaluated but the ${...//...} is skipped 
> because $restrict_path_list is unset.

In the original script, it may be set. I just shortened it.


> Fixing this so it produces "Bad substitution" should be easy, almost 
> trivial.

I, personally, would like that anyway better.

Conditionally choosing the variant of shell command language during
runtime seems quite fragile.
I'd rather see straight away, that I use something non-supported.



Is there some bugtracker for dash, so that it doesn't get forgotten?


Thanks,
Chris.
