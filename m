Received: from mail.gigawatt.nl (mail.gigawatt.nl [82.165.170.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3FF2BD587
	for <dash@vger.kernel.org>; Wed, 12 Aug 2026 02:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.165.170.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786502913; cv=none; b=rOTRSFh40go24hJ9Wtuc6pV/vvNHNnSdg2illLEz2Ewfu9ky+ViLc48Z6neaKP+W27vTll/77qrWGMD6jn7XjF6hGnV13RGMVjelWO3NsBGz4ZVSU3CX+RSMsDWxonADzOi73U6NgFSvkhCQjJRC3t/YzjOqBTvsAR/J4RMK3qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786502913; c=relaxed/simple;
	bh=LzM+zeSbygwML8/5iThnqI5XfyYVwWPF/0MbDz11dcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oPq2hhQrwRATLPDHIrP8FriDBslGLBzFswy4zi+LZwXfK+qbvIyJVqQL1PJOqeG+swwHu3H/31lyAGX3waPhsfOn1ak86KsSkLLnX0YkPVhlsp9w+gWgEawrUmfu/RmvqUPZgoXI71xuHBd5skyuQvz61c357AbuV2alCKWJCu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=RFU1roTz; arc=none smtp.client-ip=82.165.170.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="RFU1roTz"
Authentication-Results: mail.gigawatt.nl; dmarc=fail (p=none dis=none) header.from=gigawatt.nl
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 9E177A3C2E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1786502569;
	bh=8yn4JfRqHEBNjk0mrexwSpVZWY9sq3dn0cAN70F41PY=; l=1424;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RFU1roTzAWo3lH0U21V8y4B+dZCVfQ7DyfQIyjG7/VS+BmXhaRHhfqlHv1c6XHSaH
	 A36SqtNZ9dx5Xl6x3g0NvroP7KhfkGx3N82C9a+eLXBRoxZl4RhJ0juxCvj07mco3K
	 VavbIFUAEVsFg4Wodl5slN0w0Yl7dnfdpCfrGXbE=
Received: by mail.gigawatt.nl (Postfix) id 9E177A3C2E;
	Wed, 12 Aug 2026 02:42:49 +0000 (UTC)
Message-ID: <291da48e-d705-4469-a4bf-a1e0b133b29d@gigawatt.nl>
Date: Wed, 12 Aug 2026 03:42:48 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: `command -p` Not Searching Path
To: Martijn Dekker <martijn@inlv.org>, Nathan Royce
 <nroycea+kernel@gmail.com>, mail@anselmschueler.com
Cc: DASH Mailing List <dash@vger.kernel.org>
References: <CALaQ_hrYRcp1_+1KPx9UXMtMb8UgRRJCRj9Y6JBCc73ogO7jmw@mail.gmail.com>
 <b2006311-d818-440a-a2ac-d8f55037d8c6@inlv.org>
Content-Language: en-US
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <b2006311-d818-440a-a2ac-d8f55037d8c6@inlv.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/08/2026 12:38, Martijn Dekker wrote:
> Op 09-08-2026 om 20:49 schreef Nathan Royce:
>> 5) $ command -p echo //SHOULD have been from PATH, which we made to
>> be a copy of `ls`
> 
> 
> The '-p' only changes one thing about the behaviour of 'command': it 
> causes the system's default path list (as shown by 'getconf PATH') to be 
> used instead of $PATH while doing a path search. The purpose is to 
> ignore the user's $PATH setting in cases where it shouldn't be trusted. 
> In other words, the option guarantees the use of known-good standard 
> utilities.
> 
> The option changes nothing else, so this still only disables the lookup 
> of aliases and functions -- not builtins, which continue to take 
> precedence over external commands. It's not possible to change this 
> without breaking compatibility.

This is all correct but it is worth pointing out this is an intentional 
deviation from POSIX in (almost?) every shell. POSIX specifies that 
builtins should be associated with a specific directory, so that PATH 
can override builtins.

In dash, if any entry in PATH is %builtin, builtins are checked at that 
point in command lookup and earlier entries can override builtins. With 
dash 0.5.12, where echo is implemented as a builtin which does not 
support \x, but /bin/echo does support \x:

$ src/dash -c 'echo "\x40"; PATH=$PATH:%builtin; echo "\x40"'
@
\x40

Cheers,
Harald van Dijk
