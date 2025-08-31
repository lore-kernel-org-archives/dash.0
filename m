Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FA943169
	for <dash@vger.kernel.org>; Sun, 31 Aug 2025 08:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756629958; cv=none; b=eRjMa8nPxOs7gOR/zFWUyQfvn1lSJM24qc1/2ZqJ8y5YtgTq9wEHQnOVqsArXSymakMn8s7Rpk73XcZRt9KuHParuCnF12rqYRZkVrpIDEbqT7AHv141PkDfBXVfMh8SVIrWhjk7l70aIEXRqksAP3ZT0hWcjW0A2uKJvNFApoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756629958; c=relaxed/simple;
	bh=COdAYcChFeroBm+TXQOLnUQ2h6vBq/QY7/DuRO+/85Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uZyBSTZjkcsUiPqHEet7oC6T1ib2LWlxGFXBjjlMegRvZ9uKOJYPNvfhuCwRpDYKUMZGTtrYWfGfFLPHpjb1zk4UiKhZx324K4cPBhd/dJDiCrgAo96GXlExEh838enreCsR8szwLo3lwzkOX6xV9sJqOmK1ZaPqMA6mpqh+SrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=pI06781T; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="pI06781T"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Wi8jrPEvokNP6kp0mfF7Y+3Xs4RHYN7r/c68D+RZONY=; b=pI06781TPloEjEIoDWbAK/pTrl
	3POec+7F16HnGI7qZNIuncp/Is2JveNvPs+uvLMdg82jkK4MryUb7Yl3g9ppQfldwbE1rfDA+4apO
	ANziUVN/3koDV5yyUIpkBqOR69wR3TiczE/B6Ta0aIt3pK/3zwngUSkCSCny+ZcuQe3INTQewPtB3
	HVXPM5X5ZAfo8b/VOjZ/ayS3T6gY67bMeBUwSuZ05ppC/Ji5/JSFU1M4oeDk+F8j53i9Uw1UEGvfB
	5hCWTe30h5aecu5Bw1a8ZeCU3fyzBrYN+c0NoCRDkroNlJvI8ZiduJ6obPsF9y3oFkGFSXUut97mc
	LESNQTTQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1usdRj-001Khw-0M;
	Sun, 31 Aug 2025 16:45:52 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 31 Aug 2025 16:45:51 +0800
Date: Sun, 31 Aug 2025 16:45:51 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: dash@vger.kernel.org
Subject: Re: Simplify procargs
Message-ID: <aLQLv0lvv0baMEeY@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK1hOcPiN8HPDR-Y-w+GXVa9gZNwHuahV=g=CJ_oOM-KQW1tiA@mail.gmail.com>
X-Newsgroups: apana.lists.os.linux.dash

Denys Vlasenko <vda.linux@googlemail.com> wrote:
> 
> procargs(int argc, char **argv)
> 
> argc is used in just one place:
>        if (argc > 0)
>                xargv++;
> 
> Trivially replaceable by if(xargv[0] != NULL), so can avoid passing
> this argument.
> 
>        char **xargv;
>        xargv = argv;
> 
> xargv is always equal to argv, so why having a separate variable?
> 
>        const char *xminusc;
>        xminusc = minusc;
> 
> Similar situation with xminusc being equal to minusc
> during the range where it is live, they diverge here:
> 
>        if (xminusc) {
>                minusc = *xargv++;
> 
> but after this, xminusc is not used.

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
