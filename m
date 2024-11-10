Received: from silver.cherry.relay.mailchannels.net (silver.cherry.relay.mailchannels.net [23.83.223.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A438A40BF5
	for <dash@vger.kernel.org>; Sun, 10 Nov 2024 17:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.83.223.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731259757; cv=fail; b=ZTLMYkkjfSj/7w4HuWYC2NvVyie/rSgiS3jI/WhUtCbSBxZDSAGIS5F/3lfGIk/cbfgDn2Lp6EVrYv3z7Gsw0QmeD4ocs+LeJ73ZGXzF0tY8Fz2rlaH96iFuKx0XuzivBzhKPLVuEUEt/IPFQFaFqSldXhmhtNtkj4U3+3Vagfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731259757; c=relaxed/simple;
	bh=ehhZw5OjIqFRNokBKVep5Z+mJM9W3HpOnWkm0mOBN88=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mcx8gtfZNjNXl8pk6CyB9XUU3kFCACW1ebYUFUKysN0mwIkSxxzEvzlsLoJU54APXl2znB+8NZk2xzBvgMXUU2TAPOadAH9pZ/6BWCWz/09V4xrZoNVWTz71k6IJbS2i6gHCcG0T2E8D8X53gRjRIKDygcDMYD45/P2ygXm3z0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=fail smtp.client-ip=23.83.223.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id AA0A622944;
	Sun, 10 Nov 2024 16:52:25 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-9.trex.outbound.svc.cluster.local [100.111.97.42])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id C1A9D23A03;
	Sun, 10 Nov 2024 16:52:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1731257545; a=rsa-sha256;
	cv=none;
	b=kO6r3/7LdICfLNCTDsl2oW9UWC/1f8yezK+9kfeNQpuSzzvVNdAmGA3ilMe/yisBUTm9Uh
	KYzq1mvhG5ErN363J0Z8FOQr80tcqEBOkhCK2lDtvQ8SGcfWZ3jO7Mqe8Q+SMSHWwUJzBN
	r//n9loWDU8xzM264wJzUwBOblmtkKtfKEfFPvxRRWOB00zbvbZ8RDUQRnXocyKRR6l76G
	E0TVG2GFZTsRbT9GzEirr7JH0JsaxZ3fiViczh1ybPc8FTakQ62xL8oWgDGRFrO7+hC9RP
	z441ioq1VhH7eWejJi3lHNQtSWV/bbboWI2bXgKsNH/GCEwH2zO0DyHVO0sr/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1731257545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/lEjSOzGgCGrh+12T5rVCsZxK3wvaVv8wIW3+v5JhU4=;
	b=PsH3UCPb8MWQMu7oG+/L//Vgx5dcVF+LKYUTdlTmdelqycE4Ry1+Ft1fdgAR1PMtrmTPp7
	alz66zxIUe84aE3AMOdtRLr2DeiqMYnU3zc36ZWVkU2NnVQ4wieHIy3YQnJIMMN0TZAb96
	htI6RNJnXKnHXZCxYfjOXnak6ntoyi7pdjvTtedxff3HADqCj50tHhUuUyleg1tVKalpaw
	q4AZTvEc0QyfRpE2wEUlS8zq/5GoPyDNxDwojrwoUL47/fIXHWTswuFR1QbbBHYFsIMf+A
	Ga/3Ayk5bTe9McsleNE+Xe9yb5C2b+RWZGsTj+OQ7Bg0NTHPWRYvrLfN4iepIg==
ARC-Authentication-Results: i=1;
	rspamd-5b688f746d-rjj25;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Turn-Supply: 2b14c2a325a8fc23_1731257545559_2932768158
X-MC-Loop-Signature: 1731257545559:1704664275
X-MC-Ingress-Time: 1731257545558
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.111.97.42 (trex/7.0.2);
	Sun, 10 Nov 2024 16:52:25 +0000
Received: from p5b0ed864.dip0.t-ipconnect.de ([91.14.216.100]:61233 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <calestyo@scientia.org>)
	id 1tABAk-00000005kG4-3v4w;
	Sun, 10 Nov 2024 16:52:23 +0000
Message-ID: <85df2488f78032cfb64acc98ec2c483bc1fb03e5.camel@scientia.org>
Subject: Re: set -e not ignored in AND-OR list
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Harald van Dijk <harald@gigawatt.nl>, Herbert Xu
	 <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org
Date: Sun, 10 Nov 2024 17:52:21 +0100
In-Reply-To: <6496f8a6-bf07-4c4c-bbb6-3ce42dc378bd@gigawatt.nl>
References: <ZzAyYf1ZWcSuPVJZ@gondor.apana.org.au>
	 <b16286957f9b3d6409423b3b9b54c84c1c64fcb2.camel@scientia.org>
	 <6496f8a6-bf07-4c4c-bbb6-3ce42dc378bd@gigawatt.nl>
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

Hey Harald.

On Sun, 2024-11-10 at 10:04 +0000, Harald van Dijk wrote:
> I think you're right that POSIX specifies the behaviour.

Herbert still said it (I presume the ignoring of set -e) would not
apply to command substitution subshells, though I haven't found
anything yet, which would mandate this.


> The reason why bash by default behaves contrary to what POSIX
> specifies=20
> is that what POSIX specifies is not useful. In command substitutions,
> ignoring set -e in the way that you are asking for is even less
> useful.

You mean now with respect to "inheriting" -e, right? Not with respect
to ignoring -e (because there it seems to behave as POSIX says).


> Ignore what POSIX specifies for a moment. Is there any situation
> where=20
> the behaviour you are asking for is what someone who writes 'set -e'=20
> would want?

I haven't asked for it ;-) ... merely pointed out that it might
contradict POSIX.

Actually, there's IMO no case were it makes much sense to ignore set -e
... not even in the first command list of an if/etc. ... because if
that e.g. calls a function, the function may depend on it exiting in a
set -e case, and no just keep going.


>  Is there a real use case that would be helped by making this=20
> change? If there is, I am not seeing it.

If Herbert is right and POSIX allows for this, it should IMO still
explicitly be documented in the manpage (probably at both, set -e and
command substitution documntation ).

If POSIX would forbid it, but dash would still keep it, it should
perhaps additionally be documented in some POSIX-incompatibilites
section?

Reasons for changing the behaviour could be:
- breaking software that already depend on the behaviour ;-)
- being in line (and thus especially *portable*) with what POSIX says
  (which is might also be used as kind of a documentation an thus
  people could blindly assume the behaviour).
- behaving more similar to bash (which is of course no must, but surely
  not bad either).


If it's however long standing behaviour of dash (and perhaps others),
maybe POSIX should instead be revised.


Cheers,
Chris.
