From: Tim Ruehsen <tim.ruehsen@gmx.de>
Subject: Re: ':' noop results in ':: not found'
Date: Fri, 28 Oct 2016 15:08:15 +0200
Message-ID: <1749484.J6nWIO8AN1@blitz-lx>
References: <56849947.Cgj98o2q7x@blitz-lx> <c5b4a25d-bdf6-eb44-2401-c9af897f9b23@gigawatt.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7020303.XagNDhLkTl"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Return-path: <dash-owner@vger.kernel.org>
Received: from mo4-p05-ob.smtp.rzone.de ([81.169.146.183]:29654 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757923AbcJ1NIZ (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 28 Oct 2016 09:08:25 -0400
In-Reply-To: <c5b4a25d-bdf6-eb44-2401-c9af897f9b23@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org

--nextPart7020303.XagNDhLkTl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, October 28, 2016 1:22:20 PM CEST Harald van Dijk wrote:
> On 28/10/16 12:54, Tim Ruehsen wrote:
> > Hi,
> > 
> > maybe you can enlighten me :-)
> > 
> > I try to use dash (0.5.8-2.3) on Debian unstable for executing ./configure
> > scripts. Since Debian builds with --disable-lineno, all ./configure
> > scripts
> > silently fall back to bash (I created bug report #842242 to get this
> > fixed).
> As you found there, this is intentional, specifically to force configure
> scripts to continue to be run with bash, which is what happened with
> older dash versions. I asked at the time why they don't just call bash
> explicitly (bash configure instead of ./configure) if that's the goal,
> but didn't get a response.
> 
> > Next I rebuilt the package from the (Debian) sources without
> > --disable-lineno and installed it. Now I see error messages from dash
> > when it comes to the do nothing operator :.
> > 
> > $ dash -c 'test -n "a" && :'
> > dash: 1: :: not found
> > $ echo $?
> > 127
> > 
> > $ bash -c 'test -n "a" && :'
> > $ echo $?
> > 0
> > 
> > Since this : construct is wildly used and I know that dash on other
> > systems
> > work with it, I wonder what is wrong here.
> > 
> > Is there a known bug, maybe fixed on recent dash versions ?
> > Or has this some simple reason my stupidity doesn't see ?
> 
> This is likely to happen if you have the LC_ALL environment variable set
> when building dash, and I can reproduce your results with 0.5.8 by
> setting LC_ALL to en_GB.UTF-8. It was fixed in 0.5.9. (Specifically,
> where a fixed sort order was needed, 0.5.8 only forced LC_COLLATE=C, but
> that still allowed LC_ALL to override it.)

Harald !!!
That's it !
I wish you could see me grinning from ear to ear !

> dash won't be the only program that has problems with this; if you're
> building software yourself, setting LANG should generally be okay, but
> LC_ALL is best avoided. Unless you're doing it specifically to find and
> report/fix bugs, anyway.

In fact, I use LC_ALL to find bugs. Especially turkish and greek have some 
nifty casing pitfalls ;-)

Thank you so much, Harald !

Tim

--nextPart7020303.XagNDhLkTl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYE02/AAoJEAgwLbaiZwQo/cYP+wfir95v382aHX9Z43o6TJoE
XdZmzV8RMDZyeSvxame9sviKJm6oFogZNR6MTWkcjc7uLsd/dndHZuzvlO6p+2Ow
wvUY9QnfB9+BJiR8tfyBig7DZmkqu7CCeQSbcStzV8xwFYJCWzYKnH7RypC8jeCR
V0bHEnB2cNpcfVjxOfL0bshr+f18CQ9uxBsCd/qvtSHAFXhmjZ1/THokWC/xsM4e
xaMzJpx8eSUXhYU3QgC5DHNDlwl79uX0YgdLGHgvWPSuaux/pRKCxqFDulMk+2NP
QFwliUW0m6Ur6lFc4MJlh3g6xmJfLhhPrtx+9qcqXTrk50W+KIkQc8m5xDwWb00a
AfzV+wBI9MWMQSwa1XpQe6SjfvuC09SreP7ivQUcTFHHtmoZlE7X93huFGFYVdG9
4tcTfeqHs6NFY0B5A8v6e5p1/VrrBLa6dEJUuQ+f1gJHvCuCdPTjxEZI3sKa12T1
w5Wvfi78iQ63b55phOMaUAEtHzmvP31LYGL2o/c9LOaftWFGXlXypjxzHBeP/kQm
Bh2YyQm8oyAl4QXAosdABsjG2SZpuQltWW/G/ntCv5GOUCxUip8iysKYgZp0k42A
tpU9JYi5QQrEHDhJoRy9JSMc/i8jHMh3GXiZhECN8EzRjpVJQS9u8E1rxKi67/rd
gIClDn5RVGLm20L/Dh6l
=sNhc
-----END PGP SIGNATURE-----

--nextPart7020303.XagNDhLkTl--

