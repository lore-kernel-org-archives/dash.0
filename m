From: Eric Blake <eblake@redhat.com>
Subject: Re: echo "\\1"?
Date: Thu, 27 Jul 2017 09:24:46 -0500
Message-ID: <68dddf01-263e-77bd-ffc7-8e7df386ee8f@redhat.com>
References: <CAC4gepeczuKhmanuBqYybUTjvo6eNeZk6FyqHjOhx8n-qDfCSw@mail.gmail.com>
 <7253a908-22d2-03e3-5493-418ca31e5590@redhat.com>
 <CAC4gepdsPNvUJyW4Zwto9wZGc1Naq5kMsnz+RdCyAurEZzGLZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WiHur6R7pJeSr0tVci5UOjIu5KAK8AKFK"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55030 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751539AbdG0OYr (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 27 Jul 2017 10:24:47 -0400
In-Reply-To: <CAC4gepdsPNvUJyW4Zwto9wZGc1Naq5kMsnz+RdCyAurEZzGLZw@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Bosco <jbosco.gg@gmail.com>, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WiHur6R7pJeSr0tVci5UOjIu5KAK8AKFK
Content-Type: multipart/mixed; boundary="CSdwd8VfXQg8veQAWLMAhKWnCUjiquQL5";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Bosco <jbosco.gg@gmail.com>, dash@vger.kernel.org
Message-ID: <68dddf01-263e-77bd-ffc7-8e7df386ee8f@redhat.com>
Subject: Re: echo "\\1"?
References: <CAC4gepeczuKhmanuBqYybUTjvo6eNeZk6FyqHjOhx8n-qDfCSw@mail.gmail.com>
 <7253a908-22d2-03e3-5493-418ca31e5590@redhat.com>
 <CAC4gepdsPNvUJyW4Zwto9wZGc1Naq5kMsnz+RdCyAurEZzGLZw@mail.gmail.com>
In-Reply-To: <CAC4gepdsPNvUJyW4Zwto9wZGc1Naq5kMsnz+RdCyAurEZzGLZw@mail.gmail.com>

--CSdwd8VfXQg8veQAWLMAhKWnCUjiquQL5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07/27/2017 08:13 AM, Bosco wrote:
> On 27 July 2017 at 12:54, Eric Blake <eblake@redhat.com> wrote:
>> Which man pages?  Echo is one of those programs that varies widely, an=
d
>> you are MUCH better off using printf(1) instead of echo(1) if you are
>> trying to get newline suppression, trying to print something that migh=
t
>> begin with -, or trying to print something that might contain \.
>=20
> Sorry, maybe I did't explain it correctly, I mean the man pages of the
> dash source:
> https://git.kernel.org/pub/scm/utils/dash/dash.git/tree/src/dash.1#n120=
2
>=20
> And because of this, I got an error compiling zziplib, you may see
> https://github.com/gdraheim/zziplib/blob/v0.13.67/configure#L17542

Eww - storing generated files in git - that forces everyone that checks
out your project to use the EXACT same version of autotools to avoid
changing the generated files unintentionally.

Looking at those lines:

>   if test -f $ac_prefix_conf_INP ; then
>     echo "s/^#undef  *\\([ABCDEFGHIJKLMNOPQRSTUVWXYZ_]\\)/#undef $ac_pr=
efix_conf_UPP""_\\1/" > conftest.prefix

ac_prefix_conf_INP is not defined anywhere in autoconf 2.69 sources (and
you really shouldn't use the ac_ prefix if you are writing code that is
not part of autoconf proper).  I couldn't find mention of it at
https://github.com/gdraheim/zziplib/blob/v0.13.67/configure.ac, but it
may be in one of your other included files.  Can you pinpoint which part
of your configure.ac results in that part of the generated configure
file?  In all likelihood, you are using a buggy macro that is using
autoconf primitives incorrectly, and thus resulting in non-portable
code.  But without seeing the true source, I can't help you debug your
problem.

>> Arguably, since it is not required by POSIX, we don't have to do it. B=
ut
>> I also can't argue that POSIX forbids us to support \1 as an extension=

>> (it says nothing about whether implementations can have additional
>> escape sequences).  So I'll argue that it is intentional as a dash
>> extension.  But if you can make dash smaller by getting rid of the
>> extension, that might be an acceptable patch.
>=20
> In that case, I think, the man page of dash should be modified with
> that extension.

Indeed, or the fact that it is NOT documented means that it is an
unintentional bug for providing the extension.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CSdwd8VfXQg8veQAWLMAhKWnCUjiquQL5--

--WiHur6R7pJeSr0tVci5UOjIu5KAK8AKFK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll5964ACgkQp6FrSiUn
Q2pLJAgAl15BlUzBk3SCaFWt1Zqw1VJX4w+IriRFfDMDB3yBpHWXkd5oJQ6G9Fj4
d+DHYiIFq6RmFoBjQCN3cFm7nXSnzo00wcTQX6/fUWlkJSVCDHI5i8wU2a3hd01R
VWZGUFb7f/s3B6E/+LavrcVV73qSAes9Yv3JeseqO+3NLaKT3RIASbiNUF9+WNw4
OAa8k5Tu2soZNLhbjPv/kyQNZmuJvElYWzjzDro8I+RxgjqWUk23EYk6/7xrz12Q
nB9jJ54B7R+kqERjfkAdQF2dIvi7VMf6/D/b/YZ74Ivs338LZ0QcQqOcqpfD5AVx
z5E3rZnuF6jFAkkf6v+y/853rWBPzw==
=LC7A
-----END PGP SIGNATURE-----

--WiHur6R7pJeSr0tVci5UOjIu5KAK8AKFK--
