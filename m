Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C891BF24
	for <dash@vger.kernel.org>; Tue, 27 Feb 2024 03:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.249
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709005016; cv=pass; b=pIMcQG16bkDxygf3bDzPih37vyBggiyEFrfUoLU+SkikJ+fWFtH6AboUYOF1gDwPsuxPFA+UPMv9H5o2zeG/5I+4sPEvf3lLTXN5Zs0dzRqAl6w+IKPwQ9OxxmMv5ND/ZyjbsSz3JwcsW1Ez5aHS6Zt8eyazqI1zNSmxCPhtTWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709005016; c=relaxed/simple;
	bh=4pDHYldWXOpY1rusWIVdYHyZmqpLY/khG5Sap79xKZo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y0w1TCIZhRNQAnS1Qqvo825YiiBpKbb8sOBLlERz8syb8sz/C+lP5TcXWhh/2vk+VnTpXhIcvOuFvi5oo94iSojBYMhRaHDLELRSE8BMIeETmjSEM7OaihO6pn/9LZO5MhK6xMaDalH0dYC98xUT2ocpNqNLIAw8W65cbOGlHno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id CB1607A2DE5;
	Tue, 27 Feb 2024 03:28:55 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 027877A2DA0;
	Tue, 27 Feb 2024 03:28:54 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1709004535; a=rsa-sha256;
	cv=none;
	b=Ls/XnSdNjJTW173xSbVNCdupToXJrN29NRsaPvLHlTHflZfTCWnJ+NuLYo+R0mLYDB1yC0
	c4ziJc8Hg2DtLQFuAzx3NUwM9r0cWdhrwsD+quewSpWUBUo9rncEnDtMj8JaHZW99AYph9
	SyXQvxR/R0NHxtYWbMtS0B93z5Wyq8m5C4Af30ZdZumOaeAQmRptWTBABAO7qV/rUkCoAt
	ps5H4Vc6EaDNR5CJsULneIhEq5RMgGsLsCxEfCbh58S/IP1hCWVVQzSUylOq6loyxs2C1n
	SxI9j4Slbq+47G+WPhgCgPrmEXMC/SBG3mfDkHv2BuUNjk9FH/S8httlReuRIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1709004535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XwOgXVbn3DhRFRjtrYcuO1FxLfftpbNhEE/TJaazZuE=;
	b=5wdcLmfKmJvNPvJs0OSSlsXD36NdbiHGxdXfXdlHOAykta6XqwouUVcVg3HuDDX3FtkyA5
	bb6ZQei93wUsNBTINgkK+Dfpo6G4ShOXxb2v+v0g5GOGozwVL1CsxwRj/GNtLF3swB5dMu
	9jeZccKasv9GfGjkr2vX9YPjrpxatLXIwU1Bbr9mg1dzF+F6SN2dcVJIo2Ye+D8bg2jA+P
	6siYeghAL0V0i0t3ecyxl8L5BCpZpTlJr8IJKGYDihT/Kcxs8mDwI3kfRMKDWUXqLvfc+h
	vuheWISEuP15GzH7Q//+SSieFHsolG8dq8+DyktFA2rOcKjgjTJFtCZLg9Ahpg==
ARC-Authentication-Results: i=1;
	rspamd-55b4bfd7cb-6kzsj;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Chief-Supply: 075e0f0466b09634_1709004535638_2067403097
X-MC-Loop-Signature: 1709004535638:4095156185
X-MC-Ingress-Time: 1709004535638
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.112.142.233 (trex/6.9.2);
	Tue, 27 Feb 2024 03:28:55 +0000
Received: from p5b0edc93.dip0.t-ipconnect.de ([91.14.220.147]:43016 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1reo9A-00076I-2e;
	Tue, 27 Feb 2024 03:28:51 +0000
Message-ID: <fdaa6e5ea49f1eecae637929d8c3e7feb84bbd5e.camel@scientia.org>
Subject: Re: wrong behaviour when unsetting/setting some variables
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org
Date: Tue, 27 Feb 2024 04:28:46 +0100
In-Reply-To: <18ce9b6d-f9fa-467a-ab3b-5a4ddc5ed36b@gigawatt.nl>
References: <43f0631aea36f6b49e5c3dfdfe481a5a2b1fec6c.camel@scientia.org>
	 <18ce9b6d-f9fa-467a-ab3b-5a4ddc5ed36b@gigawatt.nl>
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

On Tue, 2024-02-27 at 03:07 +0000, Harald van Dijk wrote:
> I suspect the reason you don't see it happen with TERM, LINENO, and=20
> HISTSIZE is because you have built dash in a configuration in which=20
> these variables are not special.

Ah, I see... well I merely took the Debian unstable version of it.


> For special variables, we get to
>=20
> =C2=A0=C2=A0 flags |=3D vp->flags & ~(VTEXTFIXED|VSTACK|VNOSAVE|VUNSET);
>=20
> where we preserve the VEXPORT of the previous value. In case of
> VUNSET,=20
> we should not be doing that. I agree with your expectations, unset=20
> should clear the export attribute.

So is it really just:
   --- a/src/var.c	2024-02-27 04:25:32.000000000 +0100
   +++ b/src/var.c	2024-02-27 04:22:40.744456151 +0100
   @@ -295,7 +295,7 @@
    			goto out;
    		}
   =20
   -		flags |=3D vp->flags & ~(VTEXTFIXED|VSTACK|VNOSAVE|VUNSET);
   +		flags |=3D vp->flags & ~(VEXPORT|VTEXTFIXED|VSTACK|VNOSAVE|VUNSET);
    	} else {
    		if (flags & VNOSET)
    			goto out;

I had even had that before, and it seemed to work, but wasn't really
sure whether it doesn't mess anything up behind the scenes which I
didn't understand.

If so, are you going to send a proper - or shall I?

Thanks,
Chris.
