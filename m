Received: from greg.wooledge.org (unknown [209.142.155.49])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 379D9210EC
	for <dash@vger.kernel.org>; Wed, 18 Sep 2024 11:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.142.155.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726658898; cv=none; b=KRWhglO4PF9MR/vRv7bUOMOrWCss4IEjxY1sBJaupXwHtALz28Vx7ez2avM0dUnOGLhEGJD1X3SByg/6oveyzWpgC2Kk/3QjZ0CrEoJ4K1dQGxxxg+8aNaFqFxLbCHwS+yZvAo9uu43us939DmH0lRo3O8ScfFIOwvMkNsTDZHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726658898; c=relaxed/simple;
	bh=qINVGEmnTcCUnBYbwDzQNIn1paDm/N33RT4CpAtq8tU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rj2CDFPg5co8TVZuJop/mXhEIRqSRLvjTf7yHOUy+p+xRl4nDBOkIxzUwf6Irtj17uV6uDg8mMCfQeJUJuc4bERTFJHBfihTaDvXL1MOABqR9zhtfQL2ZR5S9hdkma95CMgJ8vU94ITjw/34DX9/+wkwo8FyE7uQjdR4cWMCQio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wooledge.org; spf=pass smtp.mailfrom=wooledge.org; arc=none smtp.client-ip=209.142.155.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wooledge.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wooledge.org
Received: (qmail 490040 invoked by uid 1000); 18 Sep 2024 11:21:30 -0000
Date: Wed, 18 Sep 2024 07:21:30 -0400
From: Greg Wooledge <greg@wooledge.org>
To: dash@vger.kernel.org, busybox@busybox.net, bug-bash@gnu.org,
  Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: Re: Question on $IFS related differences (Was: Question on $@ vs
 $@$@)
Message-ID: <Zuq3umfwkcx3TAtM@wooledge.org>
Mail-Followup-To: dash@vger.kernel.org, busybox@busybox.net,
	bug-bash@gnu.org, Steffen Nurpmeso <steffen@sdaoden.eu>
References: <20240918011443.AVR6sOQ3@steffen%sdaoden.eu>
 <CAH7i3Lq9xQnnkAO7cd5XZEsV4jY+Va6uWqjw3yaMi=A3mdh83g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH7i3Lq9xQnnkAO7cd5XZEsV4jY+Va6uWqjw3yaMi=A3mdh83g@mail.gmail.com>

On Wed, Sep 18, 2024 at 08:05:10 +0300, Oğuz wrote:
> On Wed, Sep 18, 2024 at 4:19 AM Steffen Nurpmeso <steffen@sdaoden.eu> wrote:
> >
> 
> It boils down to this:
> 
>   f(){ echo $#;}; set "" "" ""; IFS=x; f $*
> 
> bash, NetBSD and FreeBSD sh, and ksh88 all agree and print 2. pdksh
> prints 3 but mksh and oksh print 1. dash, ksh93, yash, and zsh print
> 0.

At the risk of sounding like a broken record, using an unquoted $* or $@
in a context where word splitting occurs is just *begging* for trouble.
Please don't do this in your scripts.  All of these implementation
differences and possible bugs will just stop mattering, if you stop
using questionable shell features.

If you want to pass along your positional parameters to a function,
use "$@" with quotes.  This will pass each parameter as a separate
argument to the function, with no modifications.  It should work in
every post-Bourne shell (if it doesn't, that's a bug).  This is almost
always what you want.

If you want to join all of your positional parameters together into
a single string, use "$*" with quotes.  The first character of IFS
will be inserted between each pair of parameters.  This is sometimes
useful when writing messages to log files, or to produce a simple
row of delimited fields (not a full-blown CSV file, though).
