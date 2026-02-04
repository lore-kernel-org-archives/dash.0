Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95ED8F7D
	for <dash@vger.kernel.org>; Wed,  4 Feb 2026 09:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770196622; cv=none; b=cEnMwBZIZXmXZzCBGGgNB2mcHNku5KJoZ8ATTO8H1nIEgLa9x3IwGo3v6qMHV3DXqOYJQ6oNOJrM0NFI7eDOW5SkUw6Yq2GOxaO72M76r0OtzuDmM4kzi9Um+Utefhycp58UNXfBxC0STVvvr/xm9pO/AtRyEZlSXAaqKaifxLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770196622; c=relaxed/simple;
	bh=alE4ZnVqNSwixvFWBlpS3jbA562UJwMVGt/wzZKh6t8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iiPyyRF02WCVx5/oNK6hMxDOw6nDWO5KTQbSwu6cKPEpU77aQxmpEbZPZpO4RBFpH9yN+LSpto11coflS6R3yFMqd/W+JC9a/TCan//SVsHHsE9sIsWwW00BhSlwQfnC2Bsq+p8kGE6ZiNON7mJXP3MLjn6CZrXVVpfpOxVVJ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=MoanBIbj; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="MoanBIbj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=UOVB5DH9NqDs9ba0CY8DEUMdtwnFnygAGqa/6cke9Pc=; b=MoanBIbjSZ1Twe8/8YBcxea+mK
	sL65bVfQolJP6fp+4ANxPgLU4FShKWlgQeQhppR0cibAcItj1xgGSL/RVF9CMvocXPG8kkryAfaL0
	J1lSHJtUEpH5OCn21Y1+YRb5itrmfbRodwdSLudgOvsfwuoDTcOyYQWEEgVAgINo87ZIp3C8FpS0B
	PrSetivPk/9RuoQz9fMvrlAfJH2x82HpDvc2Ahj23G9qMMhtv/8QzmbHoId+puCgkcmK1R36nXqFv
	CZ0SJMmYFJiV+iO/gnMR15dwTf8fCtLndIgdDLAt6KdGDI4qu5Z+/ptvih85KFx2QIjNPnQGIgw+/
	b6BOiEqA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vnZ0E-004PW3-1b;
	Wed, 04 Feb 2026 17:16:51 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 04 Feb 2026 17:16:50 +0800
Date: Wed, 4 Feb 2026 17:16:50 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jyri-Matti =?iso-8859-1?Q?L=E4hteenm=E4ki?= <jyri-matti@lahteenmaki.net>
Cc: dash@vger.kernel.org
Subject: Re: Fwd: Behavior change in Dash pipes/read?
Message-ID: <aYMOgmK_puMi2J3N@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANhYXO-M=zNN3XDN9V3O2XaOvA=3wc1vkogSfyRUWhVCP9_iGA@mail.gmail.com>
X-Newsgroups: apana.lists.os.linux.dash

Jyri-Matti Lähteenmäki <jyri-matti@lahteenmaki.net> wrote:
>
> The results are as attachments. But
> https://github.com/Mic92/strace-macos says it doesn't follow forks, so
> I guess the interesting parts are missing?
> Running /nix/store/wy9ass74g4yc1x354ydbdlxkfkxxjv2x-dash-0.5.13.1/bin/dash
> -c 'echo hello > hello; { read -r x; echo "$x"; } < hello' seems to
> work correctly.

OK try running strace inside the script:

echo hello | strace /path/to/dash -c 'read -r x; echo "$x"'

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
