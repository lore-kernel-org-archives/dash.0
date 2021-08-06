Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3875C432BE
	for <linux-dash@archiver.kernel.org>; Fri,  6 Aug 2021 08:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9911561179
	for <linux-dash@archiver.kernel.org>; Fri,  6 Aug 2021 08:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243964AbhHFI7C (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 6 Aug 2021 04:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243979AbhHFI7B (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 6 Aug 2021 04:59:01 -0400
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTP id 1BC0AC06179B
        for <dash@vger.kernel.org>; Fri,  6 Aug 2021 01:58:46 -0700 (PDT)
Received: from [IPV6:2a02:8010:68a1:0:e69:c5c8:93ab:b95] (unknown [IPv6:2a02:8010:68a1:0:e69:c5c8:93ab:b95])
        by mail.gigawatt.nl (Postfix) with UTF8SMTPSA id 3F423479;
        Fri,  6 Aug 2021 09:58:43 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 3F423479
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1628240323;
        bh=rQTmXp6mU1nLR8gIymVhIOYYap/B8cUCCdUUgOXowak=; l=839;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=nzcwIXR5jc7S+snrlFEg6vZJD6PLieNHQDkMTHky9FWrDz2nYDY5nGorVServo2j1
         KPLJbITJ8SBWFoVqOVrh5oNbs+uIERN35J7pw6/4rp7sk5v007kI0i7GYsNrXgdvtM
         1FEcpDa7oD+Qkjn02YMy+NBhNiVfstCzH1Y2PK/o=
Message-ID: <86e0cece-6580-a824-ca6e-59c952405219@gigawatt.nl>
Date:   Fri, 6 Aug 2021 09:58:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:90.0) Gecko/20100101
 Thunderbird/90.0
Subject: Re: Add arrow key input support in dash
Content-Language: en-GB
To:     Evan Greenup <evan_greenup@protonmail.com>,
        "dash@vger.kernel.org" <dash@vger.kernel.org>
References: <vadcxaUwudHIw3-PqrvheMiaoXWZYFKJGs8m26VdcbsmFS6qf2-SqWD3SEvRI1RymevQyewkWL6ktfnjxnT006fzGl7nREa4mErOSEKgv6c=@protonmail.com>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <vadcxaUwudHIw3-PqrvheMiaoXWZYFKJGs8m26VdcbsmFS6qf2-SqWD3SEvRI1RymevQyewkWL6ktfnjxnT006fzGl7nREa4mErOSEKgv6c=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hi,

On 06/08/2021 09:45, Evan Greenup wrote:
> Although dash is lite and simplified edition of bash, It doesn't support arrow key to move the cursor position.
> 
> In order to improve performance, a lot of feature in bash are removed in dash.
> 
> Add arrow key support will not cost too much performance.
> 
> Currently it dash is like that:
> 
> ```sh
> $ echo hello
> hello
> $ echo ^[[D^[[D^[[D^[[D^[[C^[[C^[[C^[[C^[[A^[[A^[[A^[[A^[[A^[[B^[[B^[[B^[[B^[[B
> 
> $ ^[[D^[[A^[[C^[[B^[[D^[[A^[[C^[[B^[[D^[[A^[[C^[[B
> 
> ```
> 
> The cursor won't move but only append unexpected character.

This is configurable. When dash is built with libedit support (configure 
--with-libedit), and the emacs or vi option is enabled, libedit is used 
for entering commands which will handle this (and more).

Cheers,
Harald van Dijk
