Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFAD14AA9
	for <dash@vger.kernel.org>; Wed, 20 Aug 2025 11:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689281; cv=none; b=IWeBpx8gEOp+LTwYUiElB8gVQmQlkvRR5smEtyOHmPYfIYi0yJdeJP6uNLuCzhgciSynCwaOXzvSslqCiKBO2spQJntQWnzQ1M2AF3/oB5RZUxJz9DVTnrWfRZNY0/HmTTP5H5b8Mwm5f3QGYtPhNGc8aefqnpoxAU/cYrhNGdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689281; c=relaxed/simple;
	bh=hVDP+UEsy8l68caH5GyfUJF8ZUPMr3P1kErcOKzjuNE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References; b=bD5dnGeQQJDyGtkGHL2SwGRM1LJAsK1SACtXVfymJrEQNvZjlemNJbEEqcPpCWDURYnFpX9L/ZvW9qZNi/DGF3TTT9ICzOd7CFqZHeBaHby2d5hurm6NkuBSRxE7crxn91lL38gaWK09vyVRBGfaFNs6LizZOmv7ehmzrjtik9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=pass smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=PfEsumMZ; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="PfEsumMZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1755689274; x=1756355940; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:openpgp:blahblahblah:author:from:
  subject:date:to:cc:resent-author:resent-date:resent-from:resent-sender:
  resent-to:resent-cc:resent-reply-to:resent-message-id:in-reply-to:
  references:mime-version:content-type:content-transfer-encoding:
  content-disposition:content-id:content-description:message-id:
  mail-followup-to:openpgp:blahblahblah;
 bh=BuShT781mcFlwcaZu7GdhHRFFu9ORrHjzOpMgkfxzJo=;
 b=PfEsumMZKVFKg3UoSkvxwnsm2K76ryDPh7xzsGhlRDyyZLyIhvMPv53/EbydN6UAnF2aNZLJ
  rnN27rztJl54LRO2NtUwDrD2TGAYKxnW6N/zvgzpamgM48HQfQdKRjwhqx5lmF5s8/4Qm0PP3Y
  voeTC4bXU9KftOMPU0x9540g9JNZLj5bFj3SbUQ2TagEhyEreYf3fPsvyXpcZIwr9sHzL5+8AL
  DrVSaE1FPTPvND9ceAFJkQwLOqgoaJ7poNuqz7HFbaUMjLgtE+SYN44q7yS81drbBAR05YRYw5
  IW0K5AYjHuUdFWW03WNKA5uiRSPkDDyXsUWUS9qu8Wfd+QWw==
Date: Wed, 20 Aug 2025 13:27:53 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Aleksander Ushakov <aushakov@astralinux.ru>, dash@vger.kernel.org
Subject: Re: [PATCH] left shift of negative value do_binop
 src/arith_yacc.c:111:12
Message-ID: <20250820112753.FJo-4m6j@steffen%sdaoden.eu>
In-Reply-To: <ef041d50-cb3b-44be-aa81-402912b42997@gigawatt.nl>
References: <1abb4964-b5ee-42d8-bbb8-959594d61665@astralinux.ru>
 <e79e39bc-02b8-4ad7-ba03-7e4d00061c3e@astralinux.ru>
 <3a37b273-3da1-45f6-a303-3c0796bd0532@gigawatt.nl>
 <024b5e9f-6112-4224-b095-f7e54b8971b4@astralinux.ru>
 <ef041d50-cb3b-44be-aa81-402912b42997@gigawatt.nl>
User-Agent: s-nail v14.9.25-698-ge40eefb876
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

Harald van Dijk wrote in
 <ef041d50-cb3b-44be-aa81-402912b42997@gigawatt.nl>:
 |On 20/08/2025 01:33, Aleksander Ushakov wrote:
 |> Well, if we take bash with UBSAN instrumentation and try to use a 
 |> similar command with a negative number shift to the left, then at least 
 |> we won't get a sanitizer error. Yes, you can remove the message that 
 |> this shift is invalid, but it is still UB to perform this shift 
 |> according to the C standard. I mean, a check should be added here so as 
 |> not to trigger UBSAN, as it is done in bash.
 |
 |I did that in my own version back in 2019, with the exception of subtly 
 |changing behaviour that differed across architectures, and changing 
 |behaviour that resulted in shell crashes: 
 |<https://github.com/hvdijk/gwsh/commit/3b2307005d9ca18f57151ba239c3a0c3c\
 |107d681> 
 |and 
 |<https://github.com/hvdijk/gwsh/commit/c4d6f1b1613c228db1e157a2136c53f55\
 |b4530c8>. 
 |As those commits show, there are quite a few more cases to consider than 
 |left shifts of negative values.

We (i am only a MUA though, since busybox did not take the code,
and kept their broken implemenation; will try again at some time)
all return -2 for "-1 << 1", at least on this hardware etc etc.
You then return 0 from looking at the commitdiff!?!

 |dash is free to take those patches, or to decide not to: you are right 
 |that these cases are undefined according to the C standard, but that 
 |means that these cases are also undefined in shell scripts, because 
 |shell arithmetic is defined by reference to the C standard: "The 
 |evaluation of arithmetic expressions shall be equivalent to that 
 |described in Section 6.5, Expressions, of the ISO C standard." The 
 |current behaviour of tolerating it by default, but flagging it when 
 |special options are used, is not my preferred behaviour, but is 
 |defensible, so I will wait for dash's maintainer to chime in on his 
 |preference.
 --End of <ef041d50-cb3b-44be-aa81-402912b42997@gigawatt.nl>

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
