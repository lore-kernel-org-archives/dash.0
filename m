Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59612C4332D
	for <linux-dash@archiver.kernel.org>; Fri,  8 Jan 2021 20:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32B1823A7C
	for <linux-dash@archiver.kernel.org>; Fri,  8 Jan 2021 20:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbhAHU4Z (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 8 Jan 2021 15:56:25 -0500
Received: from mail.gigawatt.nl ([51.68.198.76]:38222 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729514AbhAHU4Y (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 8 Jan 2021 15:56:24 -0500
Received: from [192.168.1.5] (92.40.194.146.threembb.co.uk [92.40.194.146])
        by mail.gigawatt.nl (Postfix) with UTF8SMTPSA id AF942443;
        Fri,  8 Jan 2021 21:55:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl AF942443
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1610139342;
        bh=rhPrxh8FkuU9aLB+aViewXxyqGQrSy4p6FIEsUvFMOY=; l=1014;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=NKyngQXoQQd7Jfr4v/6JF49+Ycg4zdB9wk73UCHcKE+qZDf5HTihQzjyJEDnFZ8/c
         ku0o5rVKCuMKnHr2jP3SUnB/YXBeUUy8Rc51RiT2/X7dRLwzEEcsSBDUrtj8zxZJIs
         d2O9YoZoDknYuOmf/9AH8mv1q/iPbN7cK4mXKStM=
Subject: Re: [v3 PATCH 17/17] eval: Add vfork support
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        DASH Mailing List <dash@vger.kernel.org>
References: <20180518183844.zizl3xevlcm4gzsj@gondor.apana.org.au>
 <E1fJkIG-0005qH-BW@gondobar>
From:   Harald van Dijk <harald@gigawatt.nl>
Message-ID: <4bcabb9a-5684-98ee-e7ae-e162c985be0d@gigawatt.nl>
Date:   Fri, 8 Jan 2021 20:55:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <E1fJkIG-0005qH-BW@gondobar>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 18/05/2018 19:39, Herbert Xu wrote:
> This patch adds basic vfork support for the case of a simple command.
>...  
> @@ -879,17 +892,30 @@ forkchild(struct job *jp, union node *n, int mode)
>   		}
>   	}
>   	if (!oldlvl && iflag) {
> -		setsignal(SIGINT);
> -		setsignal(SIGQUIT);
> +		if (mode != FORK_BG) {
> +			setsignal(SIGINT);
> +			setsignal(SIGQUIT);
> +		}
>   		setsignal(SIGTERM);
>   	}
> +
> +	if (lvforked)
> +		return;
> +
>   	for (jp = curjob; jp; jp = jp->prev_job)
>   		freejob(jp);
>   }

This leaves SIGQUIT ignored in background jobs in interactive shells.

   ENV= dash -ic 'dash -c "kill -QUIT \$\$; echo huh" & wait'

As of dash 0.5.11, this prints "huh". Before, the subprocess process 
killed itself before it could print anything. Other shells do not leave 
SIGQUIT ignored.

(In a few other shells, this also prints "huh", but in those other 
shells, that is because the inner shell chooses to ignore SIGQUIT, not 
because the outer shell leaves it ignored.)

Cheers,
Harald van Dijk
