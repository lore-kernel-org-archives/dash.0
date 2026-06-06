Received: from mail.gigawatt.nl (mail.gigawatt.nl [82.165.170.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7393019D07A
	for <dash@vger.kernel.org>; Sat,  6 Jun 2026 23:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.165.170.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780787022; cv=none; b=Lwog/ydxkqHS5H4k+htR3kL3M0sArMWDsXZYKOQ1WfjjfsCqP5Ujon399X45jcoDSAuJKWLV/VPFEBF54eyAX2zvb0N7aCEsPOkQF44tHrtM3ljPxYAcPtRh4obIZzULQm0ykyHsU/3tX240yd1Lc+XMcJVTMjrGc3npSIZ1spM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780787022; c=relaxed/simple;
	bh=0ny/c1vnF18ZsxRkr5I/J5x/ScbgaOdFLV2hRfgxEsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kS7jPjATUcFeBdKjAYfnbLTFMF0j2o02+C6lzs+4oszlNuYRkaFhhl4hi5n6e1Uofg+MB1xNIErq8OFlisE4YXEXIaTEexlwBV6lnke3HD7uikmLMfVbwaVeAPMvBENrd8p340tekl74FBO7ipc8bGkWAxiUr36p7fnZDS02Lcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=EQsF4paD; arc=none smtp.client-ip=82.165.170.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="EQsF4paD"
Authentication-Results: mail.gigawatt.nl; dmarc=fail (p=none dis=none) header.from=gigawatt.nl
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 4A8ABA226D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1780787019;
	bh=YtNdmafMx/8igtL9711HWuP1NL2stkr+zlBiVZotlMI=; l=1195;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EQsF4paDRN1AeHw7iVYq2cZJuKjG2aeoOC6Z4iYSF7YXb8dJfkrJ/7fcwwtztgc5A
	 IDYaNGLnMRehNpRAyYMS7uQm/0M0q9eGvDLQy/tjXlKT0rrm1Md8T33FV8+4vo0D89
	 /kNwVs6pSzZCShNFKsphAnefXcwvDYHfigu2Wep4=
Received: by mail.gigawatt.nl (Postfix) id 4A8ABA226D;
	Sat, 06 Jun 2026 23:03:39 +0000 (UTC)
Message-ID: <1ae76552-1f2b-4d21-8fe5-f632ac0f7ba8@gigawatt.nl>
Date: Sun, 7 Jun 2026 00:03:38 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] exec: Print absolute paths for command location queries
To: Kerin Millar <kfm@plushkava.net>, calestyo@scientia.org
Cc: dash@vger.kernel.org
References: <2d20377774340d1612d4f3a9243bfefd36afff60.camel@scientia.org>
 <20260606153634.119074-1-kfm@plushkava.net>
 <7dc9a5c3-7c50-4d52-b46d-7ad4477a24ae@gigawatt.nl>
 <e9b50e6f-7b82-43f0-a1ac-3bd40e0653c8@app.fastmail.com>
Content-Language: en-US
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <e9b50e6f-7b82-43f0-a1ac-3bd40e0653c8@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/06/2026 18:48, Kerin Millar wrote:
> Hi Harald,
> 
> On Sat, 6 Jun 2026, at 6:27 PM, Harald van Dijk wrote:
>> I think leaving it as printing a correct relative path is better than
>> printing a possibly wrong absolute path, personally. A change to print a
>> correct absolute path would have my support though, for whatever that is
>> worth.
> 
> It's a good point. How about using getcwd() and printing the relative path upon failure, even if to do so would not be strictly conforming?

That would be one way that sounds good to me.

What I did is check if $PWD and . are the same file (using stat() and 
comparing dev and ino), if so using $PWD, if not fall back to getcwd(). 
This approach has the advantage that if $PWD is e.g. /bin where getcwd() 
would return /usr/bin, and both are absolute paths that refer to the 
same directory, the user-specified spelling of the directory is used.

Another option instead of getcwd() is a hardcoded /proc/self/cwd, 
although it will not necessarily be portable to non-Linux systems.

I do not know which of the options would be preferred for dash, but I 
would not personally object to any of them.

Cheers,
Harald van Dijk
