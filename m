Received: from rusty.tulip.relay.mailchannels.net (rusty.tulip.relay.mailchannels.net [23.83.218.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F55A1C5F27
	for <dash@vger.kernel.org>; Wed,  3 Jun 2026 03:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456089; cv=none; b=mxy2U8thHhG2NjWoSvS6rdkPvyTZZxPiOGqz3TfdyNCWWIxeYNQ3WkYkgyVLFo21GeGXJvzNdaWJvCFZRZ3wTXDoO8uj/r9mhFB77GCJVQAJAmQhg1uvO3GzFr80u3LFu9gXEo5bKCCYEeR08sEcgnorYJiUdYvIWED4rQtDK50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456089; c=relaxed/simple;
	bh=mzL6rJOYrIIoNLPOa218RfMP5HaQ40z3dm2iKu4zXlc=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=j+V75yclzyf4Dpssv4QWfomfobBoYHsEvIraxUfpgpycPs4z2tb3C9fgvCcRFakb8tTlCtt/ZZ1qhvgnoBhNgCwkRrxhfxxdSh6HQynzqZNNwpfJDNGn4xVJjA9fXL/+yFtUISqD6ndWq52AQ2SaAuVVw7oUssfTHlhgm31FhAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=none smtp.client-ip=23.83.218.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id F266E3E1D62;
	Wed, 03 Jun 2026 03:02:04 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (100-109-212-93.trex-nlb.outbound.svc.cluster.local [100.109.212.93])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 448CC3E1B0E
	for <dash@vger.kernel.org>; Wed, 03 Jun 2026 03:02:04 +0000 (UTC)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MC-Copy: stored-urls
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Fumbling-Fumbling: 01550899089568a8_1780455724874_3413939711
X-MC-Loop-Signature: 1780455724874:2502655129
X-MC-Ingress-Time: 1780455724874
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.212.93 (trex/7.1.5);
	Wed, 03 Jun 2026 03:02:04 +0000
Received: from [212.104.214.84] (port=56381 helo=[10.2.0.2])
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <calestyo@scientia.org>)
	id 1wUbrl-0000000HEhR-483n
	for dash@vger.kernel.org;
	Wed, 03 Jun 2026 03:02:02 +0000
Message-ID: <2d20377774340d1612d4f3a9243bfefd36afff60.camel@scientia.org>
Subject: bug: in some cases command -v uses relative pathnames than
 absolutes as mandated by POSIX
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: dash@vger.kernel.org
Date: Wed, 03 Jun 2026 05:02:01 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

Hey.

When using command -v command_name POSIX mandates[0] the following
(amongst others):
"Executable utilities, regular built-in utilities, command_names including =
a <slash>
=C2=A0character, and any implementation-provided functions that are found u=
sing the PATH
=C2=A0variable (as described in 2.9.1.4 Command Search and Execution), shal=
l be written
=C2=A0as absolute pathnames."

Now I have a script "foo" in .bin/ :

dash:
$ PATH=3D"./bin/:$PATH"
$ command -v pwg
./bin//pwg
$=20

bash:
$ PATH=3D"./bin/:$PATH"
$ command -v pwg
./bin/pwg
$=20

bash --posix:
$ PATH=3D"./bin/:$PATH"
$ command -v pwg
/home/calestyo/./bin/pwg
$=20

I think POSIX is clear that it should be an absolute pathname. :-)

Cheers,
Chris.

PS: This is forwarded from [1], where I submitted it, so that it
doesn't get forgotten :-)

[0] https://pubs.opengroup.org/onlinepubs/9799919799/utilities/command.html
[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1138732
