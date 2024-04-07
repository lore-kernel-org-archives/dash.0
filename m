Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D19917573
	for <dash@vger.kernel.org>; Sun,  7 Apr 2024 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712488730; cv=none; b=L2VJ0B8KdAC+tXr9aYn0MextBWd4UMC66IzrHKlMDSofac5LzzjagDCLPOjmRzyGQThGoydXb8Fe5t1MO80s4lgl9S2Q0jvMICRUY65pFhdRokUybKJ+ZVOo5uYIjCVkaZ11vDN4IunvAPhKVirVux0PHVzSuHoXPAE3KXv3Wr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712488730; c=relaxed/simple;
	bh=GM2eTFI+G0G43gRM53LN/GsoVK/hq9uROEjSuX89aAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ju0yVgbe+OSYPTQqKDikAWNLKLuJSdMZYGgfu86wUzVdbbrd9ZaHuONukajBhEwYRsyjooERLXU8U3TiFTPJY6GmpLdLgz01rD8snw0Ni2WtPVEJ+DyVaOJqwD/bzsyr1ViGR16BUUJFnZSjezOmltY5mMnzKELnR2Ir6ABwDAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rtQXj-00GE2T-Da; Sun, 07 Apr 2024 19:18:36 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 07 Apr 2024 19:18:52 +0800
Date: Sun, 7 Apr 2024 19:18:52 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Johannes Altmanninger <aclopte@gmail.com>
Cc: Jilles Tjoelker <jilles@stack.nl>, harald@gigawatt.nl,
	dash@vger.kernel.org
Subject: Re: [PATCH v3] Allow trap to un-ignore SIGINT/SIGQUIT in async
 subshells
Message-ID: <ZhKBHMHJRJdTdsVP@gondor.apana.org.au>
References: <ZgbYAvgixaQEsF4K@gmail.com>
 <20240329153905.154792-2-aclopte@gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329153905.154792-2-aclopte@gmail.com>

On Fri, Mar 29, 2024 at 04:39:01PM +0100, Johannes Altmanninger wrote:
>
> diff --git a/src/trap.c b/src/trap.c
> index cd84814..dbf81ea 100644
> --- a/src/trap.c
> +++ b/src/trap.c
> @@ -272,7 +272,7 @@ ignoresig(int signo)
>  		signal(signo, SIG_IGN);
>  	}
>  	if (!vforked)
> -		sigmode[signo - 1] = S_HARD_IGN;
> +		sigmode[signo - 1] = S_IGN;

This is buggy if sigmode is already S_HARD_IGN.  You can fix
this by moving the if statement inside the previous one.

Please also add a comment stating that sigmode has already been
initialised by setinteractive, as otherwise we may also lose a
hard ignore.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
