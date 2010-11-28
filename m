From: Guido Berhoerster <guido+kernel.org@berhoerster.name>
Subject: Re: trap bug in recent versions of dash
Date: Sun, 28 Nov 2010 09:50:54 +0100
Message-ID: <20101128085054.GA6935@wopr.local.invalid>
References: <20100811080616.GA18303@wopr.local.invalid>
 <20101128071906.GA8818@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from multivac.heapoverflow.de ([83.169.16.167]:39113 "EHLO
	multivac.heapoverflow.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760Ab0K1I47 (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 28 Nov 2010 03:56:59 -0500
Content-Disposition: inline
In-Reply-To: <20101128071906.GA8818@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org

* Herbert Xu <herbert@gondor.apana.org.au> [2010-11-28 08:55]:
> On Wed, Aug 11, 2010 at 08:06:16AM +0000, Guido Berhoerster wrote:
> > Hello,
> > 
> > with the latest git version of dash trap actions are not
> > evaluated in the context of a function.
> > 
> > The following script demonstrates the bug:
> > ----8<----
> > read_timeout () {
> >     saved_traps="$(trap)"
> >     trap 'printf "timed out\n"; eval "${saved_traps}"; return' TERM
> >     ( sleep $1; kill -TERM $$ ) >/dev/null 2>&1 &
> >     timer_pid=$!
> >     read $2
> >     kill $timer_pid 2>/dev/null
> > }
> > 
> > read_timeout 5 value
> > printf "read \"%s\"\n" "${value:=default}"
> > 
> > ---->8----
> > The return statement in the trap inside the read_timeout function
> > does not return from the function but rather exits the script.
> > 
> > With dash 0.5.5.1 it works as expected.
> 
> Indeed this was a regression caused by the SKIPEVAL removal.
> 
> This patch should fix it.

Thanks, it does fix it.

-- 
Guido Berhoerster
