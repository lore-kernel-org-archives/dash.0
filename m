Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3874414AA9
	for <dash@vger.kernel.org>; Wed, 20 Aug 2025 11:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689295; cv=none; b=FffssS8lCyY4+0WejGcW3/dVMkLCniFGTM7oHiKSg9Y9F3VNRXhZGUfzACGJAVFjzQ5pGnSSpZL2Coo9Bxnek4fuNSNGNG4i9lrVpFZunmTSxsCVxPwTtaS0akJFBH9dYnqpq0+rlEht2upFCSEIHjPJANANkj7X61W+AAMQts4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689295; c=relaxed/simple;
	bh=tJbN1/fxwVmnh/sifRtAitJui4MAqhLXJH3fA4HCcFk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/mfxC3w2moNzPvvDQCfN/JZLK32JaqN5hmRzNrv8PTNysXkJoNqU0URTW7JJcDWs09qeFlHNoXQyBaWchPt/J/WHPhsBsNgp0EDpMhKVUwyTFU70JySSn+KYHV6t08PVfw+SEsFQcIbL4zyk21MYRfh3KcpFeSy7z//uBXbbGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=pass smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=Cxn7zlda; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="Cxn7zlda"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1755688958; x=1756355624; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:openpgp:blahblahblah:mime-version:
  content-type:content-transfer-encoding:author:from:subject:date:to:cc:
  resent-author:resent-date:resent-from:resent-sender:resent-to:resent-cc:
  resent-reply-to:resent-message-id:in-reply-to:references:mime-version:
  content-type:content-transfer-encoding:content-disposition:content-id:
  content-description:message-id:mail-followup-to:openpgp:blahblahblah;
 bh=sezr0arhLI9fWDhNYBEE0AuMvSGt5KDTH1PVNNeGaAY=;
 b=Cxn7zldaegxV8IokvTMIdizFIJ1NlhWXZzl8rh/XEEGIETR2n+ABZ/nuDae9ftsjZTLJ/KZQ
  U0SECVp12cbO0YBpnTA8rb/8eW76AuLcmBFMiW77nU3YZJubT236Z/vBElABxAcqDxA7lXTSM9
  2SNsfAVfLD50VfobD6uscOfMijl5wOiyrXI9vhJCcfXfi71XU/bvCXCZ48Kvr4ASJxJJf1XGym
  7wBKuIkLWFHVubVYGl2CvIIMJIGy3QbLLdPY5L1R4cOrO9x1kkIjYkYPTY7BhOifsBuvVFFtlq
  RjkDuEiqvhOq2VKcK+jcrFwJk4KB9OU3i3LmduwWyKFyaEeQ==
Date: Wed, 20 Aug 2025 13:22:36 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: Aleksander Ushakov <aushakov@astralinux.ru>
Cc: Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org
Subject: Re: [PATCH] left shift of negative value do_binop
 src/arith_yacc.c:111:12
Message-ID: <20250820112236.Y7RZpgu0@steffen%sdaoden.eu>
In-Reply-To: <024b5e9f-6112-4224-b095-f7e54b8971b4@astralinux.ru>
References: <1abb4964-b5ee-42d8-bbb8-959594d61665@astralinux.ru>
 <e79e39bc-02b8-4ad7-ba03-7e4d00061c3e@astralinux.ru>
 <3a37b273-3da1-45f6-a303-3c0796bd0532@gigawatt.nl>
 <024b5e9f-6112-4224-b095-f7e54b8971b4@astralinux.ru>
User-Agent: s-nail v14.9.25-698-ge40eefb876
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

Aleksander Ushakov wrote in
 <024b5e9f-6112-4224-b095-f7e54b8971b4@astralinux.ru>:
 |
 |01/08/25 00:50, Harald van Dijk wrote:
 |> On 31/07/2025 19:49, Aleksander Ushakov wrote:
 |>> There is a fix of the problem:
 |>>
 |>> diff --git a/src/arith_yacc.c b/src/arith_yacc.c
 |>> index 1a087c3..e23060d 100644
 |>> --- a/src/arith_yacc.c
 |>> +++ b/src/arith_yacc.c
 |>> @@ -108,7 +108,9 @@ static intmax_t do_binop(int op, intmax_t a,=20
 |>> intmax_t b)
 |>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case ARITH_SUB:
 |>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return a - b;
 |>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case ARITH_LSHIFT:
 |>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return a << b;
 |>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (a < 0)
 |>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 yyerror("le=
ft shift of negative value");
 |>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return (intmax_t)a << b;
 |>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case ARITH_RSHIFT:
 |>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return a >> b;
 |>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case ARITH_LT:
 |> If other major shells already issued an error here, this change would=
=20
 |> look fine (except again incomplete -- there is a lot more potential to=
=20
 |> trigger sanitizer messages in this file), but as other major shells=20
 |> accept this, I think dash should continue to accept this too.
 |>=20
 |> Cheers,
 |> Harald van Dijk
 |
 |Well, if we take bash with UBSAN instrumentation and try to use a=20
 |similar command with a negative number shift to the left, then at least=
=20
 |we won't get a sanitizer error. Yes, you can remove the message that=20

Really?  How does it do that if it uses intmax_t for all values
and then does

            case LSH:
              lvalue <<=3D value;
              break;
and

  while ((curtok =3D=3D LSH) || (curtok =3D=3D RSH))
    {
      int op =3D curtok;

      readtok ();
      val2 =3D expaddsub ();

      if (op =3D=3D LSH)
        val1 =3D val1 << val2;

Having said that i could simply try it out myself, but too lazy
i am.

 |this shift is invalid, but it is still UB to perform this shift=20
 |according to the C standard. I mean, a check should be added here so as=
=20
 |not to trigger UBSAN, as it is done in bash.

Where is that test?

 --End of <024b5e9f-6112-4224-b095-f7e54b8971b4@astralinux.ru>

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
