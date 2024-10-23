Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DD71DE2AE
	for <dash@vger.kernel.org>; Wed, 23 Oct 2024 19:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.254
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729713397; cv=pass; b=Ww57kUNY42Yt6tlTYcyvs/r63fajpyS73Pg0gOpWnPxNBkxpJKojMtA4wdbtu3jDVQeLj0xNG7HF8EQtd1BSR0hkiHWkEC1vUqJn8ofKMEHqRe8stueTILnAdv5vpgni6C0RiYDHS5bAg9CHAQb46Pr9XapPPj5dhIgFCW+iuIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729713397; c=relaxed/simple;
	bh=2+iBwHZEpbKMDrIzV4MdsN6FZkkZ/OQsu6+2NGbt6nA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=im2JumWUDCiGmfnHX06G28rqIrjIguks6lPPiDp/PVSRaMFRMRiG0U6dmM+tmD2vaBqXBWqFDRwl0iBJ0/XXBnslzauQ8AWyAiJSWnzZZCDvmHBO6Y9qDnCBvTOJGKbgxWEWo8z5enUnrM6aUB5uRLdQ/vIS9UDwQFB+7eTWTnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.218.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 56B601A5C6D
	for <dash@vger.kernel.org>; Wed, 23 Oct 2024 19:56:29 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-6.trex.outbound.svc.cluster.local [100.103.23.198])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id C11881A11B9
	for <dash@vger.kernel.org>; Wed, 23 Oct 2024 19:56:28 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1729713389; a=rsa-sha256;
	cv=none;
	b=MZJVEsNeRQIrcmq1zwevscxxRW+S47ximnGzyEj8FQvIG09yzW29PvENf5vHW35/VWh5h0
	fcm4Fgql+pveUwHwlu+lf8iDVWEbrxRiZ2DMibGAOUDXvr7Lko3vulJAmBWZaJtU1CyC8X
	2dWkheuII30bIscicEQIi/d5WOdcRio343nZIL61Gu1Vu8lrzHJgJjKMWsEiJ+CeThZBbi
	X9Q6ZxCwAHuW/XP/D74PtvScZxha9TUT0Y2ZqiUtPwFTjZRJ0DDOdSgL4C8dcjn+oMlf2x
	mISRalgtUI8asGLKiWPczA3YpeED3pdOIG4888YNJIjhqu72YzbCCtJVKeMLDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1729713389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2+iBwHZEpbKMDrIzV4MdsN6FZkkZ/OQsu6+2NGbt6nA=;
	b=aFMkqH/zVyXO4nJXnXRW6o0aBxZpCpapq4bM3zMAMf5ClnDjcNGiR32ESYQUEbYOo4hAHv
	32P/At0gLdKOg4krBlf9CckRh5Nzyg3gxrB3nvWZbriUfjLnem8tOqD+QgpTLiVTyjeNo0
	1lKzeW3rTG1SeVxNTHZgVqI7QQW97YEX4hxVR9lAVGbkMunGnHiRT2gfYtuVP1/2hsFgXo
	AYGdl6sYdf204zjdL3Os8OUMZw9tubQmrkakPKyA5DplVdUWL9oMKJwHM1WqJXWn9Y9NP0
	ECp0VRXF4u1pCEvtgEZ9J31EcMEnbUdCEipZk5mYT47DAGEFCougmhd3PupL7g==
ARC-Authentication-Results: i=1;
	rspamd-9bc7b7997-f22dl;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Bored-Eight: 44b9aba36ea48e5b_1729713389260_508412577
X-MC-Loop-Signature: 1729713389260:1568417968
X-MC-Ingress-Time: 1729713389259
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.23.198 (trex/7.0.2);
	Wed, 23 Oct 2024 19:56:29 +0000
Received: from p5b0ed864.dip0.t-ipconnect.de ([91.14.216.100]:61565 helo=heisenberg.scientia.org)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <calestyo@scientia.org>)
	id 1t3hT0-000000013cT-37yy
	for dash@vger.kernel.org;
	Wed, 23 Oct 2024 19:56:27 +0000
Received: by heisenberg.scientia.org (Postfix, from userid 1000)
	id 098C627D7EA8; Wed, 23 Oct 2024 21:56:25 +0200 (CEST)
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: dash@vger.kernel.org
Subject: [PATCH 0/1] man: Clarify the `trap` condition `EXIT`
Date: Wed, 23 Oct 2024 21:55:44 +0200
Message-ID: <20241023195623.148722-1-calestyo@scientia.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: calestyo@scientia.org

Hey.

It seems that in dash the meaning of the EXIT condition of trap is only for
"normal" exits from the shell, but not e.g. on SIGINT and the likes.
Unlike e.g. bash, which also executes that trap on such signals (other than
SIGKILL of course).


POSIX allows this https://pubs.opengroup.org/onlinepubs/9799919799/utilities/V3_chap02.html#tag_19_29:
The EXIT condition shall occur when the shell terminates normally (exits), and
may occur when the shell terminates abnormally as a result of delivery of a
signal (other than SIGKILL) whose trap action is the default.

But I think it would make sense to have it documented, especially as even on
SIGINT/etc. the shell does "exit" in the plain meaning of the word.

[If Chet reads along, it might also make sense to document the opposite in
bash.]


Could be as simple as the following patch.


Cheers,
Chris.


