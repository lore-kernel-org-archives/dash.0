From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 1/2] [JOBS] Debug compile fix
Date: Wed, 8 Sep 2010 16:26:11 +0800
Message-ID: <20100908082611.GB15377@gondor.apana.org.au>
References: <1278578180-6969-1-git-send-email-max@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:35671 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758446Ab0IHI0M (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 8 Sep 2010 04:26:12 -0400
Content-Disposition: inline
In-Reply-To: <1278578180-6969-1-git-send-email-max@stro.at>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: maximilian attems <max@stro.at>
Cc: dash@vger.kernel.org, klibc@zytor.com

On Thu, Jul 08, 2010 at 10:36:19AM +0200, maximilian attems wrote:
> No point in tracing a no longer undeclared "ps->cmd", fixes:
> jobs.c: In function =E2=80=98commandtext=E2=80=99:
> jobs.c:1192: error: =E2=80=98ps=E2=80=99 undeclared (first use in thi=
s function)
> jobs.c:1192: error: (Each undeclared identifier is reported only once
> jobs.c:1192: error: for each function it appears in.)
>=20
> Signed-off-by: maximilian attems <max@stro.at>

Patch applied.  Thanks!
--=20
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
