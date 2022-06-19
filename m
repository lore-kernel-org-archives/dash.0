Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A384C433EF
	for <linux-dash@archiver.kernel.org>; Sun, 19 Jun 2022 07:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiFSHmy (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 19 Jun 2022 03:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiFSHmy (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 19 Jun 2022 03:42:54 -0400
X-Greylist: delayed 407 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 19 Jun 2022 00:42:53 PDT
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F34F1009
        for <dash@vger.kernel.org>; Sun, 19 Jun 2022 00:42:53 -0700 (PDT)
Received: from [IPV6:2a02:8010:68a1:0:26d4:234:5292:8b5e] (unknown [IPv6:2a02:8010:68a1:0:26d4:234:5292:8b5e])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id EDFCE761;
        Sun, 19 Jun 2022 08:36:02 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl EDFCE761
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1655624163;
        bh=/meOhqSgA0PSlRyHsKi+wxfhI+GhemdLIjmd5vPaJ5o=; l=837;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=hHH55tdWf3+zSERQMSuoOEhOz9ZU+h4uiT39Qh5kvFS2dmpnuoJ6qwERHIrg5C8IE
         k4o+PdLcqdE/enl4ndkmEoRF0eLhtSISzgHKKjCAYaif2mTMs3icFByNFsj0PLym4x
         +NWhhgLEG0fUeFf1REyT1cNGnVwdaOr9jQbJ+Myc=
Message-ID: <e8090128-4bc2-ffed-b357-f8e6b562928b@gigawatt.nl>
Date:   Sun, 19 Jun 2022 08:36:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: COPYING: Copyright information mentions bash
To:     Akbarkhon Variskhanov <akbarkhon.variskhanov@gmail.com>,
        dash@vger.kernel.org
References: <CANeoM1H9YAPv4y1QLF-bt3j74BmJpxSrH7SwU=EdOOVFvqq56Q@mail.gmail.com>
Content-Language: en-US
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <CANeoM1H9YAPv4y1QLF-bt3j74BmJpxSrH7SwU=EdOOVFvqq56Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 19/06/2022 07:03, Akbarkhon Variskhanov wrote:
> Quoting the relevant paragraphs:
> 
> This file is part of GNU Bash, the Bourne Again SHell.
> 
> Bash is free software; you can redistribute it and/or modify it under
> the terms of the GNU General Public License as published by the Free
> Software Foundation; either version 2, or (at your option) any later
> version.
> 
> Bash is distributed in the hope that it will be useful, but WITHOUT ANY
> WARRANTY; without even the implied warranty of MERCHANTABILITY or
> FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> for more details.

Yes, dash makes use of bash's mksignames.c at build time. This is noted 
above the bit you have quoted. Including copyrighted code from bash 
requires including bash's copyright notice.

Cheers,
Harald van Dijk
