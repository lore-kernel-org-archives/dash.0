From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: positional argument bug
Date: Sat, 21 May 2011 09:59:51 +1000
Message-ID: <20110520235950.GA1839@gondor.apana.org.au>
References: <4DC2B0FD.1000802@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:33733 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417Ab1ETX7x (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 20 May 2011 19:59:53 -0400
Content-Disposition: inline
In-Reply-To: <4DC2B0FD.1000802@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: dash@vger.kernel.org

Eric Blake <eblake@redhat.com> wrote:
>
>> Also a POSIX violation:
>> 
>> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_02
>> 
>> "The parameter name or symbol can be enclosed in braces, which are
>> optional except for positional parameters with more than one digit or
>> when parameter is followed by a character that could be interpreted as
>> part of the name."
> 
> Additionally from POSIX:
> 
> "If the parameter name or symbol is not enclosed in braces, the
> expansion shall use the longest valid name (see XBD Name)"
> 
> "In the shell command language, a word consisting solely of underscores,
> digits, and alphabetics from the portable character set. The first
> character of a name is not a digit."
> 
> Therefore, in "$10", 10 is not a name, so the longest name is the empty
> string, and the single-character symbol is used instead, such that this
> MUST be parsed as ${1}0, not as ${10}.

I don't think any of this explicitly states that $10 cannot be
interpreted as ${10}.  All it says is that where the first character
is an underscore or alphabetic, then the longest name should be
used, and that to use $10 portably you must put braces around it.

So I'm not going to make any changes at this point.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
