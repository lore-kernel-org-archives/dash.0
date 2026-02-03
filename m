Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6526B3939AD
	for <dash@vger.kernel.org>; Tue,  3 Feb 2026 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770107905; cv=pass; b=Jtsn9BJdSdoGPal+a+bsX0XVMXAZr0s9S7ClpJMkWDN6arm8uaYkAuWQka80+4vZUhEGzDiMyfHaxuptXo4gUEsz2wenU9NRIjqF2CpvA7dPjhei+aFn6tSNtNKHoRwHnh//aWAmaLQetWvn7wzqnxrqhePdQ8KBNgqSK2QAaAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770107905; c=relaxed/simple;
	bh=+BRUFMOcHNPqUKGOlTWt2B9Sa/+oC21DFbKHlbwJc5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nLyfOkcvpyfEagUD5MYJSaJMX50yxrwJkvdNl7CRR7TOGkVH+GYoozCwDpg5JGmk0m7iO4Pp8ct2iEw3tlv42e8tUyXmqkkyTDlQBBRHNoQp6mXtWCq6WeX0brnVLtydkztwhwYh3n3QClMmFyV1MDOG5ixjV1uqFcNy8G3cm6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sim-and-cure.com; spf=pass smtp.mailfrom=sim-and-cure.com; dkim=pass (2048-bit key) header.d=sim-and-cure.com header.i=@sim-and-cure.com header.b=Geio/uBG; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sim-and-cure.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sim-and-cure.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sim-and-cure.com header.i=@sim-and-cure.com header.b="Geio/uBG"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-790992528f6so49369637b3.1
        for <dash@vger.kernel.org>; Tue, 03 Feb 2026 00:38:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770107902; cv=none;
        d=google.com; s=arc-20240605;
        b=JeGWdSB+xhFg9vFCwcc276srgw63cZRRz39WXZxyIttBaEw/g8LbYVvzbbdSoc8txN
         wg3PFb4Fl5NseQlpt+TvTV5xQ+SMRJsLB6AriDi/09KLZ6m22mCZMyprGl8H5sjX63tY
         6MuzTBhXHstGCntu3TVPib8ugupCpAKfKBObTb1TmYIQUVK6IywIyPPtEmOv/bPp4Qcc
         BqY5NbMYW3PMKpVQjmCfY9Z8fa4Syn7bc/Dg9kbplSXNo18MFUDNB2a6LbexxZYwDy+2
         IIox1D1hPvxoFji18qMXDxinStQoLsmre6S4T7w1qyAMk+USv4d5JGkw1LBX23g2JaO3
         XHig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RxRWAh37IlXxuiSSh9ILfkz4gwb+JvBgFXkvVySr3JA=;
        fh=x4uP82BJkIsL4XiJCZauYgDyRPWbmOdfzrsTMXIC1gQ=;
        b=RjXHIAGwQkHmmI1+1ExqyZBDZC6HFtjqFzyWIA9EL/cclOQVkcO6oJZctx63moAOvh
         hzySOK5vRrkdzYli4IyBfhGupYDkpCMdn1FQbMgh3PIfoGB93A5/U3BZT06AqOAQQ0iZ
         UD3V4wcEu8M+AGgmzuLpXql1xYmSs5Mv7zE8eO/HwsY9GLQAKeApiUeIZBVYxA4BNufL
         emn6epuJOGT8q2pZMUpo6jNaow/7nY2/b76Qqs3d7O93QPGDolpiF+3BX8PMvHpSEA40
         WR7qE4/AG6FOygxtl7kwMHtuc7SGPjBN4N6PH8m8hHGusMDaxuRulkHVg+Mg1dqVc0dU
         xThw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sim-and-cure.com; s=google; t=1770107902; x=1770712702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxRWAh37IlXxuiSSh9ILfkz4gwb+JvBgFXkvVySr3JA=;
        b=Geio/uBGECbz80qV6RGjjS+dphbFEb8D5WWM7/fgfjGl1UbOaVZ2gQgynXifr+u1IY
         C0kKRCwzy7OgMJLsiep5Bj5NlPSNbsnsxZFJhJ0uen/SI0ZobB0cMxgfod92UxZ6I6l5
         lzdkomE/Rc+0xshSgWe27b1Ty8sNtKlkNWHwFZ8Curdmmc1xYW0cNAsE8YRaEK+r7WIC
         26gj3L3DP7Q3MNeB1eLBHqGhrYV8ZMzmlxHR3ehx6UbCr7KOr/5WVDLSlF5TI2ayMoXK
         e249pmElLGhj+41PqAON/mSrEM74kA3SWKTQ3QL5Q4fBPlyleB5tfMJP6Xx4HmBhiPk0
         fKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770107902; x=1770712702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RxRWAh37IlXxuiSSh9ILfkz4gwb+JvBgFXkvVySr3JA=;
        b=gD0ZmmrAtRq+zMeNwKyTmTCTef3M4uFy2x+uUiPT33AVIgxLj7Ti9AAsUAOH71VEbX
         0F7EvWKiXNcIOsolNSph4XZ4p/nyZsQJy2n4wuc0oPfJiVDSiT6M+DYZW+6RCGpJH7ma
         c7TideCvXLmdajTBFn2p/KS21AgJG+8oeHRzPA4K3KM7VPQ2pCkjwDIughozxuFkHDSY
         RHwBHa/9JOB7xRJR6mxM7/2dZ33tBNc7mmRbYTc0kIzCilK61sOLTYYdQexKM63DwZpa
         XiQMFCRO7XmJuxwXUj3abBulYp5LQEDZqeqYP3TWV2SDQfQzCSrKpARbTRh4E2ZjlVWn
         nFDw==
X-Gm-Message-State: AOJu0YxvACLd4viBPKY4rYi43NPbEcuzuuf9eZon/Wg8miBnQdoq9/A3
	JkGWxhLrsECqG1vvRjPnfBcmTVgqfeM6pWSNl8924eR85dcy57g3/JPou1WMBmRqpxEAqbM8B4E
	jU5/VeHt9XCrJvzhiQhhUKi7tCBTE40FCq/9ApqpIcsGRXPy2oNLu
X-Gm-Gg: AZuq6aLsTTzAgIngCQ4EvnE8YhnPbJDYmsL12EGkbSHpFXUEmC0pVpQel1m5g6CFtNT
	+MkaEbn4lYOnae/+DoLGL5/vBDi6F2JdgAqmRgUwbdYSEfplv0w+j2K6dprrmBBvkQS31/4uRcl
	aSW7QDbl6w8ynF/nVOLX2qcE3hhk1iMlvMVN8rmhS4uIrVSA6hEtSnbSlGm3gv/0zbpLCfhBiBf
	S4GiKOQxu1iXFyf73Tue/Cxa4cpBOtk1EDSA96eIOHEhH17ZLq6FiRFNkdNZvd0bccCe4xx
X-Received: by 2002:a05:690c:10d:b0:794:e221:5cb with SMTP id
 00721157ae682-794e22115femr35875827b3.52.1770107902241; Tue, 03 Feb 2026
 00:38:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKmiXcjdFDh_jMak8S0mq5SjWO4m5K67ZKMu5HPdhPby-uUTgw@mail.gmail.com>
 <aYFfc-uXWlN8Pbor@gondor.apana.org.au> <aYGJQ6uQGFLwcvVh@gondor.apana.org.au>
In-Reply-To: <aYGJQ6uQGFLwcvVh@gondor.apana.org.au>
From: Hadrien LACOUR <h.lacour@sim-and-cure.com>
Date: Tue, 3 Feb 2026 09:38:11 +0100
X-Gm-Features: AZwV_QiWDCFONYNvALWAq9nSzinEodO0k63Cc9rImPSsFvgaBgkGcVCeTQE9PN0
Message-ID: <CAKmiXchWEy3MwPvHTrOhAyBU9p7gxdk=0m3FH5vtZ9AnjedpaA@mail.gmail.com>
Subject: Re: [PATCH] jobs: Fix here-document crash
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Works here, thanks!

Le mar. 3 f=C3=A9vr. 2026 =C3=A0 06:36, Herbert Xu <herbert@gondor.apana.or=
g.au> a =C3=A9crit :
>
> When forkchild is called while expanding here-documents, the job
> pointer is set to NULL.  If this is the case, there is no need
> to free the job pointer and other outstanding jobs.  Simply return
> if this is the case.
>
> Reported-by: Hadrien LACOUR <h.lacour@sim-and-cure.com>
> Fixes: 9881d00e939e ("jobs: Preserve parent jobs for simple commands")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>
> diff --git a/src/jobs.c b/src/jobs.c
> index 6622bdd..36c6261 100644
> --- a/src/jobs.c
> +++ b/src/jobs.c
> @@ -919,6 +919,9 @@ static void forkchild(struct job *jp, union node *n, =
int mode)
>         if (lvforked)
>                 return;
>
> +       if (!jp)
> +               return;
> +
>         freejob(jp);
>
>         if (issimplecmd(n, JOBSCMD->name))
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
