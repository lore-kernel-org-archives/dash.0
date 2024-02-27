Received: from weasel.tulip.relay.mailchannels.net (weasel.tulip.relay.mailchannels.net [23.83.218.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0DFF9D6
	for <dash@vger.kernel.org>; Tue, 27 Feb 2024 02:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.247
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000222; cv=pass; b=Oq4T2mSUImg4/OzlCI8aF/SxbAeqYTyszSjlrhBHzH+9fYQ+XQ3wDSGrt0y1rIWi/qSW+QuRLa1soQcpu6ejTtdXG7jqhPzYZ5bmleGjNEW/m7WZuCH8SpcQbe4/W015p3DlvjWNs9VRFig43m57b3Nk6bj5jb6QuKjyLxG9l6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000222; c=relaxed/simple;
	bh=VQYzFTPqCcQryKUzLA+sfwI5UdgV5ysc4zvXb0cQliQ=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=VpfKovwok9WgZBxCP6TrnEKtIPpAZiXpaIbXpyeV7tfj6F4dLhqryZUsnvW6oZ6NL0zFLZ4W1WqT87aF54xUjxSNVIIfcKxBXcnekcj1ztVOkkUlSn/aAisIScyjVmgATJUFHl3Pq5DnlQVJLkHZ1pXT3T06X6okrHJh2ES5o/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.218.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9882F824AD
	for <dash@vger.kernel.org>; Tue, 27 Feb 2024 02:07:42 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id BCE5782977
	for <dash@vger.kernel.org>; Tue, 27 Feb 2024 02:07:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1708999661; a=rsa-sha256;
	cv=none;
	b=3sRujgr8iElfCwSkfAynkQuKH1vAblWiGWs+9mNuANwr9DRZRPzd87JzUVECGE2VU5sIyZ
	nChtZSoD2KmAz+6pWV12w5ICuDdlq08xXOhKAG2ABcbhf7/+0pAJfm2SA74TMIxdmvom/5
	UjfhmWfEkKUlirgxKPLlAE+jvA17ndW0Dc0+SMBwoS9Ewnyl6BKD6qMy8oaS4Eaqu7X1tj
	FEuoQn37KXSJWf4y61X5JX6fMKMFfNABQ9ajKM3ZGNXdd3y50tzT1Ml4TEEXNCTiCOgqXC
	pYv99KZvZN9PGIgF/SXj9FTr76kOJZCQxTFyzjzkOo/3+rB62Vu9jK9PN/N7AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1708999661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lJz9HeLA+9xwu/0zHaxu0qsHj/W9GHi/679ZLqKaOM0=;
	b=PVuEwz94QcL4lovUQSl+UCFTQS+Aq37GW9ELCz7kOTk8bAjKiiPDGugUy1S7Q2sp50Dfmy
	H+ESLg6tk+jcwPm02I6cHA07uGF6da+042Q4LpAnzfpfrD8vHUKUKDSn7uPbRnrpgtERtv
	Hvfhva+Z4tNjWHp+9CYBRFhn2BxJj+Cv9IF2aGm1LlgNBTrfHK90oXSNjCyMeB0WvIR4vQ
	bzf573+SnwBVCjz8jQcfizcAwR5dXyr+/61195cvkV2KEg4lWomCP0YaSMtsapiKr0POnC
	+Zghg1roYer1T/SYDDHK1bRs8UEVAD6yXKt3JR3v7LM0d2o/vwrbE7xv3nzuDg==
ARC-Authentication-Results: i=1;
	rspamd-7f9dd9fb96-s8scj;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Spot-Zesty: 164c427a59c4b34e_1708999661265_149537058
X-MC-Loop-Signature: 1708999661265:4112042609
X-MC-Ingress-Time: 1708999661264
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.119.153.122 (trex/6.9.2);
	Tue, 27 Feb 2024 02:07:41 +0000
Received: from p5b0edc93.dip0.t-ipconnect.de ([91.14.220.147]:45096 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1remsa-0000Qn-0V
	for dash@vger.kernel.org;
	Tue, 27 Feb 2024 02:07:39 +0000
Message-ID: <43f0631aea36f6b49e5c3dfdfe481a5a2b1fec6c.camel@scientia.org>
Subject: wrong behaviour when unsetting/setting some variables
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: dash@vger.kernel.org
Date: Tue, 27 Feb 2024 03:07:33 +0100
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

Hey.

Forwarding this from my report (for the records) at:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1064874


POSIX describes[0] unset to:
> unset values and attributes of variables and functions

While the exact detials are perhaps a bit unclear (see the discussion
at [1], I
think it is rather clear that unset, on a variable that has no readonly
attribute,
shall case the variable/value binding AND any attributes to be unset.


This works as expected in dash for most variables, but not some, e.g.:
$ env -i dash
$ export
export PWD=3D'/home/calestyo'
$ export MAIL
$ export
export MAIL
export PWD=3D'/home/calestyo'
$ unset -v MAIL
$ export
export MAIL
export PWD=3D'/home/calestyo'
$=20

Same for MAILPATH and PATH, which made me believe it's perhaps an issue
in `changemail` and `changepath` as given in the struct `varinit` in
src/var.c.
But it also happens with IFS, PS1, PS2 and PS4, which have no function
listed there.
OTOH, it doesn=E2=80=99t happen with ATTY, TERM, LINENO and HISTSIZE.

The consequence of that is at least, that one has no chance to fully
unset these
variables, and even if they loose their value, they=E2=80=99ll be exported =
to
executed
commands, possibly altering their behaviour.


I think a similar problem exists when using local variables, but there
it's even
worse as it seems to affect any variable names:
```
f()
{
	export
	echo
=09
	local FOO=3Dv
	export FOO
	export
	echo
=09
	unset -v FOO
	export
}

f
```
gives:
```
export PWD=3D'/home/calestyo'

export FOO=3D'v'
export PWD=3D'/home/calestyo'

export FOO
export PWD=3D'/home/calestyo'

```
and presumaby that `FOO` would then be exported to executed commands.


Cheers,
Chris.


[0]
https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#u=
nset
[1] https://austingroupbugs.net/view.php?id=3D1806

