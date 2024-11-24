Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9340418870B
	for <dash@vger.kernel.org>; Sun, 24 Nov 2024 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732461781; cv=none; b=MJeWiSvCju103LVv4VPgcCuKgjpT2SQsbwkcUt5hGj1e8SknV2yLb+X2kK9vAmpPGpx/Ibl098tUaLcovugx7euOT/OP0N99KdRaEFWCUyA+9U/Q71COJ/UwpWbG+Zeefq4Uav0ni4+ASqM0PspxNJ/Q5uV3TbHma0qM7nvMSic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732461781; c=relaxed/simple;
	bh=XVWd5mQh4+WDr8mcLV6jVhmQlKZUi3fiiOp7kNbuzMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fccac9gdtGqzWPNvxTbCfQb0L2lt1EeiOoDDo37hZl//IdKoywpKCtUmFaIdiE31CyxD2DSFRZTjFUFUIPq0p9PHoutrFY3gk+t90aVYHBVjVb4kv1SIx1/SdDgyWt9PGQs2z0mewxPPv7EQWeTA1CwRUVsQecFSyiNCsIL8p7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=UX6249jE; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="UX6249jE"
Received: from [192.168.168.208] (unknown [178.229.9.76])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id 9BCA61A0;
	Sun, 24 Nov 2024 15:15:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 9BCA61A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1732461350;
	bh=cIe5AGFtUbw1Mq6zASk6WUf00ypnGVLcHprUnfVRyYs=; l=1965;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UX6249jEmpyVijb34T9jd5VqXteDglQaN0cIV124/AgVEOFW0si1pU8YMdcu7iFSj
	 Apaq7xvH0vIWDF8x8cBD5uW+4YyKsVwv/ZudetOldOGR1NvKab6nn+gc3x8z8NWpGB
	 tY0LxCIgt2tcfGyus54G5+sDWPwQKRBPfZHx0/ZQ=
Message-ID: <838decd8-c703-49b5-94cb-054f4572e1e9@gigawatt.nl>
Date: Sun, 24 Nov 2024 15:15:49 +0000
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: set -e not ignored in AND-OR list
To: Herbert Xu <herbert@gondor.apana.org.au>,
 Christoph Anton Mitterer <calestyo@scientia.org>
Cc: dash@vger.kernel.org
References: <ZzAyYf1ZWcSuPVJZ@gondor.apana.org.au>
 <b16286957f9b3d6409423b3b9b54c84c1c64fcb2.camel@scientia.org>
 <6496f8a6-bf07-4c4c-bbb6-3ce42dc378bd@gigawatt.nl>
 <85df2488f78032cfb64acc98ec2c483bc1fb03e5.camel@scientia.org>
 <65b72665-6d65-446f-b32b-968c6116ef1e@gigawatt.nl>
 <20715fc311f5d3655e2d6d9dc1a911e8cfbccc3f.camel@scientia.org>
 <be8c2692-ab69-46f2-a487-2f99452a0c2f@gigawatt.nl>
 <ff11abc014305b31343cc220fa503b927d3e4454.camel@scientia.org>
 <Z0MU448KJwA-03C4@gondor.apana.org.au>
Content-Language: en-GB
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <Z0MU448KJwA-03C4@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/11/2024 11:58, Herbert Xu wrote:
> On Sat, Nov 23, 2024 at 04:22:52AM +0100, Christoph Anton Mitterer wrote:
>>
>> @Herbert, you've said that you believe dash's behaviour is POSIX
>> compliant.
>> But I still couldn't find anything in the text which would imply
>> this... and Harald who typically knows things quite well also seems to
>> believe that POSIX doesn't allow it.
> 
> It's simple really, POSIX says:
> 
> 	or any command of an AND-OR list other than the last.
> 
> The word "command" refers to the commands that make up the AND-OR
> list.  Command substitution is not part of that at all.

Isn't it? Taking the rest of the sentence along with it:

   The -e setting shall be ignored when executing [...] any command of an
   AND-OR list other than the last.

So, given

   set -e
   test -n "$(false; echo x)" && echo x

the -e setting shall be ignored when executing

   test -n "$(false; echo x)"

That much I think is not in doubt.

What does it mean for that command to be executed? 2.9.1.1 Order of 
Processing says:

   When a given simple command is required to be executed (that is, when
   any conditional construct such as an AND-OR list or a case statement
   has not bypassed the simple command), the following expansions,
   assignments, and redirections shall all be performed from the
   beginning of the command text to the end:

     [...]
     2. [...] For all other command names, words after the word that
        produced the command name shall be subject only to regular
        expansion.
     [...]

That is, the expansion of words in a simple command is considered part 
of the execution of that command. When the "false; echo x" is being 
executed, this is part of the execution of test -n "$(false; echo x)". 
Because that test -n "$(false; echo x)" command is being executed, and 
it is a command of an AND-OR list other than the last, by what POSIX 
says, the set -e setting shall be ignored.

Cheers,
Harald van Dijk
