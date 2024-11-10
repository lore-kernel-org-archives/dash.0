Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5096450EE
	for <dash@vger.kernel.org>; Sun, 10 Nov 2024 20:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731269347; cv=none; b=OEBCUvxbEY1JM9hXNQaNnYpdqgRsrrADlonI1GtY5Fb9lKnixOswlBM5Lw5zB9xJrP15Q97ClGkRxkH+1a+MggB/LOvbXlIIUSN/0ncBIKzmwyUrNIjYumZHiIPj73j2HDSiM4QNJ/iZuq19fglbClbWcPBdubzZ5D8PQJ0f1xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731269347; c=relaxed/simple;
	bh=5DqxgeMO4nigUWZJYeUa+iPdc8i6X6QRhthJ3Sc1wuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FI4S0MkntIb6YJvYlNU4A5fdWX6VIyUfe4Ps3vVkC5KBR/Asb2EEv0UH1Oj+XXDbY0kNZKJB1Vh9ZU+BOOVE8DjrJPmqSCheMGSAa7GYlj8AL4uh4H2ss75lW+QJQLKZBqwACFJ8jHhTFcjK1fyOJZIJkPuaZgIiZrBCiNhXiKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=O/3eRl9A; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="O/3eRl9A"
Received: from [IPV6:2a02:8010:68a1:0:c3eb:cbfe:ac4b:964a] (unknown [IPv6:2a02:8010:68a1:0:c3eb:cbfe:ac4b:964a])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id B476D32;
	Sun, 10 Nov 2024 20:09:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl B476D32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1731269340;
	bh=bgwzr/CbEw3PPmgTuQcpTwOltMSaDQsI6r/EiFTHGYI=; l=4320;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O/3eRl9A/xOJyjID3jBEUue5vszYoGvllIOwUlH/exjnuNDJ6qRiGAJ8tvfAO909n
	 QegAuAXQIHzLoroJ8tXoKthTEH5i5Df9+HkjS0wb4IXmS8VQYuIsd3gkmE3pjiE3s9
	 wO4Fc96FHn2WULueZeWN1huXhuY+SsodKhBZjBe4=
Message-ID: <be8c2692-ab69-46f2-a487-2f99452a0c2f@gigawatt.nl>
Date: Sun, 10 Nov 2024 20:08:59 +0000
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
 <6496f8a6-bf07-4c4c-bbb6-3ce42dc378bd@gigawatt.nl>
 <85df2488f78032cfb64acc98ec2c483bc1fb03e5.camel@scientia.org>
 <65b72665-6d65-446f-b32b-968c6116ef1e@gigawatt.nl>
 <20715fc311f5d3655e2d6d9dc1a911e8cfbccc3f.camel@scientia.org>
Content-Language: en-US
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <20715fc311f5d3655e2d6d9dc1a911e8cfbccc3f.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/11/2024 18:58, Christoph Anton Mitterer wrote:
> On Sun, 2024-11-10 at 17:06 +0000, Harald van Dijk wrote:
>> In dash, the effect of 'set -e' in a
>> command
>> substitution is that a command is never considered "tested", unless
>> that
>> testing happens inside the command substitution, and it would be
>> useful
>> for that to be documented.
> 
> The way set -e is currently documented (with "tested" vs. "untested")
> in the manpage is IMO already a bit strange.

The way that 'set -e' is currently documented would be useful, but does 
not match what is implemented.

Basically: what the current documentation is saying is that every 
command gets an implicit "|| exit $?" added to it, unless there is more 
specific error handling in the script.

But that is not what POSIX specifies, and what dash implements is closer 
to what POSIX specifies, but not exactly what POSIX specifies. The 
manpage suggests that

   $ dash -c '(set -e; false; echo 123) && echo 456'

would output nothing. Of course, what happens instead, in all shells 
that I know of, is that this prints "123" followed by "456".

By POSIX's wording, that's right: "The -e setting shall be ignored when 
executing [...] any command of an AND-OR list other than the last." and 
there is no denying that that subshell is executing.

By dash's wording that's wrong: the "false" command is not the left hand 
operand of an "&&" operator, it's only *part of* the left hand operand 
of an "&&" operator.

My personal first preference, which I realise will not and should not be 
implemented because it disregards POSIX, would be to leave the 
documentation as it is, and adjust dash's behaviour to match the 
documentation.

Adjusting the documentation to match the current implementation would be 
my personal second choice.

> But your text makes it rather even more complicated O:-D
> 
> What about something like:
>   The exit status of a command
> +(excluding any commands within command substitutions therein)
>   is considered to be explicitly tested if the
>   command is  used to control an if, elif
> 
> or so...?!

I think the current behaviour would be covered by:

   The exit status of a command is considered to be explicitly tested if 
the command is used to control an if, elif, while, or until; or if the 
command is the left hand operand of an "&&" or "||" operator; or if the 
command is part of a list of which the exit status is tested.

> I mean AFAIU set -e is NOT ignored only for the commands IN the command
> substitution, but IS still ignored for the overall result of the
> command substitution (as part of an if, while, etc.).

Correct, 'set -e' is in full effect during command substitutions.

  $ dash -ec 'var=$(false; echo foo) || echo foo; var=$(false; echo 
bar); echo bar'
  foo

Here, the list 'false; echo foo' is (arguably contrary to POSIX) not 
considered the LHS of an "||" operator, therefore 'false' causes the 
whole subshell to exit, the 'var=$(false; echo foo)' command is 
considered to fail, but that command has its exit status tested so 
execution continues.

Likewise, the 'var=$(false; echo bar)' command is considered to fail, 
that command does not have its exit status tested, so execution stops.

>>> If it's however long standing behaviour of dash (and perhaps
>>> others),
>>> maybe POSIX should instead be revised.
>>
>> Yes, that would be my preference.
> 
> Another "downside" of allowing command substitutions to ignore the
> ignoring of set -e is however that things get even more complicated.
> 
> I mean it's already crazy enough that for pipelines only the ! negated
> ones and for AND-OR lists only all but the last elements are affected
> by the set -e ignoring.
> Generally excluding command substitutions from all these cases would
> make it even more complex to understand and easy to forget while
> coding.

IMHO, what dash's manpage currently states is clear and useful, and if 
that were actually implemented, the fact that it does not affect 
subshells would be a natural consequence, not a special exception.

The difference between treatment of subshells in command substitutions 
and subshells outside of command substitutions does make it more 
complicated to understand though.

Cheers,
Harald van Dijk
