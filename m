From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Allow dash to build with i18n version of Coreutils
Date: Mon, 31 Aug 2009 20:27:28 +1000
Message-ID: <20090831102728.GA6038@gondor.apana.org.au>
References: <ae958968e4a4099d81d92479ccde0167@quantum.linuxfromscratch.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:56339 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751101AbZHaK12 (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 31 Aug 2009 06:27:28 -0400
Content-Disposition: inline
In-Reply-To: <ae958968e4a4099d81d92479ccde0167@quantum.linuxfromscratch.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Matthew Burgess <matthew@linuxfromscratch.org>
Cc: dash@vger.kernel.org

On Sat, Aug 15, 2009 at 06:07:16PM +0000, Matthew Burgess wrote:
>=20
> My system has Coreutils-7.4 compiled with the i18n patch from
> http://cvs.fedoraproject.org/viewvc/devel/coreutils/coreutils-i18n.pa=
tch.
>=20
> Using this to compile dash, when in an en_GB.UTF-8 locale, I get the =
following error:
>=20
> if gcc -DHAVE_CONFIG_H -I. -I. -I..  -include ../config.h -DBSD=3D1 -=
DSHELL -DIFS_BROKEN  -Wall -g -O2 -MT eval.o -MD -MP -MF ".deps/eval.Tp=
o" -c -o eval.o eval.c; \
>         then mv -f ".deps/eval.Tpo" ".deps/eval.Po"; else rm -f ".dep=
s/eval.Tpo"; exit 1; fi
> eval.c: In function =E2=80=98evalcommand=E2=80=99:
> eval.c:810: error: =E2=80=98EXECCMD=E2=80=99 undeclared (first use in=
 this function)
> eval.c:810: error: (Each undeclared identifier is reported only once
> eval.c:810: error: for each function it appears in.)
> eval.c:812: error: =E2=80=98COMMANDCMD=E2=80=99 undeclared (first use=
 in this function)
> make[3]: *** [eval.o] Error 1
>=20
> This is because the src/mkbuiltins script ends up generating an incom=
plete
> src/builtins.h file.  This, in turn, is caused by 'sort -u -k 3,3' no=
t
> working correctly.
>=20
> The attached patch fixes/works around things by setting LC_CTYPE=3DC,=
 thus
> overriding the build environment (in a similar manner to the earlier =
call to
> 'sort' in that same script).

Thank you.  I've applied the patch but replaced LC_CTYPE with
LC_COLLATE.
--=20
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
