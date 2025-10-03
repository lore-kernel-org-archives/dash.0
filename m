Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A87E19DFA2
	for <dash@vger.kernel.org>; Fri,  3 Oct 2025 23:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759534335; cv=none; b=c59q4RP3LVHCVTkE8e/O+NsNB5JCazNWa2cTbv/15Aks5p1nV0Xh2EtN2dzR4M+/onqIR7d11txlUVNDpCdMvR5PTBKQy539Sw2fNLVM3kBHWthi1URWZJcdAZd8dBGgaJDi4X0OeGPSmmVSn1REnJzRwUzwGRLMaDFTb8+YrL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759534335; c=relaxed/simple;
	bh=IQ6kc9d0vE19FbfL7Vh+USXXh4zC3f73621qt4GZk3Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SPh34yDuMT87AtRT2PRPV79lspjHmagyJ24BQoqnIt+MZSE2icO206bQu7WWc2qQA6TsOG19rqcjttrjT9wrJ69n6Czbt7/0zxzXCPpIY59V454Dvguij4Ywt7Q85D9qbWkVhhdyVNfbPN6hpsijwf/pq3ROVpsv5BCu62ExCfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=larryv.me; spf=pass smtp.mailfrom=larryv.me; dkim=pass (2048-bit key) header.d=larryv.me header.i=@larryv.me header.b=IWbMcdLH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yn1oI57m; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=larryv.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=larryv.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=larryv.me header.i=@larryv.me header.b="IWbMcdLH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yn1oI57m"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id BF4AE1D0004D;
	Fri,  3 Oct 2025 19:32:11 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-04.internal (MEProxy); Fri, 03 Oct 2025 19:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=larryv.me; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759534331;
	 x=1759620731; bh=nKnRjqC0cN6k9JQ0ul5ee8ZElIkl51zvRRPVTpeu7YI=; b=
	IWbMcdLHUks4yrpjndx0ONhQIZSVJU1aexUVAq3bDHBlpkjq0awOPwAbaKeawV1I
	IVaoPXy7LDrvogPskrNICtIL9rdR+BYVDOIgCH4j8iS1u12h0Zzh3QXbJEgaxI2m
	wM9m+gPuocs3DzanvtqdzxnZvA+A280R6+2FXlE8exHwjB+wdqecF+g+X9PyAJ3E
	umWKdq8Y2D8PLdmWplUFSPs/yOEcQT65/Ma+dxzup+bMuG/N0n1MUFzB49f5S04f
	+YkPtwUeWM5WRCPZ9JI/WIhneTMjcGE+d2uzt8lfly+SRLheT3SGMD+v9VPsS4RG
	kP7xp/rV0GGD+VOsx/DvCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759534331; x=
	1759620731; bh=nKnRjqC0cN6k9JQ0ul5ee8ZElIkl51zvRRPVTpeu7YI=; b=y
	n1oI57mIjbijNEy/FguskYn4VJ8pKem+VItKAUkqkU8z52Vqx84fP98vvHZoNvyT
	BZnGx+sXUXQ+MGRjx7RBzRpY53oPMJ+Crn1vlBv4c8cdn5IZcqM+bHL/4PEGEOwp
	qL67IUboRMnBlK6KcR2q6juwq3TZIMzxE3RM6ulsG8jxtMDn/Wlfi2+hj8j1grE9
	6yVWXfWoTHDJoL1OL+5wj5JyMO/6AgS0zqoTXL3cM3/CsqOlPjSbZ84ZklEHD7gB
	5lvWVSjdJ05vh5y1VvED/wqmoL/ix+6lMYjtSbNl2DQj262uUMqZ1Y9qHRNKV4Va
	UX5EeNKcTqTr6Tm53B1Jg==
X-ME-Sender: <xms:-1zgaKy-S8atpuekFg_ByNm1nV4np7MovqFfmp2y1Zzhj6CQ7EY3eA>
    <xme:-1zgaBGLrUUM6lIU8c85undGmidoqgTEJCNghbVAFD044snT8igWvkT97Ycy8rOdv
    7YZw2WiwEFZZxLpJ1-NlLZH9QCQb8RTCHNtJOmLLVbcFAtnogSrvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeltddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredtjeenucfhrhhomhepnfgrfihrvghn
    tggvucggvghljoiiqhhuvgiiuceovhhqsehlrghrrhihvhdrmhgvqeenucggtffrrghtth
    gvrhhnpefggeeludehhedttefgfeehtdeuvdevjeetgefhteekudeijefhkeehuefhhfei
    udenucffohhmrghinhepohhpvghnghhrohhuphdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehvqheslhgrrhhrhihvrdhmvgdpnhgs
    pghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgtsehunh
    hishhtrhgrrdhfrhdprhgtphhtthhopegurghshhesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:-1zgaNco89FLIOeL92fayc8haK6np2gKIhK4OSyR2rZzPw17TbrCpg>
    <xmx:-1zgaJLWRxuO1OwogrV02Jlw7E3uhjtvy6TKuM1SzPRRDqMGLkrj4g>
    <xmx:-1zgaOEFvHyxPKQchFUqxzZGfr1ke82oYmbrkX_91CnTlgrHs6P0zQ>
    <xmx:-1zgaDqSWjALhhweoRzVadRGQMZquMBg6NmzwzAOnisBe-7J2akdgw>
    <xmx:-1zgaO3Zd2GvzKBcujTYc_aoEkU4008XXUriSOMX61nElZ6lFMqGxcY3>
Feedback-ID: i0b2842c6:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 140673020073; Fri,  3 Oct 2025 19:32:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A9WzF-w5Ew83
Date: Fri, 03 Oct 2025 19:31:50 -0400
From: =?UTF-8?Q?Lawrence_Vel=C3=A1zquez?= <vq@larryv.me>
To: "Marc Chantreux" <mc@unistra.fr>
Cc: dash@vger.kernel.org
Message-Id: <5a1befb9-0617-40b0-9c53-7bf6452f0dcd@app.fastmail.com>
In-Reply-To: <aOBSZYeG7UDIbOE6@prometheus>
References: <aOBSZYeG7UDIbOE6@prometheus>
Subject: Re: < "$@" doesn't expand properly?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 3, 2025, at 6:47 PM, Marc Chantreux wrote:
> The simplest way to do it (I thought) was
>
> #!/bin/sh
> set -eux
> < "$@" | sponge "$1"
>
> so inplace counter awk '{$0+=2}1' would be expanded
> as
>
> < 'counter' 'awk' '{$0+=2}1' | sponge 'counter'
>
>
> but there is an error message
>
> ./inplace: 3: cannot open counter awk {$0+=2}1: No such file
>
> so it seems that the expansion leads to
>
> < 'counter awk {$0+=2}1' | sponge 'counter'
>
> is this an expected behavior?

POSIX leaves this unspecified.  Section 2.7 [1] says that field
splitting is not performed on the word following a redirection
operator, and section 2.5.2 [2] says that the expansion of "$@" is
unspecified in that context.

Almost no shell works the way you are expecting, except for zsh in
native mode (which I suspect is where you first tried this syntax):

	% cat /tmp/x.sh
	< "$@"
	% ./bash /tmp/x.sh a b
	/tmp/x.sh: line 1: "$@": ambiguous redirect
	% dash /tmp/x.sh a b
	/tmp/x.sh: 1: cannot open a b: No such file
	% ksh /tmp/x.sh a b
	/tmp/x.sh[1]: a b: cannot open [No such file or directory]
	% mksh /tmp/x.sh a b
	/tmp/x.sh[1]: can't open a b: No such file or directory
	% oksh /tmp/x.sh a b
	/tmp/x.sh[1]: cannot open a b: No such file or directory
	% yash /tmp/x.sh a b
	yash: redirection: cannot open file `a b': No such file or directory
	% zsh /tmp/x.sh a b
	/tmp/x.sh:1: no such file or directory: a
	% zsh --emulate sh /tmp/x.sh a b
	/tmp/x.sh:1: no such file or directory: a b

  [1] https://pubs.opengroup.org/onlinepubs/9799919799.2024edition/utilities/V3_chap02.html#tag_19_07
  [2] https://pubs.opengroup.org/onlinepubs/9799919799.2024edition/utilities/V3_chap02.html#tag_19_05_02

-- 
vq
