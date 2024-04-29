Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF8F10971
	for <dash@vger.kernel.org>; Mon, 29 Apr 2024 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714396370; cv=none; b=GWv6UzMPzBC5zTtTBU+QFFCAuc3zVBA+IAE0nELZV4F6nZVkOEhtiVTSrtqPTCFBuuIyhgrn7ElqXZLRujsfsIoItHB01iNqA93E6Xmj08sr3tir0axTRh4D34aWNF/3QSdnFlhI7uDLpc/Obue1IMMhsQBTFIIj6nH7ZWv5JD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714396370; c=relaxed/simple;
	bh=oVUyJaoN5TG9KJq3fPCgHlqvoqg1rEFUjIDPAamJvdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3q7UBWp0roi217kNZPDmST6SI1eMKeX6hIV98bOTqp9rr8/vhHuMBT4tXn14aqVd6et9sVWKbFshG75Eyr8X3QXuFKHAf9MEIdJh99E+JY/2LAWs8KfToae2Vf1I7nC5tDJp8aCNjiX77Mw/XhC3wpeYvuTYxmintSCXbqvXoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s1Qny-008BuM-04;
	Mon, 29 Apr 2024 21:12:27 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 29 Apr 2024 21:12:44 +0800
Date: Mon, 29 Apr 2024 21:12:44 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Christoph Anton Mitterer <calestyo@scientia.org>,
	DASH Mailing List <dash@vger.kernel.org>
Subject: Re: [PATCH 0/8] Add multi-byte support
Message-ID: <Zi+czPiT/X/GbNm1@gondor.apana.org.au>
References: <cover.1714215826.git.herbert@gondor.apana.org.au>
 <eb927eeff3d1da7406c998d0ce816d3b6a061fc7.camel@scientia.org>
 <Zi2dIJQcNVwJgxuN@gondor.apana.org.au>
 <abc8daf0-60ab-4e7c-aba7-9a3f3b973f57@gigawatt.nl>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abc8daf0-60ab-4e7c-aba7-9a3f3b973f57@gigawatt.nl>

On Sun, Apr 28, 2024 at 03:50:57PM +0100, Harald van Dijk wrote:
>
> The way you are implementing it, once you get to pmatch(), arguably you will
> not handle ${foo%.} correctly.

I took the easy way out so for now only the fnmatch path works
properly.  But eventually I will get to the pmatch path too,
especially because fnmatch(3) seems to slow down quite a bit
once locale is set.
 
> This is something I expect to set foo to '\303', and it does in all shells I
> know of, despite POSIX not saying this needs to work. The way you are
> implementing multibyte character support, if I am reading it right, as long
> as a full multibyte character has not been read, the next byte will be taken
> as part of that multibyte character, meaning you will take '\303.' as a
> single invalid multibyte character.

A multi-byte character has to be valid according to mbrtowc
before I mark it with MBCHAR.  Otherwise it'll be treated as
just a single-byte character.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
