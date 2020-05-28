From: tiemeezeiv@wilsonb.com
Subject: Stack overflow on unbounded recursion
Date: Thu, 28 May 2020 17:17:38 +0900
Message-ID: <2PA16BT5WNILQ.2352UZK7LJF4P@wilsonb.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="----_=_317cf3be31fec3c4435fa102_=_"
Return-path: <dash-owner@vger.kernel.org>
Received: from m42-5.mailgun.net ([69.72.42.5]:64712 "EHLO m42-5.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbgE1IWx (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 28 May 2020 04:22:53 -0400
Received: from localhost (KD111239205253.au-net.ne.jp [111.239.205.253])
        by wilsonb.com (Postfix) with ESMTPSA id 7EE7CA1A90
        for <dash@vger.kernel.org>; Thu, 28 May 2020 08:17:42 +0000 (UTC)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

This is a multipart message in MIME format.

------_=_317cf3be31fec3c4435fa102_=_
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_1504d8570700c56f60fd70c6_=_"

This is a multipart message in MIME format.

------_=_1504d8570700c56f60fd70c6_=_
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Tested this against master at commit 3e3e7af1:

    $ src/dash -c 'f(){ f;};f'
    segfault

Of course this is a pathological command string, but it looks like a clear =
case
of stack overflow:

    Program received signal SIGSEGV, Segmentation fault.
    0x0000000000407762 in argstr (p=3D0x4204b0 "f", flag=3Dflag@entry=3D3) =
at expand.c:249
    249             int breakall =3D (flag & (EXP_WORD | EXP_QUOTED)) =3D=3D=
 EXP_WORD;
    (gdb) info proc mappings
          ...
          0x7ffff7ffe000     0x7ffff7fff000     0x1000        0x0
          0x7fffff7ff000     0x7ffffffff000   0x800000        0x0 [stack]
    (gdb) p/x $rsp
    $1 =3D 0x7fffff7fef50
    (gdb) x/i $rip
    =3D> 0x407762 <argstr+34>:        sete   0x7(%rsp)

Is this a bug or have I just stumbled into a known "feature"?

------_=_1504d8570700c56f60fd70c6_=_--

------_=_317cf3be31fec3c4435fa102_=_
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iI0EABYIADUWIQR15iG0PZfp3oY4hcqvddGpNAxWDQUCXs9zixccdGllbWVlemVp
dkB3aWxzb25iLmNvbQAKCRCvddGpNAxWDeZjAP9gBMycVyEQuFbI1vaENf2XT790
TTR+MVdUMaG/9o9vBAD6A0RHxK2LGqf5c43wlpAZH+kfQnsJDJViD1FrtSQh3wQ=
=Zyxc
-----END PGP SIGNATURE-----

------_=_317cf3be31fec3c4435fa102_=_--
