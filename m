Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54897148306
	for <dash@vger.kernel.org>; Thu, 11 Apr 2024 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.253
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842094; cv=pass; b=reoHwLAgK8fcXEsOYLcFBNkF3mXohuCg+FhruD/v64yUcqZEwsjdMpxbh1XvF2A7uRQg4yHDhqSW9vEMaYMLmd+D1psevUFI3RG4jJeTPGljkifhFj8NLdOu1x9vTGfwU4ezkXnrDAAakWgnF/YkweO78RoPABtXDjd1ttrhHD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842094; c=relaxed/simple;
	bh=LOknrwdp/VoLbniWHtYEWci0wQ7qnvDCSPPAIej6TwA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nDpBVEW12dvy3QT6r/daq9EI7INbOxd7Hu+yOPYq6d4RwgXfN0YTXfIUCQfosvuPpeq650AXw395VdsEYA3M5BYM47x7BS7ZjDVwAZ7MrU9JvpcH+G2Up6QZqtckCmztWv3flxm4mP/C83ErMkauUUHXQtrAlCCABOjBdGp1wPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.218.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 37B5442A24;
	Thu, 11 Apr 2024 13:28:04 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id D719843453;
	Thu, 11 Apr 2024 13:28:01 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1712842082; a=rsa-sha256;
	cv=none;
	b=xQxrhMi0NUKgSz59z6HeWQN8yuKvFZP5ko6qRbaMEKFhMT3rpWmFYDRstC3Do5rP49MD1u
	ynJw2P8HhNCpdTElcpBT9Vbf88sphhkY9j5Nwk5sM5jVTDGHWC1AJTWt3AaYbXL6HDwNx0
	8uAB96LnUrgO2+c9kF2Mn98coj25C3XbI14NKrOemEqcXargQfLxTMVHCC0PjzjxOr+LQM
	NCmA5s8fdfyD5c/MBSLhJD81IMciTDg2+U0g1CJ3W47ard7/a66yewR/qoAr8qfDlSpfR6
	eEW7VerXRAaVjq38ZrzQaEzNRKkrm2EbHoC6tsLerjkhUr8sAUM5EgJ+TAo+fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1712842082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LOknrwdp/VoLbniWHtYEWci0wQ7qnvDCSPPAIej6TwA=;
	b=lhA6heYrOqFdP1wAWBWaTD/5PoP7rCMkPwTfjZ/0fNuYx+Nd285CeugKZGmUwPBAvtZzqM
	tMjDXUmQXt+W6OBN1UuRyj/NQSrWTn3sIYidKOg3vFKZYnO5cQlvAq8zU9ANBrF93r49F5
	3rIg5564S5Dta9GIg6KUVoOg5ghE28NqQR86OdWXuj6CxzXM3lam3wppkhozoZwNCx45sn
	IpN0bwNVD/GsajVL9EbxMJ57I9olSPm6LamQwtok/LJMB8iKhupP8EWINe7bvzYwfTqaE4
	Q0jl+NGbN+NqW/14mBoMT46z724DQrBTcNLCWHBJ98QNJ1eZlj+x3IMBZxAyFQ==
ARC-Authentication-Results: i=1;
	rspamd-6f64594bc9-tcxc5;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Battle-Desert: 59bfd98e5ac8dde4_1712842082477_1913106960
X-MC-Loop-Signature: 1712842082477:212837488
X-MC-Ingress-Time: 1712842082477
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.125.113.89 (trex/6.9.2);
	Thu, 11 Apr 2024 13:28:02 +0000
Received: from p5090f28b.dip0.t-ipconnect.de ([80.144.242.139]:38298 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1ruuT8-0006f5-09;
	Thu, 11 Apr 2024 13:28:00 +0000
Message-ID: <bf7a9bc7a3108dcd78d4600ebe3807cc74c7a752.camel@scientia.org>
Subject: Re: [PATCH] var: Fix unexporting of local variables using unset
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: DASH shell mailing list <dash@vger.kernel.org>, Harald van Dijk
	 <harald@gigawatt.nl>
Date: Thu, 11 Apr 2024 15:27:54 +0200
In-Reply-To: <ZheUuMS9rReRzEY5@gondor.apana.org.au>
References: <43f0631aea36f6b49e5c3dfdfe481a5a2b1fec6c.camel@scientia.org>
	 <ac893750-085d-421a-b296-a182ae51f1ec@gigawatt.nl>
	 <0fd6f8b9-7175-4cc9-9d99-586beb3ede48@inlv.org>
	 <252ec2b0-70dc-4621-96c2-285aa915cce0@gigawatt.nl>
	 <4bcfdb66-c60f-4172-9f4c-cc25c3e99ddc@inlv.org>
	 <6e4e70da-b137-44c9-944a-4b4eb4ef2174@gigawatt.nl>
	 <d307bc34-f8f4-43d6-9c09-76e02df7d02f@inlv.org>
	 <98c5a2b67554676839deded400d4669934b9cd07.camel@scientia.org>
	 <ZheUuMS9rReRzEY5@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1+b1 
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

On Thu, 2024-04-11 at 15:43 +0800, Herbert Xu wrote:
> Thanks for the reminder.=C2=A0 This patch should fix the problem.

Thanks for the patch :-)


Cheers,
Chris.
