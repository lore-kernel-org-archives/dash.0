Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB9133FE
	for <dash@vger.kernel.org>; Sun, 30 Jun 2024 05:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719724282; cv=none; b=PSSiymfSDMVEcknRpGes+EC3v6e9tg2jUqK04P1LlPl++Khb/70LJgT01xBWZrn+Rdz1ZH/sKwDsevOfVLCu2x5qpju3K+0LdwOp0PaTOVXgtO2DvBATEpc0sd6rrCDgftrd1hgdgwXIr4GSUBtRtGKyjTvf406ZiI2ns724b4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719724282; c=relaxed/simple;
	bh=Lb3n/vxo/WR3qOFF4u8Z6I8ylK3LBK2uzOrqjHSt+9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HkzdHAyxHznNd8XfA98hxNnClAoCdTydhJ40z05fKJ7nxUz14wx+M6U5BAuKZ2UTs4MxOVIutkakoff0NDfub3rd8GrHGEVr/brIqIBfD1JDvjtTS27P7h/2jeNqDPCZ0x3qgCx0/EDWuoOzZdy2dzGAQcpeUoc2lAo8zcT4pqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/EfulRJ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/EfulRJ"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52ce01403f6so2181217e87.0
        for <dash@vger.kernel.org>; Sat, 29 Jun 2024 22:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719724278; x=1720329078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=FvkmJGDCtlYjfFf7oPn0UYhBd8GzgBGXojNgDbt3uTA=;
        b=P/EfulRJeyXq7R3UDdyGvnNAg3a3NgF5iw3+Nvt39PJxUH+tEg59vJ+glf/gQe7Ugq
         LICllUATGkRTQH/Q6M2N7RPGA9vNgVFT8i5P3dfrTDGzWg0y/sb07i9HzqLYUunfx/DV
         4LA9pQSFWNut9NprFsUeBMLxc16uj64pc/VFifL05axcSHFzP6UcyPd2CIKZnojfv2Yf
         64iYQeSHtmM05sr/7O1Gjh9OXJKiJnSj9qqeZPKvU4+g53++skmvH0fYu96YjnKOVp3L
         7dmLpgJCfIORP70e8ienmU5CLartW87JuSnd3CyahAWVqM3BPwtiNMUe1KHAzu3jqQ3P
         utRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719724278; x=1720329078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FvkmJGDCtlYjfFf7oPn0UYhBd8GzgBGXojNgDbt3uTA=;
        b=k7i+JYDlPixqDYq2RGvcO8v9S9z0YdtnDIfG4dJM89hjOsDeZUt4HMdfNMBbKynATw
         azHfs27xjBsz2EI1JmBeOKjVd0jwfQY4fCbbtGN0Yn1DO7vK45g6O7mJQqbhn+lKbNBr
         9dEeyC5Hx8HIcJ8V6YU/a/ZlPf7oD8Hw74+hMyKYzjx5+fot2ctXBPCFGRWKlmtrM5wP
         5JtGYunDxaD/NvW5/6Mj4Vh2U6xWkOIZrIybvTPNgYE98dC+HtzVT2WccYkEwU+Mjg/b
         zg7dcpXkUg6yqJYf8r+qhsqDccurEfu20Zv+5G1GwOnCsfhXWemHg51Z3RJDjmVJkyhT
         hfVA==
X-Gm-Message-State: AOJu0YyDunXnCzTaOqXdFPMw37X6Wex8/l5mISaun3dhvF5tIf5JRTgV
	Utgo0YmDn5RB+Iyl4UItm4wHR1DGvYpNnJIrcDXhtTec6USS2sCFWurnyg==
X-Google-Smtp-Source: AGHT+IE5sAl0v08zDL2hIYC+y/A7ZFQmGkV0cd/2P14v9QZyaJT2L2sey9JnYIzE98RGXHdv127b7g==
X-Received: by 2002:a05:6512:b8c:b0:52c:e171:ba2 with SMTP id 2adb3069b0e04-52e8267191amr1643604e87.17.1719724277672;
        Sat, 29 Jun 2024 22:11:17 -0700 (PDT)
Received: from [192.168.0.102] (nat-0-0.nsk.sibset.net. [5.44.169.188])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-52e7ab0bab5sm819446e87.13.2024.06.29.22.11.16
        for <dash@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jun 2024 22:11:17 -0700 (PDT)
Sender: Maxim Nikulin <m.a.nikulin@gmail.com>
Message-ID: <5ac9c288-4d06-4f84-aa37-cc8574094cb2@gmail.com>
Date: Sun, 30 Jun 2024 12:11:16 +0700
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: stdin should be consumed line by line
To: dash@vger.kernel.org
References: <6640a8ee-eda0-1e35-df1a-c8b303440ca1@mail.de>
Content-Language: en-US, ru-RU
From: Max Nikulin <manikulin@gmail.com>
In-Reply-To: <6640a8ee-eda0-1e35-df1a-c8b303440ca1@mail.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/10/2021 18:11, Tycho Kirchner wrote:
> I think stdin should be consumed line by line in order to make passing 
> to other commands possible. Please consider the following difference 
> between the stdin "consumption" between bash and dash
> 
> $ stdintest(){ printf 'echo one\ndash -c "while read -r row; do echo got 
> row \$row; done" \necho two\n'; }
> $ stdintest | dash
> one
> two
> $ stdintest | bash
> one
> got row echo two
> $
> 
> I think bash behaves "correct" here.

When I noticed the issue, I found this message with no response, but not 
other threads. I believe, the following links may be useful for those 
who will get this report in search engine results. It is a bug in dash 
and latest released version does not contains its fix.

<https://lore.kernel.org/dash/20221213221732.6mvv22u7ktdozrbx@tarta.nabijaczleweli.xyz/t/>
[PATCH] input: preadfd: read standard input byte-wise
Tue, 13 Dec 2022 23:17:32 +0100

<https://lore.kernel.org/dash/cover.1717291846.git.herbert@gondor.apana.org.au/t/#u>
[v3 PATCH 0/3] Improve performance when reading stdin.
Sun, 02 Jun 2024 09:31:30 +0800

<https://bugs.debian.org/862907>
dash: Incorrectly slurps script from stdin (POSIX compliance issue)
