Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D422F29
	for <dash@vger.kernel.org>; Sat, 16 Nov 2024 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731756265; cv=none; b=TNTO3XapNcMeOp6WK+hsVf1bN96oTfIzURZvJZMxnU0i7YCb60SFQS78gRm9qOatuX98tN5dW0JBaWu7w7ifsNrX33umj9vtByuqjUADSjSLPCN11zTXGToLrEvKiSK4egwVSGrQuuvkcXCgsze1NfFcPjKM7RxrnShNoyYJjJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731756265; c=relaxed/simple;
	bh=VaR+zL85M1Vh/VId1CqSfFj2znoWl19Ni/ZwK6mgilM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dOs+ooI9dKkuzbk1TntUvsxg2iZ3+zwipVwthMtP22Eway0/nf49nXjF2tPHa644HVNc6p40SwkEY4kybmtVGj8jZ0zBCOIqpYxWOD+uX+s6MHqAK6QZIyTh/jJOO0B7JE76PKi3xBBa98BoFyIJ7QIEo6YB3aDuuAcAe4/h4ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=aXkO/ZG+; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="aXkO/ZG+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Nmeg2vOSu3s2pAC/ADGW/Ypbrew6+EkXY7RUyXDyhW0=; b=aXkO/ZG+aoXhYFobHoM+aJsV3T
	PGa9nF371pdHlRmMU2qcQzyFdbDfDz423ciDueSlQIhH4cmWk666kPW51rDOpvHe3Io5UClqjZ5b1
	QBS/DNvAWeDijSLTT6pI6gGYtfRpm+LlBCm7O4xBtvCaTos/Dk0VT0NUvkHLtjFpa1wpnz8zOIOf+
	mraEPp94x/NagXLs36LTunHmNi4Or3HI16gY37TFllLaYk/5PCfItZRcoiixs6FvvhPKu/6izUtX1
	qp5qU9CSz54ZYBDONE0kHSycUaVUM2RZLi4FSd8oV69nDpY8sxEEAsHnNJAbK4mKRlDBbKgx5vKSY
	NddDL22A==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tCGuX-00HGSI-34;
	Sat, 16 Nov 2024 19:24:19 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 16 Nov 2024 19:24:17 +0800
Date: Sat, 16 Nov 2024 19:24:17 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: sebastien peterson boudreau <sebastien.peterson.boudreau@gmail.com>
Cc: dash@vger.kernel.org, sebastien.peterson.boudreau@gmail.com
Subject: Re: [PATCH] histedit: When editing, use `el_set` with
 `EL_PROMPT_ESC` rather than `EL_PROMPT`.
Message-ID: <ZziA4Tnd8kUzT6LR@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823222319.6732-1-sebastien.peterson.boudreau@gmail.com>
X-Newsgroups: apana.lists.os.linux.dash

sebastien peterson boudreau <sebastien.peterson.boudreau@gmail.com> wrote:
> As can be seen in the `man` page for `el_set`, using `EL_PROMPT_ESC` for
> the op is the same as `EL_PROMPT`, but it allows escape characters to be
> expanded in the prompt the same way they are when used with `echo` or
> `printf(1)`.
> 
> As far as I know, this is not specified by POSIX, but neither is the
> emacs editing mode (please correct me if I am wrong), so I think this is
> a justified change to make it align with the behaviour or `echo` and
> `printf(1)`.
> 
> Given that this is not specified by POSIX, there isn't much of a
> precident for what the value of the start/stop character should be. From
> what I have seen, 0o001 is common, so that is what I have included in
> the patch, but it may not be the most fitting. Taking a look at how
> ASCII defines its control characters, I believe any characters between
> 0o034 and 0o037 may be a more suitable choice, but this could be up for
> debate.
> 
> Signed-off-by: Sebastien Peterson-Boudreau
> <sebastien.peterson.boudreau@gmail.com>
> ---
> src/histedit.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
