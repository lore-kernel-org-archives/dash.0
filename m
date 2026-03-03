Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8AD31717E
	for <dash@vger.kernel.org>; Tue,  3 Mar 2026 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772530733; cv=none; b=hE1dFc62mQp97DL3iIcBqTW47I3qGh28IvjjfWgtz4gLdZgWYhvlNmTeb/cHMSdJBvMI2CxYR+W4i2ew4UHj8PizWKRsnewRh4+3nEaSW1f3zD1+Y6Vhpte01MhQ3VTIr4eEen1Xv3cMKhX5T91R2eQuCgBiXaKwjKiEI51SbxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772530733; c=relaxed/simple;
	bh=/A4HBd9ioGLQnvBhp00sFMkSwTitgbPyxXQFVjLf7W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIBqpWTtTv/olKM/yAKxhyozvv+toasoLbUE+FgNqJ7jRu7VU39Far146cwQqmtfhiqT0waEsZ9tsPChZWAJKb6Rdu3+Kr5uSBRMQuJLPczlsGKGggh6tg6/M1ymdehAbLnD92tPCzx+fmVyaHoARBUTcew24EX9CXvbHo0KdFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=R4MYC616; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="R4MYC616"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=bv6Fx1JfgRZz8zSG/PiBR70eUmDj/wpqjQchyeVf29I=; 
	b=R4MYC6164fcpl82A+SgtJTXOqhOJQiCEw0i/Dh15D8+8gAkBwyS0kiXFoNby3diQv0EDYQCbMJk
	UaYsmkY45frlfuh8f1baeLu5EIHhGFPcQeE75PYFBjbeU4uGmFZLHs8vc0OzftuUEveUbCa7rYBAt
	ik/YfLbnFG7sDzWlCL3VQmoVivMhLSc++QZhJ+JiZLXeEdBrUjRo/TiSzXuEX2BE0pMjLEuHYirCz
	nsPoWJwt8GtIKIw+ZiwJeCI4vuUnqVdU1LzezIfN5FK6rHTSQAHQp2n+1vgfFJPAlF7kpXSZRSB52
	8P+rZc+YnrTTS62FG751N6rDQQOI+b5Mh/yw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vxMDG-00B3Pp-2o;
	Tue, 03 Mar 2026 17:38:47 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 03 Mar 2026 18:38:46 +0900
Date: Tue, 3 Mar 2026 18:38:46 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jyri-Matti =?iso-8859-1?Q?L=E4hteenm=E4ki?= <jyri-matti@lahteenmaki.net>
Cc: dash@vger.kernel.org
Subject: Re: Fwd: Behavior change in Dash pipes/read?
Message-ID: <aaasJl7LlXhF_JY3@gondor.apana.org.au>
References: <CANhYXO-M=zNN3XDN9V3O2XaOvA=3wc1vkogSfyRUWhVCP9_iGA@mail.gmail.com>
 <aYMOgmK_puMi2J3N@gondor.apana.org.au>
 <CANhYXO9A5Y=TJi-TbEvv3ASPFjPjdd+pEfhmjqeMMXOCEoCpzw@mail.gmail.com>
 <aaOaPybgS3vDfbtQ@gondor.apana.org.au>
 <CANhYXO-FCjH6GTGyh3=iRxa+07bADbODsbM3oacfn7Uu6kkH6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANhYXO-FCjH6GTGyh3=iRxa+07bADbODsbM3oacfn7Uu6kkH6g@mail.gmail.com>

On Sun, Mar 01, 2026 at 07:53:22PM +0200, Jyri-Matti Lähteenmäki wrote:
>
> Why Only on Mac?
> 
> The key is in configure.ac:200-201:
>     if test "$use_libedit" != "yes"; then
>         AC_DEFINE([SMALL], 1, [Define if you build with -DSMALL])
> * --with-libedit succeeds → SMALL is not defined → IS_DEFINED_SMALL == 0
> * --with-libedit fails or is omitted → SMALL is defined → IS_DEFINED_SMALL

Excellent work.  So it was --with-libedit that's the key to reproducing
this.  I was distracted by tee(2) so didn't even look in that direction.

I can reproduce this now and I'll send you a patch soon.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
