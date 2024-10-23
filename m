Received: from fly.ash.relay.mailchannels.net (fly.ash.relay.mailchannels.net [23.83.222.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DBE1E51D
	for <dash@vger.kernel.org>; Wed, 23 Oct 2024 20:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729714004; cv=pass; b=raR3Fb7xa1snFpaF2RW1rpAmEXYu83JDzASWgUh9P4TrXNr4E+Yp+8drPvZDuKBNt5caNlvpreGCbHQ+YvYLADbwqwNuEd98VpUlJ1Y0PBkan48Puhn2wgeSCcySOlwS1HYNUHre+CSY3yPnGl6wi4r2MfOPNPVv5KGsXgmEH6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729714004; c=relaxed/simple;
	bh=i9BZO2GVvp3VpouSBaUP4+iEl1+fLxSjhj4NMGPNhJY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oMGhRy/k4J+h8jgAxKpSm/wy2+T//0CXPOkq5sfnt0uZkvgJAL+yyvW4/9dOkIiJHYrKSrfo/oJhiniE+wSech20MCWXDXyyNxOSqVpmrShbb3F9sNs338zYQ0eChESpcpADEh/3UC6duFXLvSZJ6F/IG+TG0eWQ3ERMGEzIlFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.222.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D85E58A6463;
	Wed, 23 Oct 2024 20:00:51 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (100-103-42-138.trex-nlb.outbound.svc.cluster.local [100.103.42.138])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 26DC28A648B;
	Wed, 23 Oct 2024 20:00:51 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1729713651; a=rsa-sha256;
	cv=none;
	b=6F/wNGdUrNQJyjDT5tUzD+T1+E3mUDE4AbTyPNm+Y0ldwmYtyc7Wja7oDkf/wfl/W/IWeU
	c+aWGDP65ysxNz+1LOunXLiESvu5wy6v/PAsJFn9+OuMSBeOxQDPVUjNkzwRQ2Yy5SaA+s
	cqOf6nIABXNOfLF1L89Nvy4F2j4yjaMdKtGUTard5yV12BEtw34XBUVjKVffTqPOpF1RMj
	8/HD018t74S/oiZ9MsrTyTz8X+GNjR/ZHEHIygXG1DQGYtxl+ZNYvEHIzOZjj4q5myznH9
	suhwwSNaJRGprRgHe4s0zYfqIvZBhVXUcoYuLkaUHMxBvPNhlXD4RnD/+ERhbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1729713651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i9BZO2GVvp3VpouSBaUP4+iEl1+fLxSjhj4NMGPNhJY=;
	b=nkQO64tFQS8/0dZftN+vBq/1o4ghsGOFTpN5d6HpmZQDiC4A9XXAs2tWw12gp49+nngEeX
	PLcBcVASnoWFH0g3qQHGjmrfAsqvXuMcNfgAIyvXjEBeT+w1RdqCydRb2z5Qal5asZD3id
	eDDwrlrvc0KGPdL1uXJi8zPPp8kD/lbecXLS2NBs2bLYaukEDUPePq3VmXh4ftie7TsNUZ
	MrBXtsjpy/mHv9bEE4cir7SUi/I7CdATLqjUNMX+eQXexhOi3S2GWtDhIHoAKK/zLfhaNO
	SvMuxMt7CrknmloSRzeMWy8cgyAe2+IARoKnyhXis5lz9KHYCCqu5BR/+xNOpw==
ARC-Authentication-Results: i=1;
	rspamd-9bc7b7997-mc4xp;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Squirrel-Glossy: 2cc2f0d7099165b1_1729713651788_3924126856
X-MC-Loop-Signature: 1729713651788:3871647153
X-MC-Ingress-Time: 1729713651788
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.42.138 (trex/7.0.2);
	Wed, 23 Oct 2024 20:00:51 +0000
Received: from p5b0ed864.dip0.t-ipconnect.de ([91.14.216.100]:63013 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <calestyo@scientia.org>)
	id 1t3hXF-000000014Qq-2Txm;
	Wed, 23 Oct 2024 20:00:49 +0000
Message-ID: <c5bcc6556a41d722e5af1353829831f55445d024.camel@scientia.org>
Subject: Re: `jobs` within command substitution doesn't work
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Mike Squire <mike.squire@gmail.com>
Cc: dash@vger.kernel.org
Date: Wed, 23 Oct 2024 22:00:47 +0200
In-Reply-To: <CAOn5hp+HSuut67JqqNXn9opCei4=aL-m+nrtFgRv7r8SjZqg-Q@mail.gmail.com>
References: <273c031d242d7610e4da37ceb9413c876f0168e0.camel@scientia.org>
	 <CAOn5hp+HSuut67JqqNXn9opCei4=aL-m+nrtFgRv7r8SjZqg-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1-1 
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

On Wed, 2024-10-23 at 20:46 +0100, Mike Squire wrote:
> $! will give you the PID of the most recently backgrounded process
> and
> is part of the POSIX specification.

Sure, I haven=E2=80=99t said it=E2=80=99s impossible... just "impossible to=
 easily=E2=80=A6".

$! get's a bit tedious if one has many jobs (or even a dynamic number)
and if one wants to check which of them still lives, one needs to
execute some other process.


> I have often seen code like "some_command & pid=3D$!" to background a
> task and get its PID. It also has the advantage that it only gives
> you
> the PID of the most recently backgrounded task, not a list of all
> currently backgrounded tasks (which "jobs -p" does).

It=E2=80=99s actually the later which I've been doing.

Still thanks :-)
Chris.
