Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E560A43169
	for <dash@vger.kernel.org>; Sun, 31 Aug 2025 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756629930; cv=none; b=VDMUucfEbhHM4aWW7MOb1q9hrtuTq08KA3A3yjJ88aIAUuuG/mzPDVeRuBU6TH1Cz6fUqAJlax2QUdr/K8OSQcjkCz+AwVLDz5AbjZ2GHh+9lBS06E8o9raQjURimOkvL5ABUn4JbfbDBu8J1iIyxJ+4GOZ6HRi6YHCbApLJ9Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756629930; c=relaxed/simple;
	bh=wn5RZVLos+XvIZpfAAB45NesyW8rLNsmK+sA+Vpfsko=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=q+r0v0BdW6vNZW/LFj15ZHesdWbxdNHCaDZXoGXqvwWPf4+DBTYe6cVFbRGH2Nxv6mGQtrHXI6cloyeoG0XkOASHmOZjWebcSBdeJBdyOL+0ro5CHhDe1v9Q9ihLBiutGe5/ZnyGPBqHP/FFpsFiOmKy8z73npD9FAMt2k7iyHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=U0ebtdre; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="U0ebtdre"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YQ9mXDhi8iYV2JiQV/u1jHoDqYoVNVYuHF78qNOUBNg=; b=U0ebtdreQglU6NLwQjhH4AJaTo
	EuRBnj9wsazaYYqvpZ3RmwcVFrz1uR8A7aRaY0d5SiyIt3TnonJewcpxbV2mSO/mpcBCGZMkze4ah
	VTDw5YH00qi0gmvwPvmttpuK99GSxy9/x04LIwn/xyMEubMhyTfQSu1ClFZSSN3CPodRlf2zCszjM
	9FWu84J8pY+ywUOvDn8UZprjukOoDE7AL9PvZ+0zbON/V/hQAngkRowdxpJfRzkNrSwUGNdrcubrz
	axBKC948HXqHof63s/zt/RkzgVBiMWDFj2ncZUCbZvv8yhtGurKXXsf4Bxt4XvrIyAAp6BRgHj39J
	rQKGmmKQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1usdR9-001KhD-0W;
	Sun, 31 Aug 2025 16:45:16 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 31 Aug 2025 16:45:15 +0800
Date: Sun, 31 Aug 2025 16:45:15 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Kuhl, Brian" <brian.kuhl@windriver.com>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] VxWorks Support
Message-ID: <aLQLm5TAk8Pf0Rc0@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB47535C0C8F14FAF266B04D309967A@DM6PR11MB4753.namprd11.prod.outlook.com>
X-Newsgroups: apana.lists.os.linux.dash

Kuhl, Brian <brian.kuhl@windriver.com> wrote:
> Recent versions of VxWorks support fork() and as result can support dash.
> For example,  to cross compile for IA with this patch applied,  and your VSB environment sourced (aka sysroot)
>  
> ./configure --build=x86_64-pc-linux-gnu --host=x86_64-wrs-vxworks --prefix=/usr \
>    CC=wr-cc CXX=wr-c++ LD=wr-ld AR=wr-ar NM=wr-nm OBJCOPY=wr-objcopy OBJDUMP=wr-objdump RANLIB=wr-ranlib READELF=wr-readelf SIZE=wr-size STRIP= wr-strip \
>    ac_cv_func_faccessat=no    \
>    CFLAGS="-DJOBS=0 "
> 
> make install DESTDIR=${VSB}/usr/3pp/develop
> 
> For other architectures update your <host> appropriately. 
> 
> ---
> configure.ac     | 4 ++--
> src/bltin/test.c | 2 ++
> src/jobs.c       | 4 ++++
> 3 files changed, 8 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
