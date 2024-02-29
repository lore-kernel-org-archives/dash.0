Received: from freekahlil.inlv.org (freekahlil.inlv.org [46.19.33.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF8416063E
	for <dash@vger.kernel.org>; Thu, 29 Feb 2024 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.33.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709229798; cv=none; b=LleCkQ1OlF+dSVszzW4JZwoFkdOZzF38jPQMkqE8nZzdrYW97qAYstpoBY1X4s+dsyw9iEi1djAHWopZGMa7iQjwGxb0b8S+6uobFnAlQ151prLl8WkJrlx1+R+sKWhz+R4Wxh7nYWz/YyU4xU9HvyQWADjQQu43aSO+kiMQVZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709229798; c=relaxed/simple;
	bh=5vf+CRQ/dEOdkOpqbeYbwc/1Ck/x9qOo1FWLIsWhf98=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MStGoK1ueOB8JH+XMlrgQG2g9/sjVCY4gJ9irDRvvYd45AYdbUzZwkwhB87CWXoIul63y8NAIlpyF0B+9xYo57SE9Y0gpj6sb82IJWdrVvl/N/X2AkD7rEB/gLv9R80PLBQDTYF13JdAa15fSrhzmbN/qbbf1t1WLMKt7SYzQQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org; spf=pass smtp.mailfrom=inlv.org; dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b=Bf2OLNz3; arc=none smtp.client-ip=46.19.33.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inlv.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b="Bf2OLNz3"
Received: from [IPV6:2a00:23c6:5398:5e01:e9a4:9d87:9bf2:8847] ([IPv6:2a00:23c6:5398:5e01:e9a4:9d87:9bf2:8847])
	(authenticated bits=0)
	by freekahlil.inlv.org (8.16.1/8.16.1) with ESMTPSA id 41TI3DLG067530
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO)
	for <dash@vger.kernel.org>; Thu, 29 Feb 2024 19:03:13 +0100 (CET)
	(envelope-from martijn@inlv.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inlv.org; s=inlv;
	t=1709229793; bh=5vf+CRQ/dEOdkOpqbeYbwc/1Ck/x9qOo1FWLIsWhf98=;
	h=From:From;
	b=Bf2OLNz3E7ZAeCGYGHvHdaaOYWPRFiD9IrWzXzlIWMTE9R2CKeA8+U5g/E4ZTqrkJ
	 738gN3Ai/IVzeRsbOSpJ+0+KBq6rtL9lhx6Y9UdX7RfvSOvvF8wPR+aiKGCn6tx106
	 5fX8o5oDyWffK8ROgVK0UCUnXxHfvvn8JGKDjdHs=
Message-ID: <a4dbc820-7fb3-4d94-82ab-fce90515cdf1@inlv.org>
Date: Thu, 29 Feb 2024 18:03:13 +0000
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
 <c9c6b3d32b50694db5639fe26c2651ae49533e48.camel@scientia.org>
From: Martijn Dekker <martijn@inlv.org>
In-Reply-To: <c9c6b3d32b50694db5639fe26c2651ae49533e48.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Op 29-02-2024 om 12:24 schreef Christoph Anton Mitterer:
[...]
> One might also argue like this:
> * -a says "the export attribute shall be set for each variable to which
>    an assignment is performed".

Further on, that same paragraph also contains:

| [...] or if the assignment is a result of the operation of the getopts or
| read utilities, the export attribute shall persist until the variable is
| unset.
So 'getopts' and 'read' are two examples of where the variable should be 
exported, and neither do an explicit shell assignment. While the language is 
indeed not very clear, this implies that the variable should indeed be 
exported in all cases where a variable assignment is actually performed.

AT&T ksh 93u+ was also broken in this regard. In ksh 93u+m, I've fixed it by 
moving the 'set -a' functionality into nv_putval(), its central shell 
assignment function, so that the variable gets exported whenever the shell 
performs an assignment for any reason and in any context.

-- 
||	modernish -- harness the shell
||	https://github.com/modernish/modernish
||
||	KornShell lives!
||	https://github.com/ksh93/ksh

