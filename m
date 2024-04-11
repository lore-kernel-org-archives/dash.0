Received: from snail.cherry.relay.mailchannels.net (snail.cherry.relay.mailchannels.net [23.83.223.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD43B6994C
	for <dash@vger.kernel.org>; Thu, 11 Apr 2024 01:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712799171; cv=pass; b=d2x56jfHnowFq/3vj0VWk1jQ8nzvRAj+Z+ke9xlxZEUjM/8DouEkS7Cqgc7Q4VHL/+ERo8J0bY42gvbMwGZds+PE1QucBkxjpD3j8WynOcawRpPNmi820FHIPhjYFflIY/PLrLibY1+Qx31oU0KWJNuhJUb5IAWr7Vg4UG8o5/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712799171; c=relaxed/simple;
	bh=3yjbEPG9D2GH2g3lZEoMpd8ftVst97zBY4KbJ3rQeE8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=toRKOZgSZFNhIh0PbMsEq55bLO/VD0oBGY5s9OOGPjsZUaIPcsw8ywYWSxXlam9o7qX6GWBVOYYwwukA2JEH/HSE3rxRu8Dixq9KfRZTVdd5BLi9nZ3/tn2ZP5R+abstT0dom8xgMzSPXOpz5Z8L49ycvhHIqxRPq9vk0jB9F+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.223.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D03ECC2F07;
	Thu, 11 Apr 2024 01:27:01 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 0673FC2D68;
	Thu, 11 Apr 2024 01:27:00 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1712798821; a=rsa-sha256;
	cv=none;
	b=sNj1lseqfwCHDBmkCIQs8ZWtZAEJvsuxt8+yGi6+IHr6t5EBcrKw9QzSxkVnXTFH0IKd+O
	jAQGJRzvK3GmcZVnaAD2Kh4PGEzgjEn+W+4ws+qXv0zDcGPb3tbBR3J4wcDTFRjO0FpZ7U
	6SMkUutSztb3fsMOyf9MG3fDCxw1JeNs7WligVuhRYlFF0vXPRaYkQ1ywJ2/clQJ/pxiOc
	KB9ZNMI6zWH0gyi9il4sCAKarHSetWKylBEBfDNjQvCE8y9lSZ3OV/C9qPtxDulUg/0Lb/
	wNWv95DU1z09x7CULPACAhWA1SyvyRax5Xh0lIMY1jhMjk16PVyjMGCoJCH56w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1712798821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3yjbEPG9D2GH2g3lZEoMpd8ftVst97zBY4KbJ3rQeE8=;
	b=KLDWNR8lXppF1xf7oB1xngLPJ3yzTDiRdDNDcylnQ0Lk/csc/g38qIkUPoVUg/nFB+xx+8
	KenB03bxoJcPdYsyOSUEa5SQMieU7mE1oeEQi3xww2oaZwZlsa042+gnarHpBz80ZClZuc
	zfOLubd30+rpQW0Ualysf9hOdxtMK725swgGdyfRzYPmpsXSvQcBdKorZM/1mGfN18IkL7
	QvVKtTXqRBSKsUDyAzU9UlrvUY7VrbD/MmtXmM7W05e/myJq2ufXF60AttH3K0QjUWXviM
	GgUO1eJwbfIz+MhNR+6lRaOaLutK/foUwMvfzyTsQmPMUir0TL8DQX/sHX+vTQ==
ARC-Authentication-Results: i=1;
	rspamd-6f64594bc9-hm94p;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Exultant-Bottle: 519dee9e3e39c5eb_1712798821620_2155468558
X-MC-Loop-Signature: 1712798821620:3873014690
X-MC-Ingress-Time: 1712798821620
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.98.182.136 (trex/6.9.2);
	Thu, 11 Apr 2024 01:27:01 +0000
Received: from p5090f28b.dip0.t-ipconnect.de ([80.144.242.139]:40628 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rujDM-00023h-21;
	Thu, 11 Apr 2024 01:26:59 +0000
Message-ID: <98c5a2b67554676839deded400d4669934b9cd07.camel@scientia.org>
Subject: Re: wrong behaviour when unsetting/setting some variables
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: DASH shell mailing list <dash@vger.kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Harald van Dijk
	 <harald@gigawatt.nl>
Date: Thu, 11 Apr 2024 03:26:53 +0200
In-Reply-To: <d307bc34-f8f4-43d6-9c09-76e02df7d02f@inlv.org>
References: <43f0631aea36f6b49e5c3dfdfe481a5a2b1fec6c.camel@scientia.org>
	 <ac893750-085d-421a-b296-a182ae51f1ec@gigawatt.nl>
	 <0fd6f8b9-7175-4cc9-9d99-586beb3ede48@inlv.org>
	 <252ec2b0-70dc-4621-96c2-285aa915cce0@gigawatt.nl>
	 <4bcfdb66-c60f-4172-9f4c-cc25c3e99ddc@inlv.org>
	 <6e4e70da-b137-44c9-944a-4b4eb4ef2174@gigawatt.nl>
	 <d307bc34-f8f4-43d6-9c09-76e02df7d02f@inlv.org>
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

Hey.

With all the recently merged patches... any chance that we get this
issue(s) here fixed?
Or at least those, where it's clear what should happen?

Cheers,
Chris.


