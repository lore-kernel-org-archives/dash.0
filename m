Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CE5218ADD
	for <dash@vger.kernel.org>; Thu, 28 Aug 2025 09:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756372436; cv=none; b=QC18YuVhTnhccgI+VQNs6AO5W/Y6Zl7VRngLBHudDzdhwozAO1vA79zzNCAEw44UzVziXtgmRE3cKUNLLCaMH6tieXQ8kaeKBBk8bll4Nohxu2fEcebxhXoDaVFjCRfCds3i6Cl5eeWZ8sTzASWOKBRgzDebW5m6sgzsDRu3qgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756372436; c=relaxed/simple;
	bh=QLSpcj3t6yq1tyHyEGQWtlLwINTtOSZJVPFR8Ic81cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbInxDJ28iF9gx9DzJwkGgzT5i2QTE2XO0OC1nyFgnTqmZw0wsDFzyKNsCpfaCBS38MzwUyR4vkvqfNrlPm3JeFjetjX1H5NIX/jcp1Z8U75v/jPt22hbZSM0svIawELqe9JGTzIgicKFY4q2vOEkA8X45xFzixa0i90SxzppC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=EFPdX6DT; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="EFPdX6DT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=h5wY3W9xAf67jsaCyNDUUqr/RFB6uZw520LWSYsyOao=; b=EFPdX6DT3uxwVh0k1YWuXeMCGR
	DGjtoThI0rcO6rtEsLwnlAtNOuTwf6srQ8Fe0Q00ljMpdz2om8fm/9TKKM0q+fMLb5jtolCzbJVG9
	Kn+8shR4kGAJYsXVqRIKjgJF0i2UNWlbwEdXF/7urSHJ/Zryw5dra5JIdDqxnXdWSeW2xaA9mlGPa
	yju1xosIYnveOFMJw4rl8T/YS/psaH6QdVrbbuz3Aemy4MwjMRbAr3ioD/zP0iEKyGXpoK4D0SjYm
	A45/n0PjOPDSjnw41wH8cDiQa+IQiGn+Xkn12xeSHxpN8w2A8NhOUAtG+D8HNQQKHw1EKDTAIqcy4
	uITbctBA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1urYRu-000SMK-08;
	Thu, 28 Aug 2025 17:13:35 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 28 Aug 2025 17:13:34 +0800
Date: Thu, 28 Aug 2025 17:13:34 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Aleksander Ushakov <aushakov@astralinux.ru>, dash@vger.kernel.org
Subject: Re: [PATCH] builtin: Fix argv overrun in aexpr and oexpr
Message-ID: <aLAdvpZDAFnlxx0a@gondor.apana.org.au>
References: <aLAG4YtNOsfqcq1l@gondor.apana.org.au>
 <b948f6b0-a7a3-4441-90dc-d1dc968700ac@gigawatt.nl>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b948f6b0-a7a3-4441-90dc-d1dc968700ac@gigawatt.nl>

On Thu, Aug 28, 2025 at 10:12:05AM +0100, Harald van Dijk wrote:
>
> This patch fixes the buffer overrun but leaves the syntax error in the
> expression undetected, which is inconsistent with how dash treats other
> syntax errors in expressions, and inconsistent with how other shells treat
> missing operands to -a and -o.

It is what NetBSD does, which is where this code came from.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
