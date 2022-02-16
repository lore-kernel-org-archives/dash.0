Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D5BC433EF
	for <linux-dash@archiver.kernel.org>; Wed, 16 Feb 2022 23:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237616AbiBPX2d (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 16 Feb 2022 18:28:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiBPX2d (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 16 Feb 2022 18:28:33 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C06B915B9BE
        for <dash@vger.kernel.org>; Wed, 16 Feb 2022 15:28:18 -0800 (PST)
Received: from [IPV6:2a02:8010:68a1:0:e69:c5c8:93ab:b95] (unknown [IPv6:2a02:8010:68a1:0:e69:c5c8:93ab:b95])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 94DBC4A;
        Wed, 16 Feb 2022 23:28:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 94DBC4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1645054094;
        bh=PWw2JjYIY9XsULtZsPA6/QWDKhdauXMnSYF/edMkKV0=; l=744;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BRugyUAVVMsrf6ZO8n2lFLQRvBpMjek/MmoziaVI91xIhUA2bJGgIFqDFsxbWaFLI
         zmZDbg+CJULVqFuojT7i1m83OuVWBlriPSP9dYn1tdknMLokyRKuAfLnd4koXo0IAP
         a98Zt/onQzwX42A2d4Ot2iSarQlSdQpMgXJtfU6o=
Message-ID: <13f96ba3-7d6f-fdb2-1cd8-b010465567f8@gigawatt.nl>
Date:   Wed, 16 Feb 2022 23:28:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: dash doesn't support switching LC_* during a script/session
Content-Language: en-GB
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        dash@vger.kernel.org
Cc:     Herbert Xu <herbert@gondor.apana.org.au>
References: <e312d45e17b49c418c3a62a56da758977067b563.camel@scientia.org>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <e312d45e17b49c418c3a62a56da758977067b563.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 25/01/2022 04:59, Christoph Anton Mitterer wrote:
> Now I'm not really sure whether or not POSIX mandates that this should
> work or whether it's unspecified.

You were right to guess that POSIX does mandate that shells support 
locales. The lack thereof is a longstanding area of nonconformance in dash.

To be fair though, I suspect it is also one of the lesser requested 
features, and getting all the details right is a rather large 
undertaking. It's doable in the current design, but it's not easy and 
there are a lot of non-obvious corner cases to consider. If this ever 
gets started, and locale support is something you are looking for, I 
would encourage you to help out by testing extensively.

Cheers,
Harald van Dijk
