Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AA1C4167B
	for <linux-dash@archiver.kernel.org>; Thu, 10 Dec 2020 07:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AEA723D4D
	for <linux-dash@archiver.kernel.org>; Thu, 10 Dec 2020 07:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbgLJH7b (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 10 Dec 2020 02:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729879AbgLJH7a (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 10 Dec 2020 02:59:30 -0500
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17248C0613CF
        for <dash@vger.kernel.org>; Wed,  9 Dec 2020 23:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=DlMltzVOtAnr+3eONUZPVI2ODuVAtJFCKKuvFlxlRcs=; b=tkOL2nqhWuv0iW5oQAJoy/qhtj
        vara0CGkwS7uDTW7h56glrosSpr7Lyqbeg/VQ4xnpkwusj2lg0SIoOioLhmfswgmTNCYsMew0rJ1R
        IXb49AdTjSXCXMlgQ5WHajX81QFSCuDVtorgO5XPTOATeyg3VyoGptKz7lfH8Lvku4rtSMyFE0hae
        5i+xniHVw6YNaCAYdXPi9uubG3ImYUi6z4Tp683ZrGB7JS8mW6TZfkjGALh4AtKq5NiN8vBdn6Q3W
        q0VM0sTB+RM/ACLRwJIGgBZ180LpeTQ1FKbZsyp39uxqb+ZCMGwA70UsWZ+fCf2wyfYmFRr5tBPXJ
        1qo3P71A==;
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <aurelien@aurel32.net>)
        id 1knGqV-0002iA-QL; Thu, 10 Dec 2020 08:58:39 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.94)
        (envelope-from <aurelien@aurel32.net>)
        id 1knGqT-00BBup-U0; Thu, 10 Dec 2020 08:58:37 +0100
Date:   Thu, 10 Dec 2020 08:58:37 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Herbert Xu <herbert@gondor.apana.org.au>, 976865@bugs.debian.org
Cc:     andrew@shadura.me, dash@vger.kernel.org, peff@peff.net
Subject: Re: Bug#976865: Fwd: Bug#974900: dash removes trailing slash from
 script arguments
Message-ID: <20201210075837.GN2297@aurel32.net>
References: <20201116094531.GA40024@coredump.intra.peff.net>
 <20201210025654.GA26577@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210025654.GA26577@gondor.apana.org.au>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 2020-12-10 13:56, Herbert Xu wrote:
> Aurelien Jarno <aurelien@aurel32.net> wrote:
> >
> > Can you please describe more precisely what is the problem with glob(3)?
> 
> It's stripping trailing slashes from the pattern, even when the
> name in question is a regular file.
> 
> https://patchwork.kernel.org/project/dash/patch/20201116025222.GA28742@gondor.apana.org.au/

That's the dash symptoms. glob(3) takes a pattern and just returns the
paths matching the pattern, as they are named on the filesystem. That
said, the option GLOB_MARK can return a trailing slash for all matched
path that are a directory.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
