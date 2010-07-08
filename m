From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: dash klibc DEBUG compile trouble
Date: Thu, 8 Jul 2010 21:04:01 +0800
Message-ID: <20100708130401.GA20383@gondor.apana.org.au>
References: <20100708084834.GB6829@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:53675 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757101Ab0GHNEF (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 8 Jul 2010 09:04:05 -0400
Content-Disposition: inline
In-Reply-To: <20100708084834.GB6829@stro.at>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: maximilian attems <max@stro.at>
Cc: dash@vger.kernel.org, klibc@zytor.com

maximilian attems <max@stro.at> wrote:
> on top of the two easy patches I sent I am seeing this one:
> usr/dash/exec.c: In function =E2=80=98find_command=E2=80=99:
> usr/dash/exec.c:290: error: storage size of =E2=80=98statb=E2=80=99 i=
sn=E2=80=99t known
> usr/dash/exec.c:299: warning: implicit declaration of function =E2=80=
=98stat64=E2=80=99
> usr/dash/exec.c:290: warning: unused variable =E2=80=98statb=E2=80=99
> make[2]: *** [usr/dash/exec.o] Error 1
>=20
>=20
> hmm which include is exec.c missing?

What does config.h say?

Cheers,
--=20
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
