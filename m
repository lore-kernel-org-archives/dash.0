Received: from norbury.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7675258
	for <dash@vger.kernel.org>; Sat,  6 Jul 2024 00:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720227571; cv=none; b=gxhx6x6/6qOgEkbwq5ia7KZYmC1JLTVf3afW03OyKE99E6iY5EgVkDDEZ9ufXa3I+IEe1go1w76jk8KrxkZDEmUiQ8AGiFBYtrFRzrlVOQjGliTOTgcZtaHGdWkNTst18d5MUeJ+R8hqpyvhILvPpU436+S9pKwHEKfUQiBtUUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720227571; c=relaxed/simple;
	bh=kmVKFcG4wKOsH4KHPwAY61M/FVr8BzKlDgwzCPbkEIs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZWoAHhcGZG90C6ow1V3uJKo3tI5gBmFlDElA8fQW0Fezg0JYfLhqMpye1Nje5sBsd+Q9YEEetPdkZvYFTYE5XQ8QjYnh9f7w+OtZhh1YRD/2JHbCtJnt1yvBg3RgLRYqSidXdmYYt12EOTnqtrLn3T6Vu/b90e4/V4R98kT2RTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
	by norbury.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sPtlt-006hBW-2v;
	Sat, 06 Jul 2024 10:59:27 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 06 Jul 2024 10:59:12 +1000
Date: Sat, 6 Jul 2024 10:59:12 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Martijn Dekker <martijn@inlv.org>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH v2] fix build on systems without memrchr(3)
Message-ID: <ZoiW4PW+Pn551Yrh@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a64ad0a4-ea0f-4de3-aa2b-e377d3bef85d@inlv.org>
X-Newsgroups: apana.lists.os.linux.dash

Martijn Dekker <martijn@inlv.org> wrote:
> 
> Op 22-06-2024 om 15:25 schreef Martijn Dekker:
>> memrchr(3) is non-standard, and has been ported from glibc to FreeBSD, NetSBD 
>> and OpenBSD, but not to macOS, at least as of 12.7.5. So we need a test for 
>> it. As far as I can tell, *name is a zero-terminated C string, so it should 
>> work to use strrchr(3) as a fallback.
> 
> Reading the code more closely, that's nonsense, because 'p' does not point to 
> the end of the string if metacharacters are found.
> 
> Guess the best we can do is provide a simple local fallback implementation of 
> memrchr(3). Patch v2 attached.

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
