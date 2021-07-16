Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDFBC07E95
	for <linux-dash@archiver.kernel.org>; Fri, 16 Jul 2021 10:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAF426115A
	for <linux-dash@archiver.kernel.org>; Fri, 16 Jul 2021 10:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbhGPKMc (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 16 Jul 2021 06:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236772AbhGPKMa (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 16 Jul 2021 06:12:30 -0400
X-Greylist: delayed 539 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 16 Jul 2021 03:09:35 PDT
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8AFBEC06175F
        for <dash@vger.kernel.org>; Fri, 16 Jul 2021 03:09:35 -0700 (PDT)
Received: from [IPv6:2a02:8010:68a1:0:e69:c5c8:93ab:b95] (unknown [IPv6:2a02:8010:68a1:0:e69:c5c8:93ab:b95])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id C47764A5;
        Fri, 16 Jul 2021 11:00:33 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl C47764A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1626429633;
        bh=Xn6l4T1HKTmnjNTjsoTVE3lnHmwi7u6YKXAjq7hL2yY=; l=1116;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=eoffdkHSneSN0nOdXvtLddfFHXH2PUZuljGDgg8uv1HtX05BSSxIJ2yEPCM6yZ6W/
         JvlTjDsKuatKBIrnXlvkmE+ez1Ef2Z7XRnMZOjSsHs930To8+Hnoh+Ccmzj5QPh9QM
         0uFrP+orIW+aIwDWPDrPPV0jvP3M9Flj2irZ/5bA=
Subject: Re: [PATCH] expand: Recognize '^' as a negation character in BE
To:     Dimitar Yurukov <mscalindt@gmail.com>, dash@vger.kernel.org
References: <20210716094227.15177-1-mscalindt@gmail.com>
From:   Harald van Dijk <harald@gigawatt.nl>
Message-ID: <0c417093-cc75-7ac6-c2a8-6b46041168c8@gigawatt.nl>
Date:   Fri, 16 Jul 2021 11:00:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716094227.15177-1-mscalindt@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 16/07/2021 10:42, Dimitar Yurukov wrote:
> While parsing bracket expression ('[...]'), DASH recognizes only '!' as
> a special character for negation/inversion, but POSIX specifies '^'.
> 
> The POSIX specification (2018 edition) states:
> 
>    ^ The <circumflex> shall signify a non-matching list expression when
>      it occurs first in a list, immediately following a
>      <left-square-bracket> (see RE Bracket Expression).

It also states:

   the <exclamation-mark> character ( '!' ) shall replace the 
<circumflex> character ( '^' ) in its role in a non-matching list in the 
regular expression notation

and

   A bracket expression starting with an unquoted <circumflex> character 
produces unspecified results.

See 2.13.1 Patterns Matching a Single Character.

So both the dash and the bash behaviour are permitted and this patch 
does not address a correctness issue. Scripts that rely on ^ for 
negation should be modified to use !.

The patch may still be worthwhile to increase compatibility, but in that 
case the same change also needs to be made to expmeta().

Cheers,
Harald van Dijk
