Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774D1167D80
	for <dash@vger.kernel.org>; Thu, 24 Oct 2024 23:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729814390; cv=pass; b=P/jRaw4amB2R43JY+QBf1W4aDYR+xG+mgUHOAUP11xR0AY29k6fOxrQaMGji9Z78Q5z/T2yIbRRdykvQWUvHonMlFckIkCT+HkXVrJokqb7DxZHoByUAeZcRMLTCJklnHnZ1sCBPgPgwuABqPYxh9JGJnx1K5g9Vr/ghpVqhr3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729814390; c=relaxed/simple;
	bh=tmFuWYXZA4LkYbMHNzHjlqe6Ny+PGidT5LQNDWO4w+U=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=QNTgETHDwRv2aWlCBLxmBRJ5YXHgYwTwfcFAji3NiM+lBvc8OXNvX6jH6tBdKWKuylOHhxbso1A0M9zq5Z7HTYd0FSAK4vq7/6K27D3/PNGGEcrFkW6tb6pj5RrRYK0RYG43N1TsXle6PmkrdUUYXFbZlVNHESGSmUfhYckAd6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.212.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id BF499904657
	for <dash@vger.kernel.org>; Thu, 24 Oct 2024 23:51:31 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-6.trex.outbound.svc.cluster.local [100.103.23.198])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 0B2E59018D6
	for <dash@vger.kernel.org>; Thu, 24 Oct 2024 23:51:30 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1729813891; a=rsa-sha256;
	cv=none;
	b=QFNtNG5aav5tywzSAFN5EWoVGTuW3XdMhW+PbPluiM7hheLzm1UtMEM0Az5nneBAbrDu0A
	kPTQeFye7w1AMPNw8MtVyNDrYabRda3nnzTK9PYRdM/b3xh8GqJ5Hj/lKa7w8h4RtxBuq8
	mH1dEdkYC3BI4eP21oISh9IpCXwCByo+jzoCrU6+Krw4W7MRqVSAIlV/qC3xdHu9TO/Ubs
	V859nMejSAJDczAvkvE52l/GOJRFmP3Nc45U1IY0J/GI7HwddpXjvB+kZNwhURD6dX4ZzS
	PWfjlopAImR+R+frxxVBJOtZEyy+l8mwE56pi1rChvCiNqllwM3eV8ZH+vyxYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1729813891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yn6WgGZtCt/5NoGkJoj6yN1cG+Sx2K11UEymhEzjnMk=;
	b=DMvE0BxdsCFoxtxIf6+yJ5myweEEkQl0T9gIoNx162B1m7Faaw/RKlDQR9sLFJ1Wrq565z
	bROsQZbRlEr5js9EPJXHm/E8zbfVYcH9nMvGL1x6Rim5HoS6G5UYdbpcJq0NTnIz/4ZqhJ
	VtZIbSeCkMK46XnNppJ4y+Jc2AS/J7z6gU1vLHip57WVo6FZqnKFknchnBCB56d/F+UIyd
	ioTHKURRgDLN6OgRsfAAQBim6yKysPNaddM5hmyxpWiljVPd6VAhoOBHbUq9eJ5Wxanha2
	VyZULVXBWBjwR81sL5yfqpVn+bica9s74J97HqzTBlG7r3wB/vqBfe4kmUh1qg==
ARC-Authentication-Results: i=1;
	rspamd-78ff97654b-pd9rz;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Relation-Chemical: 3d0f08373f36b5c4_1729813891516_4223042982
X-MC-Loop-Signature: 1729813891516:839229446
X-MC-Ingress-Time: 1729813891516
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.23.198 (trex/7.0.2);
	Thu, 24 Oct 2024 23:51:31 +0000
Received: from p57b04520.dip0.t-ipconnect.de ([87.176.69.32]:59320 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <calestyo@scientia.org>)
	id 1t47c3-000000098JY-0Lfj
	for dash@vger.kernel.org;
	Thu, 24 Oct 2024 23:51:29 +0000
Message-ID: <5e867ba59bb7fb8fd08a28f654658d0e3958942c.camel@scientia.org>
Subject: exit in traps
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: dash@vger.kernel.org
Date: Fri, 25 Oct 2024 01:51:28 +0200
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

Not sure whether this is a bug:
   #!/bin/sh
  =20
   #trap -- "echo EXIT" EXIT
   trap -- 'echo $?; echo INT; exit' INT
  =20
   foo=3D$(exit 44)
   read -r tmp

Running that and <Ctrl-C>ing at the read prompt:
$ dash x.sh ; echo $?
^C1
INT
1
$=20

$ bash x.sh ; echo $?
^C44
INT
0
$=20


First, shouldn=E2=80=99t dash=E2=80=99s echo $? give 44, like bash=E2=80=99=
s does? The most
recent pipeline is foo=3D$(exit 44), as the read hasn't completed yet, so
$? should be 44.


Second, for the final exit state:
POSIX says[0] for `exit`:
> If n is not specified, the result shall be as if n were specified
> with the current value of the special parameter '?' (see 2.5.2
> Special Parameters ), except that if the exit command would cause the
> end of execution of a trap action, the value for the special
> parameter '?' that is considered "current" shall be the value it had
> immediately preceding the trap action.

I'd read that as if a blank `exit` in a trap action (but only one that
actually causes the trap to end (i.e. not something like $(exit) ),
should cause an overall exit status of 44 here, too.

Both, dash and bash would do that wrong.


If one uncomments the trap on EXIT:
$ dash x.sh ; echo $?
^C1
INT
EXIT
1

Which I don't understand either.
IMO the INT trap should need to end with 44 here (but only because of
the literal exit - I think it should rather end with 0 if there were
not exit in it).
But then, dash executes the EXIT action, and in that the original $?
should be 44, too, (from the INT action=E2=80=99s exit, not directly from
outside the trap actions) but why does the shell end with 1? Shouldn't
it be 0 because of echo EXIT?


Thanks,
Chris.


[0] https://pubs.opengroup.org/onlinepubs/9799919799/utilities/V3_chap02.ht=
ml#tag_19_22
