Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FD460B8A
	for <dash@vger.kernel.org>; Tue, 23 Sep 2025 10:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625189; cv=none; b=Nt+Bxzr/xBzlsu0Da8sP+hj9B4RKVpaClzUCdQHkdMiCgEbdWjoTBuTT8kN8WLV4TpZFYkDDeU2JwxxyYKvlVRbHd5QIuTaeFryi9GbZy2vWM4yChc3f9frPl+vv1/JJuNnjeJmmU+bCP6yUIHiRPyU8qhaIq5oT4a4eBvk62O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625189; c=relaxed/simple;
	bh=axQdNmDw2MAdtnP95WSrKUgmOfNpYjm87+gF4P9g7iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fryDJYYJvAXCXMOq0sgxmKAK7HrkjDRNePxrTWT15C1I/It+mEA8eiU12Jmt6evur/YjxXQ+VcCjuDxzCgdIHP2sV2Izx/7FKvLvQmnavRep0fBtdaLwXg46pNXLbE81wiKJR3QXQQCQn6Cq1xjWGH2JpLqE7hL/jZnx2eHIpfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=GTinZsBr; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="GTinZsBr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:cc:to:subject:message-id:date:from:reply-to;
	bh=3NzWTz6+u5OANFMMm1FAgMgPJBefPdgw2dWQUQBDZGs=; b=GTinZsBruw6FNSenI5xBzi02gJ
	E9zfLN780Rb9XriKOs/V3PBJGnLWxQVFSO+aAsXLcT56XxoMQOC2VPJXSzjX5O//EjjhET1VC7e2H
	ILUQIbDtOyTeua9XVjCdeJf75HVTDsN1wg9LGx2H8LOrNWuIumi7m9UZXaQqCHlrikA6JJpg9xF4e
	B62qmIw9XpX+N+rxL/HfR5AovlykYgiRjBn7zR2Ndh9sAGQjxke7xCkQXEPJSWKWnwSUlRoo5YH2e
	MQg35nH887oL38j5E/OzVpmpt2pEt6TK/R1ajQgGsd2DbDnqTzjeToEjhLwy/N5Hxj/VmHWq3vLav
	VSJh/08A==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1v10kF-007ezH-3D;
	Tue, 23 Sep 2025 18:59:41 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 23 Sep 2025 18:59:39 +0800
Date: Tue, 23 Sep 2025 18:59:39 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Reilly Brogan <reilly@reillybrogan.com>, dash@vger.kernel.org
Subject: Re: bug: 0.5.13 regression in parsing
Message-ID: <aNJ9m__22OQL_zHI@gondor.apana.org.au>
References: <aNI-RCggOzN-tyHy@gondor.apana.org.au>
 <77d15ae4-e9e9-44f5-9eda-f287a4815411@gigawatt.nl>
 <aNJ3dYOcNX_lrTbr@gondor.apana.org.au>
 <aNJ4Nd-lE1rIjhH3@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNJ4Nd-lE1rIjhH3@gondor.apana.org.au>

On Tue, Sep 23, 2025 at 06:36:37PM +0800, Herbert Xu wrote:
>
> I need to look into exactly which bash/dash test it's using that
> we've managed to break and see if we can undo it.  If not then
> libtool will just have to be fixed.

Actually it appears that nothing has changed.

autoconf relies on LINENO to distinguish between dash and bash.
Because dash has supported LINENO for years, this causes massive
breakage because autoconf then goes on to rely on a non-POSIX
echo with dash, which causes backslashes to be lost.

Debian works around this by disabling LINENO in dash.

So it's a bug in autoconf that should be fixed there.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
