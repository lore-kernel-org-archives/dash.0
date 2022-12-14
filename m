Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C79C4332F
	for <linux-dash@archiver.kernel.org>; Wed, 14 Dec 2022 23:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiLNXHv (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 14 Dec 2022 18:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLNXHt (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 14 Dec 2022 18:07:49 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04B5029832
        for <dash@vger.kernel.org>; Wed, 14 Dec 2022 15:07:42 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 11A4BFBC;
        Thu, 15 Dec 2022 00:07:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1671059260;
        bh=ShkNhiY9i7XF4FfkaWpeRYOKGoig5UUH292whqtn2gE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=doOefPJookxxSCcP5nk5KuYga1/aaS8dLBTnxbMKL+kE9getXzsQxg2yHEwz+MYlA
         S9q5wKK8H7zvIm8UcU65zmJBS1Z9XHZbTKDF+Iu2Flns9yoRq4QMltAZtBdpZJEE1W
         5eKIUvDIrjm83JXO9RvY1do/JnD8rhBEWJimkHpaGubL8IjRrzK83e6PD9yGjs6jvr
         j55bZ3HaHpfJrl1zryZEqrwheDflKsOZe34f4geTYN7FgPki5Dk8UCwsUTzjP6VEkK
         hCGyClBPq79zW/8l1e78Qaj1GHjAjwyaF3yrdSVNqWaz2WtNSr6tQnuvNPxQeXH0GW
         KYeqo6VEoPx3Q==
Date:   Thu, 15 Dec 2022 00:07:38 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Michael Greenberg <michael@greenberg.science>
Cc:     Steffen Nurpmeso <steffen@sdaoden.eu>, dash@vger.kernel.org
Subject: Re: [PATCH] options: don't error when unsetting OPTIND
Message-ID: <20221214230738.kedln32yfzcgdovd@tarta.nabijaczleweli.xyz>
References: <20221214023130.u7pn4ca6ma4kuxot@tarta.nabijaczleweli.xyz>
 <m2edt2nk5q.fsf@greenberg.science>
 <20221214174946.yISP5%steffen@sdaoden.eu>
 <m2bko5obo9.fsf@greenberg.science>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q6c2eshbq64qpgmn"
Content-Disposition: inline
In-Reply-To: <m2bko5obo9.fsf@greenberg.science>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--q6c2eshbq64qpgmn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Wed, Dec 14, 2022 at 05:36:22PM -0500, Michael Greenberg wrote:
> On 2022-12-14 at 06:49:46 PM, Steffen Nurpmeso wrote:
>=20
> > Michael Greenberg wrote in
> >  <m2edt2nk5q.fsf@greenberg.science>:
> >  ...
> >  |Bafflingly, the POSIX spec gives the example `readonly HOME PWD`, but
> >  |with no explanation about why one might want to do that. (I get making
> >  |`HOME` readonly, but `PWD`? Is that supposed to stop `cd` from workin=
g?)
> >
> > PWD is a beast with lots of "behaviors of the cd and pwd utilities
> > are unspecified" in case of user edits, see "2.5.3 Shell Variables".
>=20
> Is running `readonly PWD` the same as setting `PWD`?
>=20
> The language in the documentation for `cd` and in 2.5.3 only talks about =
setting or
> unsetting `PWD`, but not the export/readonly bits.

Isssue 8 Draft 2.1, XBD, 8.1 Environment Variable Definition para. 11
(p. 156, ll. 5381-5390) says:
  Additionally, a subset of the above variables are manipulated by shell bu=
ilt-in utilities outside of
  shell assignments. If an attempt is made to mark any of the following var=
iables as readonly, then
  either the readonly utility shall reject the attempt, or readonly shall s=
ucceed but the shell can still
  modify the variables outside of assignment context, or readonly shall suc=
ceed but use of a shell
  built-in that would otherwise modify such a variable shall fail.
    LINENO
    OLDPWD
    OPTARG
    OPTIND
    PWD

I.e., readonly PWD; cd /; PWD=3Ddupa must:
  * fail in readonly, or
  * fail in the cd, or
  * fail in the assignment
at implementer's choice. Which is just a long-winded way of saying "just
do whatever but only accept readonly if it does anything".

Dash appears to do option 2:
  $ ./dash -c 'readonly PWD; cd /'
  ./dash: 1: cd: PWD: is read only
  $ ./dash -c 'readonly OPTIND; getopts a a -a'
  ./dash: 1: getopts: OPTIND: is read only
which is fine.
OLDPWD behaves like PWD and OPTARG like OPTIND.
LINENO behaves like option 3 for obvious reasons.

(For completeness: in ibid., para. 12 (ll. 5391-5392)
 there's a provision for special treatment for any non-standard
 variable we want for our built-ins:
   Implementations may provide an implementation-defined set of additional =
variables which are
   manipulated by implementation-specific built-in utilities not defined in=
 this standard. The
   readonly utility shall not reject marking these additional variables as =
readonly, but when marked
   readonly, those extension utilities shall either continue to modify the =
variables, or shall fail
   because the variable is readonly. None of the variables defined by this =
standard shall be in this
   implementation-defined set.)

Best,
=D0=BD=D0=B0=D0=B1

--q6c2eshbq64qpgmn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOaVzUACgkQvP0LAY0m
WPEC7Q//Wt+9PQ4QTpj+L9wSKPb1Qvgz81G6gjqeb44pIr2LgZY9zsk7Z7ufHfL/
Yh92cCwN1Y0chRZuKs21w2kN+1eefgA8toxe2R+h+0rffj0EqQEEfPkYvuDjdSWU
r1Ssfv9aPKl9Fo5SJmWy3VyBYY0nCl5y0igNEQq1azs2S/epXtCRhbLFUePXTMrl
r8RI8FWuPZ3NE0y3ljj7RYCzYqxuilv+St/dyU+IAZJfoYMclL18Lc7vUIqOGM4M
xyTcTFlvxIAqCgifkE2oSlRgmsCe8GK2OzRd/GY85sL7vSUZnJQSmZbyUcHx1uyh
9ljDLTnXLIwhcvztT0lTtXNL78AJgY6chCGSCZZaOYQsniFcE5RGyrmWit6dYoSe
PYL6bL3tYP1mLZ35gyO0vgHX7LkazshLkG0ko0Mz+YD1CNwOeXc4TZWOzkuQ1y6q
EU4d9pGfyQiow+dOf78uNOpl3VHFDQXLQdpXTW/An3j9KP3Lf5kNvYL9f0XGpf6+
nVwQM5854C/urBip3xHxpwi1VdFndlEWx58d3e1FJmxEwUKzA3aaOBtbUyUSIdvo
A6CEVxWZ6OoQN2St08ENWWxHq4Snx1mITKG/CvfqzxGRebxhpvWH3nZCAaNMQ5uj
wsw5JDi6tKVeUISm6eKAUPbbWL13swD3amNsIwzBz+jg1NH/+Ts=
=rnjo
-----END PGP SIGNATURE-----

--q6c2eshbq64qpgmn--
