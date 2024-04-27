Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C14E4D10A
	for <dash@vger.kernel.org>; Sat, 27 Apr 2024 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714219954; cv=none; b=ZYAgzYq3esmVOY3DXlMkouKKeT8hO0FT5y260y9D+d72TvYaVgC1aJ9xlBHoyBOFWZna0e3pKAfZN3VrR8H+Vu2x0d4XTVlbp6BPD7QAkJFVWoesT/xz5CWOf/KvnHphiA/AIIKT0HLidHJvcs/1xA7bvXfAeIrYWHcnCxESV/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714219954; c=relaxed/simple;
	bh=Fy+Z/+Tftm866vNerG1HiYUjs54yveqgWY2NtRVE/9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cNdIjZRYip7833w1wsemSUeMxI/Djr2EgDEAYpA04eX7bTrgMoFa1DVspOX7dnFIAVzRkxJ0Wv9Qapbxo8thmUalQrQwzuljHsD0bFE4C0YHpLHXnmp0J3n2t0vgFUISp/4L/idkCw7PpgpG/QTEILfyQ2i7qLHjJJN4N+I/1b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=hTLGFUbw; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="hTLGFUbw"
Received: from [IPV6:2a02:8010:68a1:0:9b52:1030:9fa8:4969] (unknown [IPv6:2a02:8010:68a1:0:9b52:1030:9fa8:4969])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id 444A8DA3;
	Sat, 27 Apr 2024 13:12:21 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 444A8DA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1714219941;
	bh=XTwjusBvcPiP2b5WjWBICUHao4Srm/EvoYlx8+QqU8A=; l=687;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=hTLGFUbw0IQnDXLaHDMhPYtgGluyz+V0y4hSHhp7llesiZWXljHRmYb05IqeN48gr
	 isePE5bFB+EloQlYsVxdKrLRjH+Qv1ODz3K9Tuji/UktUhU5A1BUYmtEOZSo0NLgAT
	 8pV085p9IOjMbwmVLx0i01AO3wnfklPZy+klEla8=
Message-ID: <000d8fe0-2898-49cc-a841-a78ae7292f6a@gigawatt.nl>
Date: Sat, 27 Apr 2024 13:12:19 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] expand: Fix naked backslah leakage
To: Herbert Xu <herbert@gondor.apana.org.au>,
 DASH Mailing List <dash@vger.kernel.org>
References: <ZizbYRti9EydVOg4@gondor.apana.org.au>
Content-Language: en-GB
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <ZizbYRti9EydVOg4@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/04/2024 12:02, Herbert Xu wrote:
> Naked backslashes in patterns may incorrectly unquote subsequent
> wild characters that are themselves quoted.  Fix this by adding
> an extra backslash when necessary.
> 
> Test case:
> 
> 	a="\\*bc"; b="\\"; c="*"; echo "<${a##$b"$c"}>"
> 
> Old result:
> 
> 	<>
> 
> New result:
> 
> 	<bc>

The correct result here, I believe, is <\*bc>. The backslash means the 
next character is taken as literal, even if that character is already 
also taken as literal because of the quoting. There is nothing to cause 
the backslash to be taken literally. The result should be that only a 
leading * is removed from $a.

Cheers,
Harald van Dijk
