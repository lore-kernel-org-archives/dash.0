Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.165.170.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792656497;
	b=fa7ZckguqVA7Bovbwbmzp8V1glGOpbuCGzBYs4iKt+KPljIwoHJK8VSeoEV5CFmNyet9
	 qWtg6QHyBvr3y/SfK7BuNdoISEExsRyf+sfwhA8yRFnwbwDGtnrwe5c6SXN/JJ3P2W4O2
	 okvyScVF9PV3Nyflh8uTzil/NqhfaaIMIHjjrJAuZOU3hsQrJyrhcsycUyVv22c0OdIzK
	 s/3WeOkqP069X0l7T3PIhDH0Nge3T7esWmRE2T5bYvKKTyRrUA1yjefKea6bTRXOHAEkl
	 vIjU6SOOMM6eEbq5pj7jMEMKIp0lmTcSgt9FxmU8Gtf887kJzAAQOg15E73PLien29Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792656497;
	h=DMARC-Filter:DKIM-Filter:DKIM-Signature:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=8D2N80HTNGDchfgzg+9udJNtwkVYsBZAzFP6hy1d4VU=;
	b=R2LRyk/UVeU8evLoDDcuj+b8UmYM1tYdcwI2aNI7Sl8Bx3DRuxvqNf7dhtlWMuJU+/hD
	 ZDzS8KiYrPGP2KPFHj7u6M70A7W9gdo29ZuYivARp0YtnN5xlMtK9SFbPQWPawA6Si2yO
	 Ttcz4rZE1yZ+BiUr+I7lejQUNGzYoNY5sszytafPOuPdEK1Fb02+Vp8xkG1uWxsm6tRJA
	 fBGXPnqXJWGf/sjp3QoJOa0ekalo2l7ETLFbc5oOGHojQssXLR3/1ZADrd4TztOR1nvF7
	 CLZQI048QQwk0sIgUNXeCc40HjcUq5n0EvVeXoc0biggfaQZTIhGPUT3wuyl8kwx69w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gigawatt.nl;
	spf=pass smtp.mailfrom=gigawatt.nl;
	dkim=pass header.d=gigawatt.nl header.i=@gigawatt.nl header.a=rsa-sha256 header.s=default header.b=eBR7dmoZ;
	arc=none smtp.remote-ip=82.165.170.251
Received: from mail.gigawatt.nl (mail.gigawatt.nl [82.165.170.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84140606A319
	for <dash@vger.kernel.org>; Thu, 22 Oct 2026 08:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84140606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gigawatt.nl header.i=@gigawatt.nl header.a=rsa-sha256 header.s=default header.b=eBR7dmoZ
Authentication-Results: mail.gigawatt.nl; dmarc=fail (p=none dis=none) header.from=gigawatt.nl
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 74471A24DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1792656488;
	bh=8D2N80HTNGDchfgzg+9udJNtwkVYsBZAzFP6hy1d4VU=; l=957;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=eBR7dmoZYMzPgLio6o/f+5eWB6x4xIaSy4j5YrTwjFGm1Fyd7m2iJ/BVQYh3+e+LM
	 PwKrXig3ziAwyowETLxh/6bExVRTrnsno2ZKG1aNqRBfzk5icgDNR5zNwfaQtjnOAC
	 ydgYq9SN8DQzFvpvz3gy9VeLvQybqGnItVOypFNo=
Received: by mail.gigawatt.nl (Postfix) id 74471A24DF;
	Thu, 22 Oct 2026 08:08:08 +0000 (UTC)
Message-ID: <5cd15b5d-f99d-429c-a2d2-96e1a991f379@gigawatt.nl>
Date: Thu, 22 Oct 2026 09:07:13 +0100
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Post: <mailto:dash@vger.kernel.org>
List-Help: <mailto:dash+help@vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
List-Owner: <mailto:dash+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: struct var::flags never has VSTACK bit?`
To: dash@vger.kernel.org, Denys Vlasenko <vda.linux@googlemail.com>
References: <CAK1hOcMy+=6SAKRA02z_DWtLG8OkyDLO3udzrnKdpfuq+C=d-g@mail.gmail.com>
Content-Language: en-US
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <CAK1hOcMy+=6SAKRA02z_DWtLG8OkyDLO3udzrnKdpfuq+C=d-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/10/2026 06:06, Denys Vlasenko wrote:
> Good day,
> 
> I can't find where VSTACK bit is ever set.
> Is it unused?

Hi,

Yes, as far as I can tell this is unused. In original ash, this was used 
for the setvareq() in evalcommand(): this was called after forking, in 
the child process which would never return(*), and avoided setvareq() 
calling savestr() to duplicate the strings. As setvareq() is now called 
earlier, before we know whether the variables need to possibly persist 
after evalcommand() returns, it's not possible to use VSTACK the same way.

It might be interesting to check whether it is possible to reintroduce 
the use of VSTACK for this in a different way and whether it would 
result in any measurable performance improvements in any real script, 
but I suspect it will not be worth it and VSTACK could just be removed.

Cheers,
Harald van Dijk

(*) ignoring the whole EXSHELLPROC logic, which had special treatment
