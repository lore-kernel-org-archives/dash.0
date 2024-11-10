Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ADD13B59A
	for <dash@vger.kernel.org>; Sun, 10 Nov 2024 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.248
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731265110; cv=pass; b=e2am5La55xWip9d0PXTpK6QwHuqq8QGkVydT5IkTTzv1ick2UfGC/C52cb9ukx9X5lxxzzvEO4CmDKwJ7D/EcPcZGIafOlSQQrl7G4vh76XStuRs7boM+9IE8FILPMbl8IUKBEkQN7z6tNuhjv6LiD2vIhglye6SBf3o6amuSaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731265110; c=relaxed/simple;
	bh=KKrq66Dn0DyS1k+2BfvVzy6ER2tpUJo8u7QkJAzczQA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LzKYa2/cKGRJUWi5E5mX5hvoTfWO4nHVyaBIrzl3NYGOSpuch7mb8gPQSjeAnJRRBs/3hBGtUtHljRUFGHCeHgFaTWxRTSQ40M1IWOXpvp0VXUJNOjEVhDFgrFEhrCFZ8iFJCwVZ/2wZKmp1DMf0psT+jd+VGphM/CVs+80Zino=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8F14882376C;
	Sun, 10 Nov 2024 18:58:22 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (100-112-47-183.trex-nlb.outbound.svc.cluster.local [100.112.47.183])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id A185D823579;
	Sun, 10 Nov 2024 18:58:21 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1731265102; a=rsa-sha256;
	cv=none;
	b=g3ES7QNwLpa9xcGa1WmOZsXKVTATnc5WnsYmY9Lb0VbIwkTa7+2ndOZd3F0VZ34H6jk2Et
	haJUz4HS15zlo7a/1c1/YengiFSlc8fwvMB42djAee1hkYrhLGUp2rakzEJKcT1Pv2e1f3
	UlagDLAk+o6AAfeAq4qxZQs2RGGZV2v3XgDr+WStB/b5DRi2x4gskyyMwYsfUU/AyhudxW
	NJ8/seKqFZzDXDUqMcop+MpdvdBRx6jdEIAS1XI9EScOOarD8gdUsw+L7eYJBazeR77lDO
	hOQB2cF1NgC/fDVbo6gYNYlcHM4RP+5jYdXHGQ2fVq2wTub+6WB7IUl4NtBngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1731265102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=riWoW1Mje54X8KT1BoGyAejJBI0v5/KmZl6qexW4FxA=;
	b=qLzT0cxVYQ7+q2EZB0gg2wNrSTRm2MqI+dixOzOMjpAo8fwz53zqyA9qZaSocqLUuLuhi0
	z0VQ4FseieGocinlkcZaKlwQTzTN7QjNqWcmCjFimcWPTx7APHmTNgPqGK7anJlvaZSTLr
	kI+1G4GhpHgAObpAxKY2JZPvzHTWZBL/KLQNZmaIYaQfjxSstGjA99sPG77yH54VchoDs4
	p8U5lLBBT//RAI0et2pl/OysPdcVllrD9FqEl6pHBZ8dGEjl+lq62UsuwQq1mjVQ0aidvX
	jDu6X8oDR+fTYpqED18XwpRto7+VwUcnYNqsZBq9Z3AiZIeVHzpTElSC94HTFg==
ARC-Authentication-Results: i=1;
	rspamd-56654dd69b-qcw2j;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Reign-Robust: 4c7d701d5d6fbc2c_1731265102463_181758588
X-MC-Loop-Signature: 1731265102463:2100724652
X-MC-Ingress-Time: 1731265102463
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.112.47.183 (trex/7.0.2);
	Sun, 10 Nov 2024 18:58:22 +0000
Received: from p5b0ed864.dip0.t-ipconnect.de ([91.14.216.100]:61886 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <calestyo@scientia.org>)
	id 1tAD8d-00000006ALk-2yM9;
	Sun, 10 Nov 2024 18:58:20 +0000
Message-ID: <20715fc311f5d3655e2d6d9dc1a911e8cfbccc3f.camel@scientia.org>
Subject: Re: set -e not ignored in AND-OR list
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Harald van Dijk <harald@gigawatt.nl>, Herbert Xu
	 <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org
Date: Sun, 10 Nov 2024 19:58:18 +0100
In-Reply-To: <65b72665-6d65-446f-b32b-968c6116ef1e@gigawatt.nl>
References: <ZzAyYf1ZWcSuPVJZ@gondor.apana.org.au>
	 <b16286957f9b3d6409423b3b9b54c84c1c64fcb2.camel@scientia.org>
	 <6496f8a6-bf07-4c4c-bbb6-3ce42dc378bd@gigawatt.nl>
	 <85df2488f78032cfb64acc98ec2c483bc1fb03e5.camel@scientia.org>
	 <65b72665-6d65-446f-b32b-968c6116ef1e@gigawatt.nl>
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

On Sun, 2024-11-10 at 17:06 +0000, Harald van Dijk wrote:
> > Herbert still said it (I presume the ignoring of set -e) would not
> > apply to command substitution subshells, though I haven't found
> > anything yet, which would mandate this.
>=20
> To be clear, I'm agreeing with your understanding of what POSIX says.

Yes, I've understood it that way :-)


> Basically, my view is that the way 'set -e' is specified to work is
> only=20
> useful for the most simple basic cases. The way it is specified to
> work=20
> is not really useful for anything more complicated. The way it works=20
> differently in bash, in non-POSIX mode, is to make it useful in more=20
> cases, but still not all.

Yes. The more complicated the program gets the more "unpredictable" it
seems.
>=20

> In dash, the effect of 'set -e' in a
> command=20
> substitution is that a command is never considered "tested", unless
> that=20
> testing happens inside the command substitution, and it would be
> useful=20
> for that to be documented.

The way set -e is currently documented (with "tested" vs. "untested")
in the manpage is IMO already a bit strange.

But your text makes it rather even more complicated O:-D

What about something like:
 The exit status of a command
+(excluding any commands within command substitutions therein)
 is considered to be explicitly tested if the
 command is  used to control an if, elif

or so...?!

I mean AFAIU set -e is NOT ignored only for the commands IN the command
substitution, but IS still ignored for the overall result of the
command substitution (as part of an if, while, etc.).


>=20
> > If it's however long standing behaviour of dash (and perhaps
> > others),
> > maybe POSIX should instead be revised.
>=20
> Yes, that would be my preference.

Another "downside" of allowing command substitutions to ignore the
ignoring of set -e is however that things get even more complicated.

I mean it's already crazy enough that for pipelines only the ! negated
ones and for AND-OR lists only all but the last elements are affected
by the set -e ignoring.
Generally excluding command substitutions from all these cases would
make it even more complex to understand and easy to forget while
coding.


Cheers,
Chris.
