Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E45B663
	for <dash@vger.kernel.org>; Wed, 20 Aug 2025 02:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755658379; cv=none; b=eBthueRknMwa2FRECq3UcUEVk+mVehvOKbJdQ12HErGduupvxb93hm0ucvGOL57zmYGx90I1s4Sg4URls8ekrfpI53WXHFh4tRbiHrMhW3C0PxuxkWxwYTBYxSteuDzn8mfgpBybTRyRAyJ5QtEfrTIeFvQgg1YkiSE74bhRN1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755658379; c=relaxed/simple;
	bh=tGYHl2pielXs4udGrbgO1wlfJwEHR27Xb7Oo5QupWpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bs/gYe93YwM1v35YOhcSlDCrKjQM0v4Vqi6/XMpN/yqJ8zSPORbpdEoVdGbaH96SrhREPd0Gnm0TIrwpMma5/6cwPD3mlok2XeOgJBnyX2zF96Cl1p3EsCcZEaGqEjsNIQ5EFv+FvHtpPeyobzEF9Psx9BzCaRL9jdzILmRbWy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=F3wb5guR; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="F3wb5guR"
Received: from [192.168.178.21] (unknown [31.94.68.39])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id F40B4140;
	Wed, 20 Aug 2025 03:46:02 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl F40B4140
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1755657963;
	bh=6Es9bPfyCkg5C4shPq7uaHwaMn5+KBfS0N29mUQSppQ=; l=1575;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=F3wb5guR0VKzym0rkhDz9SdyXP4H/n540xaMMRRcl4AxKN5dpF90BBkWSSNHXaP6k
	 3MAGAlZZWag2cE8ZT1Z6b6iWnmcN7IRbLvOphCdlahVR7+v/JeNyKEpLTw8kwN5EML
	 apVPKUgbUdPNHr80qMdfUcfS/O1rBzVJZA2d93C4=
Message-ID: <ef041d50-cb3b-44be-aa81-402912b42997@gigawatt.nl>
Date: Wed, 20 Aug 2025 03:46:01 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] left shift of negative value do_binop
 src/arith_yacc.c:111:12
To: Aleksander Ushakov <aushakov@astralinux.ru>, dash@vger.kernel.org
References: <1abb4964-b5ee-42d8-bbb8-959594d61665@astralinux.ru>
 <e79e39bc-02b8-4ad7-ba03-7e4d00061c3e@astralinux.ru>
 <3a37b273-3da1-45f6-a303-3c0796bd0532@gigawatt.nl>
 <024b5e9f-6112-4224-b095-f7e54b8971b4@astralinux.ru>
Content-Language: en-GB
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <024b5e9f-6112-4224-b095-f7e54b8971b4@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/08/2025 01:33, Aleksander Ushakov wrote:
> Well, if we take bash with UBSAN instrumentation and try to use a 
> similar command with a negative number shift to the left, then at least 
> we won't get a sanitizer error. Yes, you can remove the message that 
> this shift is invalid, but it is still UB to perform this shift 
> according to the C standard. I mean, a check should be added here so as 
> not to trigger UBSAN, as it is done in bash.

I did that in my own version back in 2019, with the exception of subtly 
changing behaviour that differed across architectures, and changing 
behaviour that resulted in shell crashes: 
<https://github.com/hvdijk/gwsh/commit/3b2307005d9ca18f57151ba239c3a0c3c107d681> 
and 
<https://github.com/hvdijk/gwsh/commit/c4d6f1b1613c228db1e157a2136c53f55b4530c8>. 
As those commits show, there are quite a few more cases to consider than 
left shifts of negative values.

dash is free to take those patches, or to decide not to: you are right 
that these cases are undefined according to the C standard, but that 
means that these cases are also undefined in shell scripts, because 
shell arithmetic is defined by reference to the C standard: "The 
evaluation of arithmetic expressions shall be equivalent to that 
described in Section 6.5, Expressions, of the ISO C standard." The 
current behaviour of tolerating it by default, but flagging it when 
special options are used, is not my preferred behaviour, but is 
defensible, so I will wait for dash's maintainer to chime in on his 
preference.

Cheers,
Harald van Dijk
