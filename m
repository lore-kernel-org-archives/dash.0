Received: from chocolate.ash.relay.mailchannels.net (chocolate.ash.relay.mailchannels.net [23.83.222.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0AE4A0A
	for <dash@vger.kernel.org>; Sat, 23 Nov 2024 03:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732332523; cv=pass; b=NFR0i76NB4kGRk/MK4rimlpTyk4OLrka0DmegMbov2AWUp4ZD+xxGSzSzww2yvTSv+nQp5LnfbGq01aLXs8lm3HkB6qN4LVuhdp9SaWPXPx2ukh9X/ZFLli18jr4ksXdiCJ0TC+ncI84TGL+dZKBIe70CNVll4CDCwODpH3CNeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732332523; c=relaxed/simple;
	bh=hvxW3LB9jOhNH6+8cZb4hX/wqfdmg6lwh+dOOtbloD8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SOZVsClLRxCkp7qoq78vGdffDKzlOW4RnkM16S+Gt7/szTUIhDr9hkovhiCnZK6JAzkWZJHSTMxva5RkD2mH+gbc1tQqZbZd7wFq9XQvQTFddpAGaMKlXvK0o/MSoKW/CXKRtUGp+wEX/IHG63GG+3tDoJi+uUiXMvDbNo/xbdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.222.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 43074437A0;
	Sat, 23 Nov 2024 03:22:57 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-1.trex.outbound.svc.cluster.local [100.113.72.251])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 270D243AAD;
	Sat, 23 Nov 2024 03:22:55 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1732332175; a=rsa-sha256;
	cv=none;
	b=UPVRAtZDL8Uqs+sFKuXFYa9I1P8HSodCSvPjYAcpXul/F3yDgX7HNveBlGgmMtfh6/AeW8
	OBtV99wMg5IyfN5Pv5Ed8gaWK2ixv8hjiobLHAduDcCmUFOrmLlfNyuI74U/iV4drI6/qR
	O8oh3A0dNfLs7muq4UiDPRfZNXNDHX6ZGSz5PNu5x5kr7Ax7enpnU/YlTP5pdpO28mPhzW
	U8FXMK14DeKLuVXycLQF+yc/JRxYDZHNMce399yi4f1NRJ0yenlr1C+6gs60E73VJXzlBw
	S0NOrQrB55k7UxAPHdll6biitk9+qSXwikzOXCEtZ9iWDcQOe2x1Rz/Lf9uslQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1732332175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dyRRsJe1Kt9w/SIv1NjQJd4MKzxNjlRrLvTl1R5TIYk=;
	b=QPMpt6Pbr6Mtgy2zFyT/IDw+Z4Fc99f9irHonldT1PXW8UMywqZ3ji4L+PVMg5r+AlvxKh
	iOAmUctBOJbEMwp+s8u8kDM8MT8jRkHv8d5QaZCzLPPUbGlNTaLc5Z0JoHt7jaBCs60/+a
	OBJdzHzTsVVyDuE8a+4NCeg2Mij6g3jzD/+zA0k6y5qsWeIIZwdFFYb5dZQDO7GZymzikq
	g6nxNd+taWqa1C1HbIgQTYvNMjgFehbgEmOgt/YWQIvlDXxJV3aTi2k3uRY7TGzaG0+TvE
	ds8SGr5hRa9c2A1UtNfeTkJ9VBx18u5vJ4JalMrY2L1bSFndcAI3zWfh6NOz/g==
ARC-Authentication-Results: i=1;
	rspamd-868968d99d-7xvvg;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Thread-Whimsical: 72ca90ad0bff076a_1732332175957_3791853984
X-MC-Loop-Signature: 1732332175957:312096994
X-MC-Ingress-Time: 1732332175957
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.113.72.251 (trex/7.0.2);
	Sat, 23 Nov 2024 03:22:55 +0000
Received: from p5090f5d8.dip0.t-ipconnect.de ([80.144.245.216]:63934 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <calestyo@scientia.org>)
	id 1tEgjX-0000000F3q4-2kxk;
	Sat, 23 Nov 2024 03:22:52 +0000
Message-ID: <ff11abc014305b31343cc220fa503b927d3e4454.camel@scientia.org>
Subject: Re: set -e not ignored in AND-OR list
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Harald van Dijk <harald@gigawatt.nl>, Herbert Xu
	 <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org
Date: Sat, 23 Nov 2024 04:22:52 +0100
In-Reply-To: <be8c2692-ab69-46f2-a487-2f99452a0c2f@gigawatt.nl>
References: <ZzAyYf1ZWcSuPVJZ@gondor.apana.org.au>
	 <b16286957f9b3d6409423b3b9b54c84c1c64fcb2.camel@scientia.org>
	 <6496f8a6-bf07-4c4c-bbb6-3ce42dc378bd@gigawatt.nl>
	 <85df2488f78032cfb64acc98ec2c483bc1fb03e5.camel@scientia.org>
	 <65b72665-6d65-446f-b32b-968c6116ef1e@gigawatt.nl>
	 <20715fc311f5d3655e2d6d9dc1a911e8cfbccc3f.camel@scientia.org>
	 <be8c2692-ab69-46f2-a487-2f99452a0c2f@gigawatt.nl>
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

Hey.

Before deciding how this behaviour should be documented, I would rather
like to ask to reconsider whether it shouldn't be changed.


@Herbert, you've said that you believe dash's behaviour is POSIX
compliant.
But I still couldn't find anything in the text which would imply
this... and Harald who typically knows things quite well also seems to
believe that POSIX doesn't allow it.

Could you possibly tell exactly from which point(s) in the text you
think this follows?


If the outcome would indeed be that it's allowed, well then we could go
back to documented it.


If not - and despite that I don't like the set-e-ignoring at all - I
still think there's some points for changing the behaviour to match
POSIX:

- Even within dash, the behaviour seems already inconsistent, i.e. it
  does ignore the set-e-ignoring in command substitutions, but not in
  any other subshells, at least not in ( ) subshell commands, and I
  think neither in the subshells caused by pipelines.

  What makes command substitution subshells so special that they
  deserve it while others don't?


- Portability.
  I think one of the main points for using dash is that unlike
  other=C2=A0shells it's AFAIK quite close to POSIX sh, thus if
  anything=C2=A0runs in dash, one can be rather sure it runs in other POSIX
  compatible shells, too, unless of course one assumes any behaviour
  where POSIX explicitly leaves choice.

  If dash deviates from POSIX here, one makes scripts which are written
  for dash (assuming it to be POSIX compatible) actually non portable,
  if such script would depend on that behaviour.


If changing the behaviour doesn't seem feasible, then I think - in
addition improving dash's documentation - one should try to get POSIX
changed, by arguing that dash has done it like this forever (not sure
if that weighs enough).

I could open a ticket at the Austin Group, but a) it would probably be
more appropriate if Herbert (as maintainer) does so and b) we should
decide first whether or not dash's behaviour can/should be adapted.


Cheers,
Chris.
