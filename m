Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A3C5234
	for <dash@vger.kernel.org>; Wed, 28 Feb 2024 00:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709081802; cv=none; b=OMj78pkAJcdfonjRN+S1AwgJHfInxSP7DmazZqL41HpyBQvLPmStsdSMdNq5H6/DulS65HlJEP96JL/jlrz9EUDmIzZy89wjiiMVsthYsScAIKamXe0ETvvPeS7Qqu1lLxxEIWTdmwuG32fR+oOWxgwftu3s6pih3r+w0JyNY44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709081802; c=relaxed/simple;
	bh=RRx4Xpl1TzctnZyfx7TR435yOX7zxkIXKkIWWQHkY9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pT3Dy8YluvmmqFnKKTB5lavytMa8m7DtXkoKJvWv+C8/PW20Y/0XCjzLHLFRq1Or3KW99N4CEV4Jsaz6y0/UZ161NXUV6haBgxtaleXllCPeCuj56t1MjzGvmpxT/6hEMOgh9sUmou6u4pxRHTvwJ1thl54XdmSarMGQnkTyiDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=PSgKBx7p; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="PSgKBx7p"
Received: from [IPV6:2a02:8010:68a1:0:647e:b5f2:452b:ccb6] (unknown [IPv6:2a02:8010:68a1:0:647e:b5f2:452b:ccb6])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id BA70E445;
	Wed, 28 Feb 2024 00:56:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl BA70E445
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1709081795;
	bh=zSh/HNIysfU32AWOuskDK7kMPkfD6nJAINGinlfGqOw=; l=963;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=PSgKBx7pL3GX6VWisnbQHLvRYwHHd/CA1FjXlJEhANnuU5XLbNe2kZwZoGkBnlLtm
	 QWUkB2QnMRSj9DI+Cgjj7Edh18AN0cRXg0w3/VzU3+nFIghUFQQnu/Aa7q0yKXPNB0
	 vHplZsQvMTXS6A3DNXacLziv31MTbMAtYjKsLDeQ=
Message-ID: <ac893750-085d-421a-b296-a182ae51f1ec@gigawatt.nl>
Date: Wed, 28 Feb 2024 00:56:34 +0000
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wrong behaviour when unsetting/setting some variables
To: Christoph Anton Mitterer <calestyo@scientia.org>, dash@vger.kernel.org
References: <43f0631aea36f6b49e5c3dfdfe481a5a2b1fec6c.camel@scientia.org>
Content-Language: en-GB
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <43f0631aea36f6b49e5c3dfdfe481a5a2b1fec6c.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/02/2024 02:07, Christoph Anton Mitterer wrote:
> Hey.
> 
> Forwarding this from my report (for the records) at:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1064874
> 
> 
> POSIX describes[0] unset to:
>> unset values and attributes of variables and functions
> 
> While the exact detials are perhaps a bit unclear (see the discussion
> at [1], I
> think it is rather clear that unset, on a variable that has no readonly
> attribute,
> shall case the variable/value binding AND any attributes to be unset.

There is even a related bug where it causes attributes to be *added*: 
under 'set -a', unset causes variables to be exported even if they 
previously weren't.

   set -a; unset foo; export

This is clearly wrong.

However, trying to fix this I come across a corner case where it is not 
clear to me what the intended behaviour is.

   set -a; readonly foo=bar; export # some shells export, not all

Cheers,
Harald van Dijk
