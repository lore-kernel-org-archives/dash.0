From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: strange `printf` arguments, parsing features (bugs?)
Date: Sun, 18 May 2008 23:41:08 +0800
Message-ID: <E1Jxl0W-0006oV-00@gondolin.me.apana.org.au>
References: <20080514165931.GB21428@flower.upol.cz>
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:52376 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753515AbYERPlM (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 18 May 2008 11:41:12 -0400
In-Reply-To: <20080514165931.GB21428@flower.upol.cz>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Oleg Verych <olecom@flower.upol.cz>
Cc: dash@vger.kernel.org

Oleg Verych <olecom@flower.upol.cz> wrote:
> # (1) parameters to `printf`?
> 
> olecom@flower:/tmp$ sh -c 'printf "-1"'
> printf: 1: Illegal option -1

This is expected.  Use printf -- if you want to disable option parsing.

> # (2) parsing features?
> 
> olecom@flower:/tmp$ sh -c 'echo 1; } echo 2'
> 1
> 2
> olecom@flower:/tmp$ sh -c '} echo 2'
> sh: Syntax error: "}" unexpected
> olecom@flower:/tmp$ sh -c 'echo 2; }'
> 2
> olecom@flower:/tmp$

Yes that's a defect in the dash parser.

> # (3) '\' in `` and in $();
> # what is POSIX "literal meaning" of '\' in `` and what is '\\' then?
> # bash has its own opinion
> 
> olecom@flower:/tmp$ PS2=''
> olecom@flower:/tmp$ dash -s << '='
> `echo ' \' >&2`
> `echo ' \\' >&2`
> `echo ' \\\' >&2`
> `echo ' \\\\' >&2`
> $(echo ' \' >&2)
> $(echo ' \\' >&2)
> $(echo ' \\\' >&2)
> $(echo ' \\\\' >&2)
> echo --
> $(echo ' \\\\\' >&2)
> `echo  ' \\\\\' >&2`

bash and dash in fact agree on these except that echo in dash
interprets escape codes as required by POSIX.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
