Received: from munnari.OZ.AU (munnari.OZ.AU [202.29.151.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4E61B375A
	for <dash@vger.kernel.org>; Wed, 14 Aug 2024 14:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.29.151.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647180; cv=none; b=h9OVzSdhmNC5K/hZjSf06fXTJtOY+B132AB9CDmHWyzLesyIfTR2v3+Zz8n+lIpiiFVujYEbpCmvF1yXjkz88sGGzyRrujHL2yldYoCzPbm1axrrfToeyN0XeUVWHncYgCXJ2Ozeypis/QZR1wG+r4acemRwgQG/NuH5pLItGTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647180; c=relaxed/simple;
	bh=nWoqLrDJT4B8DqJRcwbAqLAGqFMkV5EEqH6vm5cnQYU=;
	h=From:To:cc:Subject:In-Reply-To:References:Mime-Version:
	 Content-Type:Date:Message-ID; b=JbRLkO5XjO+CtV8cz/EdsfpjyuxCYrZ9CWV/xl2I9oNV928QKJCDq56nX/m5v0LbMe9ndeG2xo0+BCkgZW0b4gmi3byc89B1UNOzcSieJhULpz2j2rmLOb7YfCdG+IJVEOeab6cR1iT4naDW0Ed4fjYtRCzCmJx++qW65X2rBBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=munnari.OZ.AU; spf=fail smtp.mailfrom=munnari.OZ.AU; arc=none smtp.client-ip=202.29.151.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=munnari.OZ.AU
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=munnari.OZ.AU
Received: from jacaranda.noi.kre.to (localhost [IPv6:0:0:0:0:0:0:0:1]) by munnari.OZ.AU with ESMTP
	id 47EEpAn8012838; Wed, 14 Aug 2024 21:51:10 +0700 (+07)
Received: from jacaranda.noi.kre.to (localhost [127.0.0.1])
	by jacaranda.noi.kre.to (8.16.1/8.14.2) with ESMTP id 47EEp506009658;
	Wed, 14 Aug 2024 21:51:05 +0700 (+07)
From: Robert Elz <kre@munnari.OZ.AU>
To: Greg Wooledge <greg@wooledge.org>
cc: Marc Chantreux <mc@unistra.fr>, dash@vger.kernel.org, busybox@busybox.net,
        bug-bash@gnu.org, Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: Re: Question on $@ vs $@$@
In-Reply-To: <Zryv5acNkrImASKj@wooledge.org>
References: <Zryv5acNkrImASKj@wooledge.org> <20240814004525.A7mNIdWf@steffen%sdaoden.eu> <ZrwTnBvk8_2mdQUS@wooledge.org> <ZrxzCOnZv-HffFuB@prometheus>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 14 Aug 2024 21:51:05 +0700
Message-ID: <29871.1723647065@jacaranda.noi.kre.to>

    Date:        Wed, 14 Aug 2024 09:23:49 -0400
    From:        Greg Wooledge <greg@wooledge.org>
    Message-ID:  <Zryv5acNkrImASKj@wooledge.org>

  | The most obvious would be to treat "$@$@" as if it were "$@" "$@",

That would clearly be wrong when there are positional parameters.

  | As a human trying to read this expression and figure out what it means,
  | I keep returning to the documentation.  "... the expansion of the first
  | parameter is joined with the beginning part of the original word" and
  | "... the expansion of the last parameter is joined with the last part
  | of the original word".

Yes.   For the minute forget about the "$@$@" case, and see what it
means when there is "$X$@$Y" where we have done "set -- 1 2 3 ; X=x Y=y"
Now just expand things left to right (like always), and I will omit
the quotes, but they are still there:

	$X$@$Y -> x$@$Y  -> x1 2 3$Y -> x1 2 3y

The first expansion is just $X, that's trivial, and makes "x".
The second is (quoted) $@, and since we have 3 positional params
set, that produces 3 fields, 1 2 and 3.  The expansion of the first
(ie: 1) is joined with the beginning part of the original word ("x"
here) to make "x1" and the expansion of the last param (ie: 3) is
joined with the last part of the original word, that is, $Y (so we have "3$Y")
Then Y is expanded making 'y', again trivial.

  | If there are *two* instances of $@ within the same word, then the final
  | parameter of the *first* $@ is supposed to be "joined with the last
  | part of the original word".

Yes, it is.

  | But the "last part of the original word" is another list expansion,

Not yet it isn't, if you're expanding "$@$@" using the same setup as
the previous case, we get

	$@$@ -> 1 2 3$@ -> 1 2 31 2 3

Just do the expansions, one at a time, left to right, and it is all
simple.

  | Meanwhile, the first parameter of the *second* $@ is supposed to be
  | "joined with the beginning part of the original word".  But the "beginning
  | part of the original word" is once again a list, not a string.

Again, no it isn't, by the time that second $@ is expanded, the first one
already has been, the final word from that expansion has been joined to
the second $@, and you just expand "3$@" as the word being expanded.


  | So, neither of these results would shock me:
  |     <A> <B> <CA B C>    (treat it like "$@$*")
  |     <A B CA> <B> <C>    (treat it like "$*$@")

They might not shock you, but either of those would be a bug, that's
not how it works, now, or ever.

  | I also wouldn't be shocked if a shell were to say "screw this, I'm just
  | going to treat it like "$*$*" and give you one big word".

No, "$@" is only ever the same as "$*" when it is being expanded in a
situation when field splitting would not be performed (if the quotes were
not there) (and strictly in that case, what "$@" makes is just unspecified
there, it isn't necessarily "$*" - but usually seems to be).   That is,
no-one should ever write
	VAR="$@"
that's unspecified.   Same with 'case "$@" in'.   Most shells just treat
it as "$*" but if "$*" is what the script writer intended, that's what
they should write.

  | The documentation clearly never considered would should happen if the
  | script uses "$@$@",

Probably not, but it isn't really special, you could do "$@$@$@$@$@" if
you wanted, and everything is really perfectly well defined.   Just don't
ever imagine multiple expansions happening in parallel.  They never do.

The one questionable case (the only case where different shells should
be producing different results, other than possible bugs) is when there
are no positional params set ( [ $# = 0 ] is true) and the only 2 possible
results are nothing, and "".

  | I'd still love to know what the script's intent is.

My guess is that it was more academic interest - these things need to
be tested, even if they have no practical import normally, and to test
them, one needs to determine what the correct answer is.

kre

