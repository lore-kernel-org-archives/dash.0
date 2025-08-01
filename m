Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16F224DCE9
	for <dash@vger.kernel.org>; Fri,  1 Aug 2025 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754058076; cv=none; b=eA92MAGIW3607e1O9emkK4m6f9f54VAAzxyLWHPYy67ELn9JgJMGrXHK3BY1XyzWsWZBq1H6M9XK/o9p/TngU8XFfYGPFTOzH8oSlQ5SC/BTL/ylC1LMwVuQx9ldeYnaTYdAjoxE3II7Fw0dr2CGjzfk7TmDrffABMDQ+FgKXIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754058076; c=relaxed/simple;
	bh=KjlTMYfqk4bDXTNj/Dpvtxcm1JfICfxqUlqjgCNaAis=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/ba/qMBE6yk0XJkYNWBIbp3F2M2klLm3XtQ7V1l6naLjvAf1ont+lAzauk3m42O0f9RlpPMIkSWDD4pYgn229vMHJT9VkxitJSlA/Ar3mHOSf95YjUTwLQO8rEgYrivgBnuQQlW/Up+Y5Y8ew0aOWrUy57tAgWETBRn5z7JETQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=pass smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=WX0ElKBq; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="WX0ElKBq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1754058070; x=1754724736; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:openpgp:blahblahblah:mime-version:
  content-type:content-transfer-encoding:author:from:subject:date:to:cc:
  resent-author:resent-date:resent-from:resent-sender:resent-to:resent-cc:
  resent-reply-to:resent-message-id:in-reply-to:references:mime-version:
  content-type:content-transfer-encoding:content-disposition:content-id:
  content-description:message-id:mail-followup-to:openpgp:blahblahblah;
 bh=KZbW4qGkras7WtsxeWot2Cg+E+37RShRAT5C1ehQ+3Q=;
 b=WX0ElKBqdF71ZOPus2AYyzfUxgbXhqXma3/99+QM/keQ3NJIn8ncA2EqCAXstosqzhK2EJ5u
  eU6E7FN5wpx+YRYr4Bqendw9a3fGfDLd8TaXHbok5eJD/3SvsF1MtD3spJ3I03V6WWTtDxzi/c
  5oRNRz63GudpmGYfYFpcMeMEs9jl8CM3bqaHgRuxXCzXOvSFfVkrQVmCdBed8cndmDbdtp6/PQ
  S9TiAbEaGwU5WB5m1oqs1uFk5DDUiyDe28qGBh1w/JnHbYm8sN3udcnvVsXyvPjgvhXkKsqtpC
  YIxLIBwSacw52mLgYICFNQ/nP3I/JOslRJzoQuP0XUwjJRpg==
Date: Fri, 01 Aug 2025 16:21:09 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Aleksander Ushakov <aushakov@astralinux.ru>, dash@vger.kernel.org
Subject: Re: [PATCH] left shift of negative value do_binop
 src/arith_yacc.c:111:12
Message-ID: <20250801142109.ljU470sn@steffen%sdaoden.eu>
In-Reply-To: <3a37b273-3da1-45f6-a303-3c0796bd0532@gigawatt.nl>
References: <1abb4964-b5ee-42d8-bbb8-959594d61665@astralinux.ru>
 <e79e39bc-02b8-4ad7-ba03-7e4d00061c3e@astralinux.ru>
 <3a37b273-3da1-45f6-a303-3c0796bd0532@gigawatt.nl>
User-Agent: s-nail v14.9.25-685-gb8145b40c4
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Harald van Dijk wrote in
 <3a37b273-3da1-45f6-a303-3c0796bd0532@gigawatt.nl>:
 |On 31/07/2025 19:49, Aleksander Ushakov wrote:
 |> There is a fix of the problem:
 |>=20
 |> diff --git a/src/arith_yacc.c b/src/arith_yacc.c
 |> index 1a087c3..e23060d 100644
 |> --- a/src/arith_yacc.c
 |> +++ b/src/arith_yacc.c
 |> @@ -108,7 +108,9 @@ static intmax_t do_binop(int op, intmax_t a,=20
 |> intmax_t b)
 |>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case ARITH_SUB:
 |>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return a - b;
 |>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case ARITH_LSHIFT:
 |> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return a << b;
 |> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (a < 0)
 |> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 yyerror("le=
ft shift of negative value");
 |> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return (intmax_t)a << b;
 |>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case ARITH_RSHIFT:
 |>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return a >> b;
 |>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case ARITH_LT:
 |If other major shells already issued an error here, this change would=20
 |look fine (except again incomplete -- there is a lot more potential to=20
 |trigger sanitizer messages in this file), but as other major shells=20
 |accept this, I think dash should continue to accept this too.

Well said.

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
|
|During summer's humble, here's David Leonard's grumble
|
|The black bear,          The black bear,
|blithely holds his own   holds himself at leisure
|beating it, up and down  tossing over his ups and downs with pleasure
|
|Farewell, dear collar bear
