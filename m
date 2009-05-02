From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Dash problem with IFS
Date: Sat, 2 May 2009 10:01:31 +0800
Message-ID: <20090502020131.GA19531@gondor.apana.org.au>
References: <822b241f0905011133l3bcbf9dci4799abc80ec9de99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:54089 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750869AbZEBCBe (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 1 May 2009 22:01:34 -0400
Content-Disposition: inline
In-Reply-To: <822b241f0905011133l3bcbf9dci4799abc80ec9de99@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Haibo Xu <haibo.xu@gmail.com>
Cc: dash@vger.kernel.org

On Fri, May 01, 2009 at 11:33:08AM -0700, Haibo Xu wrote:
>
> > #!/bin/sh
> >
> > IFS=$' \t\n'

IFS is not supposed to interpret escape sequences.  Quoting POSIX

1419               IFS                   (Input Field Separators.) A string treated as a list of characters that is used for
1420                                     field splitting and to split lines into fields with the read command. If IFS is not
1421                                     set, the shell shall behave as if the value of IFS is <space>, <tab>, and
1422                                     <newline>; see Section 2.6.5 (on page 2244). Implementations may ignore the |
1423                                     value of IFS in the environment at the time the shell is invoked, treating IFS as |
1424                                     if it were not set.                                                                    |

So if you want it to have a tab and newline you need to specify
them literally, or use something that does interpret escapes,
like

IFS=$(echo '\n\t $')

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
