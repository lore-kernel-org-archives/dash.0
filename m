Received: from greg.wooledge.org (unknown [209.142.155.49])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 29E9E1BDD0
	for <dash@vger.kernel.org>; Wed, 14 Aug 2024 02:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.142.155.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723602230; cv=none; b=e+aCqjjFaYuSL4dnbaxVymbqB1QJmpbXN2Qlm/WaXq5ZsKq44fKkDRqi/Sy97v/63xBPxuA04OevHQxuRv0Cm/jQOyYUsOQBrcO3G0JuOPprFEHIJ8mx9UN6NjPYObQbAD0kwj06ZgG205tnlTEmzQOLk4SeTaZQVJ2+lTvHPbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723602230; c=relaxed/simple;
	bh=9FsXy1Ea29QRXhJbrdGDw5G6iUC5sVq0xCt8UWfGsKA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEblesGXdKfHPJU8+eBSe2VboXr7P77p6fSM5R403lh4NvWdTIe+SQf9Ty71kvndzOMKy2ZRgMePx9RjqCXLwgXPnPfEh3bpu2AbaUUT3afY4Gx5SGK7wtvJV3t3bZxskHVlTG4j7Xx6+R9zECwQOvdjc8fSu3krL2RN5wKLH9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wooledge.org; spf=pass smtp.mailfrom=wooledge.org; arc=none smtp.client-ip=209.142.155.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wooledge.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wooledge.org
Received: (qmail 142986 invoked by uid 1000); 14 Aug 2024 02:17:00 -0000
Date: Tue, 13 Aug 2024 22:17:00 -0400
From: Greg Wooledge <greg@wooledge.org>
To: dash@vger.kernel.org, busybox@busybox.net, bug-bash@gnu.org,
  Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: Re: Question on $@ vs $@$@
Message-ID: <ZrwTnBvk8_2mdQUS@wooledge.org>
Mail-Followup-To: dash@vger.kernel.org, busybox@busybox.net,
	bug-bash@gnu.org, Steffen Nurpmeso <steffen@sdaoden.eu>
References: <20240814004525.A7mNIdWf@steffen%sdaoden.eu>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240814004525.A7mNIdWf@steffen%sdaoden.eu>

On Wed, Aug 14, 2024 at 02:45:25 +0200, Steffen Nurpmeso wrote:
> I include bug-bash even though i think bash is correct, but there
> lots of people of expertise are listening, so, thus.
> Sorry for cross-posting, nonetheless.
> Given this snippet (twox() without argument it is)
> 
>   one() { echo "$# 1<$1>"; }
>   two() { one "$@"; }
>   twox() { one "$@$@"; }
>   two
>   two x
>   twox
>   twox x

So... what's the question?  You didn't actually ask anything.

As far as I can tell from the bash man page, "$@$@" does not appear to
be well-defined.  From the man page:

       @      Expands to the positional parameters,  starting  from  one.   In
              contexts  where  word  splitting is performed, this expands each
              positional parameter to a separate word; if  not  within  double
              quotes,  these words are subject to word splitting.  In contexts
              where word splitting is not performed, this expands to a  single
              word  with each positional parameter separated by a space.  When
              the expansion occurs within double quotes,  each  parameter  ex‐
              pands  to  a separate word.  That is, "$@" is equivalent to "$1"
              "$2" ...  If the double-quoted expansion occurs within  a  word,
              the  expansion  of the first parameter is joined with the begin‐
              ning part of the original word, and the expansion  of  the  last
              parameter  is  joined  with  the last part of the original word.
              When there are no positional parameters, "$@" and $@  expand  to
              nothing (i.e., they are removed).

We know what "$@" is supposed to do.  And something like "x${@}y" is
well-defined also -- you simply prefix "x" to the first word, and append
"y" to the final word.

But I don't know how "$@$@" is supposed to be interpreted.  I do not see
anything in the official wording that explains how it should work.

Therefore, *my* question is: what are you trying to do?

Given a series of positional parameters, such as

    set -- '' "two words" foobar

what do you expect "$@$@" to expand to?  Bash 5.2 gives me

    hobbit:~$ set -- '' "two words" foobar
    hobbit:~$ printf '<%s> ' "$@$@"; echo
    <> <two words> <foobar> <two words> <foobar> 

which appears to concatenate the last word of the list and the first
word of the list -- a reasonable output, I would say.  Here's a clearer
look:

    hobbit:~$ set -- a '' b
    hobbit:~$ printf '<%s> ' "$@$@"; echo
    <a> <> <ba> <> <b>

I can't complain about this result.  But at the same time, I can't say
"this is the best possible result".  Other interpretations seem equally
valid.  I just wonder what your intent was, in using the "$@$@" expansion
in the first place.
