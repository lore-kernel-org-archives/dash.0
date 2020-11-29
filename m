Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0339C3E8C5
	for <linux-dash@archiver.kernel.org>; Sun, 29 Nov 2020 14:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5528120719
	for <linux-dash@archiver.kernel.org>; Sun, 29 Nov 2020 14:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="D0ZluWN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgK2OiX (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 29 Nov 2020 09:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgK2OiX (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 29 Nov 2020 09:38:23 -0500
X-Greylist: delayed 550 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 29 Nov 2020 06:37:42 PST
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83C7BC0613CF
        for <dash@vger.kernel.org>; Sun, 29 Nov 2020 06:37:42 -0800 (PST)
Received: from [192.168.1.7] (hvdijk.plus.com [81.174.157.28])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 4DBA4733;
        Sun, 29 Nov 2020 15:28:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 4DBA4733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1606660108;
        bh=6h+BVCZG5frm9RFYt2ykP4tdcl+XiS91Y1ZwivV7jGk=; l=857;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=D0ZluWN9cihrqB7w45yFgIcKfLrmlNjUvJOYO6CLofZDWETeL1LkhI+WgXN4YEEOO
         6P4ZBG4lznVfSRyR/l586xbFwMTccHWDXHG+hFs1olrSKTrpqzmA6HP8PDP8C0zKft
         ahOGae2meObnZw47PAM1cASfgaKMtUIToejTC5vw=
Subject: Re: [bug] dash eats one line
To:     Pedro <pedro@cas.cat>, dash@vger.kernel.org
References: <54057fbc-b0c2-8b56-9194-e8384238f275@cas.cat>
From:   Harald van Dijk <harald@gigawatt.nl>
Message-ID: <2b7548cb-b5bb-9b1f-3ba1-b8341f1bb7a2@gigawatt.nl>
Date:   Sun, 29 Nov 2020 14:28:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <54057fbc-b0c2-8b56-9194-e8384238f275@cas.cat>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hi,

On 27/11/2020 12:16, Pedro wrote:
> Hi,
> 
> I am using dash on debian 10 buster (stable release) which according to 
> `dpkg -S dash` is `Version: 0.5.10.2-5`
> 
> evilham encountered a bug where dash eats one line but not in freebsd's 
> shell nor bash
> 
> attached you can find an example to reproduce it
> 
> execution of the example in my computer (enableUFWRules is not in new 
> line):
> 
>   ./dash-bug.sh
> # Enable UFW rules only if requested (it was)enableUFWRules
> 
>   $ bash dash-bug.sh
> # Enable UFW rules only if requested (it was)
> enableUFWRules

This looks like 
<https://www.mail-archive.com/dash@vger.kernel.org/msg01883.html>, which 
has been fixed in dash 0.5.11. I can confirm that your script produces 
the expected output with dash 0.5.11 as well as dash built from current Git.

Cheers,
Harald van Dijk
