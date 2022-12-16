Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D68C4332F
	for <linux-dash@archiver.kernel.org>; Fri, 16 Dec 2022 23:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiLPXBR (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 16 Dec 2022 18:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLPXBQ (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 16 Dec 2022 18:01:16 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CABDB537E4
        for <dash@vger.kernel.org>; Fri, 16 Dec 2022 15:01:12 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 4DBA21522
        for <dash@vger.kernel.org>; Sat, 17 Dec 2022 00:01:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1671231670;
        bh=li5/3opVe6Cb2ep7x+ydntorb6xxDEAAaYRu5xHDWgE=;
        h=Date:From:To:Subject:From;
        b=mKwo+BiC0p4AfClkB5LW20c25Sw8+/yOzX9KIXYtQ5R2/3cVbwDooSEgvk4oa6+rV
         BIKPmC1+BRShPYkh7fSWi6luS0uJO2UtVMtHk9r7sEyR5Y6KakrgDKvtl6eD4tMa2W
         rzP6e8cWcWqwWDMj/6jG5YkblBLsXoUvilWMhCagnPNQjuUicnp+8aTI4b1Ua5cW04
         CElfrfzRZJ92ocA2nVbkqZSlPg1RK6I2f407bu8Y9GvShFKmn9QBNxrPT+OJHtQvbj
         tvURq5DmK0DdRSXd9VgpGt/usaSAtc9JSQYblQPjtgd7JtcxbRyVS/tOyOFDA8uTuv
         9SPXPqdMGV4NA==
Date:   Sat, 17 Dec 2022 00:01:09 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Subject: [PATCH] redir: savefd: use F_DUPFD_CLOEXEC instead of F_DUPFD+F_SETFD
Message-ID: <20221216230109.zujtrue6a3qtj6fo@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jb6vbtppqwqej3dk"
Content-Disposition: inline
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--jb6vbtppqwqej3dk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This saves a syscall on every source file open, &c.;
F_DUPFD_CLOEXEC is a mandatory part of POSIX since Issue 7
(Austin Group Interpretation 1003.1-2001 #171).
---
 src/redir.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/redir.c b/src/redir.c
index 5a5835c..9fee74f 100644
--- a/src/redir.c
+++ b/src/redir.c
@@ -446,14 +446,12 @@ savefd(int from, int ofd)
 	int newfd;
 	int err;
=20
-	newfd =3D fcntl(from, F_DUPFD, 10);
+	newfd =3D fcntl(from, F_DUPFD_CLOEXEC, 10);
 	err =3D newfd < 0 ? errno : 0;
 	if (err !=3D EBADF) {
 		close(ofd);
 		if (err)
 			sh_error("%d: %s", from, strerror(err));
-		else
-			fcntl(newfd, F_SETFD, FD_CLOEXEC);
 	}
=20
 	return newfd;
--=20
2.30.2

--jb6vbtppqwqej3dk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOc+LQACgkQvP0LAY0m
WPGuPw/9EUU2R2cbuoAK17wmt0Lr7h1qrp2h9jcOm1G3WNuyr4sdxvJnQPqOhPnx
gWLso+UuOze2iO1UNjEXqovwV6Osc9HSR4/b1mkbSJETWPKDVlwYEjEFdk89N2eL
AEtltx3C/1CT8J5XpJKri7/I89PgAGvNRM84YbTAPobQfQXqVwVRNE91XaxHz6sl
tUQkz7r4nxN04dpklCMcNYW932uYa4C1K+LkIZnwD3M2hdW01JjCcM1Wb1iP1htw
veBql0jHdDNuyNqmMdI3Tv+M18yTeBEy75+95+ZoYhii1fP5+gE8BK3Di7rs5DwO
JhzExP4c5E8I/NZQTnENK6Sr2pCSsyo67HjaUGBC7YGtd2nQaCPgJwIXaaJQCFWO
GHx1D3T1rYX3/H7pdUkAIzEqKcyUhDIBFMmpi35vf4v27hiXzLtUinYgGJGgS9QL
IpMZbzpKg29s1kbw1jkH1L+ksZj06qtIvDzuuLLi4KvwfiSGKb9Df7tjeXjvUfWh
Ny4OaarUwtM0novb4cNBV4zQfQUzrtw9p1ekxyE2HlESvTFgVrHUrtvOxMBfWUfx
Eq/fyuC1XFEHz4UIDrKN+7xCnijGU4liIuP3g92jjnFSlyjAgAnWGtQBea0MpmDJ
zHWliNUiKVkWsusqBYSvUPzux/9OvPIWADdStQwFWs8n2vpW8p4=
=eRZR
-----END PGP SIGNATURE-----

--jb6vbtppqwqej3dk--
