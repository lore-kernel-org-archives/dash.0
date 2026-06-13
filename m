Received: from mail.gigawatt.nl (mail.gigawatt.nl [82.165.170.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586E531D757
	for <dash@vger.kernel.org>; Sat, 13 Jun 2026 02:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.165.170.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781316593; cv=none; b=VzA1kVYjBsKEEWzY8Wk9ZqjAkDikmAl0Bvvu9dHlkLTuF0Q5fgi4bvYzJX+s0pAT1fDZ3/fuTQ1wkb7F2DEfDy/iDBwXqH4wVYS6Bc9o11zEdxMEOXozopHZCPGrg4pc06gzxou55VUZXySyQGdncLAeBv0BPfNl9vaSoUhkGU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781316593; c=relaxed/simple;
	bh=ObV/34nM8+NOhbUl9HDRy9vRPxB/RxXT+VOvVzjjy5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JYabCw/RsbqCy6CsQfAr73V4CQKHf+EfFfPwC87gojvtQnwDqlZv50go33FFXViBfVaditHryKwemvgbzjBJGPpuqQhgPAJcEktXOWLqKHN5IlpfTjjjYLqQI9XGvlftKriwIh/vKFM4QQwQsxfWcVmiTXJ4LMpVKYX8bysxUi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=XKEVdMOB; arc=none smtp.client-ip=82.165.170.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="XKEVdMOB"
Authentication-Results: mail.gigawatt.nl; dmarc=fail (p=none dis=none) header.from=gigawatt.nl
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 88F8DA0A74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1781316590;
	bh=Y3bK50y80Wt5e+Gm9CJuf/T3UOYxwhF2oLcg0NZtn4o=; l=961;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XKEVdMOBWYi5bPMvX9dKR0+hc+TwmVKX+7XOxMZJCq7owhkjRYQDa6w9MfoyVPpcF
	 AhenivxyXEVYpK2D+cmPjgXMaYwJCZOItebeS1YjCQ5RzdXN+iaRhSKAMuZ1ch9Ea4
	 0bD+U8h76RuIXsiyg6CHhm9xZfRDppJzd9C5ejo0=
Received: by mail.gigawatt.nl (Postfix) id 88F8DA0A74;
	Sat, 13 Jun 2026 02:09:50 +0000 (UTC)
Message-ID: <d039d9e3-811e-4484-8107-7b0da7eb0827@gigawatt.nl>
Date: Sat, 13 Jun 2026 03:09:49 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] exec: Print absolute paths for command location
 queries
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Kerin Millar <kfm@plushkava.net>, calestyo@scientia.org,
 dash@vger.kernel.org
References: <aiy2x_l6g42HktZh@gondor.apana.org.au>
 <2896088e-bd54-4ea1-a0ed-537ba78bf548@gigawatt.nl>
 <aiy40wo-3GTRyJ6A@gondor.apana.org.au>
Content-Language: en-US
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <aiy40wo-3GTRyJ6A@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/26 02:56, Herbert Xu wrote:
> On Sat, Jun 13, 2026 at 02:52:29AM +0100, Harald van Dijk wrote:
>>
>> You're overlooking the "that are found using the PATH variable" from the
>> spec. Because you included a / in the command, it is not looked up from
>> PATH. Modifying your test to make sure PATH is used, we can see that bash
>> does do this in POSIX mode:
>>
>> $ bash -c 'cd /; PATH=bin command -v bash'
>> bin/bash
>> $ bash -o posix -c 'cd /; PATH=bin command -v bash'
>> /bin/bash
> 
> But that's not what this patch does, is it?

Oh, I see. Currently, dash never converts paths to absolute. The patch 
changes it to do so whenever possible, both for the case where commands 
are looked up from PATH (which is required by POSIX) and the case where 
they aren't (where I think POSIX is ambiguous). Other shells (ksh, yash) 
do print an absolute path in all cases, but matching bash sounds 
reasonable too.

Cheers,
Harald van Dijk
