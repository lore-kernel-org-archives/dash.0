Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3764C7EE25
	for <linux-dash@archiver.kernel.org>; Thu,  8 Jun 2023 20:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjFHUb3 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 8 Jun 2023 16:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjFHUb3 (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 8 Jun 2023 16:31:29 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08D6C185
        for <dash@vger.kernel.org>; Thu,  8 Jun 2023 13:31:26 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 32E459966;
        Thu,  8 Jun 2023 22:31:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1686256284;
        bh=/Tr9ebZdSL8o/s0m65OEPIMdxAd4fmFOy9B0q/BB+bA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gBcesYm00W04asljCWyQ2ERGRZ1aqr5QO4mNUW8dD5bZv1gqqnjZ32CJNXVQZxaRB
         +pIOn2RNvLzxqEJdNuvUtpIJWuKAP5rb3hR2D/B0ly1IzdlMnBTRLpB9u0SWFic7Cm
         QMlOAStQvRXKpL4wK02+uBK1Yk+o2uIWDU4ykkkPqWS7y9KFQAz/vqausiWIXIOxyv
         HsvblSm8WqiugNRIGSccQwLs0hSqkDX3WzN3furp+lKDQlv0uft8zYmH8lkWKQOhEk
         4ZaLXYfRUE0xNOIKBQvoBbyfq8Hv6cznbbosaL97rLmRQ5KhryP5Ct4IxXGLLCKJ7i
         vhzFRjFHdPA4Q==
Date:   Thu, 8 Jun 2023 22:31:23 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org
Subject: Re: [Debian#1037195] dash: $(here-doc in <<substitution) is always
 empty, must consume subsequent lines per POSIX?
Message-ID: <v4446mlkbaddnqggbfvh6xvghckidbc5o5swi6awsimxr3afof@ctc7n34dwh3e>
References: <ZIGaJAHo8OY1QzQa@gondor.apana.org.au>
 <efbfb9b1-5e73-0ff7-2b17-56c1406982c7@gigawatt.nl>
 <ZIGnOzJfPR0+0PNx@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q7qyitab3juxsxmc"
Content-Disposition: inline
In-Reply-To: <ZIGnOzJfPR0+0PNx@gondor.apana.org.au>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--q7qyitab3juxsxmc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 08, 2023 at 06:02:35PM +0800, Herbert Xu wrote:
> On Thu, Jun 08, 2023 at 10:19:24AM +0100, Harald van Dijk wrote:
> : For "$(" and '`' only, if instances of io_here tokens are found nested
> : within the substitution, they shall be parsed according to the rules
> : of [xref to 2.7.4]; if the terminating ')' or '`' of the substitution
> : occurs before the NEWLINE token marking the start of the here-document,
> : the behavior is unspecified.

I hand't looked if there were any explicit provisions for $( of
this sort, so I took the original segments I quoted to to include, in
  echo "$(head -n1 <<EOF)"
  2
  3
  EOF
that the first newline is the one that's at the end of line 1,
since it's next in the "input", and it wasn't clear to me whether
input is supposed to be the command in $(command), like dash does,
or the raw input, like bash does
(which did surprise me at first, since it violated $( nesting).

Thanks for clearing this up :)

Best,

--q7qyitab3juxsxmc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSCOpgACgkQvP0LAY0m
WPE4Gw/8DA/lVKauniFul6ZG4J4gHk+l7XLAuIml8WOar1ZIz1K88GNXw1D6OPjA
m4DpmxEoKK2i5KNl5b+oV6QCUnFIN8mh/wDtmO5a2W7jlD0wklqTaL8WPBOhCyEt
+9S6z39z8MGNv4yMd1n5O932cvGIDnz0WAmhDgpOyMkp1Rsb4LUyJ6rJXMNlFoNq
HwsT8QFS2xt2SoOjlFFXbPpYNgHgzTiGIeysyUW2XbtipgGU1W82iK9+WlADZUuF
/KwD3Wo1Gl/4p5yzSsV5RBggmzRYEbuAZmAB7nRE/Pw4m327h+X/4ZpR3LZU4b7h
NKl2lwoooWpDl7/FIfG/qGZvo80/Bdg5mdEkXwymnOpsjKqv/mmOQJhUK0jA2PsU
N06yCBdbVZUdmYN8IHXI4RsLFCJ1OCmeGsjVI79omC3KpMEuhRpP7MdjFCSEmQ7b
8p7b6/q6B9qg3jl8How5SSaWEEfj2ieUeNMyjRcp1c4iqwj4wtrXRBHN0rQAP5sl
wEHfUSis0AfvDOSlXML5o4V9THhrqHUwEuEBmSerBitgyU3GNJUgBI+FVwyfvhX2
B9jHjzyOL8Sd2fB/XyBar/6m2i0SALfQSNu84Gfu3g2+9JsfPPOxY5V2XLv14R5t
9Bd1cwTupg7fxRnN5MXZlwJxMtv8KLdXTJ5FcJDfzqENBV8EuIY=
=OVCC
-----END PGP SIGNATURE-----

--q7qyitab3juxsxmc--
