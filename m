From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] fix two compile time warnings
Date: Sun, 28 Nov 2010 20:57:10 +0800
Message-ID: <20101128125710.GC11109@gondor.apana.org.au>
References: <1287568775-2556-1-git-send-email-zenczykowski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:51375 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739Ab0K1M5S (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 28 Nov 2010 07:57:18 -0500
Content-Disposition: inline
In-Reply-To: <1287568775-2556-1-git-send-email-zenczykowski@gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Maciej =?utf-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc: Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>, dash@vger.kernel.org, maximillian attems <max@stro.at>

On Wed, Oct 20, 2010 at 02:59:35AM -0700, Maciej =C5=BBenczykowski wrot=
e:
> From: Maciej =C5=BBenczykowski <maze@google.com>
>=20
> jobs.c: In function 'sprint_status':
> jobs.c:427: warning: format not a string literal and no format argume=
nts
>=20
> trap.c: In function 'exitshell':
> trap.c:354: warning: variable 'status' might be clobbered by 'longjmp=
' or 'vfork'
>=20
> Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>

Thanks for the patch.  I've applied the second hunk.

As for the first, if I get annoyed enough after upgrading my gcc
then I'll think about it :) It's a false positive as strsignal
should never return anything that requires "%s".

Cheers,
--=20
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
