Received: from mail.gigawatt.nl (mail.gigawatt.nl [82.165.170.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E7CF9E8
	for <dash@vger.kernel.org>; Tue, 14 Apr 2026 02:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.165.170.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776132211; cv=none; b=nmzorQsY6wlAdaDUrI/kj17YC7O86hHBSAxak7WiPmJWSDbGDU7XQb0jSzAmdRjpP8Fya9VoQ8ovqxEski8B5cN52Gx8GkDK61065d6n/OeZdx2w0uOdlVNzfCSoK8hepa+4SBur9PdccnrZeQ+FeF8/E6Cvz719guALEWIrRXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776132211; c=relaxed/simple;
	bh=alLzHA/taUUHylW3NmP+JMF7n3ANCz/v1MxcexrzsY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p4/Oq+mAZG67E29QzGUA+QjVgmvfTM4VRDA7xOmOeputBeDVKQ5sKYIf5zM96yBXPp9hU2mimLEA9j5ctUPkM8xo4fcS+ly1v+J3EXoiZogyYfIQ+vTarD99ECwBEmuESP7XLgQYCIgkSCEFxu2u392AQHaj0f5sX/k1nY5Fv9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=UZRjSxc7; arc=none smtp.client-ip=82.165.170.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="UZRjSxc7"
Authentication-Results: mail.gigawatt.nl; dmarc=fail (p=none dis=none) header.from=gigawatt.nl
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 98F4EA01E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1776132201;
	bh=fVdNvIIn1FtIeHt6NFcx5oEQamzZ+Vq43pkUj6Ussjk=; l=643;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UZRjSxc7Q2ihf5YetYReOXTKX9ERqimgGSZggvvcvCMh6pbHzh258xbYbs/aOt0pJ
	 eXBQao4wXzg/ewpgvnyLQ0mpReLU0Wa4TyildY6TccaE4NUxIGnJEQZB/L9lFWbGgn
	 f2uli3JXwF1MQRMvcduOTMOX0uk78L1LlEPx+lQ0=
Received: by mail.gigawatt.nl (Postfix) id 98F4EA01E1;
	Tue, 14 Apr 2026 02:03:21 +0000 (UTC)
Message-ID: <5a0fccc1-c885-4387-b402-18dadf155bd5@gigawatt.nl>
Date: Tue, 14 Apr 2026 03:03:21 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] arith: Fix CVE-2026-31323 INTMAX_MIN / -1 overflow
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: 996029583@qq.com, dash@vger.kernel.org
References: <ad2AzCSwtmxQF4sd@gondor.apana.org.au>
Content-Language: en-GB
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <ad2AzCSwtmxQF4sd@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/04/2026 00:48, Herbert Xu wrote:
> Harald van Dijk <harald@gigawatt.nl> wrote:
>>
>> This looks fine if it's a conscious decision, but it differs from what
>> dash generally does when the result of arithmetic is not representable
>> in intmax_t, and also differs from bash. Depending on the reason there's
>> apparently a CVE for this, this may be an issue, see below.
> 
> This is not a normal overflow.  This actually raises an exception and
> kills the thread.

I mentioned how it raises SIGFPE and causes scripts to end so I am aware 
of that and wrote the rest of my message with that in mind.

Cheers,
Harald van Dijk
