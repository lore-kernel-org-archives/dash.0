Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820F0C4332F
	for <linux-dash@archiver.kernel.org>; Thu, 15 Dec 2022 00:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiLOAWZ (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 14 Dec 2022 19:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLOAWY (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 14 Dec 2022 19:22:24 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2D4019D
        for <dash@vger.kernel.org>; Wed, 14 Dec 2022 16:22:21 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id EA5F010AC
        for <dash@vger.kernel.org>; Thu, 15 Dec 2022 01:22:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1671063740;
        bh=JhjFPP+hdpgxUfAealvROJwMZGBh6OKXM2dzLGsJyJo=;
        h=Date:From:To:Subject:From;
        b=GNR1VRGD6tLorlH9VRkfdLjXhtQdms59EEsl9Ydy5XaRTOlvNGF2UlRcQ4Gcy6Qwq
         7HaC8UHQVhs0vdNq7g+8qq9QWBciWG4ueY0JdubqRlkTZvljGeni+bmqMp70920AHl
         KfHp+DH7cW2UhqgJzItHKh73XuuZFBbGujSHNY5fgGX1ncirP0ZGTxvj2WBLMoRzmZ
         QqTK/CXB8h3Xnf4WrA4zO2bNg0/a0xH0tyOgLvidhhSqNXfUyBJ/u6bnJ9RsYh5WFW
         sHFQ4iQmquJYI/6D19vB9FuMoqRauiVK/62Lhfnz9IX0fux+FcyGQ2h5eLtxSlErA9
         w694bisAAWrTg==
Date:   Thu, 15 Dec 2022 01:22:18 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Subject: [PATCH v2 1/3] man: document jobs builtin
Message-ID: <ce831de5c91ebd75b6da5fbdd7de79159a765e6f.1671063677.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nmlsvzxzoeyngek4"
Content-Disposition: inline
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--nmlsvzxzoeyngek4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fixes: https://bugs.debian.org/558607
---
Resending my patchset from May while I'm at it.

 src/dash.1 | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/src/dash.1 b/src/dash.1
index ff02237..969a883 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -1464,6 +1464,20 @@ The
 .Fl r
 option causes the hash command to delete all the entries in the hash table
 except for functions.
+.It jobs Oo Fl lp Oc Op Ar job ...
+Display the status of all, or just the specified,
+.Ar job Ns s :
+.Bl -tag -compact -offset 5n -width "By default"
+.It By default
+display the job number, currency
+.Pq Sy +-
+status, if any, the job state, and its shell command.
+.It Fl l
+also output the PID of the group leader, and just the PID and shell comman=
ds
+of other members of the job.
+.It Fl p
+Display only leader PIDs, one per line.
+.El
 .It pwd Op Fl LP
 builtin command remembers what the current directory
 is rather than recomputing it each time.
--=20
2.30.2


--nmlsvzxzoeyngek4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOaaLoACgkQvP0LAY0m
WPEbHw/8CyLmAp2BUoP49zjDiiz743nFywLVMKo/B8txtCPxyxqc/E2VVJ93hvs9
qP8yl0qN2/GdkvNyZwHgqLH0AL6wjozQ7GEpIzTzKEvMnrmXf/fOdcRM8Yql6tpb
uhGQpipTuZnv8G/JR6iVqFeKWwFNDOGuf3WIMrQfFYfhSLzOCFAnacyT6/Gp2oyf
StlGoLtx6jnlVxwbUEUytluoEqlsWAFnAJMSoLE12mi4Thk/EWqDa4eg9ifxhNhB
+Oef9mtDVUtaTghQuBSTS03CWaIzvQQqKQzYZTPlJL+kcl9j3mTfTOckwhVLtIFw
PcbRT6kYIHvQ95EzliOQGntj+XnpbbatFlOEhnXmlX5wLLUZ8RsZ65ccs1fpzOXq
9b+AENcLYWJ3gmVk623tezaluXruaLfbH+AVIFr9Fn/pYIrzVRtMY+WJ17Rps8Rw
aa79rz/MksNjXlY+xUnZ0UUYe8Z5b7iP0sO7wMYKD3NzlMit6pdTI8hlG1C4VrvJ
KUsDsMZMkFVcryod+CV8+QOif6rDIzzowS7gN7XMO0fvfyAvxKuoR9D2pXntqEHQ
62ouo0VzP5K872Mbt38digMjCvfVjQiBzKfaGRwIAE8GvlrBb1ifnRgzgxrDLsC4
mTeuv6RmZjdM0VfI+S71E5OXoFf+lFzLgdH/dph9pc5R9qfqjUM=
=iReA
-----END PGP SIGNATURE-----

--nmlsvzxzoeyngek4--
