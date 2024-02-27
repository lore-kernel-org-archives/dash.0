Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60CA1B27D
	for <dash@vger.kernel.org>; Tue, 27 Feb 2024 03:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709003755; cv=none; b=utkbLHaBh+TGmKti714q2C9DuuFWTudOzVk1DH6sPxaKW1TpntDNxyNemc7puQkx2zHX8BVdMwjce/TTiOjyJ6IAUKPdaeLHD5/zOFR8RNsXMKgARFjFA/IOiBg0aLsMF8yEFGVWlkVK+DSYSJHmgeNItCPN1jznD/odx9iwNnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709003755; c=relaxed/simple;
	bh=8IxVkSyuupdnDQ3UXjN4zpE+IxX47AmqxRtsKgG5Q/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=of952M1U5LqETA0122TTJ/+/pQdjxiwIexq/6qbACiAxMYBj0uoeCSeTxLhsLliAZnpF/pe5pKrY8FbToDMGkG6RR+b1bkqz+UGLQ0YrUBXO/rcNji5cBomKNWjNUMizt2ehAvFess1fzJoZ+dqSt3OXtmN/3eZzWAPY/YGCL2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=RqWvlkpC; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="RqWvlkpC"
Received: from [192.168.178.32] (uk.gigawatt.nl [51.148.134.205])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id CBB171214;
	Tue, 27 Feb 2024 03:07:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl CBB171214
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1709003263;
	bh=+BPj1tTWL56CFfIEh+MuoCaWancImEtTaKehKRbi8qU=; l=1601;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=RqWvlkpCJAJZo8l9ylqLZXosY2vPtdZXkkOdl3CMt8uA7gktaZKJKpIHz4+RpyEN5
	 TmQtG9B0H+MMvtApXkNm1LXSHQ8XBW1YGWpARplmUqxvyymRQtzc0dBJq2SO2pB65r
	 e6GdvvTSwpFwYVPS0T6U/W1aedQMHrRjphE+XGK4=
Message-ID: <18ce9b6d-f9fa-467a-ab3b-5a4ddc5ed36b@gigawatt.nl>
Date: Tue, 27 Feb 2024 03:07:41 +0000
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wrong behaviour when unsetting/setting some variables
To: Christoph Anton Mitterer <calestyo@scientia.org>, dash@vger.kernel.org
References: <43f0631aea36f6b49e5c3dfdfe481a5a2b1fec6c.camel@scientia.org>
Content-Language: en-GB
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <43f0631aea36f6b49e5c3dfdfe481a5a2b1fec6c.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/02/2024 02:07, Christoph Anton Mitterer wrote:
> This works as expected in dash for most variables, but not some, e.g.:
> $ env -i dash
> $ export
> export PWD='/home/calestyo'
> $ export MAIL
> $ export
> export MAIL
> export PWD='/home/calestyo'
> $ unset -v MAIL
> $ export
> export MAIL
> export PWD='/home/calestyo'
> $
> 
> Same for MAILPATH and PATH, which made me believe it's perhaps an issue
> in `changemail` and `changepath` as given in the struct `varinit` in
> src/var.c.
> But it also happens with IFS, PS1, PS2 and PS4, which have no function
> listed there.
> OTOH, it doesn’t happen with ATTY, TERM, LINENO and HISTSIZE.

I suspect the reason you don't see it happen with TERM, LINENO, and 
HISTSIZE is because you have built dash in a configuration in which 
these variables are not special. I do see it happen with all three of 
these. ATTY is dead code and is never special.

It looks like it is an incorrect handling of VSTRFIXED in setvareq(). 
The block

                 if (((flags & (VEXPORT|VREADONLY|VSTRFIXED|VUNSET)) |
                      (vp->flags & VSTRFIXED)) == VUNSET) {

should not be entered, and is not, but this is the block that makes it 
work for normal variables. For special variables, we get to

   flags |= vp->flags & ~(VTEXTFIXED|VSTACK|VNOSAVE|VUNSET);

where we preserve the VEXPORT of the previous value. In case of VUNSET, 
we should not be doing that. I agree with your expectations, unset 
should clear the export attribute.

VSTRFIXED is also used for local variables, so this explains what you 
see there too.

Cheers,
Harald van Dijk
