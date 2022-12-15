Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8280C4332F
	for <linux-dash@archiver.kernel.org>; Thu, 15 Dec 2022 00:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiLOAXC (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 14 Dec 2022 19:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiLOAW5 (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 14 Dec 2022 19:22:57 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C9BC33D
        for <dash@vger.kernel.org>; Wed, 14 Dec 2022 16:22:56 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id DF6C610AE
        for <dash@vger.kernel.org>; Thu, 15 Dec 2022 01:22:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1671063775;
        bh=pHTzXZY/7vJtwyPcBiMopJ8j7dWNhZckzeNXV871fm8=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=PW1hE/g2Xu+rJFJhrGYJilbLjBKIwqEyQAplU2dM4Ti0zX3ANXRPjuM5qcjAzYAw3
         njK1PU67OCjWnVfz6Amq9eXDravk07p5T7lIefrxmSMjUdUqDSSt/JXPdQxDAG6WF+
         6SENPaBJEKW/rkT86HYK20/Ci7r9gMXeYfSf1mD6SDY9LRKfbi3f4M+sGZzPPkgqgp
         9nEGIe/VskLzf+DCH9ysc/WNLu40CO9wbYJ45VS+KcugonDhfcDUBTY9wKpcKsVGiu
         CWmTUAfPKTSuqXJJgOhs1SqJg4hGMt7SgfVABlEuXMWTKBZWlxxSGWlhe1YOe8wX1M
         YMnyCNLQUzm3g==
Date:   Thu, 15 Dec 2022 01:22:54 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Subject: [PATCH v2 2/3] man: note chdir being the same builtin as cd
Message-ID: <73d0a6fb6647fc83b592070ec4c4882f1de124b6.1671063677.git.nabijaczleweli@nabijaczleweli.xyz>
References: <ce831de5c91ebd75b6da5fbdd7de79159a765e6f.1671063677.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3fxmqxks5xiabgpx"
Content-Disposition: inline
In-Reply-To: <ce831de5c91ebd75b6da5fbdd7de79159a765e6f.1671063677.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--3fxmqxks5xiabgpx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

---
 src/dash.1 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/dash.1 b/src/dash.1
index 969a883..dd2bd47 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -1143,8 +1143,8 @@ Do not execute the command but
 search for the command and print the absolute pathname
 of utilities, the name for builtins or the expansion of aliases.
 .El
-.It cd Ar -
-.It Xo cd Op Fl LP
+.It cd|chdir Ar -
+.It Xo cd|chdir Op Fl LP
 .Op Ar directory
 .Xc
 Switch to the specified directory (default
--=20
2.30.2


--3fxmqxks5xiabgpx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOaaN4ACgkQvP0LAY0m
WPGGmBAAsk53nOvG8WjhLFXbVUL+Gk8nge/DY2B1q/7bmTdEMfSj26Ey+UFVOP24
8cFxIgsjeBfb8N+QyDZSnVTlkROPmOBwCh5N9nYcZbUIoNUpFCSalk3wocwBu+j4
4XifY/51VUnQaCXNhv/IfiWWNjeJRZ8kPO/ioMpY0uGN8DHqtLPCdAO+WEz7Rlk0
T88yselWvy1PQGJdWaSbPUujnePB42pIEvML+xOtNiP/JfgNSBCXxGLCtuOCMIWA
0cgCgUQpL6uugSPPiYIFThkNePguPbJEeWFl2uSYJ+YsrGQThMY9uJPq2A6Px+zf
KBwRreFSXpA6Iefw5bqJL5PUBePiquWecDsA4fTj9uIslwVdGm5dKXGBNE5PtJIC
Xldr9hKc00Ko0WT66/E0S1Qm6OopF5/K7qT1ewurE7k0pjxH3Fp8cn0CJJrDIriE
Th8E/aPkSpfR+genYpKSGejGIWGAU4yodzVwiF1nHRg1KjoRZSPc9ho7kljKOXSq
7DDDl3xQvC2lMCHJV8xiwG6A19UkaBey1Wd/YdGhbNAU6q3pp+dI8KS2MIFbUIrW
LBYNIgCFpYcmbA2E/W5m/2eNjN0WqGzAljKGOqK5MrjCVQbYnPG7gSw154ZtYq6c
FANTSneV4G6j3/vAf2HfvI0MOOQE/y9GeInJNxyY6oCifffKj6A=
=IU/n
-----END PGP SIGNATURE-----

--3fxmqxks5xiabgpx--
