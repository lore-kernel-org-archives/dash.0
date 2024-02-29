Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40FC13C9FE
	for <dash@vger.kernel.org>; Thu, 29 Feb 2024 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709238065; cv=pass; b=E+YwvVcjfrwXhzL8zMUVYhTpAZhxGwxnSAZZ9HLxaNDtft5cAVnhc2szK+7MdFJynnqADnxk6nQClB6ylkXwMw5MAL/x5rmUyqVc5mXt7nmQ4QjpeRa682ggLj85v4rkUCy11BTlps7+ZAKRpaeYxh4Odn+zyaNOrhZsbtyX1/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709238065; c=relaxed/simple;
	bh=UW0n4zKTz1tj3z6gOq49C07o/bofextU/zdMuMEX92M=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ng10Xi3y9EhlPkdD4oOaZsjPDxspUVV4Err1rMXBdYaMPWE5EEjj06gnGxcZcgRMPkVHRKBW/M4aBBsrDSVpWdqGCcR5ixGTf60oSZ9LlItIfG27MG+yYbSVY857m1bNMVHVYUlI9ZY5+uHWRiJFY/NYqZUn4x5qPVYvBuQOb/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6799183A24;
	Thu, 29 Feb 2024 19:03:50 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 54AB28382A;
	Thu, 29 Feb 2024 19:03:49 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1709233429; a=rsa-sha256;
	cv=none;
	b=GEuOqJr/slheFh9TtceFWgE7mS50e8JCzDEs3ire1LEPkp5IDyMyiG/3NVIatlJC3JeFXE
	5SmnhCeTEQaXhc01Ot3fD780a1O2L/uLGYfClxKnFoIeTCqE8N9aZTiCPbulta8F56e57P
	0TZ2qhot8jHmxciWgjP/g/k5/tWk9FkIrCPxoUbSnZG+Cv5pezLO7+a6q6MDg62L4+9iTy
	rNMwPh4ptRplQyGzK1SqqH/xWi2g4cfGauSp/V9pCA3N1RCXlgvjXc7GJjuuP8qbKuW9to
	/UoTty+zGpHEARB7+bHcq2YcAmmf83+lvIei6Ch7erXfuZKUZwn5xyMfAUBJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1709233429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UW0n4zKTz1tj3z6gOq49C07o/bofextU/zdMuMEX92M=;
	b=QfP333D/nQbS9ROXV7x4yAVeoxw3Zu34R5Tvjgq4qWri6woJpcOuz4vh27NRW78gPvYJCR
	wi6YUo9bU16v47g8OmpjeowuSwLjWrNVp0tm2iWtXlMLvRpo+pW2Q6kz7faDnFQGMqUhI7
	qNOtQdupvoNjFks7M1mtJzB0dUKjmxDzl3Zuihr09KWP+DqAuSWHq13AJJLVKt0NqBTGrE
	WUcU+ySkvzE/k/Upqnx9VSX1LzmKzJ/IvuSxuW6dkUMXL3zJMEwPGu3r1i1DE8dMAXYQGx
	42ueViZQVuA0tpn8C88FwNzG4A0TqoPF/g3Pob3xsAP48/rzEAysR1/Vg8mTaQ==
ARC-Authentication-Results: i=1;
	rspamd-7f9dd9fb96-sjg2c;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Whispering-Society: 3887caf715273cec_1709233429987_3665145069
X-MC-Loop-Signature: 1709233429987:4062446036
X-MC-Ingress-Time: 1709233429986
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.111.192.177 (trex/6.9.2);
	Thu, 29 Feb 2024 19:03:49 +0000
Received: from p5b0ed132.dip0.t-ipconnect.de ([91.14.209.50]:40192 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rflh3-0002JG-2w;
	Thu, 29 Feb 2024 19:03:47 +0000
Message-ID: <b83fbaba7b5d6d5935131febbcecb10fe9152628.camel@scientia.org>
Subject: Re: wrong behaviour when unsetting/setting some variables
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Martijn Dekker <martijn@inlv.org>, DASH shell mailing list
	 <dash@vger.kernel.org>
Date: Thu, 29 Feb 2024 20:03:41 +0100
In-Reply-To: <96806056-0aa2-467b-9460-71f142b71bad@inlv.org>
References: <43f0631aea36f6b49e5c3dfdfe481a5a2b1fec6c.camel@scientia.org>
	 <e1f38631-18fa-4962-89ee-d9bddd83eb58@app.fastmail.com>
	 <f101dc542647549d78bb17c96b88055874f5e722.camel@scientia.org>
	 <00e1ca47-2cbc-4d00-a1bb-f7ea6115d1ce@app.fastmail.com>
	 <4ca7f5600a243a884c12616b24644e78a56a988a.camel@scientia.org>
	 <96806056-0aa2-467b-9460-71f142b71bad@inlv.org>
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

On Thu, 2024-02-29 at 17:58 +0000, Martijn Dekker wrote:
> No shell currently behaves like that, and it would make no sense, as
> 'unset'=20
> and 'empty value' are distinct states.

Well in the end I don't mind what's done, but would prefer that the
specs unambiguously describe it, and even if just says that the
behaviour is unspecified.

People read it, and by just reading the description of the export tool
one might conclude, that such variable is exported to the environment
of an executed command.

Cheers,
Chris.
