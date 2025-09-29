Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D8E625
	for <dash@vger.kernel.org>; Mon, 29 Sep 2025 05:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759122099; cv=none; b=MRHJ1dOuOR4DJboGF6KZAbKuoH/EO8vAUE1+jP90BF3b3tSaam0BoSaqHcJ2xVZgZ1PWVwfNwp0eIjdopJM75KLxKQ/sKI4jI/Eu/e8hrPt/kDp8WJuMJ9fs1UTsSuLOmZbTaytLCxN1fdZU70yUcGgsXukPut714Emov+HQDX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759122099; c=relaxed/simple;
	bh=3vgu/E8pV4LVenkbBz9d5FTkXccMtTqJTRimPCBeVVk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Mnvc9TUfd7LZU3hjeSMxcj9CgzHyAp9SaHqTRKUXOUAuss8stb5gFkcEu+VPq0i9wtovlsxdty9FSGMaKx03yMQVuVYoC1hGriJOW7bsakHCmaWpoY1MoAO9GV+2c29Nl//dv6IVR3L5mFLKyY9cy2QKUG/VNLmShLGa3iNs8cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=nIzWALkF; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="nIzWALkF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:cc:
	to:subject:message-id:date:from:references:reply-to;
	bh=e1MPpU21fQY3M4v4cdiTicwlgV8Xl5qgFNy3qILNLhE=; b=nIzWALkFIt964h+PU+NX2wjhfS
	FfdpFivIZ2WADw+I3XaxWNhMOVNRHJDKQ5OxDywE/OdzaFFV6NZUdmgcd8Aei5r1abwj+iyg7tEy1
	oX7jQWVNF4skippXtBYFBDyvmxGGWwmSL44PtPEdUy5qY8PGS2+iDGXkQ6G90nNaSujeHYHWd/Dpm
	/rpxEcnPKtkXvsEX0me+wTnsmn5l4qqSIb5SVmyjud5Doxhu9B44PUtDDPuUiGdP/qv9zyp+wMuPg
	Lri2h/mSrcLl+J3W92LcZXhRM0+04529Bf9KUgqHUk8f4NVaUtxQVR09JzY08ClL1X1yMcBSLNiwU
	SD3clz4w==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1v360q-0094zV-2a;
	Mon, 29 Sep 2025 13:01:25 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 29 Sep 2025 13:01:24 +0800
Date: Mon, 29 Sep 2025 13:01:24 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Brian.Inglis@systematicsw.ab.ca
Cc: dash@vger.kernel.org
Subject: Re: dash 0.5.13 configure config.status truncated running under dash
 0.5.13
Message-ID: <aNoSpE9jqtHtTI7M@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba3014e6-b1f6-4b6b-99ac-524dafd22f33@SystematicSW.ab.ca>
X-Newsgroups: apana.lists.os.linux.dash

Brian Inglis <Brian.Inglis@systematicsw.ab.ca> wrote:
> 
> Package dash 0.5.13 configure and build seems to run okay with previous dash 
> 0.5.12 == /bin/sh but rebuilding under latest dash 0.5.13 == /bin/sh fails in 
> configure running config.status at line 665 due to truncation at line defining 

Thanks for the report.  There has been two fixes since 0.5.13
that may fix this, please apply those patches and try again:

https://patchwork.kernel.org/project/dash/patch/aNK2DgpH6Bs0XCQm@gondor.apana.org.au/
https://patchwork.kernel.org/project/dash/patch/aNivTiVPAJAgHDDH@gondor.apana.org.au/

If it still fails please let me know.

I tried to reproduce this but I couldn't even without those two
patches.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
