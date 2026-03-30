Received: from seahorse.cherry.relay.mailchannels.net (seahorse.cherry.relay.mailchannels.net [23.83.223.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4473C553E
	for <dash@vger.kernel.org>; Mon, 30 Mar 2026 11:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869179; cv=pass; b=LlTflwtzaxS6ZrDL+yU8VJQlwZQCPdgNp0DnZRa8DhB4Y8m/YdZX7l+5QZH/21NEpNB4tyQb98tzjQrjlfmAkGnJGtZZSCWbd7czf4BgG5gjwpmfltRTPLJSKRbPlBlDstSsPRmvNM+WLkXJvFvVKd54RuzJM+JJU8O7UU2e8Ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869179; c=relaxed/simple;
	bh=WrQ222OLVWTB7M4jZyjs+s9wOgaFbzv58SQrgLljopg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bWmDSd+0OSPxcn34SLZ32b2FVNZ6dVg419oZdfGXEjXYYkul4WmmqoCxS4QTwXzhgwRhTPGOBpGfCxxLTkPWWIF9+sdBJA3Z+HoUTW1GKcaft18i7biERWmWw8xqSEEON/HhpApCFnLOUdemjiw5Pxs3bh0mnc5JW9Xl31l0rt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jidanni.org; spf=pass smtp.mailfrom=jidanni.org; dkim=pass (2048-bit key) header.d=jidanni.org header.i=@jidanni.org header.b=pdF8aW/o; arc=pass smtp.client-ip=23.83.223.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jidanni.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jidanni.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jidanni.org header.i=@jidanni.org header.b="pdF8aW/o"
X-Sender-Id: dreamhost|x-authsender|jidanni@jidanni.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 91A594C1909
	for <dash@vger.kernel.org>; Mon, 30 Mar 2026 11:12:56 +0000 (UTC)
Received: from pdx1-sub0-mail-a245.dreamhost.com (100-96-100-42.trex-nlb.outbound.svc.cluster.local [100.96.100.42])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 52BAA4C123A
	for <dash@vger.kernel.org>; Mon, 30 Mar 2026 11:12:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1774869176;
	b=Je5uNbJdHjylTC1Erw5NpZfL4ceT1prAFFtiKLGF1iHEOrpBksrsiiU4+mzbW59Mqc03Ay
	6BAgoLRdX/pbrX9LbwPaYAx0KkTjvC2Bhv+pPpe/hv52zA2G2g0xMgUbyxKbRDvQeo5275
	wbi5GmzZe4suDS/yXk7lwzem9TCMw0AAWl2FupkBAmBop/8WMMmb3DHCxXwBqaSnNeBE2C
	tKO6HaNjv+ALDZyWddn9b/Gqc4Im5Zj3yRpHQA+0wBo+hkYUw7i79G+qzd+DtJnNbuxAV4
	JeMMnuqkiprljJEVA2qZSnmy4x/kTtU4ZOMVk/+2rL+MZedlzwciu6ixfdLmag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1774869176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 dkim-signature; bh=WrQ222OLVWTB7M4jZyjs+s9wOgaFbzv58SQrgLljopg=;
	b=nFfNPvtfb+0vnrYx4y7z+BIwpFsgo+mDDGC3cZ9EbMydYRrc0BwOSOHtC/AiWEEh7i2T9P
	y/EgEB8OAP9pf38lNNjaF2n4UukbPl6YEwNmRTmnkgK97vGRppAnO6XuKOIJRpojU2v5yK
	ZTpg8TkEaRWl+ob3qRKKtVTpKguiwFgyY8M8LHO8RsLa9OWTvlsndO0o+nomXJk/9d9Uuo
	gLZeZrNU7Zs4HqGq+W3Wu5KvZInzFNQhPK/XbKlSanJj3i6wa5V+mn7U3+ZixUJBUPZO6e
	yqA/0i8tekVAPRvca8qrXUsKyamdUXryj20EhlYrCVnooPQZOPCGvqUMYSNBVw==
ARC-Authentication-Results: i=1;
	rspamd-db964497c-bfkmf;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=jidanni@jidanni.org
X-Sender-Id: dreamhost|x-authsender|jidanni@jidanni.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|jidanni@jidanni.org
X-MailChannels-Auth-Id: dreamhost
X-Average-Robust: 5d1b6b14084632e8_1774869176368_1991798737
X-MC-Loop-Signature: 1774869176368:4220390073
X-MC-Ingress-Time: 1774869176366
Received: from pdx1-sub0-mail-a245.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.100.42 (trex/7.1.5);
	Mon, 30 Mar 2026 11:12:56 +0000
Received: from jidanni.org (125-224-140-23.dynamic-ip.hinet.net [125.224.140.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jidanni@jidanni.org)
	by pdx1-sub0-mail-a245.dreamhost.com (Postfix) with ESMTPSA id 4fkpWX1PtNz107q
	for <dash@vger.kernel.org>; Mon, 30 Mar 2026 04:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jidanni.org;
	s=dreamhost; t=1774869176;
	bh=WrQ222OLVWTB7M4jZyjs+s9wOgaFbzv58SQrgLljopg=;
	h=From:To:Subject:Date:Content-Type;
	b=pdF8aW/oyE7MZ3KtaZOFSwhWYSjJpHnk6gpyrBHY9gtPuJo2vh9ZjJEsODsljXduw
	 a06pjde6UcPecU2EBHATm0SU1KhQAUxRC1j+4j2zzbJxwdcX3tmTxeBXr3cUSiAXUH
	 gZlH4mBgbORzjuxRQB8PDDPHbo2sti33Xeo4cqoMB5xoQRboQlml1MCZHmaX6fG40k
	 lLKTCPQjXz+D+ADpX+8CA4NxW/sB7t2tXUtssY9AbJk6mfB7aqSh1xdLDnt8JbKR/O
	 rtp/vCAVj2Np0a5IHQVWvTbVqfM2cI9IUqB5WQNyck/14EVlSUnpG6VRIxilBtoveh
	 W85cXYvky6+IQ==
Received: from jidanni by jidanni.org with local (Exim 4.98.2)
	(envelope-from <jidanni@jidanni.org>)
	id 1w7AYE-0000000044S-48Yf
	for dash@vger.kernel.org;
	Mon, 30 Mar 2026 19:12:59 +0800
From: Dan Jacobson <jidanni@jidanni.org>
To: dash@vger.kernel.org
Subject: Closing parenthesis doesn't raise error in backticked command
 substitution
Date: Mon, 30 Mar 2026 19:12:58 +0800
Message-ID: <871ph1h8p1.3.fsf@jidanni.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Please see https://unix.stackexchange.com/questions/805208
