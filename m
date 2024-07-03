Received: from norbury.hmeau.com (helcar.hmeau.com [216.24.177.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C182C142903
	for <dash@vger.kernel.org>; Wed,  3 Jul 2024 10:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.24.177.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003861; cv=none; b=mLLpnx6UB6a38IN7BvsJWr0wF0diT1+unCdOSptFbIFM/bSMR5KMrhWKr/ZZcNlZAb5RbY+VUPj5fRYLbi7IicrcjrWoR73wPMutfODnzo32iLfPbOo2VsqgLeTaIZVTMDlSFDKKI4A6FvCqazvQd0P2V7WqylbaD34RduX9CK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003861; c=relaxed/simple;
	bh=tRCAa/FPlt0JVFD7usB3GYBZfRV+BoGv0iF3SEJVJSU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=C8SYcGrJ3R484cph7341NgWGSeaSFy6fADryTHVimmsHvz3+QOBKIaa2X5tT8EToNYtw7joZBBHTBJ1gEEb+sRJ793DAyWT3HFgZT6Y3Jrs4STuf5arldnQGrE1qXei6wimcUVDdZ/1ZdpvBsh8Nxu/iWthKqxpzO7b9KVhW4KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=216.24.177.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
	by norbury.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sOxZJ-005iYl-36;
	Wed, 03 Jul 2024 20:50:34 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 03 Jul 2024 20:50:34 +1000
Date: Wed, 3 Jul 2024 20:50:34 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Martijn Dekker <martijn@inlv.org>
Cc: dash@vger.kernel.org
Subject: Re: [BUG] reading from FIFO broken
Message-ID: <ZoUs+i4iBAOdYmwI@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a068eda-298b-4679-84e2-0dc7a3348813@inlv.org>
X-Newsgroups: apana.lists.os.linux.dash

Martijn Dekker <martijn@inlv.org> wrote:
>
> ...reading from a FIFO is broken, at least on macOS 12.7.5. It seems like the 
> 'read' command can no longer read anything from a FIFO.
> 
> Reproducer:
> 
> $ dash -c 'trap "rm fifo" 0; mkfifo fifo;
>        echo OK >fifo & read r <fifo; echo "${#r}:$r"'
> 0:
> 
> Expected output:
> 
> 2:OK

I can't reproduce this under Linux.  Could you please run it under
strace for me?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
