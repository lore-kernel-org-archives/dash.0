Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE092264A8
	for <dash@vger.kernel.org>; Wed, 28 Jan 2026 04:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769575665; cv=none; b=aN9Du1FNZKng4YQCoX+PU2MzlOBJ0WM5FMOtYRrtZbrmJTBXwPkcOwu7uNdi5p7lOTdCdoy0UWmewdlu4qKASak989F1GN4ILoXdkoi5JmNW3upDpmsnhyqO+c5Wr0hdWTld8sWgz2XUDA+b+L/R+Ute60rsYL1ofO9nReoFlgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769575665; c=relaxed/simple;
	bh=Cel+uqNnH5iRGWoktUPu1Z5WzJh7bGDEIHiZ3awHXkA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LXKXVSvtGyTXM3tQmkM86I2xT7jOepMeDPYIPnctoHoVnuOO8P14CiHHPia0RWQ4hhmpiCMkc4Bioh5wO3ILNQcZfVrMdY4LlC/vXlAEc51YYeozj8kXid1tBb83mw6swFdKfieDuNbCPYjuPTArq2dfqcGqvsMVcE12KOorsjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=e4knmw+z; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="e4knmw+z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=ycqVxFtSPaixjOfJ+gwmEsGmsgs/yiAn0ybs5fyytts=; b=e4knmw+zNwQvqGiG+0tstIlbgW
	wM595oLJHPTsqJcfLPQdCm5nlYak4kxNR/fviHPutlxuaIf6SczeS6FsYOGBtNDDWv2OgmHQw0ksV
	ANjmCKUMJXFUakkJVnLwqnpgQNX8WfDDx8LK0K/9CIioeBnNGljT6/BjA92ct6ypv3uF8KqXd0wf7
	3Be38/eexzIOu1cdH1J5CrPSZ/CFLMXlyCZ+H9DqpaLbUOB7HKowvnTFS2waWprgmBr6PYEK1Vw1a
	PD2ZN6z0GMG0LfxY9C0OeOk/FxjUmB6sONP+KOWUE02rNWL1JGWvd9R2VHR3nxPbOwKX25zi88I/Z
	A7cOZrwQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vkxSt-002ehK-04;
	Wed, 28 Jan 2026 12:47:40 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 28 Jan 2026 12:47:39 +0800
Date: Wed, 28 Jan 2026 12:47:39 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: avidseeker@disroot.org
Cc: dash@vger.kernel.org
Subject: Re: fc -s causes infinite loop
Message-ID: <aXmU62AY8fNg85P2@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <KJFldfHRfPi3GtR2lgeOY1U4TdB3PqG4@disroot.org>
X-Newsgroups: apana.lists.os.linux.dash

avidseeker@disroot.org wrote:
> I'm trying to mimic zsh re-run ("r") behavior. The Posix way for that is
> fc -s which works as expected in bash and zsh when aliased as alias r="fc -s"

This appears to be fixed in 0.5.13.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
