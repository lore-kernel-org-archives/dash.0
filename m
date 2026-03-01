Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6002EAD1C
	for <dash@vger.kernel.org>; Sun,  1 Mar 2026 01:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329543; cv=none; b=e1be8KdxPVX4nYKMxFHSTI73Q5l2PqJA0iIv4gHauAQ9lDSiTdBRT3SdpHCKcC31fcA47xdVA4QKzO/wQiNCUzIEj9VW850K/6BbC9QGKaGrBdWhgnfENy5P7gzpkHVybex667RGDaApHCSGne+Iy0jm/FwXL23z5FQMWPNbdC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329543; c=relaxed/simple;
	bh=dH6btJQ8+jVMTk5pjcHLSJXSG2fL19ihrVEmiN5QI4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmzY3BzvJ+wsZNciCkM1M2WMA1GFuIF2dKZjozktwxs0JH3BKDtbaJmATEqenMiYe0gKwy2IYQuyTgfQbQs1fRc5CNy5tg1t1L695OhY6hCIbs5MEq9HlN7kbFy+MEY0vhSq4bE1O/cX4sMLSNQFzdp8SomSp+J88X0BlS+LKks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=ishw9pRP; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="ishw9pRP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=K0NGd6D5T/MXGH1YA+Tf+lG2hget/sppALXl4qFXO6c=; 
	b=ishw9pRPY7Bu+SjK9MtTEOKEsIFawLZpqR8lMulRRVeiQ2Se2Co6Wem3OLN43a2A6m3gpKCjybs
	2UKd3qKky+aHsXsjW3rJcWNhmWg4SyQgIUso+5LYE8hGI9ksfIjGIdhu0yT8Y5Trqdhb3LhY5vPNK
	I8+/niEVLiF4eBFFVbOhRmZpspGFyTC3rBqVf1oYv/BKE4XzBuTuqs4spUWljY1HYRj5jx7oB/Qnp
	wZwTHCd+pEiDI7Xev8nc1H7+pFglTkoZVaDaLDGKLX2FpePx6m1N5gUvi71nYvgEDm0OgK4lkolUC
	QK7p/S+pAubZxp5O7i4tyfUPocnNCn0UsDEw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vwVsF-00AQbG-2k;
	Sun, 01 Mar 2026 09:45:36 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 01 Mar 2026 10:45:35 +0900
Date: Sun, 1 Mar 2026 10:45:35 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jyri-Matti =?iso-8859-1?Q?L=E4hteenm=E4ki?= <jyri-matti@lahteenmaki.net>
Cc: dash@vger.kernel.org
Subject: Re: Fwd: Behavior change in Dash pipes/read?
Message-ID: <aaOaPybgS3vDfbtQ@gondor.apana.org.au>
References: <CANhYXO-M=zNN3XDN9V3O2XaOvA=3wc1vkogSfyRUWhVCP9_iGA@mail.gmail.com>
 <aYMOgmK_puMi2J3N@gondor.apana.org.au>
 <CANhYXO9A5Y=TJi-TbEvv3ASPFjPjdd+pEfhmjqeMMXOCEoCpzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANhYXO9A5Y=TJi-TbEvv3ASPFjPjdd+pEfhmjqeMMXOCEoCpzw@mail.gmail.com>

On Sat, Feb 07, 2026 at 09:03:16PM +0200, Jyri-Matti Lähteenmäki wrote:
> Hi,
> 
> already tried that but it didn't work. I'm guessing strace-macos
> doesn't pass stdin to the spawned process.
> Figured I could try attach-to-process approach, are these of any help?

Thanks this is quite illuminating.
 
> echo hello | /nix/store/kra243nir1p3pyc50312w3nmirbcbxr0-dash-0.5.13.1/bin/dash
> ./test.sh
> 8931
> > strace -p 8931
> sigprocmask(SIG_BLOCK, 0x0, "[]") = 0
> sigprocmask(SIG_BLOCK, 0x0, "[]") = 0
> ioctl(0, TIOCGETA, 0x100498498) = -1 EPERM (Operation not permitted)
> lseek(0, 0, SEEK_CUR) = -1 EPERM (Operation not permitted)
> pipe() = 0
> fcntl(3, F_DUPFD_CLOEXEC, 10) = 11
> close(3) = 0
> fcntl(4, F_DUPFD_CLOEXEC, 10) = 12
> close(4) = 0

This shows that the new tee(2) path was entered and then bailed
out because tee(2) is not available.

> read(0, "h", 1) = 1
> read(0, "e", 1) = 1
> read(0, "l", 1) = 1
> read(0, "l", 1) = 1
> read(0, "o", 1) = 1
> read(0, "\n", 1) = 1
> read(0, "\n", 1) = 0

This still doesn't make sense though.  For some reason read(1)
didn't stop on the first newline and just kept going until EOF,
but at least it explains the empty output after the read.

Could you please try building and running the commit just before
tee(2) was introduced?

commit b1864ee9f2418f84d918ef101dab972ecf4f852f
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Sun Jun 2 09:31:35 2024 +0800

    input: Use lseek on stdin when possible

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
