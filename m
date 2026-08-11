Received: from freekahlil.inlv.org (freekahlil.inlv.org [46.19.33.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C00543D50D
	for <dash@vger.kernel.org>; Tue, 11 Aug 2026 12:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.33.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786449606; cv=none; b=d09hD99nuYQAuI/eP5VDNlteuJckEIOkZ/VNhvzTDZhfvGl7JKPMP61uvj1XyKYXuibqLXTSlfzUgF/uGIl5RlPjYu3AeRcOAPDnhdEOLtlSV8HF7hASSu8khuIWh7B5wH/HsXpMllODzCTEiz8uwR5pRJcgl7/sL1noBZ8wIjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786449606; c=relaxed/simple;
	bh=6WHDgsri+Ha93VxSPbA4c8BqmRbLW3SbfRkzVBf0Cmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=speq2q7ntIGEWBFAMOYnEJ2NS8yD3/M4KDD/VghqDH2Ita/LowS+a2XlfUR7jxp8c8X65upOwQaIl3Yfg7HfZVKylOaq8JrmLJ1uzAd6WVKI5f3nBUGPplyQlSCNm09+LijUnLkhe0IIFCAdl9habVH1jo0czyITsXCA6czaxIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org; spf=pass smtp.mailfrom=inlv.org; dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b=XX4FJvP2; arc=none smtp.client-ip=46.19.33.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inlv.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b="XX4FJvP2"
Received: from [192.168.1.218] (host81-133-56-137.in-addr.btopenworld.com [81.133.56.137])
	(authenticated bits=0)
	by freekahlil.inlv.org (8.18.1/8.18.1) with ESMTPSA id 67BBcgQ2098133
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 11 Aug 2026 13:38:43 +0200 (CEST)
	(envelope-from martijn@inlv.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inlv.org; s=inlv;
	t=1786448323; bh=6WHDgsri+Ha93VxSPbA4c8BqmRbLW3SbfRkzVBf0Cmo=;
	h=From:From;
	b=XX4FJvP2gyMMuhI/qOU4FBRdhwsr7pAWJFWBjeUqb/a0MJMcOIkB8zUGuGUINk5R8
	 zpQTMA4ZAYZzndmKFuMaXlK3t3l5vSq+rrCDzoFhq50vtpQW9inF73HaqK4asGHbBY
	 K3taBHcS0AmN+YNBFJ+mCYUImS6H8bIeL8/gI1gA=
Message-ID: <b2006311-d818-440a-a2ac-d8f55037d8c6@inlv.org>
Date: Tue, 11 Aug 2026 12:38:42 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: `command -p` Not Searching Path
To: Nathan Royce <nroycea+kernel@gmail.com>, mail@anselmschueler.com
Cc: DASH Mailing List <dash@vger.kernel.org>
References: <CALaQ_hrYRcp1_+1KPx9UXMtMb8UgRRJCRj9Y6JBCc73ogO7jmw@mail.gmail.com>
From: Martijn Dekker <martijn@inlv.org>
Content-Language: en-GB
In-Reply-To: <CALaQ_hrYRcp1_+1KPx9UXMtMb8UgRRJCRj9Y6JBCc73ogO7jmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Op 09-08-2026 om 20:49 schreef Nathan Royce:
> 5) $ command -p echo //SHOULD have been from PATH, which we made to
> be a copy of `ls`


The '-p' only changes one thing about the behaviour of 'command': it causes 
the system's default path list (as shown by 'getconf PATH') to be used instead 
of $PATH while doing a path search. The purpose is to ignore the user's $PATH 
setting in cases where it shouldn't be trusted. In other words, the option 
guarantees the use of known-good standard utilities.

The option changes nothing else, so this still only disables the lookup of 
aliases and functions -- not builtins, which continue to take precedence over 
external commands. It's not possible to change this without breaking 
compatibility.

-- 
||	modernish -- harness the shell
||	https://github.com/modernish/modernish
||
||	KornShell lives!
||	https://github.com/ksh93/ksh
