Received: from postout2.mail.lrz.de (postout2.mail.lrz.de [129.187.255.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4F81FE46D
	for <dash@vger.kernel.org>; Tue,  6 Jan 2026 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.187.255.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767714025; cv=none; b=eGWY+HBDaeOglzGdcZhx4ygM5FqgYTJKXFWUtsOax3cLZ1+VSRCXnl/ZA6DwaF3dznDLJkcUsi9c7i4Q9u+8wIwO5eeFnY3eCgizjGnUtdZ9I6bTxvJcGCdp1bTjAXDYrzXpdTQMJ4k59cNu6Il4EZnoVQn1cDClIKWRi43S60c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767714025; c=relaxed/simple;
	bh=S1hvd0xL572SqR97Cem3esc2gFLf1m7u3JaDs2ICeYA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To; b=plJiyV0lIsveIrSC1swo6nQPI3wSe3GOuLRFT+4ol4v44bBH6O+qEsxLDEp9ESNiS6lVywW2FwmXzSy43HZg1RRoyXn3mkOfy/zfwmFX7wAoFOxqwgUbf0v0HQPBk0BJZOm7K900rFQcMgvKh7jJi+0l00opk/TGDtZBpcHDrUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tum.de; spf=pass smtp.mailfrom=tum.de; dkim=pass (2048-bit key) header.d=tum.de header.i=@tum.de header.b=VX4yRGXD; arc=none smtp.client-ip=129.187.255.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tum.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tum.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tum.de header.i=@tum.de header.b="VX4yRGXD"
Received: from lxmhs52.srv.lrz.de (localhost [127.0.0.1])
	by postout2.mail.lrz.de (Postfix) with ESMTP id 4dlwFn6B1QzyXW
	for <dash@vger.kernel.org>; Tue,  6 Jan 2026 16:34:37 +0100 (CET)
Authentication-Results: postout.lrz.de (amavis); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=tum.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tum.de; h=
	x-mailer:from:from:subject:subject:message-id:date:date
	:content-type:content-type:mime-version:received:received; s=
	tu-postout21; t=1767713677; bh=N4MGiEQXVqK2SJWnck6/kJZaMznXn2RYI
	HQ1x1+8oQo=; b=VX4yRGXDsTWG/FYs80h+sB0Igl9SkWBW+ks6FK+9IqAl9xQij
	0t8ebPwpH0PArsW6pTKnEYDRxQe9/Nipi0WHu9HWuqnbziRnj5MiaLT05dfoRgE9
	3H/FB49ly2OKFn9JN5wwwxiQ+BEAjPMBxJjokPQdWtBALpsRAKzYnVLHqfH5TWSX
	tYNVbH8LoyWmBlPF6dFRpOhswoyHod2ddRCgrpaGWUg8vuH3uFjharMqtb5burKl
	qVDT9i7tVTXKqA0JG2JrBpM6HcModl09yg7FfNmOBTfJdaKSv++9b3dvkZbLqz37
	1cHnWwBG9GIa0D2TI4eKiP15762g9aSZdtdOA==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs52.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -2.869
X-Spam-Level:
Received: from postout2.mail.lrz.de ([127.0.0.1])
 by lxmhs52.srv.lrz.de (lxmhs52.srv.lrz.de [127.0.0.1]) (amavis, port 20024)
 with LMTP id khArG9UF1lSo for <dash@vger.kernel.org>;
 Tue,  6 Jan 2026 16:34:37 +0100 (CET)
Received: from localhost (unknown [5.42.207.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by postout2.mail.lrz.de (Postfix) with ESMTPSA id 4dlwFc5BWyzyXX
	for <dash@vger.kernel.org>; Tue,  6 Jan 2026 16:34:28 +0100 (CET)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=6d4bbf0dc00f7acc97c4131d48bb1f255631138ab53d4544222d1fc0b920;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 06 Jan 2026 16:34:27 +0100
Message-Id: <DFHM744ATISY.1T8SIZ5DGCL1C@tum.de>
Subject: [PATCH] main.c: obviously initialize smark
From: "Fabian Rast" <fabian.rast@tum.de>
To: <dash@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2

--6d4bbf0dc00f7acc97c4131d48bb1f255631138ab53d4544222d1fc0b920
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Otherwise an optimizing compiler (with LTO) might conclude that an
undefined value is used in the popstackmark call in the setjmp handler,
causing undefined behavior.
---
 src/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/main.c b/src/main.c
index 5d25b8d..1ab8c04 100644
--- a/src/main.c
+++ b/src/main.c
@@ -105,6 +105,7 @@ main(int argc, char **argv)
 #endif
=20
 	setlocale(LC_ALL, "");
+	setstackmark(&smark);
=20
 	state =3D 0;
 	if (unlikely(setjmp(main_handler.loc))) {
@@ -149,7 +150,6 @@ main(int argc, char **argv)
 #endif
 	mypid =3D rootpid =3D getpid();
 	init();
-	setstackmark(&smark);
 	login =3D procargs(argv);
 	if (login) {
 		state =3D 1;
--=20
2.52.0

Hello,

I discovered this bug in a full LTO build of dash, where
triggering a longjmp using Ctrl-C caused a crash.

Reproduction, depends on compiler...

tmp $ clang --version
clang version 21.1.8 (AerynOS)
Target: x86_64-aerynos-linux
Thread model: posix
InstalledDir: /usr/bin
tmp $ git clone https://git.kernel.org/pub/scm/utils/dash/dash.git
tmp 0$ cd dash
dash $ ./autogen.sh
dash $ CC=3Dclang CFLAGS=3D'-O2 -flto=3Dfull' LDFLAGS=3D-flto=3Dfull ./conf=
igure --enable-glob --with-libedit
dash $ make
dash $ ./src/dash
$ sleep 10
^C
free(): invalid pointer
The process was killed by SIGABRT: Aborted

As far as I understand, what is happening is that in the full LTO
configuration, clang deduces that if the setjmp condition is true,
smark is still undefined, causing undefined behavior.

Of course, due to how setjmp works, the condition is _never_ true before
smark is initialized, but clang does not realize this.

I figured the optimal solution would be to move the initialization
before the setjmp if statement.
As far as I can see this should not cause other problems, although
moving the call before the `init()` feels weird
- i would love your opinon on this!

The other option would be to just zero initialize smark, but this
would be redundant in all practical executions.

Best Regards,
Fabian Rast

--6d4bbf0dc00f7acc97c4131d48bb1f255631138ab53d4544222d1fc0b920
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQR/XYlSdTMJOeXCzuZ0Wcn2B4rRwwUCaV0rhQAKCRB0Wcn2B4rR
w3x/AQDwZS6FwsU/nkLMCesWtFs74IJNJNsGJxmpjwJtnJFOVwD/adem09yozJZ6
w3bB+alvuxgiTsa+SkY+n6Z8q+hLTQA=
=cXP2
-----END PGP SIGNATURE-----

--6d4bbf0dc00f7acc97c4131d48bb1f255631138ab53d4544222d1fc0b920--
