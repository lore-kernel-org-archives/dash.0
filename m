Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAECC54EB4
	for <linux-dash@archiver.kernel.org>; Sun, 22 Jan 2023 15:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjAVPKD (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 22 Jan 2023 10:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjAVPKC (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 22 Jan 2023 10:10:02 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B8701C30E
        for <dash@vger.kernel.org>; Sun, 22 Jan 2023 07:10:00 -0800 (PST)
Received: from [192.168.178.37] (uk.gigawatt.nl [51.148.134.205])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id EF00B11BC
        for <dash@vger.kernel.org>; Sun, 22 Jan 2023 15:09:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl EF00B11BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1674400198;
        bh=VnyndE2dYGWTxw9CNCgDZzf2itcrdl8+rTcKbRx1Y7I=; l=625;
        h=Date:Subject:From:To:References:In-Reply-To:From;
        b=SAf+7HUJWOmCxiRfaL/yAVQlvMowFHuep/LI+3E0KKh+au1YKI6qJOD87WQ0Ub5my
         Cw1Ff7E3/863h3hTgKKh9t51wq1Wr/MvtOb+RHf1hBf94s/LXFiHfvxSIN6Z4x/h4N
         gKrVXGjN9vgEB5/aG9vfYy9FpZOde4XKMhxsylD8=
Message-ID: <bc839b61-a7d5-6a36-ed47-db8363989379@gigawatt.nl>
Date:   Sun, 22 Jan 2023 15:09:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101
 Thunderbird/109.0
Subject: Re: Out-of-bounds access in alias command
Content-Language: en-US
From:   Harald van Dijk <harald@gigawatt.nl>
To:     DASH shell mailing list <dash@vger.kernel.org>
References: <696b6e2b-be79-77a7-a880-66de28012c57@gigawatt.nl>
In-Reply-To: <696b6e2b-be79-77a7-a880-66de28012c57@gigawatt.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 09/01/2023 00:02, Harald van Dijk wrote:
> Hi,
> 
> Consider
> 
>    alias ""
> 
> In aliascmd(), we have
> 
>      while ((n = *++argv) != NULL) {
>        if ((v = strchr(n+1, '=')) == NULL) { /* n+1: funny ksh stuff */

I had trusted that this "n+1: funny ksh stuff" logic which allows an 
alias to start with = was because ksh allows this, but I tested this 
now, it does not and I can find no evidence that it ever did. Maybe it 
would be good to just remove this exception, or if dash wants to keep 
it, document it as an ash extension rather than claim it as a ksh thing?

Cheers,
Harald van Dijk
