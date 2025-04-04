Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E482E62C1
	for <dash@vger.kernel.org>; Fri,  4 Apr 2025 19:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743796333; cv=none; b=jXAvVbiHR9R6LN/T4ipM4+4hLT59kpA0OO0v6ESYOMF89USB1Le/2Nc+bn1ZMrAdm+8an6piKx09w21c0iRyoPJALsEnmi3IXyN/wMFtz4M9LS6bZc9HpRr0CM9D7h4e/UBdjOSWxhMu1M6OtstHEm9N+AeI2BwuonoXYoOJ7XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743796333; c=relaxed/simple;
	bh=M+kn4cFG+ysvSbG9gfW5l05PKS8vTSsPn1/oUZ+rgcw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KnP79BbIrxBvHBM5Z0tTUJikK/11GzXGS0RLMBOK2tE8O5pl/rfwUHGWAezKpYvBZVaNF6M1kuicP3Y42hOEqTAJ9fRC4EXjQObl2BSMxtDmrnCLcqzTVq7zSB+dbSXovXTX4IGYkX3kAh5xfDNKgrMvxWlQkGiH1wverasgTL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=larryv.me; spf=pass smtp.mailfrom=larryv.me; dkim=pass (2048-bit key) header.d=larryv.me header.i=@larryv.me header.b=tXarCOYw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pdJ2MCTI; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=larryv.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=larryv.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=larryv.me header.i=@larryv.me header.b="tXarCOYw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pdJ2MCTI"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 36BB92540139;
	Fri,  4 Apr 2025 15:52:09 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-04.internal (MEProxy); Fri, 04 Apr 2025 15:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=larryv.me; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1743796329;
	 x=1743882729; bh=tY/7mfmfj+Z8/3IHcdy4svcqbbrgAbA5BGHsrXnI2LE=; b=
	tXarCOYwwXgriOIHvqg7jXcm9Ta66XFRNWPAeMtZDJ6ZaPOhbeC/3xbGZpqafJIx
	mrrBn+biieTRrcF0p1m21UlOp3LMedPhdHhqvyWBmlMK/19kfshgvyDBd7C2L2NN
	m5+bamigAW4u6wts1fR9AeWph+igPk/swZ/UVaeZMMb9E2Mip0fTkkq3EC+9anDJ
	TcWJpUte46FxJZlaCWCLpgK2n6ci2Abmpec8xpDygX4nuVmpreBW+uJZprasbHEC
	5jBfZxAIYxlsiuhmwNiB8sMYRfLFLmHQ6OCWNJ6j5RGJjjZszXlEbZfF5aMo1RVs
	K9iwBquXXIGC4rO+DfG3AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743796329; x=
	1743882729; bh=tY/7mfmfj+Z8/3IHcdy4svcqbbrgAbA5BGHsrXnI2LE=; b=p
	dJ2MCTIEQ1S/dg3Zxvyawt12l5px5PEc9EerDv4e+bvAhiyEWeuu//VV/+3M6d4D
	aWu4iY805dhr7uWvPRBCvgU97aZXmsnGI0EmqmFx1hMMcywiLXQwaEfLP0yiCc4c
	uhl1/o5VA9u5W8rdHbhcl9joTA3KNt8OKgkcODpx9ceW+ZpLUPvwFgfJlilyyrV1
	AmLEChLFlcH5DUCUo1C5ugYZd2DPYocxtOZgiyBez3Ogx2jnQEhtLcVGYLu0mIdG
	Jjm9EyGUm2aQMHfAd/aC1mYNFqpEPJdDcHBPF49rHlmQ1Q/kZw7ci+Yy+i8UhxuL
	xVeHmD0GuXnZh0RTZ2ydQ==
X-ME-Sender: <xms:aDjwZ-l8EKc-suNMttT9jX6qZgPJe0j9k2JFZ7ANjTutIruWRKqMJw>
    <xme:aDjwZ12hAG-dK2NxPMZDAfJlHbcd0yu3yHrJdY2_XF7aE3HHxJWpk-NXoUnfUiwtO
    cpjsVBUCQanye2umQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduledvfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefogg
    ffhffvvefkjghfufgtgfesthejredtredtjeenucfhrhhomhepnfgrfihrvghntggvucgg
    vghljoiiqhhuvgiiuceovhhqsehlrghrrhihvhdrmhgvqeenucggtffrrghtthgvrhhnpe
    fhfefgkeevhfeikedthffftdehvdehfeejvefgffdtudetffdtkeejtddugefhgeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehvqheslhgrrh
    hrhihvrdhmvgdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhhrohihtggvrgdokhgvrhhnvghlsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epuggrshhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:aDjwZ8qaWjMRIUCSL7K_6xKs7jxUEK4I8t8Ypa3PBl7iIL_vWV6ZlQ>
    <xmx:aDjwZynQwGdV0RXeUdAW7RXATCGqOYS-5m8lcN4Xz2Eh1JF9Xobcuw>
    <xmx:aDjwZ807LRiVOcJuGmBua9Zb3D0hsLCD1p6pYFltFBtxG58Z7G-RBA>
    <xmx:aDjwZ5tA31YMiTHNU4dgjpRoCsnelSkU4Zs12Zg3qtH3m0WYNkSXrw>
    <xmx:aTjwZ11f5rDAFV78KIgwiGfUXp96NEPo1A7Ipj0cL4NpY-sKvP2xAR0i>
Feedback-ID: i0b2842c6:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CBF9A2E60088; Fri,  4 Apr 2025 15:52:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T9c5f07050d4ec5aa
Date: Fri, 04 Apr 2025 15:51:19 -0400
From: =?UTF-8?Q?Lawrence_Vel=C3=A1zquez?= <vq@larryv.me>
To: "Nathan Royce" <nroycea+kernel@gmail.com>
Cc: dash@vger.kernel.org
Message-Id: <11f69c85-4714-440a-b443-556a1d532c89@app.fastmail.com>
In-Reply-To: 
 <CALaQ_hoenH-y1+vh1M8dYyBMvPoanBXLumHi3o=Rq2MYghLU7g@mail.gmail.com>
References: 
 <CALaQ_hoenH-y1+vh1M8dYyBMvPoanBXLumHi3o=Rq2MYghLU7g@mail.gmail.com>
Subject: Re: Automatic Termination After Background Job Completes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Apr 4, 2025, at 9:09 AM, Nathan Royce wrote:
> Setting an emacs/vi flag when starting dash, and using an external
> command for a background job, the shell terminates once the job
> completes.

With dash 0.5.12, I'm seeing this behavior regardless of whether
the background job uses a shell built-in or an external utility.

	zsh% PS1='dash$ ' dash -V
	dash$ : &
	dash$
	zsh%


-- 
vq
