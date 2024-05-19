Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5EB45BE3
	for <dash@vger.kernel.org>; Sun, 19 May 2024 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716125416; cv=none; b=IsTzzBWiDEQJNgJgM0f3tTuUIxKug5vEI+q2nY+1OngQCRfrA0TZ4K2gcL6GwGKzHN4QTD0BGnRUaqccR0g68Q/XzPcrQCrYIbBdYDoubmqgcNcNr5wsJD1sJcPTsyXZbAsnMwFnCXDs1WR1fP6qdOcnOHNXJUI0OGJCU5RN+FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716125416; c=relaxed/simple;
	bh=aw63UDSPshXkwFLr6sGEBYRT3tGlpaPtuRxWiJ658b0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AfmNqUsEenM3mpZ+uvLUp2lPWJ06YeDLDzy8lL6WJzEU6D3eNWhfQwCfUdcRLyVD9e3itoAeFri5CSiU8TMoUmELexbidkMNWW/b0zHsphl5hWimWaLsaVxLc0VVN5+B4cZpDcL9R2teWEINvukq8GlR+u+9Hap7xI1aJeMRImw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=I4y0Nwqt; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="I4y0Nwqt"
Received: from [IPV6:2a02:8010:68a1:0:8273:6c6f:ca4b:6d1a] (unknown [IPv6:2a02:8010:68a1:0:8273:6c6f:ca4b:6d1a])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id F2052E57;
	Sun, 19 May 2024 14:23:26 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl F2052E57
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1716125007;
	bh=TP9S/dA/GWIHDdAZhU0jxH7VQTmUItbSLj1vUUMBu5c=; l=1131;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I4y0Nwqtxzti7O34zPqiIYVgUU3nXgBvwct+wGSSQH272OroTaSE3ldomtoaUwghB
	 U+kZ20kY/Xs4afHJxFVrdUMW76ZNmSrchcFfxyIbxD6fSafpEzfq47dwy+FdpEY269
	 A2UfaZKz3Ur5ScdPd2dkzFds2rzyYYFzW9IM+c5E=
Message-ID: <64b35f8d-32bc-4331-9e67-fc06305a2e34@gigawatt.nl>
Date: Sun, 19 May 2024 14:23:23 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] options: Always reset OPTIND in getoptsreset
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
 dash@vger.kernel.org, 985478@bugs.debian.org
References: <20221214023130.u7pn4ca6ma4kuxot@tarta.nabijaczleweli.xyz>
 <Y7P33bSfbmpe7EI/@gondor.apana.org.au>
 <20230103122619.bhvn7lep5avoanji@tarta.nabijaczleweli.xyz>
 <Y7VOEx/cE4vQZ0zE@gondor.apana.org.au>
 <20230104125421.rmjbjzme7a6qbxhx@tarta.nabijaczleweli.xyz>
 <Y7WJVBPWsNhTvRuJ@gondor.apana.org.au>
 <20230104160526.7vuq3s2ivqaaot4l@tarta.nabijaczleweli.xyz>
 <b00cdaa5-0072-392c-3cf7-184aa8e45ae3@gigawatt.nl>
 <ZkngRVxkiUil_9aG@gondor.apana.org.au>
Content-Language: en-GB
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <ZkngRVxkiUil_9aG@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/05/2024 12:19, Herbert Xu wrote:
> On Wed, Jan 04, 2023 at 04:50:34PM +0000, Harald van Dijk wrote:
>>
>> Personally, I do think it is better if shells allow assigning arbitrary
>> values to OPTIND, including unsetting it, and only have the getopts command
>> raise an error if the value is non-numeric, but that is my personal opinion
>> and I don't see much of a problem if dash decides to go the other way,
>> unless POSIX makes it explicit that it is not permitted for shells to do
>> this. FWIW, I did make that change for my version, <https://github.com/hvdijk/gwsh/commit/0df0ba33748eb3881b07cb724fd4fa54422ef2bc>,
>> if that change is desired for dash it is easy to apply.
> 
> I've decided to make getoptsreset always do the reset, regardless
> of the value of OPTIND.  Why else would you assign it anyway?

This interacts terribly with the not fully reliable but nevertheless 
fairly commonly used "local OPTIND". When the local OPTIND goes out of 
scope and the prior value of OPTIND is restored, the expectation is not 
that option processing restarts from the beginning.

Cheers,
Harald van Dijk
