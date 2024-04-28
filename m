Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF8A64A
	for <dash@vger.kernel.org>; Sun, 28 Apr 2024 01:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.248
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714267188; cv=pass; b=eakwVIJolA3OO7n+Ql0+u7V06DAMwKBPeIecFcd6ndlN9XDsYGloPFQReXE0LR/5yjBffASKu28E+ViU9p6LrSs35mIe4QPnZbJLJoM1SVGV+R/CSTr4PixsrOjF6u2O2dUEnbpBr6BY7ACvYbGeRMtby73P+vrQpgg+6wRFrTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714267188; c=relaxed/simple;
	bh=RsVHfZIqCOcE54Ow2qyloU4Z7lY+n+9ojb9CjqTOiF4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y2eiM8eq9MPyh0GlM1KSA5AKOh4f3Eo4cGSj8tfDlxPMRf2KgY66TcbaHXX/hE2nbMx2FGTCpC8WA8nWSZakQPF9dZMkl+8wEP24XYtjYtBXHNn1ZXf5yAAuiGWFZQLqOAobYHYuD0zcc0uI2y94ivpd0xeN7NBsMYopiQ4fmo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9E6A88229B;
	Sun, 28 Apr 2024 01:19:42 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id C006081CA6;
	Sun, 28 Apr 2024 01:19:41 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1714267182; a=rsa-sha256;
	cv=none;
	b=lMWlw21WGOCHvMGU1a8+xwf3hGHLJdh2Czy7/q2iy07xMIF7z4Q2S00G3WtPg/YqzSaEtl
	j7dIAbCM4LeAz5o84sDWt232LVvLG7UejmNG49lW7+PmoRPkzeGqt6EL5xoXQDIxgt0dh0
	VwjSAQKIfqmrT6H6O8C5Sywj1Yf6LaCvq6R+LsPhBtxYYDkvqjIiUsj7Ee7j5qLxgnA6rU
	OGevJAaPGTCnwkambCI0wTBT75Sh5ayGI9tbyC6jHEfwPACn0PO9fAFOzeQeN+WxVcUZgg
	5QpUNFfViQG++jWibGwyZ0LiV/q67avg4R8t9rOpc3o6jag9gylMrp6X0wXzzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1714267182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RsVHfZIqCOcE54Ow2qyloU4Z7lY+n+9ojb9CjqTOiF4=;
	b=Z/3gRfznj1HbTCRHGeRcgzrfZ38516V7BPALbJBOydA0OZITsiFPhG5Kbf27E+3O6hqLl7
	63Nfn6iKrLxoFArdAPeNw5P2a7cwDWSi0ac9QykWLZSaeJWYvQIvJb194/qICvnwmd/9Mj
	ouyz2oqxQnXsh3N0fpsB32SDHuXcDSbgC0DyOkx9r36jBd2zhhy7rc2kwmqptvr1guNihA
	9dg+lnO+3jeU7bTFUChLAmTkonEv0JCo7Lhqj5maBXr62N7+8fH8nx29KuStKBaCbzUvzE
	HFxNI4y8rW1uxtHC0uAnnTj6y/AY3zvNe5Lf46xcw0InV4mWQOBl0q74NpCuNg==
ARC-Authentication-Results: i=1;
	rspamd-67db6f49c6-m7t9r;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Exultant-Shoe: 68a4b98978af765e_1714267182412_2446542397
X-MC-Loop-Signature: 1714267182412:2082074097
X-MC-Ingress-Time: 1714267182412
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.119.153.252 (trex/6.9.2);
	Sun, 28 Apr 2024 01:19:42 +0000
Received: from p54b6d4bd.dip0.t-ipconnect.de ([84.182.212.189]:60670 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <calestyo@scientia.org>)
	id 1s0tCd-009qBL-1o;
	Sun, 28 Apr 2024 01:19:40 +0000
Message-ID: <e2d1d076a3a3d7f21bdb64b13cf9c4c3f4967bb2.camel@scientia.org>
Subject: Re: [PATCH 0/8] Add multi-byte support
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: DASH Mailing List <dash@vger.kernel.org>
Date: Sun, 28 Apr 2024 03:19:34 +0200
In-Reply-To: <Zi2dIJQcNVwJgxuN@gondor.apana.org.au>
References: <cover.1714215826.git.herbert@gondor.apana.org.au>
	 <eb927eeff3d1da7406c998d0ce816d3b6a061fc7.camel@scientia.org>
	 <Zi2dIJQcNVwJgxuN@gondor.apana.org.au>
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

On Sun, 2024-04-28 at 08:49 +0800, Herbert Xu wrote:
>=20
> Are you talking about a theoretical undefined condition, or an
> actual one?=C2=A0 Which shell doesn't deal with ${foo%.} correctly?

Well my main point for this mail was how dash does it (and not just
about '.').
I guess it simply resorts to fnmatch(3) so it will probably do whatever
the system's libc does?

But it's really not just about '.' (which is more or less a rather safe
case).
If someone assumes dash would always be LC_ALL=3DC, that any such
operation where e.g. a byte is used that is part of a multi-byte
character might, AFAIU, lead to unexpected results.
E.g. an fnmatch implementation may just decide to stop and give an
error at the first byte that's not a valid characters, right?

Also there were some locales like Big5, which had the weird property of
having multibyte chars that contain byte sequences that form other
valid chars (see=C2=A0[0]).
Not sure if I remember that correctly, but it might have been undefined
when stripping of the "shorter" character from that.
Which again, couldn't have happened so far in dash, as it simply was C
local only.


Harald van Dijk made some extensive tests back then, how different
shells behave.
I think the austrin-group-l mailing list archive is not publicly
available, but if you have an account it was in that mail:
https://collaboration.opengroup.org/operational/mailarch.php?soph=3DN&actio=
n=3Dshow&archive=3Daustin-group-l&num=3D34339&limit=3D100&offset=3D0
which showed that shells do indeed behave differently (the tests
weren't for '.').


Cheers,
Chris.

[0] https://unix.stackexchange.com/questions/383217/shell-keep-trailing-new=
lines-n-in-command-substitution/383411#383411
