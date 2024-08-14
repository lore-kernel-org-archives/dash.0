Received: from greg.wooledge.org (unknown [209.142.155.49])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 4B67F1B012A
	for <dash@vger.kernel.org>; Wed, 14 Aug 2024 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.142.155.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641837; cv=none; b=HBUznZd1NW4jKXADKJRUDs13PBD7IJ5fhO46rUBRNwY3QkffRV3MCbB4xWCcDgNeDF8H7uyE65yLbRLHlYSOGzZ9IQKPfl+TqPF5ld0HCNlYgfpzVH0pbtCXAYUkFVszNvEWtKKzlKnUB5WJcsTiPRPgf9bvWGUQQqqfvyaKv+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641837; c=relaxed/simple;
	bh=abdTruMNqyhKgz+iGB8WZCYrzuHsnjZ1hb7Dnehlbuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALLCXPnXHt+s6YG5vHfOqMibD5mgQQr48BSGDZ6U1RM6+Wobeap51okZE6oMmcyhJvJObFRwndqS66p/OhdqW+UJF5UEr59FGAP6NSHqIZ53PMwk7ju2+iWgqkeWuRys/y0wse3mHLsUDSykVZ1pTvj7+M3u5HUr8dvnQmBALLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wooledge.org; spf=pass smtp.mailfrom=wooledge.org; arc=none smtp.client-ip=209.142.155.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wooledge.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wooledge.org
Received: (qmail 160891 invoked by uid 1000); 14 Aug 2024 13:23:49 -0000
Date: Wed, 14 Aug 2024 09:23:49 -0400
From: Greg Wooledge <greg@wooledge.org>
To: Marc Chantreux <mc@unistra.fr>
Cc: dash@vger.kernel.org, busybox@busybox.net, bug-bash@gnu.org,
  Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: Re: Question on $@ vs $@$@
Message-ID: <Zryv5acNkrImASKj@wooledge.org>
Mail-Followup-To: Marc Chantreux <mc@unistra.fr>, dash@vger.kernel.org,
	busybox@busybox.net, bug-bash@gnu.org,
	Steffen Nurpmeso <steffen@sdaoden.eu>
References: <20240814004525.A7mNIdWf@steffen%sdaoden.eu>
 <ZrwTnBvk8_2mdQUS@wooledge.org>
 <ZrxzCOnZv-HffFuB@prometheus>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrxzCOnZv-HffFuB@prometheus>

On Wed, Aug 14, 2024 at 11:04:08 +0200, Marc Chantreux wrote:
> > We know what "$@" is supposed to do.  And something like "x${@}y" is
> > well-defined also -- you simply prefix "x" to the first word, and append
> > "y" to the final word.
> 
> > But I don't know how "$@$@" is supposed to be interpreted.  I do not see
> > anything in the official wording that explains how it should work.
> 
> As the doc you just mention said: let's set A B C
> 
>      "x$@y"    yA" "B" "Cy"
> 
> So the only consistent behavior I see is
> 
>      "$@$@"    A" "B" "CA" "B" "C"
>                         ^-("$3$1")
> 
>      "$@ $@"    A" "B" "C A" "B" "C"
>                         ^-("$3 $1")
> 
> I'm really currious: do you see another one ?

The most obvious would be to treat "$@$@" as if it were "$@" "$@",
generating exactly two words for each positional parameter.

    <A> <B> <C> <A> <B> <C>

As a human trying to read this expression and figure out what it means,
I keep returning to the documentation.  "... the expansion of the first
parameter is joined with the beginning part of the original word" and
"... the expansion of the last parameter is joined with the last part
of the original word".

If there are *two* instances of $@ within the same word, then the final
parameter of the *first* $@ is supposed to be "joined with the last
part of the original word".  But the "last part of the original word"
is another list expansion, not a string!  What does it even mean for
the final parameter to be "joined" with a list expansion?

Meanwhile, the first parameter of the *second* $@ is supposed to be
"joined with the beginning part of the original word".  But the "beginning
part of the original word" is once again a list, not a string.

I can't see an unambiguous way to reconcile those.

So, neither of these results would shock me:

    <A> <B> <CA B C>    (treat it like "$@$*")

    <A B CA> <B> <C>    (treat it like "$*$@")

I also wouldn't be shocked if a shell were to say "screw this, I'm just
going to treat it like "$*$*" and give you one big word".

    <A B CA B C>

I wouldn't consider that a *correct* result according to my reading of
the documentation, but also, it wouldn't shock me if some shell did it
that way out of desperation.

The documentation clearly never considered would should happen if the
script uses "$@$@", and I've gotta say, I've been doing shell stuff
for about 30 years now, and this is the first time *I've* ever seen
it come up.

I'd still love to know what the script's intent is.
