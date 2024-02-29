Received: from freekahlil.inlv.org (freekahlil.inlv.org [46.19.33.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07800757F0
	for <dash@vger.kernel.org>; Thu, 29 Feb 2024 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.33.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709229492; cv=none; b=VNR5ptLiYxNn6l1K2Hze0bHN9w16U6MnLx0uaXpAcivWCEWLApSosGr4tALWogDfG+/pWifogRMNV23mGd2kk/HA8hf8kFY7qZAzJRANZ8rFQMsAiMnDHR2/y6VQOjfb+sv9KcCx0EGzRrv2Ac4EzJXg00FHcJNMYgG6ny9r8GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709229492; c=relaxed/simple;
	bh=fV1VOyjj8vx0R9duQy0b2CB+B2J0ihy6fv4blpuo95E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cuKvvLbi9Lyx6Tb5c1Yr0a4WrXcMknZoMh1L8318AgAcxZWHrqWDgPNFMJ/GNId0c/PnHlfSBRjldFrxTUK44cYL3ikmWlICbrdwaYC6ckTG0OtYWL+mlQeQyEgPy6t8UWZIBMzapwvELjouhFH4mebSUj0w0IDqJwbqXmYxa8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org; spf=pass smtp.mailfrom=inlv.org; dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b=osnpQGkX; arc=none smtp.client-ip=46.19.33.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inlv.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b="osnpQGkX"
Received: from [IPV6:2a00:23c6:5398:5e01:e9a4:9d87:9bf2:8847] ([IPv6:2a00:23c6:5398:5e01:e9a4:9d87:9bf2:8847])
	(authenticated bits=0)
	by freekahlil.inlv.org (8.16.1/8.16.1) with ESMTPSA id 41THw4Nc067459
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO)
	for <dash@vger.kernel.org>; Thu, 29 Feb 2024 18:58:05 +0100 (CET)
	(envelope-from martijn@inlv.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inlv.org; s=inlv;
	t=1709229485; bh=fV1VOyjj8vx0R9duQy0b2CB+B2J0ihy6fv4blpuo95E=;
	h=From:From;
	b=osnpQGkXtaMH3tU5mkNHKPkqzzQJ+WmISTV0dbI1V3ZewO1iyDu00Z4rEMMy3lAPl
	 gFAa92FZV3UWt7BqNaalsRTup9dGo2cVvrOSN2K05qG7k+52O2ilaBWnirWULC208u
	 0vp32oDQ2alwVy5CukS9QXWE7Wi5zg6isT7c+eEI=
Message-ID: <96806056-0aa2-467b-9460-71f142b71bad@inlv.org>
Date: Thu, 29 Feb 2024 17:58:04 +0000
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wrong behaviour when unsetting/setting some variables
Content-Language: en-GB
To: DASH shell mailing list <dash@vger.kernel.org>
References: <43f0631aea36f6b49e5c3dfdfe481a5a2b1fec6c.camel@scientia.org>
 <e1f38631-18fa-4962-89ee-d9bddd83eb58@app.fastmail.com>
 <f101dc542647549d78bb17c96b88055874f5e722.camel@scientia.org>
 <00e1ca47-2cbc-4d00-a1bb-f7ea6115d1ce@app.fastmail.com>
 <4ca7f5600a243a884c12616b24644e78a56a988a.camel@scientia.org>
From: Martijn Dekker <martijn@inlv.org>
In-Reply-To: <4ca7f5600a243a884c12616b24644e78a56a988a.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Op 29-02-2024 om 12:29 schreef Christoph Anton Mitterer:
> On Tue, 2024-02-27 at 02:53 -0500, Lawrence Velázquez wrote:
>> That's my understanding:  Environment variables must have values
>> (even empty ones), so unset shell variables cannot be placed into
>> the environment.  One might propose that a valueless environment
>> variable could be represented as "name", but the standard requires
>> that environment strings contain a "=".
> 
> And yet:
>> The shell shall give the export attribute to the variables
>> corresponding to the specified names, which shall cause them to be
>> in the environment of subsequently executed commands.
> 
> would IMO mean that export attribute alone decides whether it's
> exported or not - not whether it has a set value.

No shell currently behaves like that, and it would make no sense, as 'unset' 
and 'empty value' are distinct states.

However, the variable will be exported once a value is subsequently assigned 
to it, without the need to re-invoke 'export'.

$ unset foo; export foo; printenv foo  # not yet actually exported
$ foo=bar; printenv foo                # but now it is

-- 
||	modernish -- harness the shell
||	https://github.com/modernish/modernish
||
||	KornShell lives!
||	https://github.com/ksh93/ksh

