Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887994A02
	for <dash@vger.kernel.org>; Thu, 28 Aug 2025 05:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756360146; cv=none; b=AJJM3hbuTM7S1gUHQ1SGlR9AXAqJwNxOKzGdx9HM5vNWdGGgoNpKK10Ku4lWD6dpbFb9manApitrznM1BpkH740u/f29vZc3RyXPqZe7Rxxi2gIHxnfi8e5APjxakxlNB2EPqMLcGWsMvHUJ8B3iFnFakVAxyXdyXZWyRv0Ua0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756360146; c=relaxed/simple;
	bh=nkJQRlJ4HbQGRpD5F/bLYYGJ8NvGr4ULACSo2ObK+D4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qG8ErLOkpGXLSB5nXH06insz829AqZ4KsD1EWiJ6FDk5WrS2cydF83wx5PIex7rrB6xjDU18CoWTHH6XX97Y0nNZ2c2VXyoPKxiCWvgGs5vxBWJIX0IED//+xdivufwpBxCCQ2mpifmPc3unm5ZrC19xC5JOMybtY6dFvmihCw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=f27DyONT; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="f27DyONT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZtnolGMxDab0+BSwK5XstYWDD8Hso2S63hfLxOkBb6A=; b=f27DyONTnKcVhGllGDFrz0jMrg
	+/jW0oySU+O/AQAPW1Z0vAjATMA6LCDIEDicyLEpyEuJ22Pk6UdIGHMhEGhXqnQj0TEGC+0VGU7ey
	36W87EdUXeMIno8rFiQvikvmX9yjaz6Nii8TLiFrmnGmGB+cvD1xqxgu5D37k51cTrWK3TU2f8gWG
	NvGWumFfJbcNUCIMfLQgoxHgOF4Fo14R97oDIesutymQ92EWXe4RpFLcZjtpMDOdKnB8RgffFQbi9
	nHwTYUBQT0/zQ5dU7w9nkzsph+KAMneP6hkG76LUwXsEXpB6ot0ljhTE4klxj93C1FhTuH9a2W3z0
	ruur6iLw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1urVFs-000PMi-1V;
	Thu, 28 Aug 2025 13:48:57 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 28 Aug 2025 13:48:56 +0800
Date: Thu, 28 Aug 2025 13:48:56 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Sam James <sam@gentoo.org>
Cc: dash@vger.kernel.org, navi@vlhl.dev, eschwartz@gentoo.org
Subject: Re: New release (or blessing to take a snapshot)?
Message-ID: <aK_tyFP5srHvrZzn@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734bkv4az.fsf@gentoo.org>
X-Newsgroups: apana.lists.os.linux.dash

Sam James <sam@gentoo.org> wrote:
> Hi,
> 
> There's many commits in master, especially wrt POSIX 2024
> conformance. Would it be possible for a new release to be made? If not,
> would it be possible to have your blessing to ship a snapshot of master
> in Gentoo? (It's completely fine if the answer is no, I just figured I'd
> ask -- Debian experimental seems to be doing that).

I hope to make a release by the end of the year.  Hopefully
the worst bugs from the locale support have been ironed out.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
