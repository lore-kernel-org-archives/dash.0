From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Parameter expansion fails when assigning a local variable
Date: Mon, 29 Jun 2009 08:47:51 +0800
Message-ID: <20090629004750.GA2019@gondor.apana.org.au>
References: <A612847CFE53224C91B23E3A5B48BAC73AEC8A9FE8@xmail3.se.axis.com> <20090622085729.GA22431@gondor.apana.org.au> <0906282220250.1491@somehost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:60475 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760899AbZF2Aru (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 28 Jun 2009 20:47:50 -0400
Content-Disposition: inline
In-Reply-To: <0906282220250.1491@somehost>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Cristian Ionescu-Idbohrn <cristian.ionescu-idbohrn@axis.com>
Cc: Jesper Bengtsson <jesper.bengtsson@axis.com>, dash@vger.kernel.org

On Sun, Jun 28, 2009 at 11:39:16PM +0200, Cristian Ionescu-Idbohrn wrote:
>
> But wait a second.  Shouldn't quotes '"' around $@ protect the whole $@?
> It does so in different other context.  Why not here?

The whole point of $@ is to retain field splitting within double
quotes:

2.5.2      Special Parameters
	   Listed below are the special parameters and the values to
	   which they shall expand. Only the values of the special
	   parameters are listed; see Section 2.6 (on page 2238) for
	   a detailed summary
	   of all the stages involved in expanding words.
	   @    Expands to the positional parameters, starting from
		one. When the expansion occurs within double-quotes,
		and where field splitting (see Section 2.6.5 (on
		page 2244)) is performed, each positional parameter
		shall expand as a separate field, with the provision
		that the expansion of the first parameter shall
		still be joined with the beginning part of the
		original word (assuming that the expanded parameter
		was embedded within a word), and the expansion of
		the last parameter shall still be joined with the
		last part of the original word. If there are no
		positional parameters, the expansion of '@' shall
		generate zero fields, even when '@' is double-quoted.

> There's som parallel unnatural behaviour I noticed:
> 
> 	local var=$(some forked thing here)
> 
> $(...)
> ^^   ^ doesn't seem to protect the resulting string. There seems to be a
> difference between:
> 
> 	local h=$(grep --help)
> 
> and:
> 
> 	local h="$(grep --help)"
> 
> Can anything motivate that?  Is that POSIX too?

As I said local is identical to any other utility in this respect,
including shell functions.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
