Received: from rusty.tulip.relay.mailchannels.net (rusty.tulip.relay.mailchannels.net [23.83.218.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF13C139
	for <dash@vger.kernel.org>; Tue,  5 Nov 2024 02:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.252
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730772269; cv=pass; b=mCjFEEoVetM8C+mwCYo6cHC7JtaBlbROexI3jq4pYZVjqr0A0LjOoCEkw7nBhtOvv4QbiqCbLwGarFxOk8YQGQ3/vS37XQpbzOFFkzjhY9JeuOo8Q55/9moktC2dcBV3dmlYPKnmWXhAc3343brRv5tsrR15TYyuLN18qWv3Dn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730772269; c=relaxed/simple;
	bh=Lr2KpbP/HoTOot+pADwQeAls3GTrQZeGWZN20nt4240=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=NAdPoKlvMRp+aWhktlfDlWcuv/00cOqPg5NCo5B2dtlMCIEM/feJtcAcANHSzNL+Ef2HdC0e8I4ibLQSqkWyxq6e5qTOuWosyu91udkN1oRkOqJ6fC8v/df/5PsmCOFF60otleLJhoN6lDtoN6qENchG8tOM4fnz0u8LIwbQrlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.218.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8BDD68A3FE2
	for <dash@vger.kernel.org>; Tue,  5 Nov 2024 02:04:19 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-0.trex.outbound.svc.cluster.local [100.103.161.184])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id F403F8A3ED3
	for <dash@vger.kernel.org>; Tue,  5 Nov 2024 02:04:18 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1730772259; a=rsa-sha256;
	cv=none;
	b=LbTjOjrX6G270z15TqSGNSJuLRgmDjzR0fAEOQquWukqqq5zGTudeMkJQFRr281ChNzvIQ
	g+TXoePB8UzYeqJECHhnAY0wU2GXdm4Yzmsdm8h8/dFMr9ETgNiTC10jYZ9kWmw/0wSYfP
	vDdjylwG8ef4JMY6Uwwf+/A+hXQ5eUBp3392oEv8CxBD6JiPD9UNMlJlLLv5Sii0+7yjDo
	oMypNLOQu+jbf7K1hzcdgih/PoPebR1lOtb+JwyXBjxQVBSn8yIA0jGLZ75+AeVN1zOqgC
	F4vuDSbFtkwSDllPhZ447TPygCSN3B1AJYFb6ux4iaN0yn6FlovrlaxIHZiSAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1730772259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qHsDVr0Xkl2r3R5gm4r1fGmmSzTP7wN87dHs1NsFa+U=;
	b=g3YoeJlYmAuX6StY8fT/AbUPwnh2xSQNoNksG7PWSEOX2nMUkaj+J7nj4gZ7UjyXOiullW
	m64lUYMKNJC5Bu2W3/DdDU8qVFMDeptFsWgrHrxqxih8pKMKt1i2M4xlMAq9DgFTL1g4s5
	OIw3qYugf6BA5Qm5wL7dDs3jjXRxia6D746067fip2pECuGzpuyJHcDj0OaghnIxwZkAqD
	/U9FhsJ1MAVVWgBhQTOqhxb8PTewP/URfMvw6Swr8ZHiwxslkkci1Rt+79Suow/wqDdM4x
	zHg0tBKQZvrF4ggpJvJw2Dsx9uICbEo0SPOla5hoJvoTGp0vUoZeprgI2mVGHg==
ARC-Authentication-Results: i=1;
	rspamd-6c6b6c849d-kp5pr;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Belong-Trouble: 610c309a7a7ec4fe_1730772259477_2822385434
X-MC-Loop-Signature: 1730772259477:37565901
X-MC-Ingress-Time: 1730772259477
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.161.184 (trex/7.0.2);
	Tue, 05 Nov 2024 02:04:19 +0000
Received: from p5b0ed864.dip0.t-ipconnect.de ([91.14.216.100]:60427 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <calestyo@scientia.org>)
	id 1t88vZ-00000006HOG-03RL
	for dash@vger.kernel.org;
	Tue, 05 Nov 2024 02:04:17 +0000
Message-ID: <9c85323dbcf182c50cad4063742f4245d94daca8.camel@scientia.org>
Subject: set -e not ignored in AND-OR list
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: dash@vger.kernel.org
Date: Tue, 05 Nov 2024 03:04:16 +0100
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

(With 0.5.12-9 on Debian.)


https://pubs.opengroup.org/onlinepubs/9799919799/utilities/V3_chap02.html#t=
ag_19_26
says for the exceptions of set -e:



>  with the following exceptions:
>=20
> 1. The failure of any individual command in a multi-command pipeline,
> or of any subshell environments in which command substitution was
> performed during word expansion, shall not cause the shell to exit.
> Only the failure of the pipeline itself shall be considered.
> 2. The -e setting shall be ignored when executing the compound list
> following the while, until, if, or elif reserved word, a pipeline
> beginning with the ! reserved word, or any command of an AND-OR list
> other than the last.
> 3. If the exit status of a compound command other than a subshell
> command was the result of a failure while -e was being ignored, then
> -e shall not apply to this command.

Looking at (2):

$ dash; echo shell left
$ set -e; foo() { echo a >&2; false; echo b >&2; }
$ foo | true
a
=3D> expected, no ! before the pipline, so -e is NOT ignored and the
   false in foo() kicks in

$ ! foo | true
a
b
=3D> expected, ! before the pipline, so -e IS ignored and the
   false in foo() kicks NOT in


$ $(foo) | true
a
=3D> expected, no ! before the pipline, so -e is NOT ignored and the
   false in foo() kicks in

$ $(foo) || true
a
$ $(foo) && true
a

=3D> these I don't understand
   it's and AND-OR list, not the last element, so -e should be ignored,
=C2=A0  yet it kicks in at the false


In fact, bash seems to do it right:
$ bash; echo shell left
$ shopt -s inherit_errexit
$ set -e; foo() { echo a >&2; false; echo b >&2; }
$ # (its behaviour is the same for the upper examples)

$ $(foo) || true
a
b
$ $(foo) && true
a
b
$

Neither of the shells exited (no "shell left" printed), which is IMO
also expected

I don't think POSIX' (1) can explain dash's behaviour, as one is only
about not causing the shell to exit (i.e. "after" the pipeline has
finished) - not about ignoring the effects of set -e (like within
foo() )

A bug?


Thanks,
Chris.
