Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F65C46467
	for <linux-dash@archiver.kernel.org>; Wed,  4 Jan 2023 11:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbjADLTA (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 4 Jan 2023 06:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjADLS4 (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 4 Jan 2023 06:18:56 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FF461A3A0
        for <dash@vger.kernel.org>; Wed,  4 Jan 2023 03:18:54 -0800 (PST)
Received: from [IPV6:2a02:8010:68a1:0:f140:f5fb:7038:8e8a] (unknown [IPv6:2a02:8010:68a1:0:f140:f5fb:7038:8e8a])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 91591477;
        Wed,  4 Jan 2023 11:18:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 91591477
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1672831132;
        bh=KLFD2fEgeWr3HCINn3ImoT6nrFNRz06hIF/hPQMIojw=; l=1339;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pV1EiuG8A7t6RQ1TouDd3lsBRIhPC4xBUqKz1n39uXCoVxS5Ou25JLLcpe/IoV6XO
         XcpeZppyhBGihoRw3pPsbHpywFoIHJHQOwkCQMGP2K0XsUtnko0LHKONKMcrlUYqI7
         bTtAheNVzPpNXkzc1Y+Xuy4gGPgppeykVTtgjWog=
Message-ID: <83fb967d-19e3-d7de-becc-179af3045e59@gigawatt.nl>
Date:   Wed, 4 Jan 2023 11:18:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101
 Thunderbird/109.0
Subject: Re: [v3 PATCH] input: Read standard input byte-wise
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        dash@vger.kernel.org
References: <Y7PIHqN4ic4UBOBb@gondor.apana.org.au>
 <9a6c2bc5-11aa-db99-8db5-541060624b01@gigawatt.nl>
 <Y7U/2PnYCDA5stZ8@gondor.apana.org.au>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <Y7U/2PnYCDA5stZ8@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 04/01/2023 08:59, Herbert Xu wrote:
> On Tue, Jan 03, 2023 at 11:54:55AM +0000, Harald van Dijk wrote:
>>
>> Does it? preadbuffer() knows to call history() with the H_APPEND flag to
>> append a next chunk of input to what was already added to the buffer.
> 
> It only uses H_APPEND once a newline has been detected and
> whichprompt switches over to PS2.

Oh yeah, that's something I'd changed in my version already in 2019 for 
other reasons. I missed that dash didn't do the same. There are a few 
separate but related bugs in the history handling, and until they are 
fixed, agreed that simply reading one bye at a time will make these more 
prominent.

One is that because of what you say, the history recording for commands 
greater than BUFSIZ is already buggy, but unlikely to pose a problem in 
practice currently because normally, people don't write such long commands.

Another is that the stripping of blank lines from history breaks when 
blank lines are significant, as in

   $ cat <<EOF
   > hello
   >
   > world
   > EOF
   hello

   world
   $ fc 1
   26
   q
   hello
   world

Note how the blank line was lost.

If there was already "something" (as the code puts it), then when more 
data is appended, blanks must be preserved.

There may be more that I am not seeing right now.

Cheers,
Harald van Dijk
