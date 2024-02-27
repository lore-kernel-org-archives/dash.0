Received: from seashell.cherry.relay.mailchannels.net (seashell.cherry.relay.mailchannels.net [23.83.223.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACDD2D04E
	for <dash@vger.kernel.org>; Tue, 27 Feb 2024 05:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709011625; cv=pass; b=j8jtxsHNGhL97QJpUV4DGYOkoMsZadAQPYFFheNhrrSsaGWwVkWbJJU5yha1LgAQIfn27AFPx/s1WU87W+G/PVML+eMtLZRXMu0wstVj2xyTXDIM4axKcrYTvqQidyJIjFlOkp38BPTUufj2W8PDlkCowWMys68IWMgzPLq6NkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709011625; c=relaxed/simple;
	bh=eIcSEfth5pivFWmBuLXWG7x7Lp3ccoQneyIxGGaR6Ck=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZaLYuvxJxlwOJNjUvOcUt6QBEVLRlCj7EkP6hO283jJWm2YHteqgFCTym54Y9Au+3X8nkEJ3921qIgqeCjcBjeIREU9EWgRdx33/vHcEhd/2WkvcweIUwFdxvY52YlH5Cn2UybAQvO+IN9RQgLGtilKS/QkqM1n4AByPjw/6wsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.223.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9253C362DA8;
	Tue, 27 Feb 2024 05:11:10 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id AADAE363960;
	Tue, 27 Feb 2024 05:11:09 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1709010670; a=rsa-sha256;
	cv=none;
	b=IYbxZTci4ajq9PgMS33En5odVPSn0FStcieqEPABNuICjtljsEikeqegb2p4KX7eFHr/n3
	QxrAOtUrbT+PzaeVSuuY/GaWDJrxbcETwxnu2dsYDGyp5kYOrNlGZ5AredTvtPG0DIFZzy
	GWTDCo2eyYSdhQCxc8sQ09yox6fjvjbSkT3kaqJQBKuOpDoWDdMUUx13FG9WSEigGSsfRS
	5+unLpH++3bJ+YzLlQx6KaIfosmozuAAepVBEUt/adkmDjz7bmSOUI8RInHJklkuHtxicv
	/VeEdXARx1lM5sIesxnK4JmKt7YtlNaToblbG5ebxiMhNYz57DhT7TS/O9VOGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1709010670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+g4wZooqotDvr51GZpp48Vg5C5btIZC3cjqPAZcBg8=;
	b=0hF7UD2ZTWsgbGSuHIxDEv6Q8UZDhDOLKcLEmr8wd94zHXieqApdrG8tqb7ZULQq3EXOQx
	0YRb1KKtVkS+uAzMG4ZnaKtto9jrbM8ZUTwSl+eimmxEMK3+i0nyTuZphcToncf0v6JE3k
	VYLxgULXFgK7qXd5+ssOxZ+uIGKkSGnpcmeMulKFUnY6+yxBi6T7rlfgx65CtZwXZNHpKW
	abt6UlFfHKiugWxHNgQOyVFMeqgb7EsOOwIQi5Czxj7S3aZtVMzeFD8JVLoQCaqw9EZcXL
	9xO2ksDfTYlQc5oshWbABH73xLVh/Rv2d8oIWS9hRkgaLEIrQUSWYLzVSHjfdQ==
ARC-Authentication-Results: i=1;
	rspamd-55b4bfd7cb-dbnc6;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Reaction-Attack: 56f27ac725d7a120_1709010670350_1095159486
X-MC-Loop-Signature: 1709010670350:587469200
X-MC-Ingress-Time: 1709010670349
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.101.14.245 (trex/6.9.2);
	Tue, 27 Feb 2024 05:11:10 +0000
Received: from p5b0edc93.dip0.t-ipconnect.de ([91.14.220.147]:54228 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1repk9-0008IL-1w;
	Tue, 27 Feb 2024 05:11:08 +0000
Message-ID: <f101dc542647549d78bb17c96b88055874f5e722.camel@scientia.org>
Subject: Re: wrong behaviour when unsetting/setting some variables
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Lawrence =?ISO-8859-1?Q?Vel=E1zquez?= <vq@larryv.me>
Cc: dash@vger.kernel.org
Date: Tue, 27 Feb 2024 06:11:03 +0100
In-Reply-To: <e1f38631-18fa-4962-89ee-d9bddd83eb58@app.fastmail.com>
References: <43f0631aea36f6b49e5c3dfdfe481a5a2b1fec6c.camel@scientia.org>
	 <e1f38631-18fa-4962-89ee-d9bddd83eb58@app.fastmail.com>
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

On Mon, 2024-02-26 at 23:23 -0500, Lawrence Vel=C3=A1zquez wrote:
> They are not exported.
>=20
> 	% env -i /opt/local/bin/dash
> 	$ export MAIL=3Dv
> 	$ unset -v MAIL
> 	$ export
> 	export MAIL
> 	export PWD=3D'/private/tmp'
> 	$ env
> 	PWD=3D/private/tmp
>=20
> Their local counterparts are not exported, either.
>=20
> 	% env -i /opt/local/bin/dash
> 	$ f() { local FOO=3Dv; export FOO; unset -v FOO; export; env;
> }
> 	$ f
> 	export FOO
> 	export PWD=3D'/private/tmp'
> 	PWD=3D/private/tmp

Interesting.
I guess it simply doesn't export any vars for which no value is set
(i.e. not even the empty value)?!


Is that POSIXly correct?


Even draft 4.1 says only:
> The shell shall give the export attribute to the variables
> corresponding to the specified names, which shall cause them to be
> in the environment of subsequently executed commands.
at the description of export.

It doesn't say that variables with just the attribute should not be
exported.

OTOH, 8.1 Environment Variable Definition says:
> The array is pointed to by the external variable environ, which is
> defined as:
> extern char **environ;
> These strings have the form name=3Dvalue;

So one might argue, that env vars must have some =3Dvalue, and that this
couldn't be done for exported shell vars with no (not even the empty)
value.


It does seem to export a local exported var, if it has some value.


Cheers,
Chris.
