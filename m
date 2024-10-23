Received: from serval.cherry.relay.mailchannels.net (serval.cherry.relay.mailchannels.net [23.83.223.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92091BBBC0
	for <dash@vger.kernel.org>; Wed, 23 Oct 2024 19:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729710228; cv=pass; b=DiehjASsi/dMHDDNzHY+rH+Nmh6OFSMtiYXvviio+8cNFEqYe+6OCyGy9pNmAUI9v4e6ewM/cChNnykS36Fl6JXp9LJpxRDT7O/KblbUUwqBPsvUAwFbf4DE9e65HkoLadlsfHLyhMlzMpYgPX5ddfx7f9WxRRGsoF352gkokgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729710228; c=relaxed/simple;
	bh=pa83AZs15xeeap9AVxUePt8LUQ/XYFfWTH/mcdd32Xs=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=BOtFxDEKIRarDhqxvP9scZkMgQ4tA55nikEWcZhXGbWHC8yo9T7CTi7+nMgAk3tFLSCDVRQ2BjY4M/yxAf7zWJS7vX/yLoCG/bWUY1YUU2hpnJqb/SG5rnYB+/f1Tjha4mFebH3AJpn9OmhBX1Z0ikW4nBFiRMCydIEKq0Bc66A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.223.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 7D4DD783C37
	for <dash@vger.kernel.org>; Wed, 23 Oct 2024 18:25:46 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (100-99-175-122.trex-nlb.outbound.svc.cluster.local [100.99.175.122])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 9FE2F784098
	for <dash@vger.kernel.org>; Wed, 23 Oct 2024 18:25:45 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1729707946; a=rsa-sha256;
	cv=none;
	b=Lqq9DJLedzqPC1k/k8v+LFLQAOcFV9/oFL7tLkjEkCdFi7YkCpu8npuHOXfk3mViPCt/TG
	IjYq5FiIt3PVyx4Y98jzopktVQ1kZI83xN+liz4AuYU//USRxkeHP/j8C4BE2v3ilJsVGM
	sw0+Ff00xY+x5I+vwW2Zce+l07dAjS5xe3SQhjwqLUKRITttk4riUjSGCPx7MN8gPBhe/F
	NAe8l4GFmqC+0YnJkqJnCH0He/A06q4rvEXYoEVUPQaQ3Jf8VBQXEX62Wk0ERmu7psvc4+
	QKq5tXbDsPNhbO5NCE2HqGB+90Wxnn4vVFcZT5r3enmgX/oAkc2s5D38pxA48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1729707946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pa83AZs15xeeap9AVxUePt8LUQ/XYFfWTH/mcdd32Xs=;
	b=2fvcep4A5lxOggtLpP4Uw/zgkCNxj1Pn2cLM0zw2kQmfUgOCJSFL737NyOpL66dUMR5gyc
	i66KKII9QKmfNFaEr6JeDdkoUAfC1FW+0Fi9fy8DPHemtOo+5w4qWCYnBpPp5HMgJRdi5M
	1QaDikbKb/o9Vi+c+GPi6EAyPly1B+9q+HE81fi0bihOJW8j8S29413rTV4b2M8tg482p9
	5wz7F6JisegRha/VJgubLFWZD+ZDTmFwqtgDtXBc4uwhr43fCgG4PHVz2BzdAvEDEuPi2n
	qughRUzvXv2stvR+Va7/Z5ZXMk6gowXnB8a4bd5NV44Y+hcNYEydExeD9/C10A==
ARC-Authentication-Results: i=1;
	rspamd-595c6868f8-ttd5t;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Abortive-Wide-Eyed: 010f7d1c796b8eb6_1729707946358_2488260769
X-MC-Loop-Signature: 1729707946358:3622375283
X-MC-Ingress-Time: 1729707946358
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.175.122 (trex/7.0.2);
	Wed, 23 Oct 2024 18:25:46 +0000
Received: from p5b0ed864.dip0.t-ipconnect.de ([91.14.216.100]:63586 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <calestyo@scientia.org>)
	id 1t3g3C-00000000leK-2sph
	for dash@vger.kernel.org;
	Wed, 23 Oct 2024 18:25:42 +0000
Message-ID: <273c031d242d7610e4da37ceb9413c876f0168e0.camel@scientia.org>
Subject: `jobs` within command substitution doesn't work
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: dash@vger.kernel.org
Date: Wed, 23 Oct 2024 20:25:40 +0200
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

With dash 0.5.12-9 from Debian unstable, it seem jobs doesn't work
within command substitution.

In bash:
$ sleep 60 &
[1] 140013
$ jobs -p
140013
$ echo $(jobs -p)
140013
$=20


but in dash:
$ sleep 60 &
$ jobs -p
140049
$ echo $(jobs -p)

$=20


Not really sure whether that=E2=80=99s behaviour which POSIX would allow, b=
ut
at least it makes it more or less impossible to easily get the PIDs of
and jobs within scripts.


Cheers,
Chris.
