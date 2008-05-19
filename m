From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: strange `printf` arguments, parsing features (bugs?)
Date: Mon, 19 May 2008 08:53:28 +0800
Message-ID: <20080519005328.GA29081@gondor.apana.org.au>
References: <20080514165931.GB21428@flower.upol.cz> <E1Jxl0W-0006oV-00@gondolin.me.apana.org.au> <20080518164026.GE21428@flower.upol.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:47627 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753314AbYESAxb (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 18 May 2008 20:53:31 -0400
Content-Disposition: inline
In-Reply-To: <20080518164026.GE21428@flower.upol.cz>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Oleg Verych <olecom@flower.upol.cz>
Cc: dash@vger.kernel.org

On Sun, May 18, 2008 at 06:40:26PM +0200, Oleg Verych wrote:
> Herbert Xu @ Sun, May 18, 2008 at 11:41:08PM +0800:
> 
> > > # (1) parameters to `printf`?
> > > 
> > > olecom@flower:/tmp$ sh -c 'printf "-1"'
> > > printf: 1: Illegal option -1
> > 
> > This is expected.  Use printf -- if you want to disable option parsing.
> 
> [second] Again for `echo` it's not so, `printf` is a mean for "propper"
>          (portable) `echo`, nothing about getopt() stuff is mentioned in
> 	 POSIX spec.

All POSIX utilities accept -- by default.  The specification for
echo specifically forbids --, while that of printf does not.

> > > # (3) '\' in `` and in $();
> > > # what is POSIX "literal meaning" of '\' in `` and what is '\\' then?
> (bash removed)
> 
> $( ' \\\\ ' ) ; ` ' \\\\ ' ` ; $( ' \\\ ' ) ; ` ' \\\ ' `
>       (4)            (2)            (3)           (2)
> $( " \\\\ " ) ; ` " \\\\ " ` ; $( " \\\ " ) ; ` " \\\ " `
> 
> it is so, but how to explain this wrt spec.?

Section 2.6.3, "Command Substitution":

            Within the backquoted style of command substitution, backslash
            shall retain its literal meaning, except when followed by:
            '$', '`', or '\\' (dollar sign, backquote, backslash).

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
