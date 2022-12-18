Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D235C4332F
	for <linux-dash@archiver.kernel.org>; Sun, 18 Dec 2022 03:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiLRDfC (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 17 Dec 2022 22:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiLRDfB (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 17 Dec 2022 22:35:01 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60B1ADFC7
        for <dash@vger.kernel.org>; Sat, 17 Dec 2022 19:34:59 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 78A59986;
        Sun, 18 Dec 2022 04:34:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1671334497;
        bh=IMDdTstibKrgaTtlHeMqm4HuKhGyN6OQeb106CJWPdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y2LYRVSkR3iUC55UyWlz3B22nPRuDBR5gCSQN6Ymf9hl4v6YfKdj9F05SH9miBTWS
         qRHm42IanjXmFXZwabyedmW5y17WWCDNOZVakM+YKg8y4zjxdSaHoqPU7aYwwriUb3
         DJJTDKvn6wNcwvrSeWzFwLwv1uTFRt0EWZ2q6DAqya5nUXbO4CXYQ3H9NgbyzuH1U7
         WmohpLqyE2eZ80t1aTs6Em69knFqVSgv+LZQGy+VwqV8EI1xzVHNcOXmjHy0kmZLyN
         bLY8WzWlj8NeeQbWESK0gVLQ1D5hWzyOnvvl6tL2xU6SiGHNwr7oomlM1Ij+bT5rKQ
         b164UAm8pQUfA==
Date:   Sun, 18 Dec 2022 04:34:56 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH] alias: aliascmd: refuse uninvokable aliases
Message-ID: <20221218033456.fe5xpkw7s3ifvcin@tarta.nabijaczleweli.xyz>
References: <20221217190705.atfwacsgggtafzl2@tarta.nabijaczleweli.xyz>
 <Y56DMzRWQB1CEH5J@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kyer4fyz3zzganhc"
Content-Disposition: inline
In-Reply-To: <Y56DMzRWQB1CEH5J@gondor.apana.org.au>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--kyer4fyz3zzganhc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Sun, Dec 18, 2022 at 11:04:19AM +0800, Herbert Xu wrote:
> The main objective of dash is to try to be minimal, so I'm not
> going to take this patch.

In that case, how's about the scissor-patch below that fixes the main
questionable part of this (these dubious aliases executed as code when
re-evaled, which POSIX says should be fine)? It's roughly what zsh does.
-- >8 --
Subject: [PATCH] alias: printalias: quote the name, too

This ensures even something like
  alias 'a|b|c=3Dd'
is output by alias as
  'a|b|c'=3D'd'
instead of
  a|b|c=3D'd'
which is both "suitable for reinput to the shell" per POSIX
and doesn't execute the aliases as code.
---
 src/alias.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/alias.c b/src/alias.c
index daeacbb..1375cdd 100644
--- a/src/alias.c
+++ b/src/alias.c
@@ -197,7 +197,7 @@ freealias(struct alias *ap) {
=20
 void
 printalias(const struct alias *ap) {
-	out1fmt("%s=3D%s\n", ap->name, single_quote(ap->val));
+	out1fmt("%s=3D%s\n", single_quote(ap->name), single_quote(ap->val));
 }
=20
 STATIC struct alias **
--=20
2.30.2

--kyer4fyz3zzganhc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOeil8ACgkQvP0LAY0m
WPHcmRAArHeit5FAzggCw+sdKrR0MiRRmQQ0h81on126RgxzPvb9s90jm35rGvoS
cNlGHxRMH18AQs2aDO/3gbriN842ECzpH+gitgkINxyOCTaBg17riDbPLiRp8ioR
mJ4YiSaR8Ttz8fyEvfu0DliPAWKxZ7acr6rHwcGxaotAXn9u4rDvwZexGZ0Wxotw
siJbH6CiQCkK0nM+VOqe3VYzWVNLwQjjJYTlDU/cfBt2V7lDDb9Dd34UWp9dtO1z
swb/Oml9bckyjszAobiJ0gHZ7ezrmGUWrwXx5t2ErfynaaCOushGHKs8vMNDNMBU
3Cc6WqMCL5YeutpoinJfCd2SgGKNvSSYBOb6Pf7vPb+E6RXlVwVXwBF43HF6H97v
kXK84HJL/d83zpu1mKUz4By+IY9JupbORqWLw2RhDntel/Npn7DskMkwFzxDLFds
AP7wtXPFRnUiVd/ZpiQM05zACL3LzzLKKuQz1yFUMn6B5ne2hoi+hdCufT8C3SR/
rXfI+wcOM8oYBHMJYexuPTI7370CyX0qYGkVBzPZVRoAQHrqmBDvutmlGEOls92d
9SlNCnZ4psSXwASdPaC1OSXmcED0b+RdcuGec1nbfQfcst3vgqwebXJg75+CCQUE
AebXkraAvvW8mdLUXZ1e+A0UtKwiwT7D7VYa9frtsRXMaf6EeNU=
=n9PC
-----END PGP SIGNATURE-----

--kyer4fyz3zzganhc--
