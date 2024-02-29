Received: from freekahlil.inlv.org (freekahlil.inlv.org [46.19.33.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009F5224D7
	for <dash@vger.kernel.org>; Thu, 29 Feb 2024 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.33.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709232346; cv=none; b=O0dzoDTLRtsLpO6KOqa9aU3FTBFCM0wElo/wkwgXLSvhxwxVvDOZ83h88mzmMIP4ZFN6fA3SNWmIa0ZZKgL5dveiwYyNd2xPEBEhU7QA6oWE/PQm50ZUB9pKGkOe25lne/pJjDtmD79ui6fDKbwKwktTMEbrFo6LpLMoK9bQ1cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709232346; c=relaxed/simple;
	bh=bqi7KkWyNtile2CXrxI8UP1fGeKaj1mGIktD76D8hPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DOnah55ghlGGgmDmERI2j8GLzdsZc5FZIRyLMUqEYBNjF7dPVd/Bt9NvKb7Iqu6Ym6g7QXRZOCGvh0s7+XYexTbpNnI4IUqg0GvE6LPPq4U9jlvdIB4ugeRkqpGxAknvOa9eqdCYFvv8KX/HN3DSX4XFVvN2pujpp6GUCPT3mEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org; spf=pass smtp.mailfrom=inlv.org; dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b=HRLCDFbB; arc=none smtp.client-ip=46.19.33.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inlv.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b="HRLCDFbB"
Received: from [IPV6:2a00:23c6:5398:5e01:e9a4:9d87:9bf2:8847] ([IPv6:2a00:23c6:5398:5e01:e9a4:9d87:9bf2:8847])
	(authenticated bits=0)
	by freekahlil.inlv.org (8.16.1/8.16.1) with ESMTPSA id 41TIjdu8067845
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO)
	for <dash@vger.kernel.org>; Thu, 29 Feb 2024 19:45:39 +0100 (CET)
	(envelope-from martijn@inlv.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inlv.org; s=inlv;
	t=1709232339; bh=bqi7KkWyNtile2CXrxI8UP1fGeKaj1mGIktD76D8hPI=;
	h=From:From;
	b=HRLCDFbB9IgcSiV6aOWrN49X+vG238HGMUYHZ0+NuewaGtGzLBAM9HOvlxrlFsTo1
	 wyF4daXq5MMSr44MVusqgXvTZX7oxKSqSFZIKmDatIA7I1hWa/DEZpO7mdS8v+mmo1
	 vEEI8XJLSuhrQGsoZEV8htYZBieRnc4x4A65grtA=
Message-ID: <4bcfdb66-c60f-4172-9f4c-cc25c3e99ddc@inlv.org>
Date: Thu, 29 Feb 2024 18:45:39 +0000
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
 <0fd6f8b9-7175-4cc9-9d99-586beb3ede48@inlv.org>
 <252ec2b0-70dc-4621-96c2-285aa915cce0@gigawatt.nl>
From: Martijn Dekker <martijn@inlv.org>
In-Reply-To: <252ec2b0-70dc-4621-96c2-285aa915cce0@gigawatt.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Op 29-02-2024 om 18:07 schreef Harald van Dijk:
> On 29/02/2024 17:41, Martijn Dekker wrote:
>> Op 28-02-2024 om 00:56 schreef Harald van Dijk:
>>> However, trying to fix this I come across a corner case where it is not 
>>> clear to me what the intended behaviour is.
>>>
>>>    set -a; readonly foo=bar; export # some shells export, not all
>>
>> IMO, the shell should export it in that case; POSIXly, 'set -a' should cause 
>> the variable to be exported whenever a value is effectively assigned to it 
>> (whether this is by a "true" shell assignment, an assignment-argument, an 
>> expansion like ${foo=bar} or ${foo:=bar}, indirectly by 'read' or 'getopts', 
>> or maybe other cases I'm not thinking of).
> 
> Spec-wise, the thing that troubles me is that the option is specified as
> 
>  > When this option is on, the export attribute shall be set for each
>  > variable to which an assignment is performed; see XBD Variable
>  > Assignment.
> 
> where XBD Variable Assignment is only about the assignment syntax of the 
> shell, not other syntax or other commands even if they also cause variables to 
> become assigned.

Yeah, that's confusing (and IMO should be fixed in the spec), but that same 
paragraph goes on to mention 'getopts' and 'read' as examples of utilities 
that perform assignments. In other words, though 'read var' is no XBD 
"Variable Assignment" assignment, it's stated explicitly that 'var', on which 
'read' performs an assignment, should gain the export attribute.

-- 
||	modernish -- harness the shell
||	https://github.com/modernish/modernish
||
||	KornShell lives!
||	https://github.com/ksh93/ksh

