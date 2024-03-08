Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B6B56464
	for <dash@vger.kernel.org>; Fri,  8 Mar 2024 11:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709898819; cv=none; b=dUfSKyR11+mJT0HsOIfehd5ghc3ZS1+RyjP3UAhq7MWL6zkJ5SKvwAuebdhxof/fvJhMrpw6m181tPMgLqgZHqAwWR2USZt54DpyCV+zrHdI5N3HzLpI+dtQYX6HTfDPiwQhXo0KIT85zg+S+S0vbcWfV6ElLir4Ca1g+ySqb+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709898819; c=relaxed/simple;
	bh=71jLNJBMQHLz5FO3dlfSvkruJxqjggxwxLi15+VKKhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DgkETHTWqmRlDyRauFsqunSa7gz4gHXHrE23vSGrVxE+egGiD4FABkhbX1WuBGmsjyj7XOAgPe63pwdT2pN2lnB/b6CqZQC4xcV34Kpyrm38ZLu6lRypoxT5mc2uA+vPjWU8IYp6+B7ZpTdXfKp8OvFc6DX/q5lAbItKFa5PZrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=QTZ7hqTa; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="QTZ7hqTa"
Received: from [IPV6:2a02:8010:68a1:0:e69:c5c8:93ab:b95] (unknown [IPv6:2a02:8010:68a1:0:e69:c5c8:93ab:b95])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id 8F18D72C;
	Fri,  8 Mar 2024 11:48:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 8F18D72C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1709898494;
	bh=S/fAwTo5R4emgNOxhJklp9wUdE7QaS9UuteP5CC18n0=; l=1047;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=QTZ7hqTaZHiY4aHO2iO7z/040jCFp72l+IIMTTyHnT/aJEtcFdiUcux368VwbAZms
	 xPQk8cmz+lJOZiYN+dbsxsg2vjd5O0xXjSAkH9mEOLaOlHqlH6nUrOF4OIl6JyxT4P
	 fqhRgS+4TzQvKDloJ9sA6m3ym3ltkJFVgErXfxJA=
Message-ID: <b42dbf13-989d-4609-bbcb-8b9eababbe65@gigawatt.nl>
Date: Fri, 8 Mar 2024 11:48:11 +0000
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] Allow trap to override permanently-ignored signals in
 background shells
Content-Language: en-GB
To: Johannes Altmanninger <aclopte@gmail.com>, dash@vger.kernel.org
References: <20240308110158.2459219-1-aclopte@gmail.com>
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <20240308110158.2459219-1-aclopte@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 08/03/2024 11:01, Johannes Altmanninger wrote:
> TL;DR: I think this job should exit on Control-C.
> 
> 	( trap - INT; sleep inf ) &

The TL;DR is oversimplified: Control-C would not result in SIGINT being 
sent to the sleep command, because it runs in the background.

Your fuller version, I agree, I think that is a bug in dash. There are 
some more known bugs in its handling of the trap command in subshells 
that require a bigger rework (particularly the one where, despite traps 
being reset in subshells, the 'trap' command should print the parent 
shell's traps if called in a subshell) that maybe should be looked at at 
the same time.

> In general, I wonder if SIGINT is only for actual shells, and SIGTERM
> is the signal to use in our situation.

SIGINT is not limited to shells. At first glance, sending SIGINT to 
another process or process group upon receipt of SIGINT, because that 
other process or process group is what it was intended for, seems like 
an appropriate use to me.

Cheers,
Harald van Dijk
