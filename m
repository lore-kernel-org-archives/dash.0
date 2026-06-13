Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718FC2264AB
	for <dash@vger.kernel.org>; Sat, 13 Jun 2026 00:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781312168; cv=none; b=P3GqxoEcQBBwWxsCNArwBAWIGpnUA3eGgsWEw0fG6FEsGXz/KZ068HBJyvEAaJSCFzWMJsKh+vBFvi0cPf4Ge2Y9ty6qrs5FIZiDiHOoxLquSI2FCIGihOxkLyO5aB3eUmxvfw9TlU9UEjV6+7dVXta1nFWvUfRET1I8DcOFfhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781312168; c=relaxed/simple;
	bh=QDutRx0Jwd4Irz3kVUuEtRGpoLK7CfGE25vxLN3BUdU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=e/ughrnip8Ilzwux28BaRTb+UdxkXzK0g7WhMHgpsSJXeLALoWEZsGzutaATKMOkIrVg5BRn5C2LAkfWncY/wXziCYFILgPhI2+cgaI5zm8Z3U5OnxX125p1AzmqwJlOVhmOfxR6wZ6ogTczYJSo5AMUqlKctJV9XjL8u9upMJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=g4kafqI9; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="g4kafqI9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=wekWbPHEWsVBdlkI9hSsCC/5KkSq0GrMGJYn+5Xa0Fw=; b=g4kafqI9fWY5u+A5c01HrXqQsZ
	n6JZvzXCvqgo/KuyifaoRbKITpVKzE22pgzdWjCN9iKWA3g5TbXRMtHfAJKZ/DATc9Mw/R7fnPXZR
	7EoBVk8WKd6dwBqbyoXyLGjgJfP+OcK4qIJzBjrrJTW0zkuebZI1nXlWgm5lY1Qtoc6IUtHB2I4e8
	VETbZDWqZR9OhE3QzciUub02cn2u7YXQ/1G0mzYBTalqs7ayOuOghqst9XlZgs/JXZdXlkMwOvaor
	LOq6BI0+TAzYj2/6hoNdnb5530FwWCMwBfE+WwFOU5ql6PwlP+Nj41Pr2jmZTNdpwWI5U3SYi1j6L
	e5cOPAuQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wYCfJ-0000000549F-0kjw;
	Sat, 13 Jun 2026 08:56:02 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 13 Jun 2026 08:56:01 +0800
Date: Sat, 13 Jun 2026 08:56:01 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: shivangu@linux.ibm.com, dash@vger.kernel.org, ilia.kashintsev@gmail.com
Subject: Re: [PATCH] parser: set recursion deapth limit for parens
Message-ID: <aiyqobCssQOO-s7V@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601140258.89135-1-shivangu@linux.ibm.com>
X-Newsgroups: apana.lists.os.linux.dash

Shivang Upadhyay <shivangu@linux.ibm.com> wrote:
> Setting 5000 as limit for recursive parenthesis '()'
> or braces '{}'.
> 
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
> src/parser.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
> 
> diff --git a/src/parser.c b/src/parser.c
> index 412e876..5198dc4 100644
> --- a/src/parser.c
> +++ b/src/parser.c
> @@ -110,7 +110,9 @@ struct nodelist *backquotelist;
> union node *redirnode;
> struct heredoc *heredoc;
> int quoteflag;                 /* set if (part of) last token was quoted */
> +static int paren_depth;                /* track parenthesis nesting depth */
> 
> +#define MAX_PAREN_DEPTH 5000

This is a completely arbitrary limit and removes the ability to
increase recursion by setting ulimit -s.

I'm not taking this.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
