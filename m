Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82AA2C027E
	for <dash@vger.kernel.org>; Wed, 28 Jan 2026 04:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769573820; cv=none; b=mpbd0LWqxGy9J60598CLqbv5vCY5U7mAd4Vq+sjRH5L5HQkFSQiDPdquVnJs9dr09aRYHroY9oZglz3o9VLPso+ux5MTW+sQYqj/5PqEDm+IBMS2buDereMjPWCcOIQMHiamOldKphZS3FRpw88doYciuaINwzL/fFA48yyIAcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769573820; c=relaxed/simple;
	bh=Gs2mC2gZI2px3zE7gQ6/vguFqAWBC3j/eCPmiJmwIJI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UlZM7abjyoLKO/d1epPEpNVeAgay7qxTv0Vx4Bt7JfHd6Uk8mGBJq4Zd804jTfFQ1xNMuWV2bI2k5P9LVi0C1nZ8j7PUAN/thuxUmQs+da8xz/BZQnnF8VhvOnMHlYz55LuadOdBJMgwYksXJjIg91PKEmUmpQ80zsaeCO9vO8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=k2TcuvyR; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="k2TcuvyR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=XP8cVEU6BB4qbYDY1qnCu4j2VKpVVJ//dGgG+/gYuvE=; b=k2TcuvyR2JyWw9ISiYY4D9sEN6
	uoZd6dV8FvAXcraqOJTwSEwvitcW0wWmzV9d+TdrPoW9tVpqILvnhS0R40G9APfHCDJp1BUQsaiTs
	iu1ajBO3Go2YoyHYQ8kAZ+yfTBVJtbI/1ioPxHHcDSpsVYM5wexwLeKen0PTSAruCyVsgfAY1mFwi
	Lehc+GJ19gAFzrCy1zrfrFcWNYDdlK1yEocHzHuBLoOeQebfjRxB9EEwgg5UMKyj4Wen9MoqDRNfZ
	AVvdRclh6RVhdj99RFn0EDTFcMiPoAoQgKvmJtIR05Yi9R7odgyoXS0gLZXHSpnTxUQkx+1+4ZBxT
	j/32iAmw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vkwz7-002eUd-1B;
	Wed, 28 Jan 2026 12:16:54 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 28 Jan 2026 12:16:53 +0800
Date: Wed, 28 Jan 2026 12:16:53 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Hadrien LACOUR <h.lacour@sim-and-cure.com>
Cc: dash@vger.kernel.org
Subject: Re: dash 0.5.13.1: heredoc parsing failure
Message-ID: <aXmNtV-8gCNEToij@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmiXchO=0x573QEG6eZnOVkd8K=0PCiNM2x=qqrQPxDsoWpKQ@mail.gmail.com>
X-Newsgroups: apana.lists.os.linux.dash

Hadrien LACOUR <h.lacour@sim-and-cure.com> wrote:
> 
> Hello, I'm on a ARM64 MacOS machine and updated from 0.5.12 to 0.5.13
> via Macports only to get a very strange failure (nothing printed)
> attached as a script. I then tried on
> 5139d6a27763fc0be386e15634db21e45598b299 ("shell: Fix unsigned char
> promotion and truncation") since my problem seemed similar but not
> cigar; tried using a modern clang (21) instead of the system one too.
> 
> Hope GMail doesn't botch anything (nothing else at work).

Dash 0.5.13 uses tee(2) on Linux for pipes, while other systems
will fall back to reading a single byte.

I suspect this is a bug in the fallback path which I no longer test.

Please run dash 0.5.13 under strace and send me the result.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
