Received: from dog.elm.relay.mailchannels.net (dog.elm.relay.mailchannels.net [23.83.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFB46AC2
	for <dash@vger.kernel.org>; Thu, 29 Feb 2024 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709209957; cv=pass; b=tdJZXZJc1JRFB4a+B/++c5KGMIr/7fpZGbpkv+VX+28KpUZsy/qUShdshsYwHvtcupanpUY/Jd2blwfTj1eM0kx/VeoSCWmVLCIocVCvzWGCYNTtlDPoZTL6OoMgBYoVMprHe0Bn1KCZwZqNEZUDgeSQE0sEXe9nnD2dzwgXD0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709209957; c=relaxed/simple;
	bh=44rRbNycm9wIRPkkNt2KkZ9fyckV+TtF72yeuhaQyLk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pL7oZYX3mC8mLbJxiSh8dtPL/R1p9cgqpuKA/r1f8wJHrJNUcs9jPIZcA3xzvcDhXVO3EeemlSxQaB/q2aeKehdXH8DVc5A53LlbvvJWEzmUzcRPUI8B0AutKLiGlCGqDO16b53+AsoO0+QsJe1mxcNeuvZ7+IGFsRaiLFVq/14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 120067A2D8E;
	Thu, 29 Feb 2024 12:24:26 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id EA6D87A273E;
	Thu, 29 Feb 2024 12:24:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1709209465; a=rsa-sha256;
	cv=none;
	b=19c47CYXRA6uHH0IWIEmjvOJNUHM3vDdr7rnEy8New7m77qbhILtdJ2IMXfs/5y5uQKFU5
	5ud1e8FlI7ribSko3ce4LylomvXFKh17J5EJvcNtTgtwQXMpnwH6/fjwfqiNnB94rRM9Oz
	g5f+++6tc+IO/khn9rp3j9hb00EBUJu7J5Hfn5cyl0Sx2/NoPCtDwjKPDZKNP+mBhkpxPd
	Q7w30EYfbwUK86QB1jI1DXuEEUy7GSIvjiAorFO6lt95o0rsQPUoQc9gtk/2ONnfeSEP7P
	BxhtHAIhwFzzbWmasxpSnM4R6IwFYTGqlCXrhbIOOymBKt70nWZ2eSDAz3HbLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1709209465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SDdhr+1zoGmGhhNp3jKPRx5Ys2cI8+euCEGhpwJFB9E=;
	b=KDA7Zm+51+9iChBKvedi+7PgBWuhSs2oJNGwGWQDIgddXFUr7vPNeLF0GKYXscQsnK14ZH
	hBf1gl2XrOsZP98zOrYE6y/s2AMPzTYyeW62GUEEbgzLIhDRHLd6hugeKdnJnvSfHpLwL5
	IbKn4b3PpHOBEpbo5o6HqmDpqanSw5uPn54/kKX29JgLz+wN6WG3llafe8MCBeoYuM7Cov
	sorgzDzzVjH2spIozczFsadUpXHxzG31pxLP0WA1b98cGIZB1+142IzzDY/6BFygp5DG3k
	HK6ifJzM/UbGoBm3uf3cnFLoIo5r2DDATG5B3Jxsu9/+kpQUEEcPce6UKJzyDQ==
ARC-Authentication-Results: i=1;
	rspamd-55b4bfd7cb-9gmpx;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Abiding-Befitting: 29350caa3be5537e_1709209465590_3940638032
X-MC-Loop-Signature: 1709209465590:4289414523
X-MC-Ingress-Time: 1709209465590
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.124.220.170 (trex/6.9.2);
	Thu, 29 Feb 2024 12:24:25 +0000
Received: from p5b0edfc2.dip0.t-ipconnect.de ([91.14.223.194]:43372 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rffSY-0003ah-1T;
	Thu, 29 Feb 2024 12:24:23 +0000
Message-ID: <c9c6b3d32b50694db5639fe26c2651ae49533e48.camel@scientia.org>
Subject: Re: wrong behaviour when unsetting/setting some variables
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org
Date: Thu, 29 Feb 2024 13:24:12 +0100
In-Reply-To: <ac893750-085d-421a-b296-a182ae51f1ec@gigawatt.nl>
References: <43f0631aea36f6b49e5c3dfdfe481a5a2b1fec6c.camel@scientia.org>
	 <ac893750-085d-421a-b296-a182ae51f1ec@gigawatt.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

On Wed, 2024-02-28 at 00:56 +0000, Harald van Dijk wrote:
> However, trying to fix this I come across a corner case where it is
> not=20
> clear to me what the intended behaviour is.
>=20
> =C2=A0=C2=A0 set -a; readonly foo=3Dbar; export # some shells export, not=
 all

As far as I can see, POSIX doesn't seem to be absolutely definite about
this, but personally I'd say the spirit of it is rather that set -a
generally applies, and so foo would be exported.

One might also argue like this:
* -a says "the export attribute shall be set for each variable to which
  an assignment is performed".
* readonly does assign at some point before it returns and at that
  point, the variable obviously cannot be readonly already.
  Only before it returns it's made readonly.

Since -a acts already at the assignment step, it the export is set
before the readonly.

But of course, that's also a lot of reading something into it ;-)


Cheers,
Chris.

