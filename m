Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C76F224D6
	for <dash@vger.kernel.org>; Tue, 23 Sep 2025 20:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758660445; cv=none; b=gW3AMDgSpiFJP1xS2xdtWmLKqU36qcfB0KY216qGv7fgBdwFmpQI8i4GftqXoc4qegO+W9DMXdpZwTVxfuiKQbO2uUJqfjOig2l/HXrNDahpMqzw+AxTByoj4oMtIX8tCizlAI7GFR94M7MUSCN6jHF+sRdRkVNTrRUinRKHOx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758660445; c=relaxed/simple;
	bh=c/jBJI+I0lpPoqMz0B7KW2nwyM80FRWPNwsRUV2CW3U=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:References:
	 In-Reply-To:Content-Type; b=WRh4EzRBt31Ebl6p0xZf/rXgcvH626v+mmsKwGJDNFD/83PR/3IzIm3mkXMzcvrvPompIQ2fwAPDNwVx95GiVTS9xH0UKsJ2Qlae0QrTpIygIj9J7Gee66INYxM56Q2OBRlWyiSEudUF0hctabx/aU4J5awZopPO48JYh7hX7d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reillybrogan.com; spf=pass smtp.mailfrom=reillybrogan.com; dkim=pass (1024-bit key) header.d=reillybrogan.com header.i=@reillybrogan.com header.b=crG/dCh+; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reillybrogan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reillybrogan.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=reillybrogan.com header.i=@reillybrogan.com header.b="crG/dCh+"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-855733c47baso60975985a.0
        for <dash@vger.kernel.org>; Tue, 23 Sep 2025 13:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reillybrogan.com; s=google; t=1758660442; x=1759265242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:subject:to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEBsA2MHerI/feLYhEXxI8FdX8FANC1CK42f4DCMBwo=;
        b=crG/dCh+6Dnt6V4qEnz7LmaCLkelsJBXjEKfFdo4bs5L/024MVFC4jCMr6hSQnbGa2
         JHHyu3sS1kanCzy5jWHEWECtNm6KFKQIboM5TJfL8kSvEjZmkLRJG9uAMG2Q9SyWoEmJ
         n4v2kP4H1QuCHLAZ1kw1jFJXQBa/XXsu4Lkco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758660442; x=1759265242;
        h=content-transfer-encoding:in-reply-to:references:subject:to:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NEBsA2MHerI/feLYhEXxI8FdX8FANC1CK42f4DCMBwo=;
        b=neB/SAROVQuT8sE2hPJDcsv+XHCiKWHOXHEv1xZxahkyMCx7vA6YS+uDmE9k1XbVHh
         U9wsnQgCmQDayUw2rMgZmKQFVfJqN4lx1PbBAWAbm3ngK1OUa+6a3UGvlnHoZJ3eq1RZ
         n5lKsQkyB3cIJtN7NiCuOBNHkismwsk3A4x7OP1+q1toMemeFL5g8c0HR1TNnPpH7/b+
         9EpDxnuD2P/fGjTs/QKifYRFaTnZsin3YlW7VI7zB/L6Fcr9kE8keH6nUvpqCwWYwHHY
         UVyCASNEkNXexvYIUU7P92kK9VVYA7m1fWYzTUWzOtnG6iH4l08N/aXo9MLM2L4wJg0+
         xySA==
X-Forwarded-Encrypted: i=1; AJvYcCWIvYI4BuOZuNKlz3bPGU7xNbAQu8opN+Q1MD2J+QV3KrBVv23NDIdWgLKQlfFtozt4R1xu@vger.kernel.org
X-Gm-Message-State: AOJu0YwOX9JDdK+FC4fosWFC2rNdcAzo7X29ryOe1iqAJNNeqNRsK+9V
	/zz5tBf/4Bkb0Mc5hQYzh4qYplQhxUHHiOOxGqWzO7/EMMorKrAvb+gQN0D/8dhtTIA=
X-Gm-Gg: ASbGncvdJW0qXj/iuZBb7pG1dfv4W4pLdjjCF5gsVbJCW3IpJGnBgrynFKw1sey7XLD
	XH0XLWexdkPWBVxy6vV+TR542aeAa1+lxr+0KsWwmc2b49XC4JAz2YDUYbhVNfQnR5VW1TC8Aeb
	cRnHfXVrGRAYDfNPFO9esTzqHep0ysOtJqC72pRn5cNpBs3WqTAVmXua2tBU8anUy+2gSbNQF9m
	krxoZxY2zxgtcooSzojYwZBgMVWYJYPs78pFbQo35q3F3m0TBmXelgEVfHChbc6VI911TBhwHze
	dNVdkg+EZ/ZyIqWRyhAQOPgxSrLY5oJ0RY8yEnRDZ7guUT7rJDL/qL6PuhE6LGMugAz+1mC3uHZ
	VXErtPdtLrLlQbSf1VYANnDeTDXyFqOqtCMGYySd4AMxBEQ+1i3k0M4Jlh45y8nHYRRM5
X-Google-Smtp-Source: AGHT+IF/xFIuZIWKcma1IOqnZTfymUeWyEmuwEarreiWauIMZhWxrHvso8eCMAt14COWv1154Wmslw==
X-Received: by 2002:a05:620a:294a:b0:811:ae92:e64 with SMTP id af79cd13be357-851737005bamr443377585a.60.1758660442340;
        Tue, 23 Sep 2025 13:47:22 -0700 (PDT)
Received: from [192.168.1.241] (24-152-154-74.fttp.usinternet.com. [24.152.154.74])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83630481f38sm1034428085a.39.2025.09.23.13.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 13:47:21 -0700 (PDT)
Message-ID: <0a884bf7-1c19-4240-a04b-9af329d2374a@reillybrogan.com>
Date: Tue, 23 Sep 2025 15:47:21 -0500
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: reilly@reillybrogan.com
To: Herbert Xu <herbert@gondor.apana.org.au>,
 Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org
Subject: Re: [PATCH] expand: Fix typo in pmatch for wildcard search
References: <aNI-RCggOzN-tyHy@gondor.apana.org.au>
 <77d15ae4-e9e9-44f5-9eda-f287a4815411@gigawatt.nl>
 <aNJ3dYOcNX_lrTbr@gondor.apana.org.au> <aNJ4Nd-lE1rIjhH3@gondor.apana.org.au>
 <6f017266-fc35-4864-9f10-3ead8af4e9f4@gigawatt.nl>
 <aNK2DgpH6Bs0XCQm@gondor.apana.org.au>
In-Reply-To: <aNK2DgpH6Bs0XCQm@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I can confirm that that patch works for all of the builds that formerly failed, thanks!

On 9/23/25 10:00 AM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Tue, Sep 23, 2025 at 12:03:20PM +0100, Harald van Dijk wrote:
> >
> > configure did/does prefer bash but can run with dash, either on systems
> > where bash is not available or when CONFIG_SHELL is set to bypass the
> > automatic switch to bash. This has been working for years, and I very much
> > suspect that if you run with a slightly older version of dash, you will see
> > that it also works for you.
> 
> Thanks, you're right.
> 
> And Reilly had already isolated the buggy commit through bisection:
> 
> ---8<---
> Skip the optimisation for * for only if the next character is
> ? and [, rather than ? and anything but [.
> 
> Reported-by: Reilly Brogan <reilly@reillybrogan.com>
> Fixes: e878137f63e6 ("expand: Move stop array closer to strpbrk call")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/src/expand.c b/src/expand.c
> index 992cbe8..1fab394 100644
> --- a/src/expand.c
> +++ b/src/expand.c
> @@ -1911,7 +1911,7 @@ static int pmatch(char *pattern, const char *string)
>   				c = *++p;
>   			if (!c)
>   				return 1;
> -			if (c == '?' || c != '[')
> +			if (c == '?' || c == '[')
>   				c = CTLESC;
>   			for (;;) {
>   				if (c != CTLESC) {
> 
