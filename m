Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077C31552FD
	for <dash@vger.kernel.org>; Sun,  9 Mar 2025 07:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741506870; cv=none; b=RwRnQdSqc0/+cZAD6MEBNslkjTCuPL0r89Otq8EqDB+0ppd8fQpR1sa4LsruJ7jdG2pSI9dhdpWYZH/m4K9j/eK7Qy/1/7NmvXHEgosa6qQlnEky7fhT60fUacErO+c/W1/+Y7554meNd/QLLmnZDo7Hk+kmcDq8vVGAcUGmBxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741506870; c=relaxed/simple;
	bh=oELxUH9XkwgG9TEEaVSOZkhgLRyTjrsGGzipnpODhQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBu05YwC3SobBTFuZ7crWcqq0bbXQacBRYM/bR1AD590xwczm+Y1FxzmBiIJ8ptoBIRLL8WRXF/S8Eh/EfPQY4v0zqFJ5HY3TNNIRGveCTEiCQyUJa8TfNOyutd5QmkEHcuJTSI1TkZOEJvaAv9eH98otbmRktTYn6APKWR++CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=YUYjzPd7; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="YUYjzPd7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=g2x3MhFDxSopZ+474LTXw6oZwm3iPZnn/dwor+Aou3A=; b=YUYjzPd74+38p0BxHhLc0lhoSi
	Q8rw2dwzufpfnB2AD59ohqkxyQ0Xxa1k3eRdNCuTuvkyGwb51+WkxL6o6Q/K9OYaYOMrTCaRqUBdm
	XpGq2Z8hg2avvKL0b9BtoLwcCQpwCJjb21CNbz1wYnOU0MVWQJDFan/SATVZvtfyiNMMV5L8QGX7a
	CpgSQd2ki3B/1Qd4x+N6Xzjo3EytN9G8q1PX7BBm2WXcNILyNN0zPjmQe4+Be9xj7JV3v2P3MtyT7
	rrhF+WN8Of4eTCXWxFVasEJZ3oAgrPqBrPdkYhFxOzvVg1YCNnTeSKZ5/YBX7Ho0IP1vjPKjMSQJQ
	tcvILqmw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1trBUM-0051nK-0Q;
	Sun, 09 Mar 2025 15:54:23 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 09 Mar 2025 15:54:22 +0800
Date: Sun, 9 Mar 2025 15:54:22 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Alain Knaff <alain@knaff.lu>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] Portability of dash to legacy systems, such as AT&T Unix
 PC : 02-stat64
Message-ID: <Z81JLq62P8jgj22W@gondor.apana.org.au>
References: <aa0e9215-622a-17e0-327b-f0233ed32ad8@knaff.lu>
 <6ea7da38-204f-54bf-7156-085a1589c40b@knaff.lu>
 <6cacf608-326e-211a-7d37-164041710980@knaff.lu>
 <ZhDq9L88eTrLxlWW@gondor.apana.org.au>
 <327cf9fa-b1b0-4740-b4a5-5f7fdb34da23@knaff.lu>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <327cf9fa-b1b0-4740-b4a5-5f7fdb34da23@knaff.lu>

On Tue, Nov 12, 2024 at 11:32:47PM +0100, Alain Knaff wrote:
.
> Checking for declarations rather than functions would miss a
> hypothetical situation where a library function stat64 would exists
> which lacks a prototype declaration. However, this is very unlikely to
> happen in practice, because general availability of prototypes of
> system function predates availability of 64 bit file offset by years.

Apparently this is what prompted the change in the first place:

commit 6f6d1f2da03468c0e131fdcbdcfa9771ffca2614
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Wed May 26 13:49:39 2021 +0800

    shell: Call CHECK_DECL on stat64

    On macOS it is possible to find stat64 at link-time but not at
    compile-time.  To make the build process more robust we should
    check for the header file as well as the library.

    Reported-by: Saagar Jha <saagar@saagarjha.com>
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
 
>  3. and finally, is the whole shebang actually needed if we use
>     AC_SYS_LARGEFILE? This autoconf directive adds an appropriate
>     #define before inclusion of system files to instruct them to make
>     the relevant system calls "64-bit clean". That way we wouldn't need
>     to mess around with redefining stat64 our-self.

Yes I think this is the way to go.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
