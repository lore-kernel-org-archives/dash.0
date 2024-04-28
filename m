Received: from seahorse.cherry.relay.mailchannels.net (seahorse.cherry.relay.mailchannels.net [23.83.223.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D76A59
	for <dash@vger.kernel.org>; Sun, 28 Apr 2024 01:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714269422; cv=pass; b=ccdXvpstyYJiRl8/5UJvvrdCjsqSNxblE2lf7voSeqxwtWyfLH2smthFlLpdAkTLoqkWZ6NgKAT0tXH0Gg+UNaWXsiuFRbJ2DvNlo8E3Sc0LdFYNr06MJEI/UklI1IpM0ssqK1s4oruw02F61XW2z6o7zuAzhpS6pEQ7ZC6KvD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714269422; c=relaxed/simple;
	bh=E0lQP/jDXndeIx6FdbKMqjBgZBjGkpGGveoBCMk7sIc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rQCiJHsyewn4FlGlEufdG3diSnRRSH05rb3k0lKNuQiRGM4p3KmHxblOaK2JXk80IvzxUPgmJn6jm5Bts+sEX52YKShKK091swpHaKiIriNYCSAl6RKxD+n79Whvo9+1mXiQ1yp1V6n5gR8FKSPFJNegSnFAZZ16Rip65kBCs+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.223.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id CE9A75423A7;
	Sun, 28 Apr 2024 01:50:53 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id CE900542486;
	Sun, 28 Apr 2024 01:50:52 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1714269053; a=rsa-sha256;
	cv=none;
	b=QY7gW/+gf+eXHlJpbeUdU7OmO2zZOx8NMP4KEaqhZenE0x4TPpmBh++2bHhYU5RJ4kaQVV
	/cbd7Xtb/iaHF36b15Ml16kyQhYqX9B+oFrAEeTW2S4UeNSatbhY1wWDkVBbWkWtHjdcZq
	Ek8QBLsN+Pc/q3WVXdIbF1m6Pis7w3Y3SgY1yaDsyGcfmtC8Mrke11XzPZgfp/OXVCPjdc
	u0LWNJJPcTQ2dFzkFvhk9bX9P/8HxFxLl0/Y87/UJ2wkUJKNhBL2Sli1xIt1SlSXQDcdv5
	oewpwNToSpnci9/wyxNCCRcMlvierwoIgHy5aNL+uNqE3rh+9C+PfZA2fBHA4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1714269053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E0lQP/jDXndeIx6FdbKMqjBgZBjGkpGGveoBCMk7sIc=;
	b=1JT4orPPla4R7kt7UGYPLnDGCCPQlGqpgtbZ8iTq34AEOrHYl+KSCiqbOHHqUlkPCXy500
	nkxqOMQ3ajpz1EewEEqE1KjBe+bRWFrR1omeqkMcNbwF4Rrn28Nx5sJqLiPNhmqcqbNlqK
	BELwmNLxavWc30Vr3GmFRaS07LH3V7JR9BQrHIyv+80/MRxiNsHQIUWtSUyaCxAPrTXcIA
	fX5xINElUyr+CFro+zdoqOgX9LTJf1HPA22NKC2rPUVjn40LVE2aeLgDmVn0DCdPNtov6X
	Vq9IyEFpCuMECTBWV9M4PMNIfJ59qKGzFiRq69l3Wr8LBBk/tfgoW5mn3g0hsw==
ARC-Authentication-Results: i=1;
	rspamd-5c97bbd7c5-m56gw;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Minister-Thoughtful: 0923009b7063a322_1714269053633_2269087634
X-MC-Loop-Signature: 1714269053633:3052572785
X-MC-Ingress-Time: 1714269053632
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.106.71.32 (trex/6.9.2);
	Sun, 28 Apr 2024 01:50:53 +0000
Received: from p54b6d4bd.dip0.t-ipconnect.de ([84.182.212.189]:58798 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <calestyo@scientia.org>)
	id 1s0tgp-009yFd-1T;
	Sun, 28 Apr 2024 01:50:51 +0000
Message-ID: <6f678ac38331e254cfbeca82e9701966ea6b6057.camel@scientia.org>
Subject: Re: [PATCH 0/8] Add multi-byte support
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Lawrence =?ISO-8859-1?Q?Vel=E1zquez?= <vq@larryv.me>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org
Date: Sun, 28 Apr 2024 03:50:46 +0200
In-Reply-To: <ba1332c0-2029-4171-89b0-b2e6b33449d6@app.fastmail.com>
References: <cover.1714215826.git.herbert@gondor.apana.org.au>
	 <eb927eeff3d1da7406c998d0ce816d3b6a061fc7.camel@scientia.org>
	 <Zi2dIJQcNVwJgxuN@gondor.apana.org.au>
	 <e2d1d076a3a3d7f21bdb64b13cf9c4c3f4967bb2.camel@scientia.org>
	 <ba1332c0-2029-4171-89b0-b2e6b33449d6@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1+b2 
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

On Sat, 2024-04-27 at 21:35 -0400, Lawrence Vel=C3=A1zquez wrote:
> What's your point?=C2=A0 Do you think dash should not acquire multibyte
> support, to avoid breaking scripts that make such assumptions?

No, as I've said I have nothing against the functionality per se, but
just wanted to give a heads up that this might have some not
immediately obvious consequences.

Maybe it makes sense to add some big fat warning in a NEWS or changelog
file, telling people that their scripts may now run under another
locale and perhaps also giving some explanation on possible subtle
consequences?


Cheers,
Chris.
