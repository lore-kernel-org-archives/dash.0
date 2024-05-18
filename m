Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD55D517
	for <dash@vger.kernel.org>; Sat, 18 May 2024 08:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716021753; cv=none; b=lxUwgv8biFg1VcBUFOnelgIJu/v91W7Hs6krFH903XtRD0La1uYPM0uSeKvW5t8YSmNVQrZF3uclB8bUxuGZ9e/Ar3EhWj4u9+JniTWijY80Y3uOtGOcr4vYDalqR5lZ0gUxqWM0hx2Xy1+DYCMQzg1y/hnfqH7K52Bb18/UhyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716021753; c=relaxed/simple;
	bh=flej30cnkRRsIBEU+qyLUsspiCe5uk7QcZpxFeTsIaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DE6geY7Z9OxhFUR+pu0irVVQsMAlAj+jgthUVDX/7V/iVx4KznqyRwXjUykMflXvviRZ0dmLqsE3goIR2w8My1MGgqozUh0Y8Etc9mz1V1Q7fMSlayWtKwYsNR7xAgu/rb1QlVVYuXzjPGKWICGMyTy1mOiiTRnSyXGGX7WYHDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkhCMlZG; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkhCMlZG"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5708d8beec6so5591525a12.0
        for <dash@vger.kernel.org>; Sat, 18 May 2024 01:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716021750; x=1716626550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A3mav2n8UH+5Gp0oxzeSJWGMMeW9WcaknukoiPSzDKw=;
        b=YkhCMlZGvoWhJr/OkQ3wIxE1QWms214kp8JiVGc7EAPvm+El+1KdQ0QKrls0K719zW
         Rs0YZqdot4VgR5cK3vnfBF8Lbp2bxP9WpDRopxQiZ9dWJ5BBIG7gOXehCesjCv5/XDtC
         A4fHYmc8x9biM5sOHcGVZv3A4/7Z7i2Btw0y+/EjX0nTZEUuSp6W/dgMTNRfmpsWngu+
         dnPcBNorrkbqSGO2J7Djgm4UHvcRR3sBbRWOv0OK9xQmy7yoWd03GB7wGokElNsKKImm
         WpashzLEUyiDVWU6VWxrOq7kvPk7GGjHM6YcvGXrd220q1evv5r+5aXvyXESMYFJj41c
         OhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716021750; x=1716626550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3mav2n8UH+5Gp0oxzeSJWGMMeW9WcaknukoiPSzDKw=;
        b=peLsLqyIFB2A+UXLWuhWYWpFyP/yqRsdWdWIdTb/safoxZH3fB8MWMr4r5H+uG3UKZ
         gSJqaW2rAnfpzmvF4RBsszXEonYSdz8pVIitWJapNYqGOb7vGbdpX5HPKKGS1JAsrKLd
         Vooopj0xSYl7HbSUH4dAS8J6vp8NYMW3G4ZXmU1iJ8HjncNnlUY9Ew0IghBbeo2nGhsY
         60Gt5PFgpQPmaxqusMWdSncHfmHeyMAAgOrU2z1bq+RnJpj/tfoja53pv0YEWpKxHWFS
         Ip1J1IO23Zq6eHqapt7so9AZr1BMhLoT5q6IiuL++eBdt/OA+TlaJjylKqR7Tfbm6muA
         hF7g==
X-Forwarded-Encrypted: i=1; AJvYcCX2k0gfLQOR3Qky31pnzXQPpJHEFxVazLPPz/ccqnAq7jw5506G/pEg0c7Vvb/o3A272MF7PDYBdBROfAeQvorQSIZ6Rg==
X-Gm-Message-State: AOJu0Yy5YY+nwQUXBfPKO/aLdDl/lutlLcANpthAsrJZmwod1EKBCiZQ
	3Bj6ZRfNHGXgqAc+7UHbIZ8l4WjBE5GfHvKUNa2NxC3oDbuulAEw
X-Google-Smtp-Source: AGHT+IE3ZvsQGXQkCQKLpT1m6sVGVo+B5radpadtQ4QxYkHtdMIU/gZI0jPD2hRrxnw2H0L1dA/K/Q==
X-Received: by 2002:a17:907:9446:b0:a59:afdd:590a with SMTP id a640c23a62f3a-a5a2d65d66dmr2890051366b.56.1716021750035;
        Sat, 18 May 2024 01:42:30 -0700 (PDT)
Received: from gmail.com (178-189-141-61.adsl.highway.telekom.at. [178.189.141.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a7b53fc8fsm608165966b.38.2024.05.18.01.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 01:42:29 -0700 (PDT)
Date: Sat, 18 May 2024 10:43:12 +0200
From: Johannes Altmanninger <aclopte@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jilles Tjoelker <jilles@stack.nl>, harald@gigawatt.nl,
	dash@vger.kernel.org
Subject: Re: [PATCH v3] Allow trap to un-ignore SIGINT/SIGQUIT in async
 subshells
Message-ID: <ZkhqIFR3mUyaXpN2@gmail.com>
References: <ZgbYAvgixaQEsF4K@gmail.com>
 <20240329153905.154792-2-aclopte@gmail.com>
 <ZhKBHMHJRJdTdsVP@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhKBHMHJRJdTdsVP@gondor.apana.org.au>

On Sun, Apr 07, 2024 at 07:18:52PM +0800, Herbert Xu wrote:
> On Fri, Mar 29, 2024 at 04:39:01PM +0100, Johannes Altmanninger wrote:
> >
> > diff --git a/src/trap.c b/src/trap.c
> > index cd84814..dbf81ea 100644
> > --- a/src/trap.c
> > +++ b/src/trap.c
> > @@ -272,7 +272,7 @@ ignoresig(int signo)
> >  		signal(signo, SIG_IGN);
> >  	}
> >  	if (!vforked)
> > -		sigmode[signo - 1] = S_HARD_IGN;
> > +		sigmode[signo - 1] = S_IGN;
> 
> This is buggy if sigmode is already S_HARD_IGN.  You can fix
> this by moving the if statement inside the previous one.
> 
> Please also add a comment stating that sigmode has already been
> initialised by setinteractive, as otherwise we may also lose a
> hard ignore.

I'm not really following the last part;
maybe it's no longer relevant with the bug fix.
Note that it works the same whether "set -i" or "trap - INT" is used,
also in noninteractive shells like

	dash -c '( trap - INT; sleep inf ) & read _'
