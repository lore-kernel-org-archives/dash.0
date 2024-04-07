Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C29917FF
	for <dash@vger.kernel.org>; Sun,  7 Apr 2024 05:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712467020; cv=none; b=U2ZlYPSHCiQdn6fsyd9QJ1ZHn50v8sGEPJnybsVE1R2QgmCCBqDYJICJBC2KoRs9xZ1ngEXbkN+dCtywhAJ7eJuZeKtZBhmnPtaQBpfOyquv7RNOAisTA0GzW0Wm9gcZ959Q6byqrh57j93pGOG87LDejueIB65CoZGVdokcWMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712467020; c=relaxed/simple;
	bh=78QZB0lq3Ia8haRUdC/vvNPyVWLHzTsHIkG5e4rrPbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGdtp3X7OrWj9dLI3V/kS26vCZ7Aa0gkEqePrvj5BLia5kjl22Xh8NB45ieZsIE8103xO5VGkAXI5aT5i7dOs0qpaEQxxQZsi9vzKGk8mQFSzoPO6yBrMkJYJJE1P3wPHjCYLnpoyNfbAv0rlfhvOr15MkSw+Z31SlvQh2WtYwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rtKtf-00G7NP-Ln; Sun, 07 Apr 2024 13:16:52 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 07 Apr 2024 13:17:08 +0800
Date: Sun, 7 Apr 2024 13:17:08 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] configure.ac: drop -Wl,--fatal-warnings
Message-ID: <ZhIsVADM19upkCfl@gondor.apana.org.au>
References: <20240216163319.860768-1-fontaine.fabrice@gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216163319.860768-1-fontaine.fabrice@gmail.com>

On Fri, Feb 16, 2024 at 05:33:19PM +0100, Fabrice Fontaine wrote:
> Drop -Wl,--fatal-warnings with --enable-static to avoid the following
> static build failure:
> 
> configure:4778: checking for strtod
> configure:4778: /home/autobuild/autobuild/instance-8/output-1/host/bin/powerpc-buildroot-linux-uclibcspe-gcc -o conftest -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -mabi=spe -mfloat-gprs=single -Wa,-me500 -Os -g0  -static -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -static -Wl,--fatal-warnings conftest.c  >&5
> /home/autobuild/autobuild/instance-8/output-1/host/lib/gcc/powerpc-buildroot-linux-uclibcspe/8.4.0/../../../../powerpc-buildroot-linux-uclibcspe/bin/ld: warning: conftest has a LOAD segment with RWX permissions
> collect2: error: ld returned 1 exit status
> 
> [...]
> 
> In file included from arith_yylex.c:44:
> system.h:74:22: error: static declaration of 'strtod' follows non-static declaration
>  static inline double strtod(const char *nptr, char **endptr)
>                       ^~~~~~
> 
> Fixes:
>  - http://autobuild.buildroot.org/results/a54fdc7d1b94beb47203373ae35b08d9cea8d42c
> 
> Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
> ---
>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
