Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404A760B8A
	for <dash@vger.kernel.org>; Tue, 23 Sep 2025 10:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758623807; cv=none; b=VJ2pyKEWxD68ahBNp47CvgM4h6Lvi+qEmpM8Yrcit8twrxdgmA9K7711SrT5p48d1ChjBbM4l2Yn7u9fP5C+RwYwZbl4ZUE1xedxeS3WNydH/qN2bxH3w9pTLrehri/oW+DezrdF8zSaq4pziqOq+jJWCAGho1TYjS3fAX1Sh60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758623807; c=relaxed/simple;
	bh=i3jhWboETHqvyVoiMyMwiUIZLby3xzraA298J40rK1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+lR0NV3+fgXt9f6qxX6yj3IVEmnZ3MUIeY7vvDBVRTa0ICMLcH72WGT3Pw/8udF1/8aHvenKeXewr5/TxOIWjdKpsVE+c/QHjjLz6GgclGmB+eWgKETOwgaT0H7EvtFVnGnbqTg3BeLxGaSiIccKc5vKXcemZlji2Pd6ROluKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=OnoaGoQ2; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="OnoaGoQ2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:cc:to:subject:message-id:date:from:reply-to;
	bh=AQ2cboX8OwAVP11AQ6YyEzb+hfSg352AXmQXdfm2qMI=; b=OnoaGoQ2vbO8/GT+yDaCSzSLPA
	0u8F9e5Q+6Rh267g2fdh7w457EEKlp1KQgz++Bn0gasn4+AONR/jtV7tpRIA3dy9QRCmp5SWgP+lM
	d3LFi47zLqwZiAtGKjEidGM9uog2+msv74AW47+RsRf2IQnAzXxFipyDyUF76SviJZU/e8XZUj4T+
	Zb1h/brVGpqkOI4HwEhkeb5+fYh7cvFSOLA4GKhtqEdojr+yqEX2ciizPYnYuiFzsPrRKGPKzL2E9
	08voHetnEmm5bURz2EuQfW4f5FQkKjttmt+xBsPI8K7CENWVj+RETTJD2tNaedPk18d95+bzdELyb
	atBuVPFA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1v10Nx-007egl-3C;
	Tue, 23 Sep 2025 18:36:39 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 23 Sep 2025 18:36:37 +0800
Date: Tue, 23 Sep 2025 18:36:37 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Reilly Brogan <reilly@reillybrogan.com>, dash@vger.kernel.org
Subject: Re: bug: 0.5.13 regression in parsing
Message-ID: <aNJ4Nd-lE1rIjhH3@gondor.apana.org.au>
References: <aNI-RCggOzN-tyHy@gondor.apana.org.au>
 <77d15ae4-e9e9-44f5-9eda-f287a4815411@gigawatt.nl>
 <aNJ3dYOcNX_lrTbr@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNJ3dYOcNX_lrTbr@gondor.apana.org.au>

On Tue, Sep 23, 2025 at 06:33:25PM +0800, Herbert Xu wrote:
>
> Thanks for the hint.  I can reproduce now by attempting to build
> xcb-util.  I'm looking into it.

OK it's the same old problem: whenever we add a new feature that
makes us closer to bash, libtool gets confused and mistakes dash
for bash.  Normally it would explicitly invoke /bin/bash if it
detects that /bin/sh is dash.

As libtool is still not POSIX-compliant, that means it produces
crap.

I need to look into exactly which bash/dash test it's using that
we've managed to break and see if we can undo it.  If not then
libtool will just have to be fixed.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
