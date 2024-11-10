Received: from slateblue.cherry.relay.mailchannels.net (slateblue.cherry.relay.mailchannels.net [23.83.223.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD3A4B5AE
	for <dash@vger.kernel.org>; Sun, 10 Nov 2024 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731258993; cv=pass; b=I4FRThYkKCy0oTTv6g8uXBbAPwrLB07x7zluMebYpEx6312zKw/T//RkLQmSQF139XiaAc6QlHOF7yM/gX3Sy+snNV6jdszMgsUqTdvCRe2ayqe6J93W2XSUxAstuZAUZHBKLz0a2KYWStLfl3u7dCCC/MSMG/iy7cZmY02EfJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731258993; c=relaxed/simple;
	bh=wS9KqqtYoqsXpKfBp5hF4UNRRX4R3IZhPSxYUic45HA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jvvfh51Fw4hRiAPTLl6r26A2HGxfy+1K4mZr5hP6FEpA7L4BUzqs40SA3DHyoLkfISbMnfEMSoZMl6UmKkr8lKu7a4yPF7e1cx9Dl2Sp6L+K3+PIzQjk4hsjSw8z5KtWEv3h4E1Z6cytPCt6Hrt1vaFw5OgpxvmGtrrak+pQVIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.223.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9559F8A43B4;
	Sun, 10 Nov 2024 16:40:26 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-4.trex.outbound.svc.cluster.local [100.111.109.20])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id CD48D8A3D88;
	Sun, 10 Nov 2024 16:40:25 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1731256826; a=rsa-sha256;
	cv=none;
	b=d4Pcq6yP8zEVpiHGHcS/8x/0Qss+Cafk2Q+YW68Z1TNPM9qq568/qrl+Ax4bPIZXlG5S13
	KAcEfU9MZVNkkU5S6+W0ylQzh4BD64kSViJKVjYd8tdIQOjtdvB7k+JL9wSBUa6OydW3Dj
	uy80jlro/K+vebBHJSJFJOzQO0PXB/Mg6EUdoo6PoVjuPGjer3Y16CjvSQ3bVwBCq587Oz
	hdIdo0xkIWnTFtgtHEg1pFJmzLucjvBiO7VKdIWfWKjsTtGjGJWHuV//oUraGqD+MGuykY
	ipO+c3AacyQ+NIkLr/W3t6VzoTNY339t6fDY5hrNSRzvl35wfZNsiVaC+spg3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1731256826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+X5oz6K9ZX2sy02f12lhQFVBuaw8D9tCBavX3G3OlP0=;
	b=805K3EC0Ta3CIH601q/oZkc7upS984bbTt1w/kXcSXPt3HG6bozwuhMP/rvZvpOCTRJxVL
	9zQypZPRyE4rEeoXGuhhI/AEYmeMljgzLEoYaBIi1aRxNL04Z24ONEch8HH/8oh8aucaZM
	LkvCFHQEFchJy4s6G6I3X4fJHlm79spNI+y2lXXJ6zvPnmeJ0Jr/W8nGc2eUN1HBMZmmAW
	+xXPZT226pf5v+gqPPOnhJo/od2IDnwl/KEfy3cDoES6W7nz7pTL/zqRPGCopxYGdeJfB8
	ldTn4DDWv8PHXtlqYGXaES0A9+8qWO9MkIFI76PFhANxBDeeC52ifPd76LlZhA==
ARC-Authentication-Results: i=1;
	rspamd-5b688f746d-t68jp;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Inform-Irritate: 7952b6270b11af78_1731256826468_425063415
X-MC-Loop-Signature: 1731256826468:69576100
X-MC-Ingress-Time: 1731256826467
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.111.109.20 (trex/7.0.2);
	Sun, 10 Nov 2024 16:40:26 +0000
Received: from p5b0ed864.dip0.t-ipconnect.de ([91.14.216.100]:62522 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <calestyo@scientia.org>)
	id 1tAAzA-00000005evN-05Oo;
	Sun, 10 Nov 2024 16:40:24 +0000
Message-ID: <343abc303a3ba27fa373c63542f411f282a12b87.camel@scientia.org>
Subject: Re: set -e not ignored in AND-OR list
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Lawrence =?ISO-8859-1?Q?Vel=E1zquez?= <vq@larryv.me>
Cc: dash@vger.kernel.org
Date: Sun, 10 Nov 2024 17:40:23 +0100
In-Reply-To: <437c27e2-4877-4c9c-9cfb-5167423a8b44@app.fastmail.com>
References: <ZzAyYf1ZWcSuPVJZ@gondor.apana.org.au>
	 <b16286957f9b3d6409423b3b9b54c84c1c64fcb2.camel@scientia.org>
	 <437c27e2-4877-4c9c-9cfb-5167423a8b44@app.fastmail.com>
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

On Sun, 2024-11-10 at 02:38 -0500, Lawrence Vel=C3=A1zquez wrote:
> On Sun, Nov 10, 2024, at 1:08 AM, Christoph Anton Mitterer wrote:
> > I know that bash ignores set -e per default in the standard (which
> > I
> > think is however NOT POSIX compliant either), e.g.
> >=20
> > bash without --posix:
> > $ set -e=20
> > $ echo "$(echo a; false; echo b)"
> > a
> > b
> > $
>=20
> Bash does NOT ignore "set -e" here; it just sets "set +e" in the
> command substitution subshell.

My wording was bad,... with "ignore" at that point (in the non --posix
example) I mean what you said, i.e. that it clears the flag again as
also described in its manpage.

My examples were bad, too, as I forgot to add the "ignoring" context,
as you already did with your second example.

But even without explicitly re-setting -e inside the command
substitution, though in --posix mode:

bash --posix
bash-5.2$ set -e
bash-5.2$  echo "$(echo $-; false; echo b)" || :
ehimBHs
b
$

So it keeps -e (in --posix) AND ignores it (because of the || : ), as
IMO mandated by POSIX.


Cheers,
Chris

