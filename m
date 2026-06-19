Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCA61DF980
	for <dash@vger.kernel.org>; Fri, 19 Jun 2026 05:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781845492; cv=none; b=KprUIiQ3XMEQRAx/hDNmEJJOKLZeTHEtQL8xnGr3yxOrtM0L+TdSW+hbyxx+tKg8GReKI1TsE3Adu0I8njgL5WV7h00qUSU/aoPY+e4xlKOcHTfSl1JDZ71aNjqBZ69cWG4Lt70Rt3r/b3yEcgq/DtfybcoVE2OlbzLsyBfCwso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781845492; c=relaxed/simple;
	bh=UfxsmTarbscX1dNOEeEgtP/z2/8yXHX/mFESk1X+030=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=gYi0frqd2/XMxvlaK2WylslcmZKYFW3CobeFgFmFIoL9F6AYxpMquj3zZtiiKNH7H9jTwLkZQ7dlT/5KrFWZ9O+N/7LFpgw62U0rxixQ25vsdEAKHPmkgwrdh5b1s7kIFdqqBKd4O7cKFesbB6gxrKdIm646L/aSyCAsDjRUL+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plushkava.net; spf=pass smtp.mailfrom=plushkava.net; dkim=pass (2048-bit key) header.d=plushkava.net header.i=@plushkava.net header.b=JzJtTQtP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NDRcC+K7; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plushkava.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plushkava.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plushkava.net header.i=@plushkava.net header.b="JzJtTQtP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NDRcC+K7"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 252D41D0016E;
	Fri, 19 Jun 2026 01:04:49 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-01.internal (MEProxy); Fri, 19 Jun 2026 01:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plushkava.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm2; t=1781845488; x=
	1781931888; bh=81LIhzhJ/w31NMvotnBHQOIUKOzvYCwZ8yoP9PAu4cY=; b=J
	zJtTQtPFKjYrVubZdNOEizEOJaj46WJFgPlrG6/t0QXUhYccsHvdZ0YKPoXnSn7z
	KpQq4N35Pvss2j4HpIXWlQa0QNeYHMOYKyK33K5dXBrg0QtpE1BX9fDig/CaaKFP
	W3MQq4JgpNaz2K9lm/J5S6Mpqq/6LiZNFSj17tWcHWKxt7YYOsHPSMKrH5cEcjLy
	lGBaVnX8EbbD6db6Sq5TAc0Cx8HwnpJ1riiwI0XGdYHHINWoEOgKcuqCrFyQBRXs
	7UicD491O0OAdyf7l8i9Aq9bow3HmH5FrqyRahfIkXNQY+CedlT4WVqaHO0Jp0jp
	8fGPrSynAJnSc3KV/Uiqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1781845488; x=1781931888; bh=81LIhzhJ/w31NMvotnBHQOIUKOzv
	YCwZ8yoP9PAu4cY=; b=NDRcC+K7ozEYHRUckkIWjrYwu8fzbu8222XvSZnbDOsx
	UfeO4M5Er0XDPRcEsdzGMX3ZUkFDXFLpgfN8AqHpDrX7VwAJe3iZl0fvR5/djrkH
	SZPrLrGPbnhWSmfI0ZSM3FCRfw/FPf8bCB9Ycl3IOvBlH/7KtG1scm0BlzHUM7RT
	64DD2vwo1ojBXl/2wbyBPazIIua3Zjf+w5bIjhChcWsHGLs7u6pxCEfZCqkKHsCt
	HzmPJmW4DMienx8SfNzbIL+BLFgEK8Ya8cCnSfj9ZD8hs5pZ2XnCSgI21ZTXaAoS
	joVtI72wogml7S5yIGCXW962lP+EiA+vJzRqwhee3Q==
X-ME-Sender: <xms:8M00aj_I0ENWqvWTI5b9g-B3QE0AzAeKNbNKT4ytCBcZ_4WCY9zOvQ>
    <xme:8M00aqiwcItNZXNuovzcnxI4nyAGRUmLSiErkq_n1_L8aYd_iHgL7OYcfusO2AP4r
    KsoXg5zL_GNvWgPMNhuxxpGIsJ1Ax7PLz_-jj6Fm0Fx0SQM6KVgVw>
X-ME-Proxy-Cause: dmFkZTFuMakakcs9j/+FOzYv71W+hbeJldrTw04xrJ6mZEpA65PzjwZIhF6oOOJcp0zO8k
    HnI88TgA8HQFY2VdmWK94aeobYunimIxCFPYrqu0xqy0MUlB3MgP4FdmbgxQLumrKmqdxt
    ITaxy0eGlBeJ9SdDgGCwnt5ONFIF0H8iISZxt0fjaF3jt/2zYNfussRBA1q9JZOsfi2eW8
    0wJRsMt3XckvHmbkD8xoGeqM90yoaZO4G8wp/hzGv2pcZaaUjpOQlr45Ly9mMfFAZVJbBW
    Rm5nMQTqWT/ag3Z4AXPbKVZgpLLLLG5xB/mHzaD6oeMTR+2CI3TjhPjk/coGr8QE9Bx5PQ
    egtar++lcHLlNF06X8QmAlXxkJK4zM8qjxuv4YvHidRC+4JjIykDXcJd5CiiJ2wqa79qFD
    OMaPAsWeoveUBTTkBQOYIzf3Bs8MnK3mtjFOXftV28EBiZLysnAGiFr6NQYwMpPqDHq9H0
    0j6+fyeM3IDgjMxQvAr5a8u3e9LTB8c6aF7P/XT8ACKd5NQDx7mUfCAQW/FHcZvxMGoj6i
    kklJzD2pLUZgfxOmIRwi4wiksgUyMozgnMdOOdUvrnIlBa9+FMDwtNTjqg2zM+LraPTj19
    RB151/VmPXGP6mZvCz6+Pklerhlf4/8dovVP9OIkt9D0/w9BT/8YxupoZSjw
X-ME-Proxy: <xmx:8M00aiq9aTF8L-WVq1I25WKXFkot99o4DChX6N6qwbBRCU9i3JAfcQ>
    <xmx:8M00aumPiwANL9gMUAm21CXWzMpBeuZMpT6Q1tj0hzkL1DFFTrLAdQ>
    <xmx:8M00auwZSkF6lJjUcZJv6V9434WZ_Zbz8pbBokWtyhkiJ6sBa3lxxg>
    <xmx:8M00aun8_oqKHuU0H2FJOEz-lJTagdAoHgJ_gNCODoX9O67UBIxgyw>
    <xmx:8M00andCM73o5wp1l8HZCngaxvyFNcVRAo0fjukoFPUFfu-f9qMR6D9w>
Feedback-ID: i2431475f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id ADB16216008A; Fri, 19 Jun 2026 01:04:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 19 Jun 2026 06:04:27 +0100
From: "Kerin Millar" <kfm@plushkava.net>
To: dash@vger.kernel.org
Cc: "Sam James" <sam@gentoo.org>
Message-Id: <bf5516e9-e59f-444a-81c6-7b112b71563a@app.fastmail.com>
Subject: The read builtin erroneously consumes null bytes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Consider the following test case. It demonstrates NUL being consumed by the read builtin, rather than by cat(1) as it should have been.

$ printf 'a\n\0bc' | dash -c 'read x; cat' | od -An -t x1 -c
  62  63
   b   c

This defect may be attributable to https://git.kernel.org/pub/scm/utils/dash/dash.git/tree/src/input.c?h=v0.5.13.4#n411.

Incidentally, it results in tests #5510, #5558 and #6020 failing for git v2.54.0.

-- 
Kerin Millar
