Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EE4C4321E
	for <linux-dash@archiver.kernel.org>; Mon,  5 Dec 2022 15:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiLEP1X (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 5 Dec 2022 10:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiLEP02 (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 5 Dec 2022 10:26:28 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38282DE80
        for <dash@vger.kernel.org>; Mon,  5 Dec 2022 07:25:02 -0800 (PST)
Received: from [192.168.178.37] (uk.gigawatt.nl [51.148.134.205])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 80A09177;
        Mon,  5 Dec 2022 15:25:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 80A09177
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1670253900;
        bh=gQbe9gro0LncqumNQs1cnXznllyDKJHs3wRHik0a+U0=; l=1833;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=F2Jq0jYP0KzPpm7nrr0+Wnmvp5Ekvbt5MFJ/sMJ+Hf/3tWDiSOAWoliPH1eg2JrnM
         GxvVimfZe0JevFwP8xxPsnIv/7I0CJZdRPcrqc9l4HRa67t6MGY77YYgvHdknYKRrn
         K0mlagmBzK48F7whmmmVsqRxeyrY6+Yp91eknK1c=
Message-ID: <2f8aff20-ed7f-ee61-9f3d-b7e649cbe56d@gigawatt.nl>
Date:   Mon, 5 Dec 2022 15:24:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101
 Thunderbird/108.0
Subject: Re: [v2 PATCH] expand: Add ifsfree to expand to fix a logic error
 that causes a buffer over-read
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Alex Gorinson <algore3698@gmail.com>
Cc:     dash@vger.kernel.org
References: <CAOKKkHc=bt4p1d4hMzFbQeE14mZJJ7d1REpJ-D_BQD02re1Pdw@mail.gmail.com>
 <Y44H6WLH/b/6+Dey@gondor.apana.org.au>
Content-Language: en-US
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <Y44H6WLH/b/6+Dey@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 05/12/2022 15:02, Herbert Xu wrote:
> On Mon, Jun 20, 2022 at 02:27:10PM -0400, Alex Gorinson wrote:
>> Due to a logic error in the ifsbreakup function in expand.c if a
>> heredoc and normal command is run one after the other by means of a
>> semi-colon, when the second command drops into ifsbreakup the command
>> will be evaluated with the ifslastp/ifsfirst struct that was set when
>> the here doc was evaluated. This results in a buffer over-read that
>> can leak the program's heap, stack, and arena addresses which can be
>> used to beat ASLR.
>>
>> Steps to Reproduce:
>> First bug:
>> cmd args: ~/exampleDir/example> dash
>> $ M='AAAAAAAAAAAAAAAAA'    <note: 17 A's>
>> $ q00(){
>> $ <<000;echo
>> $ ${D?$M$M$M$M$M$M}        <note: 6 $M's>
>> $ 000
>> $ }
>> $ q00                      <note: After the q00 is typed in, the leak
>> should be echo'd out; this works with ash, busybox ash, and dash and
>> with all option args.>
>>[...]
> 
> Thanks for the report!
> 
> I think it's better to add the ifsfree() call to the exception
> handling path as other sh_error calls may trigger this too.

FWIW, the possibility of other sh_error calls being overlooked is why I 
ended up doing it differently myself: I ended up with exverror() calling 
ifsfree(). It is a smaller change than this; it works because there is 
currently no case where preserving IFS regions after an error is wanted 
anyway, and I cannot imagine a future change that would change that. But 
it is possible that my imagination is lacking there.

Q: If exception != EXERROR, longjmp() is called without first calling 
ifsfree(), leaving IFS regions in place for a higher level to deal with. 
If execution ultimately ends up at exitreset(), which calls ifsfree() 
anyway, that is fine. Is that guaranteed to always be the case?

Cheers,
Harald van Dijk
