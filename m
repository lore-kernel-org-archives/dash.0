Received: from chocolate.ash.relay.mailchannels.net (chocolate.ash.relay.mailchannels.net [23.83.222.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E012D879E
	for <dash@vger.kernel.org>; Sat, 25 Apr 2026 21:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777152289; cv=pass; b=M+q9I0N6BwJLOoJov9s4lvuKN5WOCW3kuuQh/jio1yLfiNOvbj1xYuQueRYetY9OmtuOEYgdfP1RrSw0TP3B8FDfGirs0gbWgnX2H7VF4ohr0EYJerqRw4A711iSgy5oWL3ZKS8XW2sfoQwnbEmYYh62UoGhYEGmO2Lh9mgy94I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777152289; c=relaxed/simple;
	bh=4DAP/QAHk5XvzBOOlNFaKew/A8q3ty9pAWb8NbLy70k=;
	h=From:To:Subject:Date:MIME-Version:Message-ID:Content-Type; b=MxJetq3Zm5yC4oeELlydrlrL2G+mJCRLlZPst86rhyv5v73lJ0Ne94r+U9C27ZdbousaXMRLb39C7JW7tyOAXIWOyLV71cs+bMiymR6GkYAqMs4YFksUSB7D9H0fnJAwyZY3QhBZpDGBZCPgCDnojxs2d8kE9vM9uLzukv5sFPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mattwhitlock.name; spf=pass smtp.mailfrom=mattwhitlock.name; dkim=pass (2048-bit key) header.d=mattwhitlock.name header.i=@mattwhitlock.name header.b=KtUvouza; arc=pass smtp.client-ip=23.83.222.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mattwhitlock.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mattwhitlock.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mattwhitlock.name header.i=@mattwhitlock.name header.b="KtUvouza"
X-Sender-Id: dreamhost|x-authsender|matt@whitlock.name
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 101DA460CD0
	for <dash@vger.kernel.org>; Sat, 25 Apr 2026 21:06:23 +0000 (UTC)
Received: from pdx1-sub0-mail-a243.dreamhost.com (100-96-238-119.trex-nlb.outbound.svc.cluster.local [100.96.238.119])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id AE626460F4C
	for <dash@vger.kernel.org>; Sat, 25 Apr 2026 21:06:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1777151182;
	b=DUnS+3atE22MX3dsPwlMyhQzJRED5IyxHXmIDCWumuyof7AOL10Z799BcrF+U3XTfFwwiW
	Ed4a1ylqDCcYZQCs3lCkXr0vWRjhzp2kta6Cexsl6Gnbo6J0pqJI09pgaqdOk9qQM6D5TW
	gmQ7qI+xq5x8jtule4w+rQyayB7mpFsfuWgd+IS23Ku/FUoYxyo+T/kw4XN/Ox1VdS813V
	L5xWAmILzWqDgP+J9Z7r0yIo1dH9jgn4pjb4dNVjxteSVuQo8BkyQp+7sOUqffgwFaPUDP
	xoLep1T3YwoiTQe8r296GljFP0Yy49+o/M0B3RX6YuYGFZRK86tykT2rZjFlWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1777151182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=4DAP/QAHk5XvzBOOlNFaKew/A8q3ty9pAWb8NbLy70k=;
	b=z+cEbsZX1fxkmRQ01eO1dUtKTGGwzh3L2X4JQR9XyazVkrMoaYcd0qpPIA27//yfCN0sOp
	iFiTyh9YWv2LiEywEG2HOUDlijIYlzcRoCicutczRTNIP8B5m0BJVIAe4Hy1VahmCViHh8
	N/IAnE6/HZyEGyRHQH7Xa9nnSnyAwbjzlg8B65zW6y5ewNGM8lCZxJjIgZzeAPoS4ELHEI
	GKwEBomNJcpDza2f7whuexLF7SIsFkClF2XL2P95ax23MROlgptsSXRCngpEfsNh7tf28t
	wGooJsxi1J7oZotbExqOctCZduatTp6o/FB4Qa5iDdzx6PQ1zWBDI5U2Tn1VoA==
ARC-Authentication-Results: i=1;
	rspamd-55bb47d7db-4r9g6;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kernel@mattwhitlock.name
X-Sender-Id: dreamhost|x-authsender|matt@whitlock.name
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|matt@whitlock.name
X-MailChannels-Auth-Id: dreamhost
X-Hook-Cooperative: 718e576a3be07758_1777151182964_154622362
X-MC-Loop-Signature: 1777151182964:3388139015
X-MC-Ingress-Time: 1777151182963
Received: from pdx1-sub0-mail-a243.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.238.119 (trex/7.1.5);
	Sat, 25 Apr 2026 21:06:22 +0000
Received: from localhost (unknown [70.8.171.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: matt@whitlock.name)
	by pdx1-sub0-mail-a243.dreamhost.com (Postfix) with ESMTPSA id 4g32SG2qmpzyrH
	for <dash@vger.kernel.org>; Sat, 25 Apr 2026 14:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mattwhitlock.name;
	s=dreamhost; t=1777151182;
	bh=4DAP/QAHk5XvzBOOlNFaKew/A8q3ty9pAWb8NbLy70k=;
	h=From:To:Subject:Date:Content-Type:Content-Transfer-Encoding;
	b=KtUvouzasVQcRjSZnuCgsnsP0PMZ29MVVrnvtXI7CEkb4ZIhKRVwzHjgWUIUwK1qv
	 FfhkF+kHDnuXhIYK5ldJkxF7QFvVFIKVjuWdbI9qWFM3uTn6Ni3Synn8ulZzbhUX1P
	 LwD2HnDF1dGO+3aruEaPyaalARxLweql4ZSoExncGnIfgHcSsaSj5CZIa4Vxk09cmX
	 u/3Lmj1gr0y4Q+dBj7wEfjBc/yN3iBkWJYwCoXiQwJO3EbM40UdAQwAXAL3xSnzEYD
	 tjLFcNao8OXLN5D67vbwSIAhXvtB40APhzCK/vO/gP1ls9w1T9jpJwReZBAG6oYXKJ
	 MGKH7+BDz9VPg==
From: Matt Whitlock <kernel@mattwhitlock.name>
To: <dash@vger.kernel.org>
Subject: 0.5.13: read loop stops reading when body forks a background subshell
Date: Sat, 25 Apr 2026 17:06:21 -0400
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <377dcdcd-68dd-48b0-a23e-5ede49e4af02@mattwhitlock.name>
User-Agent: Trojita/v0.7-781-gfddd17b7; Qt/6.10.3; xcb; Linux; Gentoo Linux
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dash 0.5.13.3:=0A=0A$ /bin/dash -c '{ echo 1; sleep 1; echo 2; } | while read=
 -r line; do echo "${line}" & done'=0A1=0A^C=0A=0A=0ADash 0.5.12:=0A=0A$ /bin=
/bash -c '{ echo 1; sleep 1; echo 2; } | while read -r line; do echo "${line}=
" & done'=0A1=0A2=0A=0A=0ABash 5.3.9:=0A=0A$ /bin/bash -c '{ echo 1; sleep 1;=
 echo 2; } | while read -r line; do echo "${line}" & done'=0A1=0A2=0A=0A=0A$ =
uname -a=0ALinux Crushinator 6.18.18-gentoo #1 SMP PREEMPT Mon Apr 13 03:01:4=
1 EDT 2026 x86_64 Intel(R) Core(TM)2 Quad CPU Q6600 @ 2.40GHz GenuineIntel GN=
U/Linux=0A
