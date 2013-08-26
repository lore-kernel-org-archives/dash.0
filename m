From: Harald van Dijk <haraldvdijk@gmail.com>
Subject: Re: test incorrectly rejecting valid expression with confusing !
 placement
Date: Mon, 26 Aug 2013 18:24:00 +0200
Message-ID: <521B8120.8010407@gigawatt.nl>
References: <5218BCAD.2010107@gigawatt.nl> <Pine.BSM.4.64L.1308261117200.19888@herc.mirbsd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:57908 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133Ab3HZQYQ (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 26 Aug 2013 12:24:16 -0400
Received: by mail-ee0-f43.google.com with SMTP id e52so1736503eek.30
        for <dash@vger.kernel.org>; Mon, 26 Aug 2013 09:24:15 -0700 (PDT)
In-Reply-To: <Pine.BSM.4.64L.1308261117200.19888@herc.mirbsd.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash <dash@vger.kernel.org>

On 26/08/13 13:19, Thorsten Glaser wrote:
> Harald van Dijk dixit:
>=20
>> $ src/dash -c 'test ! ! =3D !'
>> src/dash: 1: test: =3D: unexpected operator
>>
>> POSIX requires special behaviour for four-argument tests:
>=20
> Right but=E2=80=A6
>=20
>> There are also some cases where test gives incorrect results when
>> combining ! with -o
>=20
> =E2=80=A6 =E2=80=98-o=E2=80=99 is XSI, not POSIX. Do not expect=E2=80=
=A6
>
>> $ src/dash -c 'test ! "" -o !'; echo $?
>=20
> =E2=80=A6 this to work.
>
>> This is covered by the special rule for four arguments, there ! as t=
he
>> first argument evaluates the remaining three-argument test and negat=
es
>> the result. In this special case, ! does not have higher precedence =
than
>> -o, so the correct exit status is 1, which bash's test gives.
>=20
> Only for a shell implementing the XSI =E2=80=98-o=E2=80=99 for POSIX =
test.

That is correct, but dash is such a shell. It attempts to implement -o,
-a, and \( ... \), and does so mostly correctly.

> You shouldn=E2=80=99t use -o anyway as it=E2=80=99s deprecated.

Indeed. I made a note that it has been obsoleted. I wrote:
> There are also some cases where test gives incorrect results when
> combining ! with -o, but ( ), -a and -o have been obsoleted in favour=
 of
> the built-in shell operators ( ), && and ||, so I am not sure if that=
 is
> worth fixing.

Even if it had not been obsoleted, it would be better not to use -a and
-o. In fact, I have trouble imagining why ! has not also been obsoleted
in favour of a simple logical negation of the test (test x !=3D y inste=
ad
of test ! x =3D=3D y, which is only possible for some of the tests), or=
 the
shell's built-in ! (! test x =3D=3D y instead of test ! x =3D=3D y, whi=
ch is
always possible).

Cheers,
Harald
