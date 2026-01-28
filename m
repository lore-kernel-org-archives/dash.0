Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A622BEC2E
	for <dash@vger.kernel.org>; Wed, 28 Jan 2026 12:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769602027; cv=pass; b=gtqaRi2ySSgxa+PQECDmgsG4GR4oxUPVVD/Dw9WFtLzuz1pd2PcVH7qNmYBB1blE+8uuBb7wwVCesGUQAHGztiOr7B2aC//KhC0eKLm0JCznSbQRcECs0TslLdm8TPhFS4E534eb8x9oaWO29xS+JImmKYn1TP6xxfW3jGmYkLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769602027; c=relaxed/simple;
	bh=pqwSPYjfF1n0PMXlyBtgdLNLB4/Zd/YtPRBuf5QBtlI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jfKKznDhsatrtBeEIR9cE32+/s1WJfqkHA5hIdY6H4KOvaSIJcjwEYdC0PK1jO9kUJaCw39xl7t2v/D76XOVUHv4EspZ48PiUrCnsKwadW0NbbYXFHF5zFoeO6xGaQQVlPCfPiqzS1gOOFo3YhiQEBm9jdlNT74ubE12wGSt2xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=XYL9ShRt; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="XYL9ShRt"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-78f9b964c3eso15294117b3.1
        for <dash@vger.kernel.org>; Wed, 28 Jan 2026 04:07:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769602024; cv=none;
        d=google.com; s=arc-20240605;
        b=e+k1Tau95XaPM0sfrdEwEQG7P1KFvPJmx/9jhhMHWG5MIOboS6oOjAnXkM6wVddk7L
         /EnYHfpuRyMgTO9osKAuLCgOSKzzA/4VYJ1dc9jUPuYFJRoDihKfARHItUWTyFrIl81e
         3FFPRqSnu+axUQpNcB0PrDUO8wtM11w2eGnrlRP01PPx1VHRmhOPHPcagNEaRofw8RTP
         LiTC2RKpdia3J8Xccg1Wy+4LDTolRIYTLqQ6V9bZ8Lp5vWSRSePuMEEXsrjr7c9r6inu
         nar6ZuAk6+Fpi4H+twAis86qMs62mMevHA7Wq3HUd4Kt1HHRYf3IB9v6sLJcNxIrka7z
         IovA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=QihXDqTsrAfyMtPJKgY+DHNeSxIFQHv49hW/bsY4GOs=;
        fh=8ViJBE7khi76CnJqQzrAav0OoHrBlpLAVTsfTw9REA8=;
        b=IDowbIvnGN04jSzYMk4iZXgscEngn6mcDezfRQMdj+p51cQyEreQ+6hFI76CowN+oN
         y2BM2Nnfho1mPZIDCGFsdOt2w/wizbeYVGs80Ad6X76LEnZt5+542iBjEYBVbLFoghyq
         I8iqZwdeZENs8hNFVKP3s5FiYNJE3295PdpAECSdQrxRoca03EA+v6NkeD82RSrk6OSs
         TaZdoAYGLzROT02S60li5Mf2YEkxgwAbiRJsGMDANaFxb5VjaYaiwHom8HRTg0rL7Tao
         VO3nN+PbjhZTyS7cFyTSMIIFm3S9CXO+r04s/qbTxFIKD7rtVLFiGFn/CS3+rZkMyLtm
         0ROw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1769602024; x=1770206824; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QihXDqTsrAfyMtPJKgY+DHNeSxIFQHv49hW/bsY4GOs=;
        b=XYL9ShRteSti95veeCwRPx3e5gCL7LI45KxlwPEJf9utl8skQElRxSjcGbiTXuAmnA
         dMMgM5oziM2XoNClGktxzT8M0zoHlOYL6Ze8XuaHCIHZgJl2a0MkMM7jKfdlXEKCxlIw
         GKRKGqBzXpU7JfkGUt8wrC7FaT6fyial88/bws50Mvn3BC+hLTqpNbOZXBsoz0u+ofgH
         8jcqB1G12CBRoVGnBpj+kVsmh89+ps7OAMGIIdaC2i5LDmX6+JRv7T03cD0GmM5zMNQW
         g9Ih1a5ltOAUk/hV8WCU6i543THcdBJQr09RJycjqMERa5FRaZ3Nimzp54hosfpmewy9
         u22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769602024; x=1770206824;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QihXDqTsrAfyMtPJKgY+DHNeSxIFQHv49hW/bsY4GOs=;
        b=gXXLs3H3u5F21FbiZ5AMb/RVKITjA0yHnUdN1dmANTa0RIIM7Yh63rDcRfg+FZWQMk
         QaKsGcMZ4/ehW/gi3VtiuB1yFeqVjk7E7y0yS232n65By7Za4cD7s4geBOOM58FQites
         o1JfbnQCbS7vh+9eJMGTtFY7aHoZUyLoD3/r7eqDZTsjW0vhLwILa1vlef+mC3a/lGXF
         vg7v1nftrNR4ypCczmcDr2CS6XDvavciVVyP1bA2ChNWa+HNBxF+Ata5yezD76UPTMed
         PXzhTgiBpNBMjgA/Zbc2rt51kWPGj0ogHPHMit8NYbOVK5XLEpZduPTGo2ptdkfh6o0t
         gsag==
X-Gm-Message-State: AOJu0Yx9lc0KJCx713PIlTYFxwIg0/pKBp8okCV9qbn+E9fbQTmz0KE1
	qVvOHDRC9badsk3kuA8tRROR98lzQKMBVgv4jb/XgDMC3TD0n2wDZ7mT6juemXEMl73kOgOU+9O
	VsjwVFyGK2sdKQq4BejGKn/JrpTuzqdFqfGgD
X-Gm-Gg: AZuq6aIu1ePuwF1v3j/y4n8/KXFmgzqEMDeQLKX6ii7ZtVcbfgtnp+72ojKYA1X8T49
	msUenhPWi5eKk5BSjR+Z2U3HdUihKVIbaecz7qhcDQ9KB3YcPF4NKd6fBrrptEeIX9yttiRfFQp
	EFEsX31+KkuQTCkHUWt3Mzw7CpT3ZEAaFBIRxoguYCD7oGM80PyAOYf8gKGWhVytTw6uV2dVAPC
	Y2ltx8lEBb9myUCr3RsBREnT07tOXe63e0XQw5wJjWS1tPVC6XIsCFlQaHLB0o5Tpv3CIk=
X-Received: by 2002:a05:690c:60c2:b0:793:a289:f60c with SMTP id
 00721157ae682-79485e0d75cmr10440597b3.4.1769602024065; Wed, 28 Jan 2026
 04:07:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Denys Vlasenko <vda.linux@googlemail.com>
Date: Wed, 28 Jan 2026 13:06:52 +0100
X-Gm-Features: AZwV_QgATlphtSpi_JaFuGb31dYW-Q72bVQp8juX8rDIvBaXWR70PZsUELDyL_I
Message-ID: <CAK1hOcMsRRQsgp+pyNmui2v+gMx6zFf6nLa89jzeid-AfcKv8w@mail.gmail.com>
Subject: trstring() has \ooo octal printing code, it's buggy
To: DASH shell mailing list <dash@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Good day,
                                putc('\\', tracefile);
                                putc(*p >> 6 & 03, tracefile);
                                putc(*p >> 3 & 07, tracefile);
                                putc(*p & 07, tracefile);

The last three putc need '0' added to the char value:
they need to print '0...'7' bytes, not 0...7
