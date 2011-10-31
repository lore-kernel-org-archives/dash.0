From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH] echo: fix octal escaping with \1...\7
Date: Mon, 31 Oct 2011 14:39:37 -0400
Message-ID: <201110311439.38413.vapier@gentoo.org>
References: <20111031034146.GA19477@gondor.apana.org.au> <201110310023.45138.vapier@gentoo.org> <4EAE9ECB.4040607@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart12134331.pGt6qVsan4";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:58129 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933683Ab1JaSjj (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 31 Oct 2011 14:39:39 -0400
In-Reply-To: <4EAE9ECB.4040607@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: Herbert Xu <herbert@gondor.hengli.com.au>, dash@vger.kernel.org, bug-libtool@gnu.org

--nextPart12134331.pGt6qVsan4
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Monday 31 October 2011 09:12:43 Eric Blake wrote:
> On 10/30/2011 10:23 PM, Mike Frysinger wrote:
> > On Sunday 30 October 2011 23:41:58 Herbert Xu wrote:
> >> Mike Frysinger wrote:
> >>> POSIX states that octal escape sequences should take the form \0num
> >>> when using echo.  dash however additionally treats \num as an octal
> >>> sequence.  This breaks some packages (like libtool) who attempt to
> >>> use strings with these escape sequences via variables to execute sed
> >>> (since sed ends up getting passed a byte instead of a literal \1).
>=20
> That's a bug in libtool for using "echo '\1'" and expecting sane
> behavior.  Can you provide more details on this libtool bug, so we can
> get it fixed in libtool?  Or perhaps it has already been fixed in modern
> libtool, and you are just encountering it in an older version?

i plan on digging through the relevant packages and posting patches where=20
applicable.  i might be wrong about the libtool side, but do know of at lea=
st=20
one ax m4 file using it (which is what started this rat hole in the first=20
place).  but i consider that a parallel issue :).

> >> OK this is a bit of problem.  From our conversation I had the
> >> impression that you were referring to the lack of support of
> >> escape codes, rather than unwanted support.
> >>=20
> >> If it was the former I could easily add it if POSIX said so,
> >> however, as this is an existing feature there may well be scripts
> >> out there that depend on it.  So removing it is not an option
> >> unless it is explicitly forbidden by POSIX.
> >=20
> > i'm not seeing how this jives with dash's goal.  if it intends to be a
> > fast/small POSIX compliant shell while punting (almost) all the rest,
> > then why carry additional functionality that POSIX doesn't even mention
> > in passing ? this isn't "documented but optional extended
> > functionality", but rather the realm of "anything goes".  otherwise we
> > approach the same realm that dash was created to avoid -- carrying lots
> > of cruft that slow things down because scripts use it rather than POSIX
> > mandating it.
> >=20
> > as a comparison, bash/ksh/tcsh/zsh/busybox[ash] all behave the way my
> > patch updates dash to operate ... i would test more shells, but these
> > tend to be the standards that everyone compares against.  i can't see
> > people writing scripts that only work under dash either.
> >=20
> >> In any case, scripts that rely on escape codes like this are
> >> simply broken and should either be fixed to use printf or just
> >> run with #!/bin/bash.
> >=20
> > they're relying on these escape codes not being interpreted as escape
> > codes (which every other shell appears to do), not the other way around
>=20
> Scripts that rely on a certain interpretation of "echo '\1'" are broken
> regardless of how dash behaves;

sure, i'm not arguing that logic

> but that said, since POSIX doesn't
> require dash's current behavior, and since the proposed patch makes dash
> both smaller and more like other shells in treating it as an extension
> that means a literal 1 rather than an octal escape, I would be in favor
> of making the change in dash.

right, that's what i'm going for
=2Dmike

--nextPart12134331.pGt6qVsan4
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJOrutqAAoJEEFjO5/oN/WBx1oP/0skpIcRcE2b1vUGPUVKwOWk
2Vqa6q7ALDEQRaqKW30cLpPk21y8/kNY4VAi9vLHT8aUbKHNdwTiS2BWZS0Vqp5i
8sIwrLkPIyVx91dZPzCSAstK99e5QjUBbJt2rqtepfYfFyY7KRASa0DyDG3WBofO
hFR4hBC9EBPLwYCjzyUvjmKihLlQSGmFjDIZ4HmLHeeXLRUm05nNcXPPuaxUMgBV
nA8YFMgNLydrt6wso/UE7M6ksQLzwGirS2PE4BB9c7ekd9WAEO8G88xUkWTidGe7
K++vqrlobiJPY6ROmFvxV740AS1FKz0MTm5TwzyrWbQ4vN5cXwpdj7vMrY4ee+B+
5bTH+WeelqJIqpKxNsIuEQHelpKU5BFySfBEkUTIvs0GCQyTnjmHVosLCXDF5rK1
MKoOb56aLqK0zJC2tFtD7Dmrv31hTkUNYGAYSZtYUcetxbSGDdfYCClVZjy3h3jQ
cuIZxRo863ROCYvo5QLgzwaOAuaWChgg/KJ0BQkxzIW13aiNN38CPbHVjBRKFsfa
r7C6EnHWHXdIcmMzyClGS0wqjEnnVxM6HZQojZMnR5gLfrglx3NVIslHOJAcus0Z
u7Aa4vIOoGG50nEvU/7FXboc3j2G9R9BzBJo9w3WEBNP755LzjBAlcOlac2UUs4A
DAcAC77KKAbchnu8esGX
=SuOL
-----END PGP SIGNATURE-----

--nextPart12134331.pGt6qVsan4--
