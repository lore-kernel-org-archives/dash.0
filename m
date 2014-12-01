From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [MAN] Clarify two redirection mechanisms
Date: Mon, 1 Dec 2014 18:04:56 +0800
Message-ID: <20141201100456.GA16404@gondor.apana.org.au>
References: <1416570754-9998-1-git-send-email-saulery@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:37277 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbaLAKFC (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 1 Dec 2014 05:05:02 -0500
Content-Disposition: inline
In-Reply-To: <1416570754-9998-1-git-send-email-saulery@free.fr>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
Cc: dash@vger.kernel.org, saulery@free.fr

saulery@free.fr wrote:
> From: St=E9phane Aulery <saulery@free.fr>
>=20
> Close Debian Bug #501566
> ---
> src/dash.1 | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/src/dash.1 b/src/dash.1
> index d782882..429657a 100644
> --- a/src/dash.1
> +++ b/src/dash.1
> @@ -402,11 +402,13 @@ Append standard output (or n) to file.
> .It [n] Ns \*[Lt] file
> Redirect standard input (or n) from file.
> .It [n1] Ns \*[Lt]& Ns n2
> -Duplicate standard input (or n1) from file descriptor n2.
> +Redirect standard input (or fd n1) from the same resource as current=
ly open on
> +fd n2.

"Resource" is rather unwieldy, how about simply "file"?

Thanks,
--=20
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
