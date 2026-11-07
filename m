Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794062262;
	b=DpT6KL8MYPXWNUdRS4UBcBsrm9AeMNxiievF0mikSihwEFG2/It/POjkA4ko23gEPRkX
	 w+y6K1glbFF9WrOxeqAuqcDIsxNIYuP9tA1SjqDcsHDneVu9o8QVxbL40+er5d8tcf/fv
	 XfvhOwuKZ3NOH5XxfJYFP6aWS7E4vPFXrfGMksb+Lou1UGA+aqY99CftSxazAuAYiPclx
	 5CdhGWGj+28C3Kf5WFyV243hPBxGoF1dAz/xB+Itjf02HxffIrc5crnPdETTm2g2QZPq/
	 hF786YfwoMQWxbMdTAnnndPzET529h2/wgPp8kSZbP7ft4ltTCxGUbqGeHQCoSixCuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794062262;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:Message-ID:Date:
	 MIME-Version:User-Agent:Content-Language:In-Reply-To:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding;
	bh=HmC09QROeq6xn6nBMJnPw2Epx0Q0gykGPls9a9/DqnY=;
	b=PBLx65qgPBN6dUANqjmfcgZJ5R7BCGDvbudASzgrOkXscBrupXvt6cbQxD24KPOqeNWZ
	 dSj00CaillEa7tr/Th8X1aWEt9n2AXtfiwOGbSNl7zFieL219Ps4yvUt6aP0wAcai7zar
	 BtVGsjptSJfy/xYs6/RXeXLre8CAHI+0nXipZO1GZYio6abSOlIHM6PENyi4QtDHZwyWm
	 yH8Zw/hMs44f1yTTsDAp5HMR+I9S4qiMNbgh47BymcvtlnvEbiIN8tC4c6CWs/evyVfWO
	 bEOnO/AEOD9GjpXttiZuCUTuhIV6/lM6Y1+JLRjvAr8qsh9qqb90iIBPPfHnyGc0jSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=draigBrady.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UG30igF2;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDC8606EE82
	for <dash@vger.kernel.org>; Sat,  7 Nov 2026 14:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FDC8606EE82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draigBrady.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UG30igF2
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48fd2e38825so936820f8f.2
        for <dash@vger.kernel.org>; Sat, 07 Nov 2026 06:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794062260; x=1794667060; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :in-reply-to:content-language:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HmC09QROeq6xn6nBMJnPw2Epx0Q0gykGPls9a9/DqnY=;
        b=UG30igF2DRpkQ5M3jtFpvtIqxnNLohL1VU5wmgYGpKaxg8T+k5CfQibF8c72vWxpE1
         cpn126OSOoYaIyaoaWwLkkT1p7ZPYwlZOY6Z3qJZPe+LMk35Q3CjIewbXBH2haqbJjXX
         wo/JhBxx3F2bQkic3o2QVVLDziLx+v2Gxue9g98VvHRUewLrIfqfedntTgMNO4pcRpJB
         64v73uGi7FJgBlpAElmMV/7gZynI19iWeFoAKy2VXr4q311iRM0iFZC/wIu+py02Tg1q
         ZChrcclPxI/oBchfpLG3veUxFDVkR+HY+28OAjT7d9YKh3khwfZcIm0zJuweubmwBLEf
         OJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794062260; x=1794667060;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :in-reply-to:content-language:user-agent:mime-version:date
         :message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HmC09QROeq6xn6nBMJnPw2Epx0Q0gykGPls9a9/DqnY=;
        b=U7yWsqYkGM9o6VFcwfnMYaNFe10XjuCzDur7ZhmJNcOq1eXc8xwSzb8X4S6OpUOf72
         ChfzvrEhOJcogK44Pv5iL1rg/1BhhO6J5M7+7L9LW7XCLzAy/2naIGEbmfb3aXnqf1XR
         GRRa3UMg+T0ef+scQxP+bxx1yvQRMzKCBCMxMtqxZQtHIuKO9+IgRl/AMCmYmOFPcmwC
         qPILJOhiqpoHN60Egaphix9x9aRqCTUF/gu9anpFquEJaJomZ3bBo4QPEak92oMs1/0W
         cmUEovldNevlkQpv6DKQX6Bo7Tc9PRC3qhCYVh31+wA220KSI8g+sIsmRr/aYUzvRMsB
         shUg==
X-Gm-Message-State: APuU4Z/6vsIiAPOt+O1JwUod2xkKxNrZenBwZ1YQkKCqUTFDvSBjpBEN
	eCzuokEeqJKZHE7cOtIo6+jq5u+V+MS6NINUy0DAEIBr8Y5TlypEkpA5l9a2wg==
X-Gm-Gg: AYBFou32/8mVOMPf+k8jOyvFgLRFuShERFLGz5MhchaWDGr9Faf6q0rqLMHn/UA+plZ
	fVEAYw5aOZZIA5ovgZP2x+tTMRFWawjtL8KDBcGCCSTmDH0wihbYe9ZSjpi/K512xcyxicp48xc
	t9FTPaONImXcTtVzhMMe7+Y3FcQw1NTC3LvjwaDplbaAALh1JcZRiHZoNIDthUnyZU0ySjnppgW
	lEAZ7+D+S0NrrDxayAFOXp0qOYe2nglnMl4cNkzLugBvMb4tTzESFgPt/6ah8LGblejrgerfyKS
	CaCJqyp69OrrUXzrU4of7LPnP8vJC8rItmebSnICm+s4ienF5FnnbSr7IgkMv5GvLyuQ96L/J3W
	5PWCk5wIwryPOVwi+8d4otDRNYaWpqkKoDux7wSBGjIteY+GjA8qDzf9pT0SXm+6tIe8QC3qoYG
	ZKVq3/3DlHgIw/nDJKND2EuthjXeriJphOgao3KhuZqAyJRwz2O5lQoOtuFscIruCFSqeBXlIgw
	Fjo/D2Jvighfh2vp3kIUC3orKUCnfHSpawD6DLPFXfOvnYtU4T+IOVi/ls9ijgD0mKAiOsuGJOJ
	Hw2LiJ0jQbRM6nPOwrmV74x/nY8dkRSoV3/uOYt5C4Pm2F3RtxmPMaxLF7fDYzEm4HxXU9cUrKG
	nhXAzoAiEwMO2RieGLMubJ2CXFbc=
X-Received: by 2002:a05:6000:22c1:b0:48d:f3ee:7cc with SMTP id ffacd0b85a97d-4927669881emr11945407f8f.30.1794062259782;
        Sat, 07 Nov 2026 06:37:39 -0800 (PST)
Received: from [192.168.1.31] (86-44-210-62-dynamic.agg2.lod.rsl-rtd.eircom.net. [86.44.210.62])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-492d7cc6162sm9744977f8f.47.2026.11.07.06.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2026 06:37:39 -0800 (PST)
Sender: =?UTF-8?Q?P=C3=A1draig_Brady?= <pixelbeat@gmail.com>
Message-ID: <8a050dca-a4b5-440e-ad4f-f1f41159519c@draigBrady.com>
Date: Sat, 7 Nov 2026 14:37:37 +0000
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Post: <mailto:dash@vger.kernel.org>
List-Help: <mailto:dash+help@vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
List-Owner: <mailto:dash+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-US
In-Reply-To: 20260817202007.93924-1-ayeshashafique123@gmail.com
To: dash@vger.kernel.org
Cc: herbert@gondor.apana.org.au, Ayesha Shafique <ayeshashafique123@gmail.com>
From: =?UTF-8?Q?P=C3=A1draig_Brady?= <P@draigBrady.com>
Subject: RE: [PATCH] expand: Fix out-of-bounds syntax table access
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I hit this on Fedora 44 (0.5.13.1).
It causes the coreutils test suite to fail.
Note that test suite also sets LC_ALL=C which I would
have expected to otherwise avoid this multi-byte specific path.
So perhaps the following is also an appropriate optimization:

cheers,
Padraig

diff --git a/src/expand.c b/src/expand.c
index 76e67ce..5efa257 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -992,7 +992,7 @@ static size_t memtodest(const char *p, size_t len, int flags)

                 count++;

-               if (unlikely(c < 0)) {
+               if (unlikely(c < 0) && MB_CUR_MAX > 1) {
                         struct mbpair mbp = mbtodest(p, q, syntax, len);
                         unsigned mlm;

