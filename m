Received: from black.elm.relay.mailchannels.net (black.elm.relay.mailchannels.net [23.83.212.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46A822615
	for <dash@vger.kernel.org>; Sun, 10 Nov 2024 06:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.83.212.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731219460; cv=fail; b=raFHPLR1mw0JRLeUppTLg0oefDiuDiq8J1ZfyTt6Dn/NdjtA5b2YYVLtM+DLOn2mvrcQKQSuQ6ZEhsaGxJSlSiuoSpY1bS6dSt4YO+bSJQWkrRd4ZPuNeIpi+W6Lfeb4rUOgrxG52Hz1B7tj+BrueIZU+ygTG58v1673lP/NbfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731219460; c=relaxed/simple;
	bh=1L+t2WNEpNZpsxLTBepZgClcbpQDPVPvLjdKra9Hr/M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MeVCozx3CfhsMasqIXylZvcaBOCYYEo7xo+Tvx7MxEA1WnKf2dMqx1k76dJ/MIP6sp5buQ4ASqXSwKl38xWiMr5uEtq2RkLPENmOBI+c7GgKDijOTELY2bD81SK6xdimpKAMff1LA4k0qU8NyyPoxZ7wCCo2jWfDxuy/4fQA3WU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=fail smtp.client-ip=23.83.212.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A8B0D8C16EE;
	Sun, 10 Nov 2024 06:08:13 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (100-103-135-172.trex-nlb.outbound.svc.cluster.local [100.103.135.172])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id DA5648C1B2B;
	Sun, 10 Nov 2024 06:08:12 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1731218893; a=rsa-sha256;
	cv=none;
	b=7mna/9W8VZrqmrT8crJ71OWbHEjs35ipm4/ypHHskBPhURajouueRwexowP7pD+EaH1kMb
	ujeTGqLwQHgw9UArUPQSddjNMTBESWOJN8nDl8MUvMOWECSd4Du5KuhqjzZab2BvdOW5bg
	BTrMhWfgg3SZAj6/GmP72Fx3X+ET2yEhzNVknhNRIEVf7/4RhEUxy5SijCSSw+B3O/Ai49
	EtsAJ2bjXIg2/uQ8RTI8Rq3wLP0Xg05+8VZk4DDCeTXAe6ouGGXnfwXcNhzbgddDvMfv0x
	tYfXvdTunbUZLJVClE7EIXCQ7H1u1ZDwg3Ufv3cRE/hQoe6+Hp5Xv5T3OUc+5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1731218893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DpHBL6LkA2Z+is4T7QfHvroZ82RKmwriw+u1sBEXofo=;
	b=acRmOLc3wJoRCQIWa2EIn9AdJF67JMp+ySq/GXABaz+glApUY9J4pm+6GVJWs16F9S08P5
	lGbOLtx5bGTT9gmG/iD7EGTamHHDLAFp3vu++bB170EZdhiZykAu7/lHkESlEBDVLYTBmJ
	PdLbWSNKq1voT63vdCQJQUL+4qtEsOh2F3U8GlnJPF8Zot3/lO4PqaAU4f3EJz2W5vZxIJ
	23XKq4zNuX+ngS5030Lr5JEEfmjZLfyPEbHLnG0Eb7v+uXePvZzRbAVEcMnVQsP6TmRdO0
	j401XHDxZaXdGgv6lzslFdOdpeVsTOgUTpa64o3lp8/qBTjlEm/Gq38v0AvyOw==
ARC-Authentication-Results: i=1;
	rspamd-56654dd69b-v7p4n;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Power-Soft: 19ad23443bca797a_1731218893540_2797921575
X-MC-Loop-Signature: 1731218893540:138335719
X-MC-Ingress-Time: 1731218893540
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.135.172 (trex/7.0.2);
	Sun, 10 Nov 2024 06:08:13 +0000
Received: from p5b0ed864.dip0.t-ipconnect.de ([91.14.216.100]:64548 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <calestyo@scientia.org>)
	id 1tA17K-00000003PLw-3cIH;
	Sun, 10 Nov 2024 06:08:11 +0000
Message-ID: <b16286957f9b3d6409423b3b9b54c84c1c64fcb2.camel@scientia.org>
Subject: Re: set -e not ignored in AND-OR list
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org
Date: Sun, 10 Nov 2024 07:08:10 +0100
In-Reply-To: <ZzAyYf1ZWcSuPVJZ@gondor.apana.org.au>
References: <ZzAyYf1ZWcSuPVJZ@gondor.apana.org.au>
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

On Sun, 2024-11-10 at 12:11 +0800, Herbert Xu wrote:
> This is simply undefined behaviour.

Are you sure that this is undefined? Cause:

> The -e setting shall be ignored when executing the compound list
> following the while, until, if, or elif reserved word, a pipeline
> beginning with the ! reserved word, or any command of an AND-OR list
> other than the last.

... seems to define just that.

Or do you know of any part in the standard that allows an exception
from this?



> Some shells will ignore set -e
> within the command substitution subshell as a result of the ||, some
> won't.=C2=A0 Dash does the latter.

I know that bash ignores set -e per default in the standard (which I
think is however NOT POSIX compliant either), e.g.

bash without --posix:
$ set -e=20
$ echo "$(echo a; false; echo b)"
a
b
$

But bash with --posix:
$ bash --posix
bash-5.2$ set -e=20
bash-5.2$ echo "$(echo a; false; echo b)"
a
bash-5.2$=20


Cheers,
Chris.
