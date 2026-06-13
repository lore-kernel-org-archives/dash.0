Received: from mail.gigawatt.nl (mail.gigawatt.nl [82.165.170.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800109475
	for <dash@vger.kernel.org>; Sat, 13 Jun 2026 02:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.165.170.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781318238; cv=none; b=BoOQ5AdlOWalFk3c4caIhvYH0grNPJS49t0vV88zMgCCvRkEmEO8Ti/ciQz6/4D2XZDtRkQCy8AvmRYLGZ/eDB5hJWtrvI2A3fzQ2MIo0HLyDyO9JEtQXAJUJuioy+MA0oLY3ncDbI18V4I27oh+T0kWlp/+aepAHVHMS5pqiPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781318238; c=relaxed/simple;
	bh=Tf7q7PatY3NgW0uM7Sy4qKS9RovnPCLiyxrSNpKUGZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A4A5SDN/wo/7sFQgWv6WA+6AuqEYEcd/fbLN51zsgMh6/Eq+MMMrvFBvBzC2hHeErQ1Q2ZYCFDqVAbF797JPHhyTvoFhFLZ4m9f51JiUAN/ENuuso91XCOR9rCePgEDucOSM7ZxYRoqiXKVckEEdIs1ko5cWsVcYV9hmfgFPPyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=EXOfYqVS; arc=none smtp.client-ip=82.165.170.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="EXOfYqVS"
Authentication-Results: mail.gigawatt.nl; dmarc=fail (p=none dis=none) header.from=gigawatt.nl
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl A80C6A0A74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1781318235;
	bh=RxuTg0ZNOCkLdTdg3E0bbx3Brq0Y6O1cd/6psWkURyM=; l=1025;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EXOfYqVSuZfjyqvlsEtdKFi4TQ1BQT/EXd/kQVBPcQ4vOVFXg0tdlhv3YjqB9MClm
	 DtkxeXpFV/nKGiJ+EWG0xlByvcbCAJ/S7RhbFx35FIVEhrcbhZyJpH8jvZnXQ4VqZ5
	 44vo/oORBwFooslJ0lYhhEghjmgyNrbNR29ghEUU=
Received: by mail.gigawatt.nl (Postfix) id A80C6A0A74;
	Sat, 13 Jun 2026 02:37:15 +0000 (UTC)
Message-ID: <357e71e2-672a-41a0-aad1-082f41dac861@gigawatt.nl>
Date: Sat, 13 Jun 2026 03:37:14 +0100
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
 <d039d9e3-811e-4484-8107-7b0da7eb0827@gigawatt.nl>
 <aizBLwgt79MG4945@gondor.apana.org.au>
Content-Language: en-US
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <aizBLwgt79MG4945@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/26 03:32, Herbert Xu wrote:
> On Sat, Jun 13, 2026 at 03:09:49AM +0100, Harald van Dijk wrote:
>>
>> Oh, I see. Currently, dash never converts paths to absolute. The patch
>> changes it to do so whenever possible, both for the case where commands are
>> looked up from PATH (which is required by POSIX) and the case where they
>> aren't (where I think POSIX is ambiguous). Other shells (ksh, yash) do print
>> an absolute path in all cases, but matching bash sounds reasonable too.
> 
> Reading the standard again it seems that bash might actually be
> in the wrong here, as it specifically refers to "command_names
> including a <slash>".
> 
> Since that precludes a PATH search, it is self-contradictory.  I'll
> wait for the standard (or bash) to be fixed before taking this change.

Huh. Good point. That would make the interpretation that matches what 
the patch does almost certainly the intended interpretation, but it 
would be nice if the standard actually said so.

Cheers,
Harald van Dijk
