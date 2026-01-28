Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4691DE2A5
	for <dash@vger.kernel.org>; Wed, 28 Jan 2026 00:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769560032; cv=pass; b=VTGrMq4FZwwem22+l8+Au7SiIAuL6vQJZorQBcaB/9Znz2TGdNjlmr8wXfZ3vJ7xZ0TAWhfbk/P4lyhhaQ+tWGYt1Kix0+xkHa/eeBvkVk2PCZQxWSZswSm87Jif3Z3O4y9535TMIlCzZxkKBFHcTldYZCkYfT0LxZHN9X6zKn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769560032; c=relaxed/simple;
	bh=woG331AyoNxwuSwur54RnH2CvbPv8+TnOsp+Yktfbd4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KCpzsx0ordzmCvHXYGIQb7g5N0L40nRMFZC6qyT1yHsL3jDXpAuUGnOYKN9xIGTrc1TNUcXWqIp1cXwyqow9iiyjh3bEwMi92+OvBH8XQ0YydJQrKEKTLzmwk2QpEp1ylGDIqKwuMUwYVZy5faCBW6Z6/n9Td1kIFQ4Q/ckS6Jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=E5lTttg2; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="E5lTttg2"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7942e28eb3aso6997327b3.3
        for <dash@vger.kernel.org>; Tue, 27 Jan 2026 16:27:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769560030; cv=none;
        d=google.com; s=arc-20240605;
        b=KPbH3AflJXOmPyHGG1zEPosbcbCjgfhM/6D+68PQUIgJBu1A0WyFBYhJx0oO44fEnz
         FNUqqa5RUzE9NiTOC7nI4tXa2d7j8dxFmuyNR9AW699dJ6mKgnj/fSjqTW5q4v/9w6f8
         /Ugy/ZcB9llQQ0hNVQxMzyX3RJif8K6R/pBcsf1i3GM8T0BNnb5ewBuiABG5iSvf0LUp
         6hV26XupiPwKxPs0BVet8knMWoHHN1COEJ+YoGoNjZUpi2K71kCkw4DLFKufhj6vBEg8
         zsaFlWRhQCoCHuiFSP6Vv7GQ/SdRZ/jZQCSmb25DAVOXgrhkB2yexHxWQJ5Mg/+NO5D3
         6FWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=rgEwqncysmATJAUt59qiJeaKVoJmLAJRvihGbLmuv1Y=;
        fh=8ViJBE7khi76CnJqQzrAav0OoHrBlpLAVTsfTw9REA8=;
        b=RFmF6OxebXCXpPEa2F6Nq0EmPnvtc8ddG/nvuaulfifSKQ9+xy3GzIIqa1spfsYvju
         RD+s9di00BIg1MGlngyeM1Rou8aCZS2GlmjzKeam69UTUb4KDexayV7THwfT2onm6QyC
         Yw8uyw+Ss8sctQ88rh+kHeP+0kMJdwGY8ezWgphpeTw4SkjG6OjXS0DI/cEOBR/hgVhp
         72EIk31Xnv4mmIWTNTuC6quep9nMcz6IIfdk+GQEP1khGyhjczq07ourRlbaoCZUWbHp
         NMGMC0Hp+7QRuNZBYGOPtC1jK9pfRWIqCcvy7V7ra1AsIj5AsuS63S1GccuOuwKzdopF
         MOgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1769560030; x=1770164830; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rgEwqncysmATJAUt59qiJeaKVoJmLAJRvihGbLmuv1Y=;
        b=E5lTttg2qJnCwQ6KhC0Cw1UOzdmhIc9CbBrMBVhwdKILWZ0esKqeXu062h8vZiW84S
         oAwv1XNcM9NvI7npRG3NBlz3CtD2bqm2vDx3HqYVZf7dGyPq5alTHcQPvLySGU5JChPf
         uf58PR21nir36TC4xJmR6HNzUo7J2xB9MxutCUEbdlde83zaHxrgmkL4ynDeYwFVo/q7
         /WWHU8yhe0OOA3jRH2b9WwPGP61SHY7P628hYZA+5CI7z88PROFuA49O5arxcumnLSdS
         0mH480Ns5zPl4g6WOLZO86Apzls7TGPbOfjyprCGHCdjywvkMZK0Fwl1xkZmY1mVROzs
         fW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769560030; x=1770164830;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rgEwqncysmATJAUt59qiJeaKVoJmLAJRvihGbLmuv1Y=;
        b=nY1edK/jsBobe+3DR1oiXXXBjxfMJUMxD6qXargiWkcO1LofWB83MvMAcnrReYKUkZ
         Usqk4MMVW1NQ3AoRvbHtAbc6movWd5wZAXlh5xvoIEKEVw/eSfcxH0X0NXJldk3carex
         qUltfVfimI/Z2BaGkZlZL5mFtWwTtaC8yxy8JtY1ZW/hVOJK6LMn7KTW7A6VGemRANbd
         0BOfc0e9DscpIAlpW8hmwsBMwYSEGZRcTWkuMr4uzYU2zc8RJbUjg3NTIP2e9dm/RUrE
         hsHpv0YmaNBfC20socgRRLMa3Iw05s0uYM/6pAuNOrYQFzymovryfWAtgluioLioKW9q
         r0Lg==
X-Gm-Message-State: AOJu0Yw8ZYJFMLWJZ8olaDrwstviwr98JjbqgI6o6604jAgs1H0Wx8MB
	VMuUPBWWn8IkUq1Jt8jNkLdD1hhJyDYpxAIDmCpmCNgWxcDLquYNdUawKR9OFqp+0nDN2fUjufp
	MYcDMyK43N2ZyWE8E11xmaWGb025zBb+qLjt4
X-Gm-Gg: AZuq6aJa8Fa/Pd2eKFaAHTMBQKgxaNCcey4Vz8nvU7wYJFoXS5cEM0EOP2264zk6VFy
	08FRlkF1kca79auyH9bNVdhQifiAqq9YnLAjlqR5xN0JWTkMsq1IpPYtRzaph02uUCFUirAzftu
	m4Q1DyGxa6MUC8WsjIrXdj3ed9WePoLqd53KVEUkUrAAz5oOq8iqNnsYDlhCpYFEazmvS+moifl
	Ei5LCzGQdgjEVDr/Ow1jNDIUxiCnBGQFPNfxr5WSQ5eeBaE+s+DOdzDKZvA19PUFXN9cQ4Mbg==
X-Received: by 2002:a05:690e:138e:b0:649:47f1:26d8 with SMTP id
 956f58d0204a3-64995828637mr469606d50.6.1769560028277; Tue, 27 Jan 2026
 16:27:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Denys Vlasenko <vda.linux@googlemail.com>
Date: Wed, 28 Jan 2026 01:26:57 +0100
X-Gm-Features: AZwV_QgTEolI3jaeKQ8jRXHbGUMs-CsOEAq93iE-xeq60jWldwTnmX9yHq6hXsQ
Message-ID: <CAK1hOcP3BZAszT3XGgxQ9AEQwAd+nD4e+eY3xtmo9D8qSsjRew@mail.gmail.com>
Subject: Superfluous "chdir" builtin - maybe remove?
To: DASH shell mailing list <dash@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Good day.

In builtins.def.in:
cdcmd           -u cd chdir

The "chdir" there causes generation of a table entry
for builtin named "chdir" (an alias to the normal "cd").

No such builtin is required or even suggested by standards.
bash has no such thing either.
