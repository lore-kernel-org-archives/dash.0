Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F800215043
	for <dash@vger.kernel.org>; Sat,  4 Oct 2025 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759590873; cv=none; b=RdFAirkbar5EvINOTC+6nr2MFv4mCAyB32/37lGNGZygtDE8458RcZiVXf7u1XJeAceBW7egR07g/LPdt7pnLDzx9s1Tcqj93HwZtRbeu2IO94jV/5DJMDGkC1qSF8XDDYBly1eF7dBfVSVsnqzUllQ5uqZXggiJTgSuAxjHbwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759590873; c=relaxed/simple;
	bh=oeFL3GR/zMVl+OSDHlGLO2Bm7aavcL3rm3S4RZMRFZ8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Uv9jY/ap0CRJEwaLJvJv05V+vTrWbnP5r4rX8H8xEEHKx0PsM17sve5OdmgugRTQFzRuxFp5dpfki3X47p0h9Krz1ASo89Bsv57N8To9mdiZxWy330dd9N9YS0wTY6Liy1f8S5nMBhMkF1BY88PB/aKeJARQGex/NcjO21BAnMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=larryv.me; spf=pass smtp.mailfrom=larryv.me; dkim=pass (2048-bit key) header.d=larryv.me header.i=@larryv.me header.b=xftO5mai; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MiE9r6Kx; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=larryv.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=larryv.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=larryv.me header.i=@larryv.me header.b="xftO5mai";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MiE9r6Kx"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6378114000CC;
	Sat,  4 Oct 2025 11:14:30 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-04.internal (MEProxy); Sat, 04 Oct 2025 11:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=larryv.me; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759590870;
	 x=1759677270; bh=GG4rFJX7bMZQ1iKCP9YT9m1ilI1lYG/jyipW6hs4YIc=; b=
	xftO5maitbcWLra4ItO8kgCfsPQ9fRe2ncz+BEL+qKfpQgcx6fPuemK4Hi0+gPHt
	YJT6k6ZGN9fPMEvBg9KRr9mscTfvQIznX1Ek5zgibrKMXF+2p5uklBraWY4ypcyE
	dXgmq+OQDcysZOWnx8sH2qVdHKSx5Jw3xdp1cqY6UBJctflzoGqgBCpG3J9B1SXg
	XBuWtSQEWDFqxJCYRYByqafzM6H4U/t8eJITsY7uCkjkFUftIbI+g0sEwGtAR73F
	j0VAmFt23A+zfVsW04yvs2d/fyNKdulzGa6gKLDsnmQWMBJg00KOPt83wbNBHTe4
	R5++/ZYtUnvE2YzC3Br4ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759590870; x=
	1759677270; bh=GG4rFJX7bMZQ1iKCP9YT9m1ilI1lYG/jyipW6hs4YIc=; b=M
	iE9r6KxSWyTI34Zhe4o/KXF2jmINaO54eoSizyfoWoPtieJ1nwkj+NR56BE3zHqH
	EvjsJdr2f7p+w36BJlfoiI+RO5rLxeRfK6JCBVVEYAnMv0niTjExNIj1y+g8JjMa
	HibWeARIhyzuUYLFgP44z1Rtzw27bT009FzQ1c4KTHEvqvRFmWKcGpn08uQcnRIZ
	+ETjxnz7yzecQIXiSiXsj80wikY7EQiCkyTkW2QOnMcc2rGWW2gdPrROvD5KDIvu
	1OjC2Nt6CNB942C4LZ4n2474a7358SheoBxQenc5rDYoWFZudNgxTQ0oAXB1JblS
	zauGqTR3TgnyHByMh/u/Q==
X-ME-Sender: <xms:1jnhaObwXqEa1wtESjhT-w2YVPDqo80oRdLvqCBRLZgsM9-dlXplmg>
    <xme:1jnhaMMJcmXPtgLIE2qe000U2Bs_G4gVEJijt2ja828csli-0U32hTRGB9UHmM917
    K5a-fbjk7xwptZNu4quQVskpgpClWPsqvJ90cbJKG7mAiB1bmvzyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelvdduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredtjeenucfhrhhomhepnfgrfihrvghn
    tggvucggvghljoiiqhhuvgiiuceovhhqsehlrghrrhihvhdrmhgvqeenucggtffrrghtth
    gvrhhnpefhfefgkeevhfeikedthffftdehvdehfeejvefgffdtudetffdtkeejtddugefh
    geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehvqh
    eslhgrrhhrhihvrdhmvgdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepmhgtsehunhhishhtrhgrrdhfrhdprhgtphhtthhopegurghshhesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:1jnhaJFdfxrZscKnhS261NMih3AhAcw2bXBCwFFm8Q-4cQ3Vfb_TMA>
    <xmx:1jnhaMRl0d2KKE26hwE89OI3m9I8HTh_9hIuhrHBUebQoBBspUFWQg>
    <xmx:1jnhaCvqDEZkjph7PH0Bqw2utxdoYPONR_vfAOfkCTdbVXMRDsgF-w>
    <xmx:1jnhaLxBHjWhO0ORnOp2JlUqrIExpW2WQArSwTorX9vN4yrqB5tSNg>
    <xmx:1jnhaJ9az8y9hzmzQGDGeMPauX-kxq3pBxoVxtDLAmxw0OcvTkl_GLHf>
Feedback-ID: i0b2842c6:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1739E3020086; Sat,  4 Oct 2025 11:14:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A9WzF-w5Ew83
Date: Sat, 04 Oct 2025 11:13:51 -0400
From: =?UTF-8?Q?Lawrence_Vel=C3=A1zquez?= <vq@larryv.me>
To: "Marc Chantreux" <mc@unistra.fr>
Cc: dash@vger.kernel.org
Message-Id: <cff17249-7e9d-47f9-aca1-ef1bfa5cd32a@app.fastmail.com>
In-Reply-To: <aODE8547kOvhQPIf@prometheus>
References: <aOBSZYeG7UDIbOE6@prometheus>
 <5a1befb9-0617-40b0-9c53-7bf6452f0dcd@app.fastmail.com>
 <aODE8547kOvhQPIf@prometheus>
Subject: Re: < "$@" doesn't expand properly?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Oct 4, 2025, at 2:55 AM, Marc Chantreux wrote:
> wow ... thank you so much for digging this. this is the second time
> this year where oppose POSIX standard against consistency and ease of
> use.
>
> I can understand why because most of the scripts I learned with were
> postfixing the redirections so word splitting doesn't matter at this
> point

Sure it does.  Redirections can be infixed, so these are all valid:

	<file cmd arg
	cmd <file arg
	cmd arg <file

Someone who agrees with your argument should logically expect this
to "work":

	set file arg
	cmd < "$@"


>> Almost no shell works the way you are expecting, except for zsh in
>> native mode (which I suspect is where you first tried this syntax)
>
> Not at all.

Ah, well.  I guessed so because I know from the zsh mailing lists
that you're a big zsh fan.


> As the behavior is undefined, of course, I would like to propose to
> behave the most helpful way when it makes sense because
>
> * the other usecases are already doable:
> 	* if the expected behavior is "$*", so use "$*"
> 	* what's the point of A  < "$@" ? use "$1" instead
> * it's a matter of consistency to me. why "$@" can't behave as "$@" ?

One could easily make the same "consistency" argument from the
perspective of the redirection operator.  POSIX disallows this
expansion from producing multiple fields...

	var='foo bar'
	cmd < $var

...so why should this one produce multiple fields?

	set foo bar
	cmd < "$@"

In any case, the existing behavior conforms to POSIX and is far
more portable, so it is not likely to change.


-- 
vq
