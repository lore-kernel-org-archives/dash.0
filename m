Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435402F0C66
	for <dash@vger.kernel.org>; Thu, 28 Aug 2025 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756374460; cv=none; b=MYJlcfZu3OfwJtMp5L4BfPDsVn1tmubVqEZA990VUyVEAswB4jFhcl6o9eWY3owW43F7NZTgMwrydsf+wa5RQ37TEfus0b/VR6YdHWuNPfnEtcvEu1J4sSdZPD7kT79DlYYpwShFM/BnstDHXqnCVwgR0bi4634sET8LFPsl0aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756374460; c=relaxed/simple;
	bh=0fwEO/qZWMLaxFIlVhXtnz/jn+YlG25Pl99R4Ebnvl8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jvY8+lhokEP6CTIpQ2VRRIbax9sb9rr/yCB3IFQKImiZ7CH7b/uhGDY9YEx7Zq3V+ct55Hx3dABCroFoeSj4z0UV0AFUvlFrOiTP9W9dRmsVJcrhFuCXIsxtGEdulDh3RZCZIIN5JUhTMuvQ5ChJY1gfenOkZBhfr0xyh53IJ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=AZwnJruy; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="AZwnJruy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XslHA3sxPK3IyLiZHYOhQUeX3VLV31jUBeA6DpCmOYw=; b=AZwnJruyBRnL5KWNrnl+6NWI0p
	FgKJ2Seq1bdnNKAmJ2wbJHvkxzYmAqBq2TCf24Jwn4qtTVGq4bcqvxXlqKioBfe2qjys1Z7Q0efZL
	VoKWEFIs7Hy9Uemp4XujoPq9ARcPK8pHQcbSYg/FQo7aJwSdRWF+Zqmm1HrTLZRdvCUAMPbq2mA3+
	EpLlvBZqo8Vp7jU0KSuUd/4v42tH36CIAGH8fEWH/WGHC4cazZG+nzUcboeWI5CgDGI9O+1NV8mOu
	QU19WKxNiL2cqA9zVoIvAku8Yoawahr1DrsVCz4rviVPRBKedapVCcq15rvR/Dnwyhg6PsSVM6wQz
	sd4iv+2g==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1urYyn-000StX-10;
	Thu, 28 Aug 2025 17:47:34 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 28 Aug 2025 17:47:33 +0800
Date: Thu, 28 Aug 2025 17:47:33 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Denys Vlasenko <dvlasenk@redhat.com>
Cc: dash@vger.kernel.org, herbert.xu@redhat.com, dvlasenk@redhat.com
Subject: Re: [PATCH] Handle line continuation in unquoted heredocs
Message-ID: <aLAltecN3o4AdeNv@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807201015.11358-1-dvlasenk@redhat.com>
X-Newsgroups: apana.lists.os.linux.dash

Denys Vlasenko <dvlasenk@redhat.com> wrote:
> Testcases:
> 
> cat <<nice
> heredoc1
> ni\
> ce
> nice # this isn't heredoc end, the end is above

I think this is debatable.  The current behaviour differs from
bash, but matches ksh.

Since POSIX apparently left this as unspecified, I'm not changing
dash.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
