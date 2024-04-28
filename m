Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED7E3E494
	for <dash@vger.kernel.org>; Sun, 28 Apr 2024 06:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.254
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714286207; cv=pass; b=nfMbFPknGQM5bwP6QX5md+0gSasV1Rh+LyM3riDeaOAXiGmwuC34g9snnQnUlCxviDoZxmN+E8w+XYvfGnwaQhwMCvIOG4+lFdu3MyrZUtFW7Df5cHDB8QyrqMJOYBicWY7N9st6lNrYsewcfuF7YndQxDa0mHofDC/cyRSkAnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714286207; c=relaxed/simple;
	bh=HFCtydu9HY8d0Cm+zkxOOpj8BAKmG9xCFA8Y4CW5x1U=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V1MGo4TdV4APjnGEH69GN3YHNXU0Genjp263qAG+bInp86MSkr5EaIxhSAg0jp90p6cgh1/btvnCQMberCBsT9zoIPjzY+eT9iJZVLEbo8xmL/RBid/3UpAg/GvQPzcTZk4w+sKjgE9eeKbytNhhu8Gf+jn82EmRHvH5tGRN+pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.218.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 365949016C1
	for <dash@vger.kernel.org>; Sun, 28 Apr 2024 02:03:30 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 8EC4C901139
	for <dash@vger.kernel.org>; Sun, 28 Apr 2024 02:03:29 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1714269809; a=rsa-sha256;
	cv=none;
	b=SRrzi3IIoeHlxfO9PaG7ybLwLpDc7eKH4lDQ7+PRqRVve4EOpx7g2XV2enzljzVfLNvjSt
	MTqdYp/VUW6uPLqJ6/MMZagzwHgVH5j5Y8u2fWjg2KqsNvB+H87uJ+8V1sR6m5lRH30ZPQ
	adPVD0BsXG8yE7uIJzwaQLoCJZC1VHQ/tjPZUIA3OH++zcJuL6G2IrGASeq8FMPhioqkwg
	PUJ4XHb2oosNm7ZhG0IJOlxHLCMsRZJhArdC9z9WpbEnDOy8JU4ETZthbX4HwC565pp1RK
	4IgUgJkzw2br7Uu/2K2yNjzor3PG2c+ZLTzJY7Jhs1AKn34Nvlg0otlVELI6jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1714269809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rheMmOTuAyvvzsnRV/bInab/hLYG5GwHPoGO5UNsyVA=;
	b=lbq7TnmD4yhx+/Zm4WlFVlEccPgp/171xbR1pOTmJ/kPkFk6c8h+E4QgTTFKW9gFJeZdS5
	XoycdZIw/o+lauuQfoxjBj12aZ91tuyVmvBsLUvz7u/fGPttjmB4xDVfTY/gea+dp1C+ZF
	OLTLP6tiW3TQlF1tHVPrO06rUOUVH2uHmSj1T96twOG59yEP40Fm83FAYHKaSR/WJulkWw
	iYpks2QR4wcHvo5/ufdwMF58Z94jNigwACoBXXBTtONELOUASBzeGGcoMM1KqjLAgNxI6b
	QsCLW878iQGOkGmVzkIza/7k87opyrGaADqYXeoXFEVbSq+excPBdI2/z+aEHw==
ARC-Authentication-Results: i=1;
	rspamd-67db6f49c6-m7t9r;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Descriptive-Callous: 7c0053b37d30ab19_1714269810083_3971431341
X-MC-Loop-Signature: 1714269810082:328302903
X-MC-Ingress-Time: 1714269810082
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.124.116.18 (trex/6.9.2);
	Sun, 28 Apr 2024 02:03:30 +0000
Received: from p54b6d4bd.dip0.t-ipconnect.de ([84.182.212.189]:37046 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <calestyo@scientia.org>)
	id 1s0tt1-00A0z4-2p
	for dash@vger.kernel.org;
	Sun, 28 Apr 2024 02:03:28 +0000
Message-ID: <6a3890716ea21c010fde3c422e7141dd43d4fd62.camel@scientia.org>
Subject: Re: [PATCH 0/8] Add multi-byte support
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: DASH Mailing List <dash@vger.kernel.org>
Date: Sun, 28 Apr 2024 04:03:23 +0200
In-Reply-To: <e2d1d076a3a3d7f21bdb64b13cf9c4c3f4967bb2.camel@scientia.org>
References: <cover.1714215826.git.herbert@gondor.apana.org.au>
	 <eb927eeff3d1da7406c998d0ce816d3b6a061fc7.camel@scientia.org>
	 <Zi2dIJQcNVwJgxuN@gondor.apana.org.au>
	 <e2d1d076a3a3d7f21bdb64b13cf9c4c3f4967bb2.camel@scientia.org>
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

Just to give a simple example:

x.sh:
   char=3D=C3=A4
   printf '%s' "$char" | hd
  =20
   byte=3D"$( printf '\244' )"
   printf '%s' "$byte" | hd
  =20
   printf '%s' "${char%$byte}" | hd


$ LC_ALL=3Den_US.UTF-8 bash x.sh=20
00000000  c3 a4                                             |..|
00000002
00000000  a4                                                |.|
00000001
00000000  c3                                                |.|
00000001
$ LC_ALL=3DC bash x.sh=20
00000000  c3 a4                                             |..|
00000002
00000000  a4                                                |.|
00000001
00000000  c3                                                |.|
00000001

$ dash x.sh=20
00000000  c3 a4                                             |..|
00000002
00000000  a4                                                |.|
00000001
00000000  c3                                                |.|
00000001

but:

$ LC_ALL=3Den_US.UTF-8 zsh x.sh=20
00000000  c3 a4                                             |..|
00000002
00000000  a4                                                |.|
00000001
00000000  c3 a4                                             |..|
00000002
$ LC_ALL=3DC zsh x.sh=20
00000000  c3 a4                                             |..|
00000002
00000000  a4                                                |.|
00000001
00000000  c3                                                |.|
00000001


Again, not saying that this means dash shouldn't support other
locales... but people may (of course wrongly) rely on the behaviour
that dash is always in the C locale.

Even if that doesn't change right now with the fnmatch()
implementation, it could in principle do so with any change there.


Ceers,
Chris.
