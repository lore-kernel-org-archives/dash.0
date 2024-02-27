Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C0A52F62
	for <dash@vger.kernel.org>; Tue, 27 Feb 2024 07:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709020453; cv=none; b=l9PQouQCNbTj9+gT2pk1iATVK/egD3ZsaFzwkHh9AXAoy3Yz4937Jeq/uykSXOZ54Hz/mDuGg5lhWnTvNY8lZTGIQgADiA1Uh09AMCK/CSo+w/53kkTSMneIcG1Cc9fU8jsyr5Wr+7sK//wWB0vqCwf65D/oDTK/m+ggmsfx8wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709020453; c=relaxed/simple;
	bh=lpoSf/ssA3QT3xJS94E/TPIGG8C+5TAWSz+QEHxPVW4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=mxtuwdJCTflTr78Hca/IpnohU1v+uQ/h9dcEoIy/cjhFnqhH84Eh+xVwL2yi5jio+Hbd0XoQYQcLZxS2Ji+nvrqc5wbhgnPVttVdnPCpRH49C+aoNbv1fN8BvOutEbsAad0m7gqrSP73JiJVwBtxd6Fv7+d3ndHgmQAs+It2wjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=larryv.me; spf=pass smtp.mailfrom=larryv.me; dkim=pass (2048-bit key) header.d=larryv.me header.i=@larryv.me header.b=ZBaBaxf+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=APO1ari+; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=larryv.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=larryv.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=larryv.me header.i=@larryv.me header.b="ZBaBaxf+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="APO1ari+"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id C564D1C00081;
	Tue, 27 Feb 2024 02:54:10 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Tue, 27 Feb 2024 02:54:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=larryv.me; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709020450; x=1709106850; bh=zg7Yn5t7oC
	Jb9+S0z00+o3+U2YdTrI9h2r5h4HRGjco=; b=ZBaBaxf+hKabjjqGt9Rm4i1PlN
	gN/OZkz0zgBFxscQtpmc4VWZ4xHRJeLqF2ZCEjFm7RR0KYXKRmdUNbfkZrwCER3x
	rJpVpTyn6e211xFmXCh5EF6RYWnGtjBSj1DPhkcAK7RaYPunk4mnpQ10aVhKh14O
	RKxdS1jlwEqIucY84xFj2lSsITlUPPsa+5btDZ8blcq4vjPmrvBiVaMqGcmH0HIP
	U38fjDhJVgwfusXcW5KvzsmhCtJaHLK29MCfqYuclZL5Pc/WHvHmTj03DpTn1Wwa
	RUn6CsQI7ZRcFMfbTInuAg5oxVHTTVW2x8t//5rCo87SYELeb/27IRBB4OGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709020450; x=1709106850; bh=zg7Yn5t7oCJb9+S0z00+o3+U2YdT
	rI9h2r5h4HRGjco=; b=APO1ari+y61S2opduf61kfQqO1gHm8dtbsvX6fMbM7D+
	9IVmfb9PCETpevaGRfIaAaT6hj42HZkLo3nC1u6fY0NcYLJ8qe9wou4u45+CIgPz
	6TPNB2BhAqerzS2tp2yYZE0ow2/xdyhULGWo5SL98ZavzbDWduujk/T78v/hKXtt
	l+0IWmhw1VNU46+hTQCn61O5ZdmrCPwB6s7kOvXofDhWWoGmSc86b+fMqRhGF1/S
	j1LepgRLSsG25sUlyF56u6BAdPurP6XL/4hhJmegK4QUfpb8dq8r0rB3DOu0KUhh
	BQBNEf8zpMPXp2T2MdxYYzVMHkTV/jWJL2tdgTQfxA==
X-ME-Sender: <xms:IpXdZcND2LINbT1iU-WH0_0g7dkk2CMwBg5S7wNwkAU9zcv-E-OdIA>
    <xme:IpXdZS8osEx2dOgTOiPNkHiTjBWmI7pAj5-RTZd1XKOLWWYqx-GoUKXg3pGOh8Io9
    _wuhYp-r54AwnC_vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeefgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreerjeenucfhrhhomhepnfgrfihrvghntggvucggvghljoiiqhhuvgiiuceovhhq
    sehlrghrrhihvhdrmhgvqeenucggtffrrghtthgvrhhnpeffhfehueejudduleefueevhe
    etkefggedvgfdvuefhieduieetffehleejveeileenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehvqheslhgrrhhrhihvrdhmvg
X-ME-Proxy: <xmx:IpXdZTSuz697vhYzXk8Dtz8RxFbuUInbt6CO-zWoar1MdaMJrumQkw>
    <xmx:IpXdZUtQw2bwRY7cCii8NDYJpcrIeFJ_egE_bgnj5cAAPncTL6cahw>
    <xmx:IpXdZUdWtIZtccfl2jndzPa31OnsACteFwxVlUV4g3DXW8u7dU9BxQ>
    <xmx:IpXdZQH6OdmhlDe15Kg2g3agOI0abk-rKdMIf60mebIQ37jE7JiG5WnSstc>
Feedback-ID: i0b2842c6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0F95331A0065; Tue, 27 Feb 2024 02:54:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <00e1ca47-2cbc-4d00-a1bb-f7ea6115d1ce@app.fastmail.com>
In-Reply-To: <f101dc542647549d78bb17c96b88055874f5e722.camel@scientia.org>
References: <43f0631aea36f6b49e5c3dfdfe481a5a2b1fec6c.camel@scientia.org>
 <e1f38631-18fa-4962-89ee-d9bddd83eb58@app.fastmail.com>
 <f101dc542647549d78bb17c96b88055874f5e722.camel@scientia.org>
Date: Tue, 27 Feb 2024 02:53:49 -0500
From: =?UTF-8?Q?Lawrence_Vel=C3=A1zquez?= <vq@larryv.me>
To: "Christoph Anton Mitterer" <calestyo@scientia.org>
Cc: dash@vger.kernel.org
Subject: Re: wrong behaviour when unsetting/setting some variables
Content-Type: text/plain

On Tue, Feb 27, 2024, at 12:11 AM, Christoph Anton Mitterer wrote:
> OTOH, 8.1 Environment Variable Definition says:
>> The array is pointed to by the external variable environ, which is
>> defined as:
>> extern char **environ;
>> These strings have the form name=value;
>
> So one might argue, that env vars must have some =value, and that this
> couldn't be done for exported shell vars with no (not even the empty)
> value.

That's my understanding:  Environment variables must have values
(even empty ones), so unset shell variables cannot be placed into
the environment.  One might propose that a valueless environment
variable could be represented as "name", but the standard requires
that environment strings contain a "=".

-- 
vq
