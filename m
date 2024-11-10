Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AA6233D62
	for <dash@vger.kernel.org>; Sun, 10 Nov 2024 07:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731224363; cv=none; b=BI/QFrTncIJenGX2/w/wbRPNUw5QNFEj9tOHPi0o8JWzK6Vc4hml3nft/BFZ52zskYtkgvVsWJjtJ1wt4Gc+8svqsM3ZpSSi7AghzHmi6wINpo25yv45V6000FMyej1yMI1OIBakdefATOgDSdofPhf/4SNCVzq223Tg1XTL8VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731224363; c=relaxed/simple;
	bh=xXXUTa17Cj3DzmaPggqJIl62P3MCBqsoYLElda0O0N4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BPNjeRdxVRu0rTlkCThUYt82HQ0EjILSZCQ06Sthaw55KjzffBHDZSaKmeF7xcdWQcTKlmXtnLznP84raHMlHg5aaoXy6gagDLbFdAFGpDljZ8HgmhBm8m7paYxFCg6i5M12k4GZTaWQ0o3MxECjryhOfh5meyUgm7qy38OX+10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=larryv.me; spf=pass smtp.mailfrom=larryv.me; dkim=pass (2048-bit key) header.d=larryv.me header.i=@larryv.me header.b=eX6hQFZI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OODzv0Mo; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=larryv.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=larryv.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=larryv.me header.i=@larryv.me header.b="eX6hQFZI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OODzv0Mo"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 065301380223;
	Sun, 10 Nov 2024 02:39:20 -0500 (EST)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-08.internal (MEProxy); Sun, 10 Nov 2024 02:39:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=larryv.me; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731224360;
	 x=1731310760; bh=Xo8U+5FhzAAmpwsV+FrQ7puAwgjKXsZ7fS9IZbqGeEk=; b=
	eX6hQFZIEXttrhaItSTNXI9N+iI//LazlYJa7a4RJteAWu9F6H6C/13B7sKvig65
	YVCRzYxYaoEqjJA9iHb/V2OzAQrwh58uOrHKzt16Vmh3BdsyOz0IyO08EPE7n5yG
	8+H9VIjIiJZEgm1aOGkzCp/nqpRP+vIYqJGNWBvI+DA3GVoz+ueo8LDx5XxRJzF1
	dd65UB4qHqeRG+KXrlBPtGebeIR53aqhhHjfXKDD0DYeESL7ell/A8w4e/qvAAeJ
	wepw7mEfpbLsn6Hk/l5KvgNDnISclx1VW+xdpKsXsvplWQPuuCTIw2pIZjexvBKx
	4M8lTvs84qZ1Rt6fNBTChA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731224360; x=
	1731310760; bh=Xo8U+5FhzAAmpwsV+FrQ7puAwgjKXsZ7fS9IZbqGeEk=; b=O
	ODzv0MoYoMx2vuQFdRomMY7riKVXJSeL5RNUsnHV7TyPH5jqB+bZQ/o0xgWxV4q7
	eg5iPh/X6QsTcEdWytkdUd+CEsS6o1kAlbqY9PxkfSufE6fl8D8eA2ETrFrkrR+c
	AkAYxeMvaeWCwou4RKZ6jTTjXUDXfnVde+fP3o41c8yRgY5TFdOzpUTO4kNzzy4u
	xyAmseg1rZXCKeetBy9jdZW2ZEE50gtsUKbDWfiPLrI8IWqnyNDGX6uOgnvBzUTw
	gQxwPldq5ZgZ5oj/ZBpUUe2VBeyJ6qxD/rTtu2szToIcuKQNzh1kKIh/NQ2zcyZm
	ZHJSxIrRgMLf3oja0k+zA==
X-ME-Sender: <xms:J2MwZ6iQVjl7CQKeHdbDYk6ZSJCXrX5CMuVL84GGJJ0PjDzgfcdaQQ>
    <xme:J2MwZ7CjqIJfnSbFsfc7MXn4z1Xv0okCFQKOCDdRAPUN5ADSs9-UJ9YMgNJKfxSOa
    osrCFvdu7RDqfSw8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdelgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvvefkjghfufgtgfesthejredtredtjeenucfhrhhomhepnfgrfihrvghntggvucggvghl
    joiiqhhuvgiiuceovhhqsehlrghrrhihvhdrmhgvqeenucggtffrrghtthgvrhhnpefhfe
    fgkeevhfeikedthffftdehvdehfeejvefgffdtudetffdtkeejtddugefhgeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehvqheslhgrrhhrhi
    hvrdhmvgdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptggrlhgvshhthihosehstghivghnthhirgdrohhrghdprhgtphhtthhopegurghshh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:J2MwZyEqfqLF8gFuDQiduVhA4IHCIJGjNjBSpcAF14CBYLhWuLHJbQ>
    <xmx:J2MwZzQC4UIoY_dkG_gy4V0nqHBSpz5SO0DWBjwYmFj0KQdQCXEeGA>
    <xmx:J2MwZ3xs_P243YIcbcbtP4f5Mq9LgQNqTrBWD6etbCA9VyfLbpSG5w>
    <xmx:J2MwZx41KPn_hlmaZ9XXxs7urp5M3Lc4TcFxc-ROEOwERCGvRxSvIA>
    <xmx:J2MwZwqgOhjnlcZtjUF0CsxR0qLL6XgDTOQd5BE4l3-srOHw8TCmfgkS>
Feedback-ID: i0b2842c6:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B69092E60084; Sun, 10 Nov 2024 02:39:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 10 Nov 2024 02:38:58 -0500
From: =?UTF-8?Q?Lawrence_Vel=C3=A1zquez?= <vq@larryv.me>
To: "Christoph Anton Mitterer" <calestyo@scientia.org>
Cc: dash@vger.kernel.org
Message-Id: <437c27e2-4877-4c9c-9cfb-5167423a8b44@app.fastmail.com>
In-Reply-To: <b16286957f9b3d6409423b3b9b54c84c1c64fcb2.camel@scientia.org>
References: <ZzAyYf1ZWcSuPVJZ@gondor.apana.org.au>
 <b16286957f9b3d6409423b3b9b54c84c1c64fcb2.camel@scientia.org>
Subject: Re: set -e not ignored in AND-OR list
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Nov 10, 2024, at 1:08 AM, Christoph Anton Mitterer wrote:
> I know that bash ignores set -e per default in the standard (which I
> think is however NOT POSIX compliant either), e.g.
>
> bash without --posix:
> $ set -e 
> $ echo "$(echo a; false; echo b)"
> a
> b
> $

Bash does NOT ignore "set -e" here; it just sets "set +e" in the
command substitution subshell.  You can see this by reenabling
"set -e" inside:

	$ ./bash -ec 'echo "$(set -e; echo a; false; echo b)"'
	a

Compare with a context in which it actually does ignore "set -e":

	$ ./bash -ec '! echo "$(set -e; echo a; false; echo b)"'
	a
	b

-- 
vq
