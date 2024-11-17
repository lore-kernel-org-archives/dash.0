Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D1B634
	for <dash@vger.kernel.org>; Sun, 17 Nov 2024 09:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731836106; cv=none; b=a2kt/8YVy6WvLds4TgWh7uIxEg4gP+1BLbeaQL5n4uk8saw/j+YmpYbudSO7Bun/4fxhIvURjp+9bLgjBIkvygrp06+tkIfti5magx/QtLZVvDjNkgAko08rDthQiDX4ajeYioM0M9OG4xa+2AZhiGkqBxqM06gA4LMydqwpPt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731836106; c=relaxed/simple;
	bh=LN0F0MQpoUTRGAUqm9vJULTyZyFH5f9bf1J1oxldak4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HltqttldeMRj5NGMMfqQeo2y2llnRdbrBlOypoAh+u8zYJnACWBp8iGjpLeJH4mpY0aQ/4uB58m2AriIVKuxLzy6zRZOlCFTrWSR0tyaNaAUgcdYMOMWf+ZMR4Jl4fZa6+1jxmSC2EH43O7rdsa0EnKnoTSeskT7isb3tL4kRco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=khvBUBXN; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="khvBUBXN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=GVMdHMitiBvhwCIl0dDAEARWP4Er9zAob3dQ9c4G56Q=; b=khvBUBXNX4x84hPZR/foSpooYN
	lJp1lfli29MmR8gJKBjEYuESAMPkudg7PC0Niw+PYVorMnjmv70iIM+lLOe1BWClWjC8kgl1jnzIT
	+iYpA7kfO+5PGfiewij83xJr6uEunvrPvlB10hvqHgvNSdeS6Xp2jveAbEn69SUbFVZjNOrE2twLz
	PY2hmfELBQ7ucu0rqUKG42ZRc50pljk7m5uPqh2JIGTpj5oxlYVtFLpg2rgZwDyiJ8BCWgExA86jW
	btmUZpjiG1RncNw0XLQMvWEEtOIP0pw9qF58QMRpW4pkoOcSjFbZJXu7MGzj9wzPDIPYR6V0daZhI
	M0O0TSyw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tCbgJ-00HPEf-1y;
	Sun, 17 Nov 2024 17:35:00 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 17 Nov 2024 17:34:59 +0800
Date: Sun, 17 Nov 2024 17:34:59 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Alain Knaff <alain@knaff.lu>
Cc: dash@vger.kernel.org
Subject: Re: P*rtability of dash to legacy systems, such as AT&T Unix PC :
 03-name-max
Message-ID: <Zzm4w8KC0G0EgTTK@gondor.apana.org.au>
References: <aa0e9215-622a-17e0-327b-f0233ed32ad8@knaff.lu>
 <6ea7da38-204f-54bf-7156-085a1589c40b@knaff.lu>
 <6cacf608-326e-211a-7d37-164041710980@knaff.lu>
 <ZhDq9L88eTrLxlWW@gondor.apana.org.au>
 <60f962f7-1834-45da-bee9-c245c6797f9e@knaff.lu>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60f962f7-1834-45da-bee9-c245c6797f9e@knaff.lu>

On Sun, Nov 17, 2024 at 10:32:38AM +0100, Alain Knaff wrote:
> Hi,
> 
> The third part of the patch set supplies a definition of NAME_MAX
> where one is lacking.

Please don't put that prefix in the Subject (P*rtability of
dash to legacy systems, such as AT&T Unix PC :).  There is a length
limit to what patchwork will take from the Subject line and using
this prefix of yours will cause all but the first patch to go in
as a comment.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
