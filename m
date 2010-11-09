From: Eric Blake <eblake@redhat.com>
Subject: static vs. dynamic scoping
Date: Tue, 09 Nov 2010 15:02:53 -0700
Message-ID: <4CD9C50D.5010305@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig17E33706D15AAAFDDA2821EB"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54265 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752627Ab0KIWCz (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 9 Nov 2010 17:02:55 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id oA9M2s6V007786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <dash@vger.kernel.org>; Tue, 9 Nov 2010 17:02:55 -0500
Received: from [10.3.113.96] (ovpn-113-96.phx2.redhat.com [10.3.113.96])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id oA9M2sTv029991
	for <dash@vger.kernel.org>; Tue, 9 Nov 2010 17:02:54 -0500
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig17E33706D15AAAFDDA2821EB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On the Austin Group mailing list, David Korn (of ksh93 fame)
complained[1] that bash's 'local' uses dynamic scoping, but that ksh's
'typeset' uses static scoping, and argued that static scoping is saner
since it matches the behavior of declarative languages like C and Java
(dynamic scoping mainly matters in functional languages like lisp):

[1]
https://www.opengroup.org/sophocles/show_mail.tpl?CALLER=3Dshow_archive.t=
pl&source=3DL&listname=3Daustin-group-l&id=3D14951

I'm trying to standardize the notion of local variables for the next
revision of POSIX, but before I can do so, I need some feedback on two
general aspects:

1. Implementation aspect:
  How hard would it be to add static scoping to dash?
  Is it something that should be added in addition to dynamic scoping,
via the use of an option to select the non-default mode (for example,
'local -d' to force dynamic, 'local -s' to force static, and 'local' to
go with default scoping)?
  Or should dash switch entirely to static scoping (my gut feel is that
static scoping may be more efficient to implement, which fits in line
with dash's desire to be as lean as possible)?

2. User aspect:
  Is anyone aware of a script that intentionally uses the full power of
dynamic scoping available through 'local' which would break if scoping
switched to static?

Here's a sample shell script that illustrates the difference between the
two scoping methods (note that ksh only provides nested scoping via its
typeset builtin, and only when using the function reserved word).

$ ksh -c 'function f1 { typeset a=3Dlocal; f2; echo $a; };
  function f2 { echo $a; a=3Dchanged; };
  a=3Dglobal; f1; echo $a'
global
local
changed

$ dash -c 'f1 () { typeset a=3Dlocal; f2; echo $a; };
  f2 () { echo $a; a=3Dchanged; };
  a=3Dglobal; f1; echo $a'
local
changed
global

In static scoping, function f2 does not shadow a declaration of a, so
references to $a within f2 refer to the global variable.  The local
variable a of f1 can only be accessed within f1; the behavior of f2 is
the same no matter how it was reached.

In dynamic scoping, function f2 looks up its call stack for the closest
enclosing scope of a variable named a, and finds the local one declared
in f1.  Therefore, the behavior of f2 depends on how f2 is called.

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org



--------------enig17E33706D15AAAFDDA2821EB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJM2cUNAAoJEKeha0olJ0NqHiQIAIVDKR1Mz3l5N+lcCVXfEdIm
ewFLjdOpG3LU/PaPhXGGwswPPbkpYA8jCA3KjbiBBCfje+8BZ6A7j983t2NnoHGi
zjqoowhwHumRXb2oPTBMVifnTcrUWyHb4gkhQ41S9sD4KXIEnBDjtUVvyiaefD+s
Uv6IADlzm0KFsfbTLRuE9BN3XVI+nyzG9W2+mCc4mKNbk/kx8UN2o8OAoXVYlA7h
+ELkrPGNAZ6WwLFLhZczj/2x1cN8EPq3CoIJf9irGbgtQ7iowbriOwUnoGDhf3Wa
e/CBdgHSs8YvZ2wI4dHbJrbC5R+yUrf2v4JHx696YqcGppJupDp8ACE3S0akmk4=
=ZlWu
-----END PGP SIGNATURE-----

--------------enig17E33706D15AAAFDDA2821EB--
