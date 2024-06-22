Received: from freekahlil.inlv.org (freekahlil.inlv.org [46.19.33.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA63C8C7
	for <dash@vger.kernel.org>; Sat, 22 Jun 2024 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.33.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719075207; cv=none; b=uY6e+x3uaKSCi/j8kpXNBi04cdEo7c+P01V3XXlhOESNSOy3ZhbNBoK/CGLyG9cXHoqWK4hsNUnKE/OA0egm7KgFUNNjDC+BPaVUCsBb3rcPrhAlc3BW+ItzcSTGPpi/zNeqJBrja1BMNpfyfN38FPt8SC1sFGhUDjXA4fGRwLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719075207; c=relaxed/simple;
	bh=5v4iI5ilOLskwbhODLvd6y+86gHmPPznfWxBjI7cn+k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=OgSi8olJfo2rDRyDHdgOYKcuJcNHpWhs9fw+WrRAz4iS2Xiu14rp71CoZq15MV7kSGKVI8RO9j700OmsdVWy2g3ZgShQe7vuZ1g57lKTMKjkTtWDJ1PbWRH/8hqNqer5NR2DKav2YMli3AOCam5TMlKw/z8tesOwkmU/Wg34lQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org; spf=pass smtp.mailfrom=inlv.org; dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b=YAVtaVQV; arc=none smtp.client-ip=46.19.33.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inlv.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b="YAVtaVQV"
Received: from [IPV6:2a00:23c6:5398:5e01:4c17:9df7:7a66:fce1] ([IPv6:2a00:23c6:5398:5e01:4c17:9df7:7a66:fce1])
	(authenticated bits=0)
	by freekahlil.inlv.org (8.16.1/8.16.1) with ESMTPSA id 45MGrJab031509
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO)
	for <dash@vger.kernel.org>; Sat, 22 Jun 2024 18:53:19 +0200 (CEST)
	(envelope-from martijn@inlv.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inlv.org; s=inlv;
	t=1719075200; bh=5v4iI5ilOLskwbhODLvd6y+86gHmPPznfWxBjI7cn+k=;
	h=From:From;
	b=YAVtaVQVyXWqZ3BXWEpLUs9B7Cz7BXN6s6eQrkXnUq8+Q5skTwwwkPK+ZXFSwn+Tm
	 ghPbjF3+pYzhBH3tU+UWFmVQvXZeFArHQLKhhMvR75TEDyaOZZeFSgkfM7eSpjOC9l
	 33q7rKcHqbzopgeN/XrpcwM/L9fWWeqaAj7C3DUk=
Message-ID: <3a068eda-298b-4679-84e2-0dc7a3348813@inlv.org>
Date: Sat, 22 Jun 2024 17:53:19 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Martijn Dekker <martijn@inlv.org>
Subject: [BUG] reading from FIFO broken
To: DASH shell mailing list <dash@vger.kernel.org>
Content-Language: en-GB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

As of this commit:

> commit a065467315dc5f2f312f7e6f1d2e9d05a77b3cb7
> Author: Herbert Xu <herbert@gondor.apana.org.au>
> Date:   Sun Jun 2 09:31:32 2024 +0800
> 
>     input: Move newline loop into preadbuffer
>     
>     As it stands preadfd tries to fetch a whole line when we're reading
>     one byte at a time.  However, this is wrong because how many bytes
>     we're trying to read has nothing to do with whether we get a whole
>     line or not.
>     
>     Move the loop into preadbuffer alongside the other history support
>     code.
>     
>     Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

...reading from a FIFO is broken, at least on macOS 12.7.5. It seems like the 
'read' command can no longer read anything from a FIFO.

Reproducer:

$ dash -c 'trap "rm fifo" 0; mkfifo fifo;
	echo OK >fifo & read r <fifo; echo "${#r}:$r"'
0:

Expected output:

2:OK

-- 
||	modernish -- harness the shell
||	https://github.com/modernish/modernish
||
||	KornShell lives!
||	https://github.com/ksh93/ksh
