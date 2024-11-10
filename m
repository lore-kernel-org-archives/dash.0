Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC4B14AD0E
	for <dash@vger.kernel.org>; Sun, 10 Nov 2024 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731233490; cv=none; b=rpoI0JjpHWjjwmNCvqVXYtzkbStPG5/OZF/ucfgvarfoC1Pck/HCqHUAaFo55rhk/CSlBQAJYAaNTmY/GjffCq2wtAMdiMe6m7RErGKjjUSXY8fif3lcny6tfxkB472Q1ETWH30N/irhBHcaRnFlrxcfIVIe9mujibXXjZoiYpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731233490; c=relaxed/simple;
	bh=DG9Lzy+PTRcKvxlMwJPaWGL4VXTJw57+sTH8bAzFRzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YKOiY1kAmNgZR4gCrJ7qacAhdTql+NbQo33uMEkrqqS4gStcadEkHCneyAjxb5cjTgLoBZOx/9BnoPxPW1rmeKBJC+LPipNI58FynkRq8VzCbNE6uMkYUaAXmboAhZiWb34EYNF7RS9cbLUm/lxvrCGnqNZMBxDsWqsG4qjcTyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=K0kFVJst; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="K0kFVJst"
Received: from [IPV6:2a02:8010:68a1:0:bc47:f906:f20d:2ef2] (unknown [IPv6:2a02:8010:68a1:0:bc47:f906:f20d:2ef2])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id 8043F32;
	Sun, 10 Nov 2024 10:04:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 8043F32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1731233096;
	bh=VSw/gTmRj6Hng3aGAsQ5WA6FSgJ65HqHhUUyCYelWng=; l=1202;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K0kFVJstdb2iaj/pRRmlfKUKsS9HbMOlRhNNFhrG7fwxph++Kq2KYz4J0Mhb/20Hy
	 vb4wzvVCNpGv5YpW8aLt3Z6MM3w64CO3KXFcpBT8zGJR7LvKHR/bFz546tkAZw7e/R
	 39jKHeDBGfqrfT9CPbl7BVyE0QKzDhRmg/0IprO0=
Message-ID: <6496f8a6-bf07-4c4c-bbb6-3ce42dc378bd@gigawatt.nl>
Date: Sun, 10 Nov 2024 10:04:54 +0000
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: set -e not ignored in AND-OR list
To: Christoph Anton Mitterer <calestyo@scientia.org>,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org
References: <ZzAyYf1ZWcSuPVJZ@gondor.apana.org.au>
 <b16286957f9b3d6409423b3b9b54c84c1c64fcb2.camel@scientia.org>
Content-Language: en-GB
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <b16286957f9b3d6409423b3b9b54c84c1c64fcb2.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/11/2024 06:08, Christoph Anton Mitterer wrote:
> On Sun, 2024-11-10 at 12:11 +0800, Herbert Xu wrote:
>> This is simply undefined behaviour.
> 
> Are you sure that this is undefined? Cause:
> 
>> The -e setting shall be ignored when executing the compound list
>> following the while, until, if, or elif reserved word, a pipeline
>> beginning with the ! reserved word, or any command of an AND-OR list
>> other than the last.
> 
> ... seems to define just that.
> 
> Or do you know of any part in the standard that allows an exception
> from this?

I think you're right that POSIX specifies the behaviour.

I think Herbert Xu is also right not to want to make changes here.

The reason why bash by default behaves contrary to what POSIX specifies 
is that what POSIX specifies is not useful. In command substitutions, 
ignoring set -e in the way that you are asking for is even less useful.

Ignore what POSIX specifies for a moment. Is there any situation where 
the behaviour you are asking for is what someone who writes 'set -e' 
would want? Is there a real use case that would be helped by making this 
change? If there is, I am not seeing it.

Cheers,
Harald van Dijk
