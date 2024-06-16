Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850F83A8CB
	for <dash@vger.kernel.org>; Sun, 16 Jun 2024 10:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718534559; cv=none; b=BZYG3N9k8F4E5ESpUzcTh0bWcD+I0Bz6lhYat7LNmCTsT4eqhHLwHV3JRjBpbsWlpTeTgqlXeNTgjSPZ4miMqAyh/k0+bV8t7YODTZAbeY4fYrUbruGgz0xbaX5zD7Jc/6X85PefUL+J5rEXoihgV4v/iiqOwct2U8t5fJlx7Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718534559; c=relaxed/simple;
	bh=Idtf5xzpYjxSO29Y/+C1ti3mYJlfZgMcsIb4K978Fbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=rvaTxRktXB7qfsAarey0SCd0pDz2HB4h9VDrQS+rAmKFdejyP1V/ZUNX4enJfggx6aqMeKw3ouqHL5ctw8MydWg7lGUOOLOX49NHdqD3aXmnBLTJZ2HlINlbmcpVU3rb7nbIwSLf2X1QJz5h5DXS3xL9FmtfeFV66x0qQjpxPXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jetbrains.com; spf=pass smtp.mailfrom=jetbrains.com; dkim=pass (1024-bit key) header.d=jetbrains.com header.i=@jetbrains.com header.b=bSK95zG/; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jetbrains.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetbrains.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jetbrains.com header.i=@jetbrains.com header.b="bSK95zG/"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6fd8506a0b2so2940397a12.3
        for <dash@vger.kernel.org>; Sun, 16 Jun 2024 03:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jetbrains.com; s=googleapps; t=1718534557; x=1719139357; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aNDc6KQiPRNOfVuH/JnEe3gp8d/NmXSrFpKlAr8zfUw=;
        b=bSK95zG/dEwcGxHs+lOqZI4cbbyYoed3ogIxpUkYC8qlmnAa5DIBQwtQgorxQVMnxw
         Xc91QozvlgJOr+Zm1fUaO/tFu1N0usXRxwhtloJKoZNCx6OOMyIiZpc9jNadRT/Twbim
         vv+D+VViM11K2TYecrNJ8tXjXhwAV80s+lmv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718534557; x=1719139357;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aNDc6KQiPRNOfVuH/JnEe3gp8d/NmXSrFpKlAr8zfUw=;
        b=uTHi+yNDNQviD7b9U3IUfgwOFDKsy3wxxYOpJhIq/ZViUO7EWhRpRP1ktx5MehD+W8
         ZYRovmnGKvNSrnSxwe2rYpBrjeTpHVdJquHy3as5renXtzUZnS4uEiSGrSkEqqI7O2eF
         q+C0dTBIxNqrHa9msd24h8dPO8x77aeo8CzPGIhWVyCxV8g/3/9w5LXCGcp59ZDT4HWA
         +nivJs4g96//Rv3RfVaf9HMJ+FE/T5s+30CVYeg0BNnx69hGPqBZ37G3j76nUUKsWoAS
         44KBlQwvBfcJ/nVAztKprfH7KWXcavWtWMibuNoQaB+4MI2Cf06JeU+An09+NFKlEs8i
         fCvw==
X-Gm-Message-State: AOJu0YxdzqtZhmUe4q2jfotBr9mKRYDRSSr1a6vtlInD9pEaEKPF+oHg
	LaXwsGVdzDZ8rXiEHwuC1wU9n7UmhrcRffJ9V9nzvFlEKB+AyMtFFI9KMZdjfmiT8xazsUEybvC
	LdN5I8OkInslH+zR8vXcYUoaBV+4KJVfYX+ncsxJyWRslZhpOZXJq
X-Google-Smtp-Source: AGHT+IGta1EgxNJKSKKWkHQiR82pv1L4YmrNdgIu5dD+lwspSdrvcjR/VNAUKCmuVbq6o5+37SxPmxyeLl6JxBlBev4=
X-Received: by 2002:a05:6a20:7489:b0:1b7:f59d:fd1e with SMTP id
 adf61e73a8af0-1bae802b39dmr9104100637.50.1718534557347; Sun, 16 Jun 2024
 03:42:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMQsgbSZnEac=ETYnR6a_ysnAysaHThwY03pnoDxC=p5FqtAag@mail.gmail.com>
 <Zm5y3du0C2MHdhSR@gondor.apana.org.au>
In-Reply-To: <Zm5y3du0C2MHdhSR@gondor.apana.org.au>
From: Ilya Kazakevich <ilya.kazakevich@jetbrains.com>
Date: Sun, 16 Jun 2024 12:42:26 +0200
Message-ID: <CAMQsgbQotWyBs+Hg9qACTjffnVcF0XHVb7EsdOdCLPzt6kMPAA@mail.gmail.com>
Subject: Re: Subprocess doesn't get stdin sometimes.
To: dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Yes this is a known bug in dash 0.5.12 and prior.  It was fixed
> a while ago in the git tree by:
>
> commit 5f094d08c5bcee876191404a4f3dd2d075571215


Thank you Herbert,

I now see that 0.5.12 reads the whole line instead of bytes.
``
read(0, "head -c 2\nab\n", 8192) = 13
```

I can also confirm that this bug doesn't exist in the latest version
built from git.

Ilya.
