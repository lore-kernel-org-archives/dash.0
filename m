Received: from mail.gigawatt.nl (mail.gigawatt.nl [82.165.170.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433483CEBB9
	for <dash@vger.kernel.org>; Wed,  7 Oct 2026 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.165.170.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791371421; cv=none; b=IU4NHLusBEpaHDdmqqO90B/YJ8cj5CpUlwgy7BkRfC9m2J3YbtKSPfbRDGo8vmksLQ+skkkW5cG02powBqBuzywthDdII+GIEEA/ts7yjK4oSqCXCfodAqj+bm/wzLxqtJ1xVIv+GVDQVELYnFZwPgn67mKlw8Vkx6ETMzSpRmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791371421; c=relaxed/simple;
	bh=zEh+gn4ECr9ICTeN9Q/8/VThoKRqVu5Iu6fvSu2db7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PQR/EXODt1wp+MpCVOTyF4fe/3iHbxaNWfuBbSnk4eK+YCoASzvGNxneYQl8iFCfBAY8S53bhNw85hXaUZZ1nOlfDSp4ps0sXPD0H62AHdhA+J2EhzgfveOM/ym6TYgAdT//iSh2V9umyJTETV0pNwuDshbx3/zrSHW3oEr01eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=jCOrxif7; arc=none smtp.client-ip=82.165.170.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="jCOrxif7"
Authentication-Results: mail.gigawatt.nl; dmarc=fail (p=none dis=none) header.from=gigawatt.nl
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl A3654AAC3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1791370840;
	bh=K3AmN8hkhyO7vrWZMB3EwWTgy+SqdYH1UGHQJaZniN4=; l=381;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jCOrxif7wzg5/aAONclZkW+8ooarkaOgZsTXtfyn1XMA0/iahs9Av6eNOXv1fWkWB
	 lc/hGsaHnckWV8MVS491RTqwfkTDrsyzTo+IH5VEW6+hKVNebpuxOagzAThj7nOuQ7
	 YafZ6yOVKx/T8ipRaB9KL4AurT1HYvK9fu53c4MY=
Received: by mail.gigawatt.nl (Postfix) id A3654AAC3C;
	Wed, 07 Oct 2026 11:00:40 +0000 (UTC)
Message-ID: <057ee3ea-1ca7-45c0-bc84-119e7282609e@gigawatt.nl>
Date: Wed, 7 Oct 2026 12:00:39 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] exec: Print absolute paths for command location
 queries
To: Kerin Millar <kfm@plushkava.net>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: Christoph Anton Mitterer <calestyo@scientia.org>, dash@vger.kernel.org
References: <aiy2x_l6g42HktZh@gondor.apana.org.au>
 <2896088e-bd54-4ea1-a0ed-537ba78bf548@gigawatt.nl>
 <aiy40wo-3GTRyJ6A@gondor.apana.org.au>
 <d039d9e3-811e-4484-8107-7b0da7eb0827@gigawatt.nl>
 <aizBLwgt79MG4945@gondor.apana.org.au>
 <d2f60cce-6848-4d1a-856b-304e9d5a3d04@app.fastmail.com>
Content-Language: en-US
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <d2f60cce-6848-4d1a-856b-304e9d5a3d04@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/10/2026 10:13, Kerin Millar wrote:
> I have since observed that commit 76037847c3c7 in the devel branch of bash incorporates the following change:
> 
> "In posix mode, `command -v' should print absolute pathnames"
Thanks for pointing that out, I've copied that to the Austin Group in 
case this affects what they want POSIX to require for it.

Cheers,
Harald van Dijk
