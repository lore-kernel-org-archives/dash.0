Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0BA13F454
	for <dash@vger.kernel.org>; Fri, 26 Apr 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714125032; cv=none; b=fWxIybuZYfH/R5CafPexDj9XaVTP41fPjn6/qSwOCY6xZg3f6ZXFbkHEqESekpJPpp5gx8qKMgY9qGe1bF9+9BJq2HAJ0Kou1B2aydWLArQ+MeSF86w7GtBDLVQfnjnCV0yO75d8FmyMP2wyMKH3Ehqn1tasw2bRpAi65dBA/Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714125032; c=relaxed/simple;
	bh=9MGfRnT2UQjS8RbgkQuEMqkahPcc+CtnccJmC0ZOpI4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EmnIl7nDnJPtP0nw8l9Au5SBDw+7psLeQ2XmeMeXPlStaxRIBOoCXHCfPGIGkNTSwPRPdIxjWNHTV5aeIMCSOWCPkpN6BvL4TVYAjTgiaVo1s7gafP6/hgJb8nSVSi6Bxxzq16HEK7Uh0tTZgY55FIRVrHOOuCnDfykoE67bUak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1s0IDq-006enq-6X; Fri, 26 Apr 2024 17:50:27 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Apr 2024 17:50:44 +0800
Date: Fri, 26 Apr 2024 17:50:44 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Avid Seeker <avidseeker7@protonmail.com>
Cc: dash@vger.kernel.org
Subject: Re: Dash core dump on network monitoring script
Message-ID: <Zit49MRjj26XtjNt@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <WgTCSYEuzKbHuKFOr2TSJ8vLHAP7U_I8xGdY6fJP0LpGnQlFT6wVBbQIlpKZxlVnzr_7odCse-q9myZj5yjrf9XKzKVFvCJsngYL723T4Co=@protonmail.com>
X-Newsgroups: apana.lists.os.linux.dash

Avid Seeker <avidseeker7@protonmail.com> wrote:
> systemd-coredump[65616]: [🡕] Process 65608 (sb-nettraf) of user 1000 dumped core.

Is this crash reproducible?

If the answer is no then a lot of digging would be needed to
get anywhere with this.  You could start by deciphering the
numerical addresses using the source code of your distribution.

>                                                 Stack trace of thread 65608:
>                                                 #0  0x00007c545ec90278 n/a (libc.so.6 + 0x4a278)
>                                                 #1  0x00005d3418d15df2 n/a (dash + 0x9df2)

If you could at least decipher this address then the report
becomes a lot more useful.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
