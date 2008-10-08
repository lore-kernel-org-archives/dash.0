From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: errexit and pipelines
Date: Wed, 08 Oct 2008 22:12:25 +0800
Message-ID: <E1KnZm5-0002Ih-OB@gondolin.me.apana.org.au>
References: <20081007104400.GA3219@beczulka>
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:52453 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754504AbYJHOMa (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 8 Oct 2008 10:12:30 -0400
In-Reply-To: <20081007104400.GA3219@beczulka>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Marcin Owsiany <marcin@owsiany.pl>
Cc: dash@vger.kernel.org

Marcin Owsiany <marcin@owsiany.pl> wrote:
>
> I thought that this inconsistency was a bug in bash, but as you can find
> out in the thread, it is the first type of statements that behaves
> incorrectly, according to SUS.

I disagree with Chet on that.  My assessment is that POSIX/SUS
is ambiguous on this.  It is true that only simple commands can
lead to the shell exiting.  However, it also explicitly excludes
pipelines starting with !.  This can be construed as indicating
that simple commands that are a part of a pipeline not preceded
with ! can cause an exit.

Of course dash's current interpretation only includes the last
component of the pipeline, when not preceded by !.

> Since I like dash behavior more (makes it easier to write reliable
> scripts), I'm considering switching my program (cruft) to dash. But
> before I do it, can someone please confirm that what is written in the
> manpage and how dash behaves right now is indeed the intended behaviour,
> and will not in forseeable future be changed to match bash's behaviour?

I make no guarantees on this as SUS is subject to revision.
However, I also have no plans to change this until such SUS
clarifies this which probably won't occur for eons.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
