From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: dash: details of redirection/duplication in manpage are reversed
Date: Mon, 10 Nov 2014 21:24:09 +0800
Message-ID: <20141110132409.GA8416@gondor.apana.org.au>
References: <20141110111951.GA4185@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:39587 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbaKJNYO (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 10 Nov 2014 08:24:14 -0500
Content-Disposition: inline
In-Reply-To: <20141110111951.GA4185@free.fr>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: =?iso-8859-1?Q?St=E9phane?= Aulery <saulery@free.fr>
Cc: dash@vger.kernel.org, 501566@bugs.debian.org, 501566-submitter@bugs.debian.org

St=E9phane Aulery <saulery@free.fr> wrote:
>=20
> --IS0zKkzwUGydFO0o
> Content-Type: text/plain; charset=3Dutf-8
> Content-Disposition: inline
> Content-Transfer-Encoding: 8bit
>=20
> forwarded 501566 dash@vger.kernel.org
> stop
> -------------------------------------------------------
>=20
> Hello,
>=20
> Here is a small patch reported by a user of Debian [1]. Could you ple=
ase
> integrate? Thank you for your help.
>=20
> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D501566
>=20
> Regards,
>=20
> --=20
> St=E9phane Aulery
>=20
> --IS0zKkzwUGydFO0o
> Content-Type: text/x-diff; charset=3Dutf-8
> Content-Disposition: attachment; filename=3D"dash.1.fix-redirection-d=
ocs.diff"
>=20
> --- dash.1.old	2014-11-10 12:15:29.809398575 +0100
> +++ dash.1.new	2014-11-10 12:17:03.401856125 +0100
> @@ -402,11 +402,11 @@
> .It [n] Ns \*[Lt] file
> Redirect standard input (or n) from file.
> .It [n1] Ns \*[Lt]& Ns n2
> -Duplicate standard input (or n1) from file descriptor n2.
> +Duplicate standard input (or n1) to file descriptor n2.
> .It [n] Ns \*[Lt]&-
> Close standard input (or n).
> .It [n1] Ns \*[Gt]& Ns n2
> -Duplicate standard output (or n1) to n2.
> +Duplicate standard output (or n1) from n2.
> .It [n] Ns \*[Gt]&-
> Close standard output (or n).
> .It [n] Ns \*[Lt]\*[Gt] file

I'm sorry but this patch looks wrong and the text looks correct
to me as is.

Cheers,
--=20
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
