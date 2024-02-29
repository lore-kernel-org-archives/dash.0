Received: from freekahlil.inlv.org (freekahlil.inlv.org [46.19.33.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BACE160649
	for <dash@vger.kernel.org>; Thu, 29 Feb 2024 18:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.33.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709229623; cv=none; b=tdRRgavVEEzXpNcKX1rRVBZTUO4a4kEmrNYVlo6G9euV9/FIAMwHrZVL3RKBlvR8Y1No8wINe/Nr3H51F4OYdV5tA4VEuG07/t7AI029LWnDtF3uPp8XmU8+YqDR4JCNWseJn2Fi30Wdibrxn2R15QWGmAucwx9op/mIs8ItWDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709229623; c=relaxed/simple;
	bh=wReQa65I+n3+B2twk7t+N9tymVQmsc4HUns8UqOHvZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lJYK+3Nf05wMd84p6RNeKmn5v4cp5Mh96KH0zjWC0sknPR/MnsXGsyY8WxozKQ3nrb5Y7YJlJiTxO4Fk1XHZuVJJ8fhoiGpHxfLno7dWTp04Av6vx3RTLeiQMPoVex+MLjJfQORJYnyFMpzaEvMjyAndplfVA6ARD/dkgSZacXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org; spf=pass smtp.mailfrom=inlv.org; dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b=kFQ99l0r; arc=none smtp.client-ip=46.19.33.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inlv.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b="kFQ99l0r"
Received: from [IPV6:2a00:23c6:5398:5e01:e9a4:9d87:9bf2:8847] ([IPv6:2a00:23c6:5398:5e01:e9a4:9d87:9bf2:8847])
	(authenticated bits=0)
	by freekahlil.inlv.org (8.16.1/8.16.1) with ESMTPSA id 41THf9am067359
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO)
	for <dash@vger.kernel.org>; Thu, 29 Feb 2024 18:41:09 +0100 (CET)
	(envelope-from martijn@inlv.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inlv.org; s=inlv;
	t=1709228469; bh=wReQa65I+n3+B2twk7t+N9tymVQmsc4HUns8UqOHvZs=;
	h=From:From;
	b=kFQ99l0rOAPcRM85MW+yoCPuQjH5RvvFNFhk10I+OukTxrTBgV/TJbHVW6TsmjVUX
	 FuB6ibC2SNWIUiIJt0iF0HiAmiuPgT7Lxc36SEgar6E8YmxLe8BqXjTohAOcxXdnPr
	 HTKV7PhfWAveTWUIgpUBHhcFwZuludjZqUS+dxo4=
Message-ID: <0fd6f8b9-7175-4cc9-9d99-586beb3ede48@inlv.org>
Date: Thu, 29 Feb 2024 17:41:08 +0000
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
 <ac893750-085d-421a-b296-a182ae51f1ec@gigawatt.nl>
From: Martijn Dekker <martijn@inlv.org>
In-Reply-To: <ac893750-085d-421a-b296-a182ae51f1ec@gigawatt.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Op 28-02-2024 om 00:56 schreef Harald van Dijk:
> However, trying to fix this I come across a corner case where it is not 
> clear to me what the intended behaviour is.
> 
>    set -a; readonly foo=bar; export # some shells export, not all

IMO, the shell should export it in that case; POSIXly, 'set -a' should cause 
the variable to be exported whenever a value is effectively assigned to it 
(whether this is by a "true" shell assignment, an assignment-argument, an 
expansion like ${foo=bar} or ${foo:=bar}, indirectly by 'read' or 'getopts', 
or maybe other cases I'm not thinking of).

-- 
||	modernish -- harness the shell
||	https://github.com/modernish/modernish
||
||	KornShell lives!
||	https://github.com/ksh93/ksh

