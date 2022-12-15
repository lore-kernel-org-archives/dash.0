Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C0DC4332F
	for <linux-dash@archiver.kernel.org>; Thu, 15 Dec 2022 00:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiLOAXG (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 14 Dec 2022 19:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiLOAXE (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 14 Dec 2022 19:23:04 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 933EF33D
        for <dash@vger.kernel.org>; Wed, 14 Dec 2022 16:23:03 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id E7B4D10B0
        for <dash@vger.kernel.org>; Thu, 15 Dec 2022 01:23:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1671063782;
        bh=5o6tJ0cSUTQyKxBYqsWZuD7huartTkVdL44QI2weMfY=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=FrY0jhlQyxhsXKtUP39sRSGOUrmnMHXpIUJfRMjlNsJfvap17Nu2Y9npaWtPQb5Ha
         Y+gcJdtG9qRX1ioeZtfBaTmzIya4VZuFjgYmHiDHxH49XDh5bcAUcHErlcJbTZmxqS
         +TsrassWBVgpFuPZJGGAjJvKNZOjyOevS43+sU7w07lEiN77/S+PpBe5llm40ibjNf
         4dgBeDpszZ6eCDLqw/DkdW01jV+ybcGxR7OhakcC/b8xzMk0hcwmmr2B9QgUuT/h9+
         e2XF1GG5HXwGlx3xQHsK+rcI4p4gq3flbTL1KRBy13InNS3Wevkv2ALixddQ9VMn9N
         U5DLjj3vWujhQ==
Date:   Thu, 15 Dec 2022 01:23:01 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Subject: [PATCH v2 3/3] man: document kill builtin
Message-ID: <90e2b94e6e75aab4d591affa3eb0c63446eb404d.1671063677.git.nabijaczleweli@nabijaczleweli.xyz>
References: <ce831de5c91ebd75b6da5fbdd7de79159a765e6f.1671063677.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gg4kgjf2fq3f2v26"
Content-Disposition: inline
In-Reply-To: <ce831de5c91ebd75b6da5fbdd7de79159a765e6f.1671063677.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--gg4kgjf2fq3f2v26
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The manual now contains all built-ins
---
 src/dash.1 | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/src/dash.1 b/src/dash.1
index dd2bd47..514fcfe 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -1478,6 +1478,33 @@ of other members of the job.
 .It Fl p
 Display only leader PIDs, one per line.
 .El
+.It kill Oo Fl s Ar sigspec | Fl Ns Ar signum | Fl Ns Ar sigspec Oc Op Ar =
pid | job ...
+Equivalent to
+.Xr kill 1 ,
+but a
+.Ar job
+spec may also be specified.
+Signals can be either case-insensitive names without
+.Dv SIG
+prefixes or decimal numbers; the default is
+.Dv TERM .
+.It kill Fl l Op Ar signum | exitstatus
+List available signal names without the
+.Dv SIG
+prefix
+.Pq Ar sigspec Ns s .
+If
+.Ar signum
+specified, display just the
+.Ar sigspec
+for that signal.
+If
+.Ar exitstatus
+specified
+.Pq > Sy 128 ,
+display just the
+.Ar sigspec
+that caused it.
 .It pwd Op Fl LP
 builtin command remembers what the current directory
 is rather than recomputing it each time.
--=20
2.30.2

--gg4kgjf2fq3f2v26
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOaaOUACgkQvP0LAY0m
WPFEzA/6A4MeWfA34sJlcSojPkspLRgY0reAAY7SEjdbimbwLmkBkBmzk/DsWeZe
Byf8pTrSf48yhVLlmNXaFjTdjjQXxG3jTuH24N7jWqlkYykZj26LHbO2Q1717aC3
YtNBmrkN+ng/Pgv7Xa1b8SOsqmJrUnAIDuXaS8Mk82gv5+SJNJ+GX9xwc6VPhAdp
UGyp0f4JM75nfx1asixPmlst0gdlXqac7gduJ+1ZDQgBwRtvZTFx5EV9iCatmd1C
be2c+b/A9jiZuoDc9nEXYsho6asuVA1mODwo0rOL+3ln8u1m3wF3Ixh6Ilh/Y4NR
zYXmX4t0iq/LpMuDnJKfeGMNntb8+WQRrnZrS9TGkbmbMAluwOxlki6112mRVszU
u+UkVjbxvzLXFo1pxrj0bw8zEPKJVgtDWs10n9d5bvs+Q3xsw7UPHfJJnHYivsy9
S+/VkJpBfa1/evMlFoejmKH6rgmeeNA2G+8J4/SDjN+kXsTMRZm6hatJoPHjcLfN
KjcWEX9UTKVKr51EaoWoMYg72npwdPOM3hjdxT3Di3xTlQLOPU38JatDhIN21MSk
70wz8EgiOKlmX1PoxowtsYmZB3+sPM2eMYSV7rOb39Ojk2zYj9OxsJyoL1orkvWp
rhME5NzR1mYaXQNeLDvvKeqZyVrLaMplKeU+t1aVJJ5kwDjv6Gs=
=YXsa
-----END PGP SIGNATURE-----

--gg4kgjf2fq3f2v26--
