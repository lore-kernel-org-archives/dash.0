From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: LINENO and PS{1,2,4} ?
Date: Thu, 26 Jun 2008 23:04:05 +0800
Message-ID: <E1KBt13-00085P-00@gondolin.me.apana.org.au>
References: <6cd6de210806231229x1b30d3f6yb65e989b11c6a95e@mail.gmail.com>
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:58042 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760763AbYFZPEI (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 26 Jun 2008 11:04:08 -0400
In-Reply-To: <6cd6de210806231229x1b30d3f6yb65e989b11c6a95e@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Rocky Bernstein <rocky.bernstein@gmail.com>
Cc: dash@vger.kernel.org

Rocky Bernstein <rocky.bernstein@gmail.com> wrote:
> I have been looking at dash recently and notice in the manual page:
> 
> BUGS: PS1, PS2, and PS4 should be subject to parameter expansion
> before being displayed.
> 
> Also I notice that there isn't a builtin LINENO which POSIX suggests
> (e.g. http://www.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html)
> 
> I've been considering rectifying this. What's the protocol for
> submitting a patch, and/or the likelihood this would get into a
> release assuming the patch is reasonable.

Just send it to the list (with a cc to me preferably).

> Is there currently a schedule for the next release?

The next release is overdue :) There is a serious performance
regression since the last release.  Once I've tracked that down
a release will be made.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
