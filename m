From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 2/2] [EVAL] clean up myhistedit.h
Date: Wed, 8 Sep 2010 16:25:46 +0800
Message-ID: <20100908082546.GA15377@gondor.apana.org.au>
References: <1278578180-6969-1-git-send-email-max@stro.at> <1278578180-6969-2-git-send-email-max@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:53476 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758459Ab0IHIZt (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 8 Sep 2010 04:25:49 -0400
Content-Disposition: inline
In-Reply-To: <1278578180-6969-2-git-send-email-max@stro.at>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: maximilian attems <max@stro.at>
Cc: dash@vger.kernel.org, klibc@zytor.com

On Thu, Jul 08, 2010 at 10:36:20AM +0200, maximilian attems wrote:
> fixes debug compilation of klibc:
> In file included from usr/dash/eval.c:64:
> usr/dash/myhistedit.h:34:22: error: histedit.h: No such file or direc=
tory
> In file included from usr/dash/eval.c:64:
> usr/dash/myhistedit.h:36: error: expected =E2=80=98=3D=E2=80=99, =E2=80=
=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or =E2=80=98_=
_attribute__=E2=80=99 before =E2=80=98*=E2=80=99 token
> usr/dash/myhistedit.h:37: error: expected =E2=80=98=3D=E2=80=99, =E2=80=
=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or =E2=80=98_=
_attribute__
>=20
> as none of the History or EditLine seem to have an usage, removed the=
m.
>=20
> Signed-off-by: maximilian attems <max@stro.at>

Actually this shouldn't happen.  myhistedit.h is only included
when built without -DSMALL, which means that libedit is present.

Cheers,
--=20
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
