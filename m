From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [Partial patch] IFS and read builtin
Date: Sat, 16 Oct 2010 14:15:48 -0500
Message-ID: <20101016191548.GA10626@burratino>
References: <4C71A29C.1080609@gigawatt.nl>
 <20100908115324.GA17029@gondor.apana.org.au>
 <20100908120849.GA17121@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42021 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832Ab0JPTTW (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 16 Oct 2010 15:19:22 -0400
Received: by yxm8 with SMTP id 8so836032yxm.19
        for <dash@vger.kernel.org>; Sat, 16 Oct 2010 12:19:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100908120849.GA17121@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org

Hi Herbert,

Herbert Xu wrote:

> commit f42e443bb511ed3224f09b4fcf0772438ebdbbfa
> Author: Herbert Xu <herbert@gondor.apana.org.au>
> Date:   Wed Sep 8 20:07:26 2010 +0800
>=20
>     [EXPAND] Fix ifsfirst/ifslastp leak
>    =20
>     As it stands expandarg may return with a non-NULL ifslastp which
>     then confuses any subsequent ifsbreakup user that doesn't clear
>     it directly.
>    =20
>     What's worse, if we get interrupted before we hit ifsfree in
>     expandarg we will leak memory.
>    =20
>     This patch fixes this by always calling ifsfree in expandarg
>     thus ensuring that ifslastp is always NULL on the normal path.
>     It also adds an ifsfree call to the RESET path to ensure that
>     memory isn't leaked.

I was experiencing weird symptoms with a local test script (for another
program):

	$ sh -x t5523-push-upstream.sh -i -v
	[...]
	+ test_terminal git push -u upstream master
	+ die
	+ code=3D2
	+ test -n
	+ echo FATAL: Unexpected exit with code 2
	FATAL: Unexpected exit with code 2
	+ exit 1
	$ cat trash\ directory.t5523-push-upstream/err
	+ test_declared_prereq TTY
	+ return 1
	+ test_declared_prereq TTYREDIR
	+ return :T=EF=BF=BD    D=EF=BF=BD      \=EF=BF=BD      K=EF=BF=BD    =
  l=EF=BF=BD      M=EF=BF=BD      1 =EF=BF=BD     D=EF=BF=BD      \=EF=BF=
=BD      K=EF=BF=BD      l=EF=BF=BD      M=EF=BF=BD      1 1
	return: 1: Illegal number: :T=EF=BF=BD  D=EF=BF=BD      \=EF=BF=BD    =
  K=EF=BF=BD      l=EF=BF=BD      M=EF=BF=BD      1

The strange text there is supposed to be 127, I think, and it is not
supposed to be redirected to err.

Bisects to f42e443bb.  Reverting it avoids the problem.  Any ideas
before I investigate further?

Jonathan
