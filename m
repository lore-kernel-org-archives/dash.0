From: =?iso-8859-1?Q?St=E9phane?= CHAZELAS <stephane.chazelas@gmail.com>
Subject: Re: Bug#501566: dash: details of redirection/duplication in manpage
 are reversed
Date: Wed, 19 Nov 2014 00:00:08 +0000
Message-ID: <20141119000008.GC3963@chaz.gmail.com>
References: <20141110111951.GA4185@free.fr>
 <20141110132409.GA8416@gondor.apana.org.au>
 <20141110134957.GA5664@free.fr>
 <CAEuPzf47pS0u+uY9-RUjOgGOuuGb6o9htY5Quu-B6dMuOVWA3Q@mail.gmail.com>
 <20141118232718.GA9223@free.fr>
 <20141118234603.GA9586@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37070 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932865AbaKSAAL (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 18 Nov 2014 19:00:11 -0500
Received: by mail-wi0-f182.google.com with SMTP id h11so63329wiw.15
        for <dash@vger.kernel.org>; Tue, 18 Nov 2014 16:00:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141118234603.GA9586@free.fr>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: =?iso-8859-1?Q?St=E9phane?= Aulery <saulery@free.fr>
Cc: Stephen Shirley <diamond@nonado.net>, Herbert Xu <herbert@gondor.apana.org.au>, 501566@bugs.debian.org, dash@vger.kernel.org

2014-11-19 00:46:03 +0100, St=E9phane Aulery:
> Hello Stephen and Herbert,
>=20
> St=E9phane Chazelas just made a complete proposal:
>=20
>=20
> 1) [n1]<&n2    Redirect standard input (or fd n1) from the same
>                resource as open on fd n2.
>=20
> 2b) [n1]>&n2   Redirect standard output (or fd n1) to
>                the same resource as open on fd n2.
>=20
>=20
> What do you think about?
[...]

A final touch (add "currently").

 [n1]<&n2    Redirect standard input (or fd n1) from the same
             resource as currently open on fd n2.
=20
 [n1]>&n2   Redirect standard output (or fd n1) to
            the same resource as currently open on fd n2.

--=20
Stephane
