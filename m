Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7DE15E5D4
	for <dash@vger.kernel.org>; Wed,  1 Oct 2025 00:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759279244; cv=none; b=taRbzJPeg6Ne1z184Xg4Dz6KWpl6bq4zzRChOBo+lTi1yjD2olR7dJPrtJWeGrzmbEE+NPkXL9gbfYlOJjjFola3CfXnN2LC+h/4bxeu2UOIfKbUG6K4jwu46tWwoeSHLT2gl+7tZAbh66OigK5+uw5XH2ES2ldMKTiqPHgRTNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759279244; c=relaxed/simple;
	bh=GvlchjwD1CvFQLxRKTLoQ1EYIkjzjj4nsRbXuBurcME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tv8YKQA5KC+cLkZ/CmLtDGxXRL/51+CnXois+RU17ufSHIksjRZ3NYrPaTrdbSU4bU8IFjDmFtveqfC3R729qVRZWvCp5PsjeDUNjyZDKaT4uBr/N3QmP77Z1gG4qrkGTOiFPGEN5CF5koAjaC3av70NJB5ibMUfMoKl1NkqexQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=UrpvrCNI; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="UrpvrCNI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	reply-to; bh=WvI+bALfC4H+mMaMao6/PJ7dwz3abFYsdv0nLN8l95s=; b=UrpvrCNIogSq+F+B
	Xgrzhfhtnfd4LpIbMSk0FtNePBLhO2fM6tyAfKHZlAl9qRSK822qy525HS9qRRDioi1w0Eumt0xoH
	9lo/b+RijFQ/NXhy1/wZXhl46GmwP9g2GvSUKNXDnfAzRTyF47OlAF1pcAvl4xPETRzpUoivE8PkB
	q3J7vdrisozI9YoSlWgBBhjFEf20sKtCE0ypz6VVRvQtnpEHgfauob1IT6CUDCgQckBkzeuN2pRFr
	f/F2srpRmsaIKys06eeTqTF/xedGtqjOlPmwYsmPuGl5PbAFn4namDd6RxlNcfm/+TDBloSZWdJRY
	MNl4FkDp5dLo05XJEA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1v3ktX-009ZsZ-3A;
	Wed, 01 Oct 2025 08:40:37 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 01 Oct 2025 08:40:35 +0800
Date: Wed, 1 Oct 2025 08:40:35 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Brian Inglis <Brian.Inglis@systematicsw.ab.ca>
Cc: Dash <dash@vger.kernel.org>
Subject: Re: dash 0.5.13 configure config.status truncated running under dash
 0.5.13
Message-ID: <aNx4g4eZSsdvXlRH@gondor.apana.org.au>
References: <ba3014e6-b1f6-4b6b-99ac-524dafd22f33@SystematicSW.ab.ca>
 <aNvMWqEu-uIiCbGk@gondor.apana.org.au>
 <81470aa2-3689-46a7-84bc-a7781cacf048@systematicsw.ab.ca>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81470aa2-3689-46a7-84bc-a7781cacf048@systematicsw.ab.ca>

On Tue, Sep 30, 2025 at 11:11:49AM -0600, Brian Inglis wrote:
>
> Attached outputs from last instance of failing build just to be sure:
> zstd compressed bigger files this time to keep sizes decent.

Thanks.  I tried it and it makes no difference.

So I guess you will have to bisect this one.  Here is my suspicion
and it would be a good place to start your bisection:

commit 509f5b0dcd710804fb6c66750c7c7fd2d30a3ec9
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Sun Apr 21 08:33:53 2024 +0800

    redir: Use memfd_create instead of pipe

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
