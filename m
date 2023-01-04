Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195D1C4332F
	for <linux-dash@archiver.kernel.org>; Wed,  4 Jan 2023 16:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjADQza (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 4 Jan 2023 11:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239347AbjADQzP (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 4 Jan 2023 11:55:15 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6426349140
        for <dash@vger.kernel.org>; Wed,  4 Jan 2023 08:51:20 -0800 (PST)
Received: from [192.168.178.37] (uk.gigawatt.nl [51.148.134.205])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id E1EA5DC7;
        Wed,  4 Jan 2023 16:50:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl E1EA5DC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1672851037;
        bh=gZTeib+EWoASx1D2VC6QW53mKQamFCmOmmIrF1fiK0o=; l=2696;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=i9JIFsTGY1Q2aUYEX3fo6RqVmE20ijT7TByCn0NTuIGUzdgpp77gzQDx3FoTYBXhM
         AqK7y3ChconeuDNj2w/aYH5p9ckUqjxtIeA2PYp8yFQFdPqZWi57wmkWtNSz2PtX6j
         awRo9gicfn0/fRG3uGYNzLL4cYOoJuQleRuPhJTo=
Message-ID: <b00cdaa5-0072-392c-3cf7-184aa8e45ae3@gigawatt.nl>
Date:   Wed, 4 Jan 2023 16:50:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101
 Thunderbird/109.0
Subject: Re: [PATCH] var: Do not add 1 to return value of strchrnul
Content-Language: en-US
To:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     dash@vger.kernel.org
References: <20221214023130.u7pn4ca6ma4kuxot@tarta.nabijaczleweli.xyz>
 <Y7P33bSfbmpe7EI/@gondor.apana.org.au>
 <20230103122619.bhvn7lep5avoanji@tarta.nabijaczleweli.xyz>
 <Y7VOEx/cE4vQZ0zE@gondor.apana.org.au>
 <20230104125421.rmjbjzme7a6qbxhx@tarta.nabijaczleweli.xyz>
 <Y7WJVBPWsNhTvRuJ@gondor.apana.org.au>
 <20230104160526.7vuq3s2ivqaaot4l@tarta.nabijaczleweli.xyz>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <20230104160526.7vuq3s2ivqaaot4l@tarta.nabijaczleweli.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 04/01/2023 16:05, наб wrote:
> Hi!
> 
> On Wed, Jan 04, 2023 at 10:12:36PM +0800, Herbert Xu wrote:
>> On Wed, Jan 04, 2023 at 01:54:21PM +0100, наб wrote:
>>> AFAICT, after trawling through the Issue 8 Draft 2.1,
>>> there are no special provisions for unset/OPTIND,
>> Well it says this regarding OPTIND:
>>
>> : If the application sets OPTIND to the value 1, a new set of parameters
>> : can be used: either the current positional parameters or new arg
>> : values. Any other attempt to invoke getopts multiple times in a single
>> : shell execution environment with parameters (positional parameters
>> : or arg operands) that are not the same in all invocations, or with an
>> : OPTIND value modified to be a value other than 1, produces unspecified
>> : results.
>>
>> Unsetting OPTIND ought to do the same thing as setting it to "",
> On the basis of? Those are fundamentally unrelated operations,
> and when they are to do the same thing, this is explicitly noted.

On the basis of common sense, keeping in mind that different people's 
ideas of common sense will be different. In this one, I'm tempted to 
agree with Herbert Xu, $OPTIND would expand to an empty string whether 
OPTIND is unset or set to an empty string, assuming set -u is not in 
effect, so for the purpose of the getopts command it would be good for 
it to behave the same way there too.

> Additionally, this is a description of /getopts/, and therefore only
> applies if you do "OPTIND=dupa; getopts ..." ‒ the getopts call is
> unspecified.
> 
> /Any/ operation on OPTIND is legal, and the current behaviour is wrong
> (but it seems that no-one has actually cared) ‒ POSIX defines this in
> terms of getopts inspecting OPTIND when it's run.

Indeed, but dash isn't the only shell that behaves this way (posh does 
too) and I'm not sure whether this is what POSIX intends to specify. I 
agree with your interpretation of what POSIX actually says, but it would 
be good for POSIX to reword it regardless of what is intended to be 
clearer that this case was actually considered.

Personally, I do think it is better if shells allow assigning arbitrary 
values to OPTIND, including unsetting it, and only have the getopts 
command raise an error if the value is non-numeric, but that is my 
personal opinion and I don't see much of a problem if dash decides to go 
the other way, unless POSIX makes it explicit that it is not permitted 
for shells to do this. FWIW, I did make that change for my version, 
<https://github.com/hvdijk/gwsh/commit/0df0ba33748eb3881b07cb724fd4fa54422ef2bc>, 
if that change is desired for dash it is easy to apply.

Cheers,
Harald van Dijk
