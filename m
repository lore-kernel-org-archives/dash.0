From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH dash] [EXPAND] Free IFS state after here document expansion
Date: Sun, 13 Mar 2011 13:48:58 -0500
Message-ID: <20110313184858.GA6687@elie>
References: <20110313144103.30026.48296.reportbug@volta.aurel32.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:45108 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754636Ab1CMStF convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Sun, 13 Mar 2011 14:49:05 -0400
Received: by yia27 with SMTP id 27so1775639yia.19
        for <dash@vger.kernel.org>; Sun, 13 Mar 2011 11:49:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110313144103.30026.48296.reportbug@volta.aurel32.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Aurelien Jarno <aurel32@debian.org>, Herbert Xu <herbert@gondor.apana.org.au>

Here's another bug bisecting to f42e443bb ([EXPAND] Fix
ifsfirst/ifslastp leak, 2010-09-08).  It was found with the following
test case, based on the configure script for Tracker:

	dash -x -c '
		<<-_ACEOF
		$@
		_ACEOF
		exec
	' - abcdefgh
	+
	+ exec   =EF=BF=BDa
	exec: 1: : Permission denied

The missing ifsfree call is in expandarg when it returns to openhere
during here document expansion.

Reported-by: Aurelien Jarno <aurel32@debian.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi,

Aurelien Jarno wrote[1]:

>   https://buildd.debian.org/fetch.cgi?pkg=3Dtracker&arch=3Damd64&ver=3D=
0.10.3-1&stamp=3D1299968124&file=3Dlog&as=3Draw
[...]
> |  57145 dash     CALL  execve(0x806bf64,0x806ba64,0x806bef4)
> |  57145 dash     NAMI  "/usr/local/bincd$e,f4g<hDnLoTpu"

This patch seems to fix it.  Thoughts?

[1] http://bugs.debian.org/618023

 src/expand.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/expand.c b/src/expand.c
index 7a9b157..eac6c6d 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -194,6 +194,7 @@ expandarg(union node *arg, struct arglist *arglist,=
 int flag)
 	p =3D _STPUTC('\0', expdest);
 	expdest =3D p - 1;
 	if (arglist =3D=3D NULL) {
+		ifsfree();
 		return;			/* here document expanded */
 	}
 	p =3D grabstackstr(p);
--=20
1.7.4.1

