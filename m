Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7AB4A32
	for <dash@vger.kernel.org>; Sat, 20 Jun 2026 01:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781920375; cv=none; b=NpHKvdApMzvZJr9b1TTopH/5zYr7xms4DGlSir9C3WNgAOBz9qV51eERrWFzs0/WNlxpZRHR/mXf0wGfSwnu8GM9p7W2eRUBV1RKgW/KW2zne+TdSjavn3+J9WokyaOfH3nyl2T+TJZpe5dj125VSZsx9B0+bA5uNzziYnoadnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781920375; c=relaxed/simple;
	bh=O/jEx8LqdsZnih+bQs0X7WzBBDhnv/gmNvUhMLVxSCk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mDKVdOovOzwk5JrxbBcGR+B6TEqqxT1pQrP8ecGlaDtT5k72yuExC00x7k4fJjmCd1Ad0ZfIaEr680cK4RGJa8a9x/wPY10PETV5RBhz8ferGwsT1jtdmWthcYJ90eZlcVYgzQsI4xlPtbFctF+ZnjcwQoXJQ++Nsi4wF+7I4k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+Z1j25r; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+Z1j25r"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c40397e746so16143155ad.3
        for <dash@vger.kernel.org>; Fri, 19 Jun 2026 18:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781920373; x=1782525173; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8p5ZdcwYJjbcTBcA1HpW5X5VLtyfN0o6Ej8SpOD+b9U=;
        b=C+Z1j25r0jAydtSbUsfydGGchRKc/bhVVtdsGTe1EaN+pmEUNcvkOoS1tzoRJUgG0G
         Ey4ocgrFi3NmctmmP9rW49q3zTqhE7gP/nv7ZNTzWfPO0OS+MKhIhphcrVc857Vycr6G
         1vdSYwxwpGVpchAlD7oXg6FOsWVj+lH5W/CLNlCZ+Cm22suPt57SGVNNxmeFDxXMC5As
         5Y5Nn9gfkw9raFpMCO1MbmqnvyapdOhQtUgPTC0ABLRmRZZl5TVzbTpEtDovwZjOcWid
         Knz+xsrXiaKoDGgYvEmeMkbnT5DqkruWqR2b5P6Xx7OjzSdALq3WE0RttKxSTcMs6hoL
         2mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781920373; x=1782525173;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8p5ZdcwYJjbcTBcA1HpW5X5VLtyfN0o6Ej8SpOD+b9U=;
        b=Kp1iVYKJe3pnfv6sBEj3U/nDlFPMoKsQb/o7FitWsBiC/YgMvCIRLb3u2a18LMTvVK
         9nAmXjOW41JES1eAGJflYbVeF7USYfHup9TWZAI7Rs+3AatU9A/vdgExkAYpGwokvtfT
         JfBCJuOB8wrGljJZrtJbroFRrJUdZFAFzWTZlFobxdaZqnxAaPw6PMhEUepuxNHKseKO
         /VWhPYAK8f/lecpRFCzTT8D/k8g2ratvXVPUsEng6kVZB/GGgWqR6jSEVNIlk2sj1Fw0
         Zbv1xkVwYPsS+L/5p6I3NTzO/jFRRRhOHC9bW/yH9SvIr3lLHlr5NH2f6kOt6MEi1vJN
         j0vQ==
X-Gm-Message-State: AOJu0YxW/zgKa4+Bm0Jtb/mDqX3rafgVtN4XRnigy+ZiF0l1nNdwIaWJ
	2wTOK/UV2oZZJmpNA5j/A++sLsRtdxEFlP8bIKGOlHm51xJQfQ8DkQf2TAHxfSkF
X-Gm-Gg: AfdE7clWzCGLZpn0gB2I1DS6PIGVFtwcQqHeCZZNEbeppQwAU43NN8SPYU6+psmMNCK
	hBNz5XLdHyifwCUeQN75Fbf2sc4WL+kTlV9n4plpacZq6fR3jfmlo5XToPxADNRxMzoQyrqGksQ
	fOEL1cXCNdFBG/5lGEV50UZbdsYAE71jfJT0OxzHL6eKwZiCXKsucDsTnSrRgbsJxffxiRfwckQ
	ObK+RB5QkhraoRmJjEpzAqYD4OgLVcxkT6+dAzhbUTGCgBgTRdDu4NcSF5rg46uu0jn8k2rQCor
	lge5f1tYkgWsuB+r5vH7btKylzACPZwPX8vnUfm/IoUC6HoyR7Nch285LQwlsYiwZ5ohyKl1MWE
	OIHwsBzikRuQW6i9fhmTpKeuDoVjjeXdZrhfu6BX5boe8cZp1f5oA7/FF4hiySUfvhMTMFEOdPm
	MnsRu9ep/WUvw7GDFEL3T6bp6a82DdzWmNxR1BzrVP0zDp
X-Received: by 2002:a17:903:32d2:b0:2b2:ec46:dfed with SMTP id d9443c01a7336-2c742b5ae34mr13531935ad.31.1781920373467;
        Fri, 19 Jun 2026 18:52:53 -0700 (PDT)
Received: from localhost (14-201-157-35.static.tpgi.com.au. [14.201.157.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c743bfe4fasm6771605ad.59.2026.06.19.18.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 18:52:53 -0700 (PDT)
From: Alexis <flexibeast@gmail.com>
To: dash@vger.kernel.org
Cc: "Sam James" <sam@gentoo.org>
Subject: Re: The read builtin erroneously consumes null bytes
In-Reply-To: <bf5516e9-e59f-444a-81c6-7b112b71563a@app.fastmail.com> (Kerin
	Millar's message of "Fri, 19 Jun 2026 06:04:27 +0100")
References: <bf5516e9-e59f-444a-81c6-7b112b71563a@app.fastmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Sat, 20 Jun 2026 11:52:49 +1000
Message-ID: <87h5myx9ji.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed

"Kerin Millar" <kfm@plushkava.net> writes:

> Consider the following test case. It demonstrates NUL being 
> consumed by the read builtin, rather than by cat(1) as it should 
> have been.
>
> $ printf 'a\n\0bc' | dash -c 'read x; cat' | od -An -t x1 -c
>   62  63
>    b   c

POSIX doesn't require a `read` _builtin_, but for the `read` 
_utility_, it says:

> STDIN
>
> If the -d delim option is not specified, or if it is specified 
> and
> delim is not the null string, the standard input shall contain 
> zero or
> more bytes (which need not form valid characters) and shall not
> contain any null bytes.
>
> If the -d delim option is specified and delim is the null 
> string, the
> standard input shall contain zero or more bytes (which need not 
> form
> valid characters).
-- 
   https://pubs.opengroup.org/onlinepubs/9799919799/utilities/read.html#tag_20_100

dash's `read` builtin doesn't have an `-d delim` option, and it 
seems to me that in such a context, it's reasonable to regard `-d 
delim` as "not specified", such that stdin isn't allowed to 
contain any null bytes.


Alexis.
