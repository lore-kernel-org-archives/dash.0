Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863C3C7619A
	for <linux-dash@archiver.kernel.org>; Sun,  2 Apr 2023 17:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjDBRbk (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 2 Apr 2023 13:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDBRbk (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 2 Apr 2023 13:31:40 -0400
X-Greylist: delayed 356 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 02 Apr 2023 10:31:37 PDT
Received: from pmg.in-ulm.de (pmg.in-ulm.de [IPv6:2001:1410:200:81b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9C81BFA
        for <dash@vger.kernel.org>; Sun,  2 Apr 2023 10:31:37 -0700 (PDT)
Received: from pmg.in-ulm.de (localhost.localdomain [127.0.0.1])
        by pmg.in-ulm.de (Proxmox) with ESMTP id 742462275B
        for <dash@vger.kernel.org>; Sun,  2 Apr 2023 19:25:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in-ulm.de; h=cc
        :content-transfer-encoding:content-type:content-type:date:from
        :from:in-reply-to:message-id:mime-version:references:reply-to
        :subject:subject:to:to; s=pmg; bh=KltKvFnHByBWwGA1U9EevkXgjMW2bX
        4n+EkLgyTCv60=; b=BNYHKZvFfyNk8J9wZE+y5zhWCztcjtND51bLtiR5w2u58i
        yfS7mGqr9SAFEtJ4HRVf6XWb2/k/VuITs0WNp7jOqY/AK2dUrHfxbKZ5zzLIvHBx
        0USEsJ9vRSiZWiLXP+kPo1I846rO0VM70NNDeQ3h7kwL7SvKp1f6s470uyly8=
Received: from email.in-ulm.de (email.in-ulm.de [217.10.8.14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by pmg.in-ulm.de (Proxmox) with ESMTPS
        for <dash@vger.kernel.org>; Sun,  2 Apr 2023 19:25:37 +0200 (CEST)
Message-ID: <b91caaf6-bd80-b606-3acf-0bb7dcb1ccfb@in-ulm.de>
Date:   Sun, 2 Apr 2023 19:25:36 +0200
MIME-Version: 1.0
Subject: Re: Are there users of ash's "pathopts"? Do other shells have such a
 thing?
To:     dash@vger.kernel.org
References: <aad32205-1e0a-fea6-0825-8eb45c6ae915@redhat.com>
From:   Sven Mascheck <mascheck@in-ulm.de>
In-Reply-To: <aad32205-1e0a-fea6-0825-8eb45c6ae915@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 01/04/2023 19:46, Denys Vlasenko wrote:
> I tried a few searches on the internet and this feature
> seems to be almost entirely not documented. I found exactly one
> manpage documenting it:
>
> https://www.unix.com/man-page/minix/1/ash/
>
PS: interestingly, in 4.4BSD-Alpha ('92), this feature was removed from=20
the man page.=C2=A0 sh had started aiming at POSIX and the man page was=20
completely rewritten...

Minix-2 ash was taked from the 4.3BSD-Net/2 ('91), though, which still=20
had the original Almquist man page, and so this is a rare place where=20
the documentation survived.
--=20
https://www.in-ulm.de/~mascheck/various/ash/

