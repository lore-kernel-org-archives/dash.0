From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: inconsistency with handling of symlinked ttys in background
Date: Tue, 15 Mar 2011 17:53:00 +0800
Message-ID: <20110315095300.GA10726@gondor.apana.org.au>
References: <4CD91FFB.40105@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:35879 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893Ab1COJxF (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 15 Mar 2011 05:53:05 -0400
Content-Disposition: inline
In-Reply-To: <4CD91FFB.40105@draigBrady.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: dash@vger.kernel.org

On Tue, Nov 09, 2010 at 10:18:35AM +0000, P=E1draig Brady wrote:
> I noticed a bug with dash-0.5.6-2.fc11.i586
> in that it doesn't redirect from symlinked ttys
> correctly for background processes.
>=20
> $ dash -c "tty < /dev/stdin&"
> $ dash -c "tty < /dev/stdin"
> /dev/pts/3
> $ bash -c "tty < /dev/stdin&"
> /dev/pts/3
> $ dash -c "tty < $(readlink -f /dev/stdin)&"
> /dev/pts/3

It's completely expected as we close stdin for backgrounded
commands.

Try:

bash -c '{ :; tty < /dev/stdin; }&'

Now who is inconsistent? :)

Cheers,
--=20
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
