Received: from insect.birch.relay.mailchannels.net (insect.birch.relay.mailchannels.net [23.83.209.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9203B7C09C
	for <dash@vger.kernel.org>; Thu, 29 Feb 2024 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709210368; cv=pass; b=FO2mnWkTOhU3B2Vmrh3tf3msqV3qkknRAoUti3RvmJuVsJEhZlWfdr7XkNXPeUrDJOelMfyT4AAcBjTrtcjo1zq9Jn4iaU7d22zY6bE1RtjOyYkQUEQWa51d3Xa5qVP2s5yi7L//MKL8hAaumHBmgVND/4KzIDiH3Yw0oEiFdUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709210368; c=relaxed/simple;
	bh=0GjIjvFMUTzOLAgvrLg/PJ4Yrt30yinSbC8+6vYAitU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MQLIsUEWwXshC1NWlIlsfyKAddkegcc6Nl0sXDYBMhDLJBsQDNZjPL7WeiUxgko2QZZ7nuGbH6T6L22TbleJlK9MF2fpUGrmK3CgZ2IdKgHtYpXO3NgbxCUkU740u1fzw7quwNiJ+KRtt898DpkHO9wNAGzmExsQdNlzmSA+Rkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.209.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A768941AD5;
	Thu, 29 Feb 2024 12:29:41 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id C84B9418B9;
	Thu, 29 Feb 2024 12:29:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1709209781; a=rsa-sha256;
	cv=none;
	b=EH8SDwv8glfA7gn2yPEl2YBSi2qQz33uXVOQXRpQLWGgtSiHtU7qkAsE/0Vi2ZuUY48t32
	A1aG77VApVHWfNASUnw+Hx4+MDVzQhYS7llM98aLlm0G6oTHCaQkV3R/sxRUM+f6hCRQ2N
	0T1gt/BrIaeyXB+thSSkUTPMINE5Jwt05pDnI31BFNhKkVoosZiC5c4f2j3JtUk30abywg
	O32PdaYzJbGRUfodINtMB3yo0GquvHrhkMNAIsAxylNiJTRGQAZWhXv4IEe3qlxoDx7V4x
	1zK/QbtMRxcRDQV2XlbhluoUAd64+SmsnyukYxo1SnWTHVcOAbA/FgqxAaBvnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1709209781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0GjIjvFMUTzOLAgvrLg/PJ4Yrt30yinSbC8+6vYAitU=;
	b=2Uf4/P38FFw7/VMLH7HbP+BsTcmzVnIgk9tKjGgbPTBahbIvNNLBzoPmvYftazuKm1EHmS
	r9Lo8biSQyH3BttHYP4mHFvqXmGhFozaaJm39GfNd4i8BcgqDou5cOoGU7pgiGSITVer8r
	sYL/SfENMy1JR05ZnajffV5zLAhWu95qSd5+i0amBvBwsUY7Jx/H6vOdrVj6rlzFj/EQfV
	gCp/U6UQxJr1AQSjwK+kO/cwW53/WWDmhXlVy63nNucnQFlRBtM7dsb/FNoHCY7CZYoSWj
	Jh7FQW/zJAMnVy4/2W/lQFdGg+MKAACM9Qk9niy6NL+ROXIU1+T/lBe1YP2NBg==
ARC-Authentication-Results: i=1;
	rspamd-7f9dd9fb96-4725m;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Cooperative-Reign: 36eba8b24844404e_1709209781449_1818850370
X-MC-Loop-Signature: 1709209781449:199115492
X-MC-Ingress-Time: 1709209781449
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.111.192.177 (trex/6.9.2);
	Thu, 29 Feb 2024 12:29:41 +0000
Received: from p5b0edfc2.dip0.t-ipconnect.de ([91.14.223.194]:54322 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rffXe-000541-0m;
	Thu, 29 Feb 2024 12:29:39 +0000
Message-ID: <4ca7f5600a243a884c12616b24644e78a56a988a.camel@scientia.org>
Subject: Re: wrong behaviour when unsetting/setting some variables
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Lawrence =?ISO-8859-1?Q?Vel=E1zquez?= <vq@larryv.me>
Cc: dash@vger.kernel.org
Date: Thu, 29 Feb 2024 13:29:33 +0100
In-Reply-To: <00e1ca47-2cbc-4d00-a1bb-f7ea6115d1ce@app.fastmail.com>
References: <43f0631aea36f6b49e5c3dfdfe481a5a2b1fec6c.camel@scientia.org>
	 <e1f38631-18fa-4962-89ee-d9bddd83eb58@app.fastmail.com>
	 <f101dc542647549d78bb17c96b88055874f5e722.camel@scientia.org>
	 <00e1ca47-2cbc-4d00-a1bb-f7ea6115d1ce@app.fastmail.com>
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

On Tue, 2024-02-27 at 02:53 -0500, Lawrence Vel=C3=A1zquez wrote:
> That's my understanding:=C2=A0 Environment variables must have values
> (even empty ones), so unset shell variables cannot be placed into
> the environment.=C2=A0 One might propose that a valueless environment
> variable could be represented as "name", but the standard requires
> that environment strings contain a "=3D".

And yet:
> The shell shall give the export attribute to the variables
> corresponding to the specified names, which shall cause them to be
> in the environment of subsequently executed commands.

would IMO mean that export attribute alone decides whether it's
exported or not - not whether it has a set value.

Unless set -u is given an expanded unset shell variable would give the
empty string, so one could say that the similar concept would apply
when the shell exports a variable that has the export attribute but no
set value.


Maybe I should open a ticket at austinbugs, asking for clarification.
Perhaps also for the issue that Harald pointed out in his mail (about
set -a + readonly).


Cheers,
Chris.

