Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.181.231.80
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794386029;
	b=xwDFbyWRNsfs+7D8qWjOVMEnhTkMsp8DZnhtAxD9/PJ7mD63NR56DpM8kh41g28fekP2
	 MzH72VnbrR2QsiKRR7q16fRtJNL4eXKp4kX5bC7zmqKmHoaKiNluc+NSkZTCwcBoZYRXv
	 RIl37iEDosZxM2dKvW0ZO5KdueWF5IEOYe+yYSNjaM+Z1F3clVc/hOM+VHiaJMwX5AQfH
	 2gWHd3XTCcTGI9tAwZitF+/ua0HYgYlS17u5RDlHdRcDoZhaLCe/eKciiJSifeHd+8L62
	 r0GCHZWQbI7uljCMuOk16rm8Fquf+18g0CHJ6DMoAsmooswSzG0pMG2GP+AV9GOFkng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794386029;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=hv/X2qR3EjY7GWbzHJ70Gr59EnAKclHuzD53ozAmAwo=;
	b=wXD5g5eutk1s2nkfeqpzgmDm1QEAcBUsjHNPB3a4W58BRFo3a+eeoWSHzMbquffcmOQu
	 /47yU0nTEHsCYNYhg+3Q9Lm0psCUVReZPS2F4O1jujiJOBRa/7KJ4u9cKBJEiliBnfLE4
	 Kk71wexoMH49lBfTuLYgcV/F2Q2GzRtiJ9gqoboNLETLAI3TE/m+RO1ZDodzwUNP6T2xV
	 9Uaj5exy/IU253n5+Dm7Osb7ALg6OKmiX3LDr/j4VMczKZhoA3CyLJMDolm51FxIMSKl1
	 l+Ar+g7OmqXGaxKXk4CjhhxBQNwP2PtMSxB62dMCrkF77l60C+OHOEazw5eEomIGFmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gondor.apana.org.au;
	spf=pass smtp.mailfrom=gondor.apana.org.au;
	dkim=pass header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=iPCsFRfz;
	arc=none smtp.remote-ip=180.181.231.80
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47988606A31C
	for <dash@vger.kernel.org>; Wed, 11 Nov 2026 08:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47988606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=iPCsFRfz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=hv/X2qR3EjY7GWbzHJ70Gr59EnAKclHuzD53ozAmAwo=; 
	b=iPCsFRfz0w31Hcq4dFMh5cF1NiSFAbjSLO4CSa9+8YFpObZp8hXgfZJl7M5ygZKYz05sHorknnx
	i0r3EXwaBW1sallkUcHArloj7F0VASKf4bfUeoIS64Ydw4Nz0FrFTVRv/uipheehHeZzeYtq1bu1z
	Ey9uHaAP5qBu+WuX251z1DdMQ27+e1vidkLaV8lh7CSkWF+Le8yAkT8iWO5MTfUmbpP8p8oQ9uoKn
	Qr6VkkTDqpEAk0YBwJrkDO++RiNa7yAbBzjPSvuyWdts6/rxArlPOEVjQLVNhKqOpy5epJ3D0vEPZ
	ZTatToQma4BjhUl942T3xEURvMeEJVaeN6sA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1xR3m4-0000000DinH-0nvW;
	Wed, 11 Nov 2026 16:33:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 11 Nov 2026 16:33:44 +0800
Date: Wed, 11 Nov 2026 16:33:44 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Ayesha Shafique <ayeshashafique123@gmail.com>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] expand: Fix out-of-bounds syntax table access
Message-ID: <avQoaJdeFdDypoOU@gondor.apana.org.au>
References: <20260817202007.93924-1-ayeshashafique123@gmail.com>
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Post: <mailto:dash@vger.kernel.org>
List-Help: <mailto:dash+help@vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
List-Owner: <mailto:dash+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817202007.93924-1-ayeshashafique123@gmail.com>

On Mon, Aug 17, 2026 at 03:20:07PM -0500, Ayesha Shafique wrote:
> mbtodest passes a signed byte to chtodest. Bytes with the high bit set
> can therefore be negative. The syntax tables are based at SYNBASE so
> that signed character values can be used as indices. However, the
> is_type path did not apply this offset, causing chtodest and mbtodest
> to read before the array:
> 
>   $ printf 'v=\377\nw=$v\n' | src/dash
>   AddressSanitizer: global-buffer-overflow in chtodest
> 
> Apply SYNBASE to is_type, as is already done by the is_special macro.
> 
> Fixes: c0c860df08c9 ("expand: Count multi-byte characters for VSLENGTH")
> Signed-off-by: Ayesha Shafique <ayeshashafique123@gmail.com>
> ---
> 
> Hi,
> 
> I found this while working on a research project, testing against
> commit 037bbdf ("Release 0.5.13.5"). Here is the relevant GDB and
> AddressSanitizer trace:
> 
>   $ printf 'v=\xff\nw=$v\n' > /tmp/s.sh
>   $ gdb -q --args ./dash /tmp/s.sh
>   Reading symbols from ./dash...
>   (gdb) b expand.c:895
>   Breakpoint 1 at 0x8c028: file expand.c, line 895.
>   (gdb) run
>   Starting program: /home/aysha/dash/src/dash /tmp/s.sh
> 
>   Breakpoint 1, chtodest (c=-1,
>       syntax=0x55555562d680 <is_type> "",
>       out=0x5555556bea42 <stackbase+98> "\377") at expand.c:895
>   895     {
>   (gdb) info args
>   c = -1
>   syntax = 0x55555562d680 <is_type> ""
>   out = 0x5555556bea42 <stackbase+98> "\377"
>   (gdb) n
>   896             if (syntax[c] == CCTL)
>   (gdb) p c
>   $1 = -1
>   (gdb) n
>   =================================================================
>   ERROR: AddressSanitizer: global-buffer-overflow on address
>   0x55555562d67f
>   READ of size 1 at 0x55555562d67f thread T0
>       #0 in chtodest /home/aysha/dash/src/expand.c:896
>       #1 in mbtodest /home/aysha/dash/src/expand.c:918
>       #2 in memtodest /home/aysha/dash/src/expand.c:996
>       #3 in strtodest /home/aysha/dash/src/expand.c:1017
>       #4 in varvalue /home/aysha/dash/src/expand.c:1140
>       #5 in evalvar /home/aysha/dash/src/expand.c:811
>       #6 in argstr /home/aysha/dash/src/expand.c:391
>       #7 in expandarg /home/aysha/dash/src/expand.c:232
>   0x55555562d67f is located 1 bytes before global variable 'is_type'
>   defined in 'syntax.c:285:12' (0x55555562d680) of size 257
>   SUMMARY: AddressSanitizer: global-buffer-overflow
>   /home/aysha/dash/src/expand.c:896 in chtodest
> 
> This is my first patch to dash, so apologies for any mistakes I might
> have made. I'm happy to fix anything you point out.
> 
> Thanks!
> Ayesha
> 
>  src/expand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
