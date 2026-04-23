Received: from mail.gigawatt.nl (mail.gigawatt.nl [82.165.170.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB5524E4A8
	for <dash@vger.kernel.org>; Thu, 23 Apr 2026 07:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.165.170.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776928490; cv=none; b=HJkg8j4B/mFGiIOe3cd133m9geH4Rh4yX0/Wz6agf+7oHqWcpvrAAikDEgZLp+PnUrbH9bp5s3IqqNGvxiy6mJs3kbYKSyaVKSixAC/uGQ07RhboIxzc/SYTpFuavL0vz6PEVoFdq2rBIqK1igm0YWJjjJzQSVKQ+o/GSxpgc4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776928490; c=relaxed/simple;
	bh=wHRJScZYePh6Mim1RQlL/u1hfietqBTvhlMaPgSGJuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gC0Lx/aMKjL4nxG+gd0LnAwYeOYKg1QHbjBYtb2gkf/kFy+p42IlLdq5T8+RW8z3IkW/4jQZ+IKugNJJgtLU+IURAmax0rjiumpd7bG6Ys9AwqMrBSqPXNIXIzkdedNnuHLvC0yGovN2lseyYTcg2wkMDssiEptVDewChOJbjDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=Y31KGfYz; arc=none smtp.client-ip=82.165.170.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="Y31KGfYz"
Authentication-Results: mail.gigawatt.nl; dmarc=fail (p=none dis=none) header.from=gigawatt.nl
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 50DB4A2CB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1776927919;
	bh=nuwIsXfmSwYL09s8En2H7kk03PRtq+DQ+UlGkeFY/j0=; l=1089;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Y31KGfYzgaTPMSo+qz0gAI10GN20ciYek4lWLriiFQX3SGdC1zMHXeVYceGCHPifg
	 BCbidQjXOa8oTO2kq54e7HExOpXXBcsLAaBPfuXNeSlMYU+BgkNJSi09EU5yl9EjeL
	 sp+5PvubfxVbyKEh53ppjCSbbOLfBMjCEmHoOCCw=
Received: by mail.gigawatt.nl (Postfix) id 50DB4A2CB9
	for <dash@vger.kernel.org>; Thu, 23 Apr 2026 07:05:19 +0000 (UTC)
Message-ID: <b7d62511-4a17-427e-ab7b-468f9896e6de@gigawatt.nl>
Date: Thu, 23 Apr 2026 08:05:17 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: stty -echo doesn't work?
To: dash@vger.kernel.org
References: <aemGV--9_pn_ABU2@HQ>
Content-Language: en-GB
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <aemGV--9_pn_ABU2@HQ>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/04/2026 03:39, Sebastien Peterson-Boudreau wrote:
> apologies if this has been posted before.
> 
> I just noticed that the following command
> 
> 	$ stty -echo
> 
> does not work in an interactive dash(1) shell.

Hi,

stty is not a shell built-in command and dash has no control over what 
it does. Running this locally, what seems to be happening is that the 
command did work, but when dash is using libedit for command editing, it 
immediately gets reset when prompting for the next command. This seems 
to be intentional on the part of libedit, it resets the tty to a known 
good state when it knows it needs it, but I am not sure whether it is 
also intentional that that reset state persists after it has 
successfully read the next line.

What behaviour are you expecting here? Are you expecting echo to still 
be turned off when entering the next command, or to be turned off again 
after the next command has been entered successfully? Both options, as 
well as dash/libedit's current behaviour, seem reasonable at first 
glance to me.

Cheers,
Harald van Dijk
