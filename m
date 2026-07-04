Received: from freekahlil.inlv.org (freekahlil.inlv.org [46.19.33.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75A62FFF8D
	for <dash@vger.kernel.org>; Sat,  4 Jul 2026 21:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.33.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783198807; cv=none; b=jAtnhCp5+k4T3bImdyoInIorXiyF1LV2isr4WnfbbDZ4rq4NO9LQlNNWfJMcNEbdlyaRFC0NOJoODKJeprdupIna65Q0fM7Bd2rh8TE9NvpPlvCM2VOhHZhZO4T+YtNt4AmHFpB8BT0Sw3ZhrfsYxzocPZkrjXjn2vOD2akNvIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783198807; c=relaxed/simple;
	bh=OFbpmIPsg4+zDU0QrDWnY4IzUMpQ/whVgkoVRkLmuU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YTcvySyjq4F9IIfsmheWTn2eao+ZFaKl2BQo2OlOhxz7nPFcqV4xicbvd7vQ4X3eb2I/W1+w1eHZoh7ApwEON/XaqDY+2N9BpawYZ08vGdT9ImdkWkQwdjIuoyMNn++lxF/8YuaB5bSO4essLj9m6T0eLH1qAalrtDMig4A7z6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org; spf=pass smtp.mailfrom=inlv.org; dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b=jrTt88n+; arc=none smtp.client-ip=46.19.33.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inlv.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b="jrTt88n+"
Received: from [192.168.1.122] ([78.141.58.175])
	(authenticated bits=0)
	by freekahlil.inlv.org (8.18.1/8.18.1) with ESMTPSA id 664KhMew073694
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 4 Jul 2026 22:43:23 +0200 (CEST)
	(envelope-from martijn@inlv.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inlv.org; s=inlv;
	t=1783197803; bh=OFbpmIPsg4+zDU0QrDWnY4IzUMpQ/whVgkoVRkLmuU0=;
	h=From:From;
	b=jrTt88n+v6fcN7laprWzq85Mf0W8yLAUpXwxDwel8pv44os3jjcifjGulu2Wkn3FA
	 Xa3ekLNRA7i8T7l10GqByf7FJQPir3iNL7DcQBg3aBjZNnqdPR/+lajcZumWO0Nlcf
	 AeotOT+sH/4jaKmNMjTneag9S/Y7EDFemdQX7E6Q=
Message-ID: <894fe634-5fea-4eb5-8748-f8b999298ddf@inlv.org>
Date: Sat, 4 Jul 2026 21:43:22 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] builtin: Add CTLESC before all CCTLs in dollar single
 quote
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org
References: <akiJaZ9FJZeO9DNZ@gondor.apana.org.au>
From: Martijn Dekker <martijn@inlv.org>
Content-Language: nl
In-Reply-To: <akiJaZ9FJZeO9DNZ@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Op 04-07-2026 om 05:17 schreef Herbert Xu:
> Thanks for the report.  This patch should fix the problem:

Fix confirmed, thanks!

-- 
||	modernish -- harness the shell
||	https://github.com/modernish/modernish
||
||	KornShell lives!
||	https://github.com/ksh93/ksh
