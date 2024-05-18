Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F388D518
	for <dash@vger.kernel.org>; Sat, 18 May 2024 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716022952; cv=none; b=aiy065TwIGgS1DEES/AJDIUt6rHE+L4xI4xHessLT94inefD0/l2lZdIN8VIDS4uR76gFFeVfADtJikvbqeNqs24Ip2Wi85JRq+wv0B/Pq3x/tdFqmyD52WSRk25b0ycpxahtOjH50vi6MGo66gG3Le69aUcGqPX7gvXpMoCrPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716022952; c=relaxed/simple;
	bh=E/mgHYkN2KsVCbTJoNPZHYxujX9Ox5IJZjFCPWxTM5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jl90eT7Hvs8yN4BVyP+uKJZrGq3eSkR/v6iyVabCW2XsTQCrsv2x8BR9f1PKEjVqvCxoVg6ExgiIkIn0kooIpxHWH3tqwt9yUje5Y3yHq0LGFPItvk30uwXgeT9shcw5ZfJfsrko6vVHD6YmSVsk2GRiRmqPd5NpNrT4N4jh+9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s8FxG-00H3j3-17;
	Sat, 18 May 2024 17:02:15 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 18 May 2024 17:02:15 +0800
Date: Sat, 18 May 2024 17:02:15 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Johannes Altmanninger <aclopte@gmail.com>
Cc: Jilles Tjoelker <jilles@stack.nl>, harald@gigawatt.nl,
	dash@vger.kernel.org
Subject: Re: [PATCH v3] Allow trap to un-ignore SIGINT/SIGQUIT in async
 subshells
Message-ID: <Zkhul13IfDE3-x7A@gondor.apana.org.au>
References: <ZgbYAvgixaQEsF4K@gmail.com>
 <20240329153905.154792-2-aclopte@gmail.com>
 <ZhKBHMHJRJdTdsVP@gondor.apana.org.au>
 <ZkhqIFR3mUyaXpN2@gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkhqIFR3mUyaXpN2@gmail.com>

On Sat, May 18, 2024 at 10:43:12AM +0200, Johannes Altmanninger wrote:
>
> I'm not really following the last part;
> maybe it's no longer relevant with the bug fix.
> Note that it works the same whether "set -i" or "trap - INT" is used,
> also in noninteractive shells like
> 
> 	dash -c '( trap - INT; sleep inf ) & read _'

All I meant was that if you call ignoresig before sigmode itself
is initialised it will do the wrong thing if the signal was supposed
to be a hard ignore.

However, this can't happen because we only call ignoresig for
SIGINT and SIGQUIT, and for those two signals, ignoresig is
always called after setinteractive which will initialise the
sigmode array to S_HARD_IGN if necessary.

I'll add a comment when applying your patch.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
