Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23D9C433F5
	for <linux-dash@archiver.kernel.org>; Tue,  2 Nov 2021 12:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C932D60EB9
	for <linux-dash@archiver.kernel.org>; Tue,  2 Nov 2021 12:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhKBMuc (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 2 Nov 2021 08:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhKBMuc (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 2 Nov 2021 08:50:32 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF16C061714
        for <dash@vger.kernel.org>; Tue,  2 Nov 2021 05:47:57 -0700 (PDT)
Received: from [IPV6:2a01:c846:1980:2500:6e66:64fa:396d:a0b3] (unknown [IPv6:2a01:c846:1980:2500:6e66:64fa:396d:a0b3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: andrewsh)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id AF20F1F439AB
        for <dash@vger.kernel.org>; Tue,  2 Nov 2021 12:47:55 +0000 (GMT)
Message-ID: <46266bf7-82ec-945e-7645-6d65b5393119@collabora.co.uk>
Date:   Tue, 2 Nov 2021 13:47:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: Testing dash on a new OS?
Content-Language: en-GB
References: <DM6PR11MB34686DFD31F7C9C07D3F8B1D998B9@DM6PR11MB3468.namprd11.prod.outlook.com>
 <BL0PR11MB34587FF7466464F0C18F2C68998B9@BL0PR11MB3458.namprd11.prod.outlook.com>
From:   Andrej Shadura <andrew.shadura@collabora.co.uk>
To:     dash <dash@vger.kernel.org>
Organization: Collabora
In-Reply-To: <BL0PR11MB34587FF7466464F0C18F2C68998B9@BL0PR11MB3458.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hi,

On 02/11/2021 01:45, Kuhl, Brian wrote:
> Myself and an intern are working on porting dash to VxWorks.
> https://www.windriver.com/products/vxworks
> 
> I've found harness for testing scripts, I haven't found anything for verifying dash itself?
> How does Debian, or any other distro, (or for that matter a BSD),  regression test dash?

Answering for Debian: we don’t really. There is only a smoke test 
verifying dash exists and symlinks to it are all in place, but nothing 
more than that at the moment.

-- 
Cheers,
   Andrej
