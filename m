Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D39C46467
	for <linux-dash@archiver.kernel.org>; Wed,  4 Jan 2023 14:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbjADO7b (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 4 Jan 2023 09:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239434AbjADO72 (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 4 Jan 2023 09:59:28 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 340921EEC3
        for <dash@vger.kernel.org>; Wed,  4 Jan 2023 06:59:27 -0800 (PST)
Received: from [192.168.178.37] (uk.gigawatt.nl [51.148.134.205])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 3BC6D744;
        Wed,  4 Jan 2023 14:59:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 3BC6D744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1672844366;
        bh=CTk97JTbMHh9vGbQdENuzKxPsX0cKX2pO94kQj+pgXU=; l=1976;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LMFIHLqeKyZ/OWwWjOkSOmkiqCbCuV3wyT1OLAZ+aKuERGpL95juEvEWtqEjJqpYz
         WpnDTjbsnwjZkVAOaSAyGAdaS/t6Qf+l/NQKXDPJhx2BqXikWZgvImInAnCIR+2R/9
         pw9FZuEieOOHAmwTgHNA9gjsosw+GqeTwJVPiLgU=
Message-ID: <5eca3f9d-ed49-2ef2-0004-4495a676400e@gigawatt.nl>
Date:   Wed, 4 Jan 2023 14:59:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101
 Thunderbird/109.0
Subject: Re: [PATCH v2 2/3] parser: synerror: explicitly consume the entire
 invalid line
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        dash@vger.kernel.org
References: <Y7OKk/jM53zRE4xg@gondor.apana.org.au>
 <bb422d70-0ba5-e29b-3ec8-8fc1c4630233@gigawatt.nl>
 <Y7VMJGPXXziUrBio@gondor.apana.org.au>
 <8ddcc8a3-9588-435a-9d5f-1edbcd121012@gigawatt.nl>
 <Y7WIuSnsIbkHrEvH@gondor.apana.org.au>
 <6883838e-4340-c80a-cca4-83d2d57078ba@gigawatt.nl>
 <Y7WQCoSQmTniSXUx@gondor.apana.org.au>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <Y7WQCoSQmTniSXUx@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 04/01/2023 14:41, Herbert Xu wrote:
> On Wed, Jan 04, 2023 at 02:30:00PM +0000, Harald van Dijk wrote:
>>
>> In theory, yes. In practice, because of the default Linux overcommit
>> behaviour, that is not going to happen, that's going to cause the OOM killer
>> to kick in and forcibly kill the whole process without any way of handling
>> it. Either that, or forcibly kill some other process that we get no
>> indication of.
>>
>> Even if we change the overcommit settings, I'm struggling to think of any
>> situation where parsing fails because we run out of memory, but freeing the
>> memory we've already allocated for parsing that one line of input frees
>> enough to allow us to meaningfully continue.
> 
> ckmalloc is just an example.  It could really come from anywhere.
> For example, expandstr calls expandarg, which could trigger an
> exception for SIGINT.  Indeed, getting SIGINT directly while in
> the parser would also do the trick.

The only place expandstr() is called in the parser is in getprompt(), 
which is only called when we're at the start of a line and reading the 
next line of input is probably wrong.

As for a SIGINT during actual parsing, that's true. I'm not sure reading 
the rest of the input line is always the right thing to do in that case 
either. Imagine the user typing

   echo 1 <^C> echo 2 <return>

Normally we want this 'echo 2' to be interpreted as a new command. It 
seems odd to me to say that we interpret the 'echo 2' as a new command, 
*except* if the Ctrl-C is processed early, and the 'echo 2' is entered 
early too, in which case we discard it. Especially if this special 
exception only applies if "early" is so early that it cannot reliably be 
triggered. I would want this to be deterministic.

As long as we're talking about things like that, regardless of how it's 
implemented, we could also get another SIGINT during the skipping of the 
rest of the input line.

Cheers,
Harald van Dijk
