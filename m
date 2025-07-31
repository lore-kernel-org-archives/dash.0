Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD80124728D
	for <dash@vger.kernel.org>; Thu, 31 Jul 2025 21:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753997952; cv=none; b=oRqeHlpI1xjdjnRE8WicyY9/zNO6uysfp8qtA8l43uGehHl/8CCGElNp0k5QVj2mqDw2MrxPhSjB3lpiJ2W6o0ATyAYpjArdsNYKIup2aRvpzZzuqJAqG7vPOCaK0a/2uT6DumgRxrHA9ncT4+yWlm1SihDIBKEI+QXz6qwCTrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753997952; c=relaxed/simple;
	bh=SroYb1bQaZUupgaLf/QOgkdgByuxU1GdkfguYmx5TPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bWTuo+DM7dbIcPJz+Zygclo//Drn2sthSBK0ie+JszE4Ki4uu6p86e1JrO/pA2mMTRCMuAs1UeCk414gey0NeZ/2khXM6CPCISN/5IEjapisjH35wfL8pnIdc5kpkFR6TzgZ8VNRt/ERywGSIZV/antyHyLdiWm4O2rOKF0eo1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=HdrmAvsB; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="HdrmAvsB"
Received: from [192.168.178.21] (unknown [31.94.68.113])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id CC015E9;
	Thu, 31 Jul 2025 22:39:05 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl CC015E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1753997946;
	bh=TvGcmB7dlCBycqTlmey7NpOz4Mb1NnJybWdCGx3BM6g=; l=663;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=HdrmAvsB0zCRymjeJxV35mrZ7gGh3dPI3Q12+w+LUxb4ZD489KSb5OejOPOOqvu1q
	 EvRMyNlcq9KfJW1aYitsAmFG3jRFTRY/Cotqby02rfdtPZw7WBtjIGomhhLhfAfhKp
	 K/6LN9w2JjckgMfxMxyYTMoVETOr3a8K0K0YO4C0=
Message-ID: <02f1785e-6657-4f7f-a2c1-c860bd45d4f3@gigawatt.nl>
Date: Thu, 31 Jul 2025 22:39:02 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] invalid-null-argument outmem() src/output.c:149:17
To: Aleksander Ushakov <aushakov@astralinux.ru>, dash@vger.kernel.org
References: <8e89d699-8353-4294-85ee-68fba4fdb391@astralinux.ru>
Content-Language: en-GB
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <8e89d699-8353-4294-85ee-68fba4fdb391@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/07/2025 18:33, Aleksander Ushakov wrote:
> Hello Dash maintainers,
> 
> I encountered a bug in Dash in commit b4ef25d7 and would like to report
> it. The details are provided below.
> 
> output.c:149:25: runtime error: null pointer passed as argument 1, which 
> is declared to never be null

Although this was previously formally undefined behaviour, it no longer 
is, and this change has been suggested to be applied retroactively. 
(https://www.open-std.org/jtc1/sc22/wg14/www/previous.html, look for 
N3322) As such, this should be considered a sanitizer false positive now 
and dash should not need any changes here.

Cheers,
Harald van Dijk
