Received: from skyblue.cherry.relay.mailchannels.net (skyblue.cherry.relay.mailchannels.net [23.83.223.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8C214658F
	for <dash@vger.kernel.org>; Wed, 23 Oct 2024 19:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.83.223.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729710689; cv=fail; b=CqBm7h9z5GOp/yIblpkzF0hSjqw+udqFl5Y0SuooCwEsIsJRfVDbMCTPVYfY/zWlbAwrBriR0PqrnlPgDwUumTfek9NzAJcs33/Mn4PXxtnM0RF3QAi2kSkt/2AjC1QeOKSYDBMX7w1fXxMay5eYiGlO28iVF+OG8DHilbldje4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729710689; c=relaxed/simple;
	bh=2muYPCLxpBD+OqmeOd44IpgDAcDs1kzuCE7Wrx294LY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TlItPuVpdw8hdlHtNmdqMkyabw61jqNVf6QOnoai31HIr21x++6CiISOLiBnDk0WhQGxcuizq/Z49ua6sfd+y0hH8Htvs7vHtQqsUF6CE9nz+Z6dDJwQ9kKr+8NDrr7r5c/gRCTWZiyPHGEs7aKnBLKwtnVZT40v73HuauGqhE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=fail smtp.client-ip=23.83.223.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E0CA68A3710
	for <dash@vger.kernel.org>; Wed, 23 Oct 2024 19:11:21 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-5.trex.outbound.svc.cluster.local [100.103.26.202])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 3A60D8A5665
	for <dash@vger.kernel.org>; Wed, 23 Oct 2024 19:11:21 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1729710681; a=rsa-sha256;
	cv=none;
	b=n0LnuWLC0xlpyuwMqKAJSN3qmRgVj90jVVCjUKKYEyml6FqmGyLL0lgu9TBI9iNE84Dbh+
	kI8gobbHY/KEjsRqyf8O0d740KwL+DdQ5W5UnrR3VexmpVr+eAKULz9w52XyPJ0dFstRGd
	p95CrYx+qmV0VVDyjQVVwCY5mPYHslyIY26bSffvaoS7qf1z2s4WlaBPADHl1iO/gccQ5r
	Vyg47uNIQyba0O1mvSI5d9v/vxx/3exWzrHIZzKmgT9Td7GvU2u765Ke6eEoRlZWg1Ide9
	kZk9FGhZkGe/toPYV7lO4UAwH/D1enHKQS6Hhm+2EbBIv5xkBmqw9uN4UUuuFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1729710681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5qTPR1zgs7paMLk6BV4aYOzgazA4gbC2VjXRqQDwino=;
	b=4slfmwSdiKnatS5rBt5XZKQ2NblGlHrb//nB4fDfQyiK90mcggUwcM0edI1cjUTl2z/eNb
	8hxKE99VdV0/rWYFjaapYi46AncYWBrrslL34698oAztOCpuISKthiWnsG8hNcjpr5Pl1Y
	MkmQLMLpCII4+8g1Xt2mw2RpVxQuLeqdtOrqc31E5v6H2MooSZf7rWVcAVXW7bQkl43LAv
	AtToRl61qdvsHGRj7sLVn9w/sjbV4AXKraCnURVVmnlJf1eVg5Elkgs7E+arqsFKEBcc/s
	l/Yjc9fCbcIUrbImtg1fZ+VpOkNQnVhTxTXwbbRQqW9wGdLi9+yAbOL1zfLfBw==
ARC-Authentication-Results: i=1;
	rspamd-9bc7b7997-nbncr;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Soft-Chemical: 3beeaeaf0864b2ee_1729710681719_3177401084
X-MC-Loop-Signature: 1729710681719:318774065
X-MC-Ingress-Time: 1729710681719
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.26.202 (trex/7.0.2);
	Wed, 23 Oct 2024 19:11:21 +0000
Received: from p5b0ed864.dip0.t-ipconnect.de ([91.14.216.100]:62048 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <calestyo@scientia.org>)
	id 1t3glL-00000000vU2-0fXX
	for dash@vger.kernel.org;
	Wed, 23 Oct 2024 19:11:19 +0000
Message-ID: <4c2eab2c165792da4ef809d7e56fa1bcbd6a3d0a.camel@scientia.org>
Subject: Re: `jobs` within command substitution doesn't work
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: dash@vger.kernel.org
Date: Wed, 23 Oct 2024 21:11:17 +0200
In-Reply-To: <273c031d242d7610e4da37ceb9413c876f0168e0.camel@scientia.org>
References: <273c031d242d7610e4da37ceb9413c876f0168e0.camel@scientia.org>
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

From https://pubs.opengroup.org/onlinepubs/9799919799/utilities/jobs.html :

> DESCRIPTION
>
> If the current shell execution environment (see 2.13 Shell
> Execution Environment ) is not a subshell environment, the jobs
> utility shall display the status of background jobs that were created
> in the current shell execution environment; it may also do so if the
> current shell execution environment is a subshell environment.

So I guess dash is indeed allowed to behave as it does.


OTOH:

> APPLICATION USAGE
>
...
> The -p option is the only portable way to find out the process
> group of a job-control background job because different
> implementations have different strategies for defining the process
> group of the job. Usage such as $(jobs -p) provides a way of
> referring to the process group of the job in an
> implementation-independent way.

Which kinda implies (though in the informative-only section, of
course), that there's indeed some intended need for $(jobs -p).

So, could dash be made to behave the other way?


btw: While playing around, I've noticed that:
$ foo=3D"$(sleep 60 &)"
cannot be <Ctrl-C>ed in dash (which works in e.g. bash.).


Cheers,
Chris.
