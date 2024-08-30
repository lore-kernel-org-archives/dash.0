Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9DA1BE24B
	for <dash@vger.kernel.org>; Fri, 30 Aug 2024 20:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725049067; cv=none; b=TffAP619YcyT3SmbUOCx2gz46HeeZOyLnFR7yFLM4xU32Kcz/2ndALUU8bomxknhUTHi8bEfsIyTfN5kCXVX64qvxIowl+hp9ZnmCpo72RUppx9B59q/N15bRXIgsddy0LDDQlr3UPN4qru0+mrUk+EKvYblmevcb+r5UcY/+pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725049067; c=relaxed/simple;
	bh=zkIjc68gQ0WOxWgcY57GWHYmh1y4xG6JaOjCYQkMzo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ale49ZXRtUutwor0FpCjGlwPnHDpeFRf3UNHngPVv/2/ulXvwqnZEd/IugpYxc0WfjjA4/aiJAxvIChnysvJrs4RxcLOsVDhWq27ibD2ND9KruoCUeqh2Jb0OAiSazSV09xlGDvAaAFLaH4J1kTiBsFsDBjWr/3ZVQL9vFKr6h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=ORWln+xO; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="ORWln+xO"
Received: from [IPV6:2a02:8010:68a1:0:aa8:4aa0:420a:466c] (unknown [IPv6:2a02:8010:68a1:0:aa8:4aa0:420a:466c])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id 53EC951;
	Fri, 30 Aug 2024 21:11:03 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 53EC951
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1725048663;
	bh=XsB+XI64X+RbB3AqvhyFvu/zg4m/DohDiGYve1dMjdc=; l=1412;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ORWln+xO/fhMdG6aQbJ0bDmjDBPQQjYadc76q/zAshcaSLfpUjOXBeiAAZs6Eh8iQ
	 0dSeLS51ltOSExHA8oEDfGMken6paRgLschdxW1FWWYk03s0zrBLZU4maBy5H/L9+G
	 TTMOhqhJ5mre/YnEjsK39IQLvs8qVelCqO8ZpyMk=
Message-ID: <58645737-6af4-493e-8674-378c574fa78c@gigawatt.nl>
Date: Fri, 30 Aug 2024 21:11:00 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Why does the command builtin not circumvent invocation of
 builtins?
To: =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>,
 dash@vger.kernel.org
References: <9098f57c-66f1-40fc-a714-b73d208c81d6@anselmschueler.com>
Content-Language: en-US
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <9098f57c-66f1-40fc-a714-b73d208c81d6@anselmschueler.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 30/08/2024 19:28, Anselm Schüler wrote:
> The dash(1) manpage reads:
> 
> command [-p] [-v] [-V] command [arg ...]
>         Execute the specified command but ignore shell functions when 
> searching for it. (This is useful when you have a shell function with 
> the same name as a builtin command.)

This implies that it does not ignore builtin commands, because otherwise 
it would not be useful for this purpose.

> Because of this, I expected commands like command . or PATH= command 
> true to fail. They don’t.

. and true are builtin commands, not shell functions (at least not by 
default), so they are found.

This is how it is meant to work. The parenthesised comment is there to 
highlight that you can do things such as

   echo() {                  # shell function
     command echo "$@" >>log # builtin command
     command echo "$@"       # builtin command
   }
   echo hello # call shell function to print both to log and to stdout

(Mind you, this is an intentionally silly example that nobody should 
write this way, it just demonstrates the concept.)

Here, it is important for "command echo" to find the builtin command, 
not the shell function. If it found the shell function, this would 
recurse infinitely. If it did not find the builtin command, this would 
not necessarily print anything.

This also matches how "command" works in other shells as well.

Cheers,
Harald van Dijk
