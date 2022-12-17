Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF5DC4332F
	for <linux-dash@archiver.kernel.org>; Sat, 17 Dec 2022 19:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiLQTKE (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 17 Dec 2022 14:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiLQTJh (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 17 Dec 2022 14:09:37 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAF4B10FC2
        for <dash@vger.kernel.org>; Sat, 17 Dec 2022 11:07:10 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id E4AA8600
        for <dash@vger.kernel.org>; Sat, 17 Dec 2022 20:07:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1671304026;
        bh=MVGPISGlRvYu/TQcug5DRH8t/jSeBdOvOmJErXguYpY=;
        h=Date:From:To:Subject:From;
        b=fv0f7B6CoF/vmbdNzwtRN+5ARpKCGkYeTe6vIZTonjwEqeeUz0ai3XhnhwLvXrvim
         EuvVq9+ufyVVjYir8kbngiConCvY0w6r/DRisDItNN6Mw+VNJbfy84We5guYjoaWf6
         f5tqIfDz4InLBHCzwMWGyCD6gIdnoCo9TSImAePd2wvaVZiXl/AxXAggPiK2HQis0W
         w3hch4EAl027ED9YNQSW4jblKLXmzxK6Zgck5/3Vzot5v++UbuTxoIsFOsMtpwGDSd
         XosHNQnn8UdSQjLnlfclE7oRgz2PMDflpWOBylYEQ8tXhIjnonhZkDC8TXO19VVdUg
         iaUydquqhoJnA==
Date:   Sat, 17 Dec 2022 20:07:05 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Subject: [PATCH] alias: aliascmd: refuse uninvokable aliases
Message-ID: <20221217190705.atfwacsgggtafzl2@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qi6vuo6d46oaxrhi"
Content-Disposition: inline
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--qi6vuo6d46oaxrhi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

See standards quote within, but the fun bit is:
  alias "a'b=3Dc" "ls&id=3Dcd"; alias
outputs
  ls&id=3D'cd'
  a'b=3D'c'
neither of which is What You Want, and also you can't invoke them
because you need to escape the quote/&/whatever, which disables
alias processing. Forbid the minimum broken set.

For reference's sake, here's a test driver:
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <sys/wait.h>
  #include <unistd.h>
  int main(int _, char ** argv) {
  	putenv("LC_ALL=3DC");
  	char val[] =3D "alias 'aQb=3Decho a' && alias";
  	unsigned char * vp =3D strchr(val, 'Q');
  	for(unsigned i =3D 0; i <=3D 0xFF; ++i) {
  		*vp =3D i;
  		if(!vfork()) {
  			execl(argv[1], "sh", "-c", val, (char *)NULL);
  			_exit(-1);
  		}
  		int r;
  		wait(&r);
  		fprintf(stderr, "%02x: %d\n", i, WEXITSTATUS(r));
  	}
  }

zsh  refuses nothing
dash refuses 09 0a 20 22 24 26 27 28 29 3b 3c 3e 5c 60 7c
bash refuses dash + 2f
mksh refuses bash + 23 + 2a + 3f + 5e + <20 + >7c
ksh  refuses bash + 2a + 3f + 5b + 7b + 7d

Fixes: https://bugs.debian.org/758542
---
 src/alias.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/src/alias.c b/src/alias.c
index daeacbb..81de975 100644
--- a/src/alias.c
+++ b/src/alias.c
@@ -32,6 +32,7 @@
  * SUCH DAMAGE.
  */
=20
+#include <stdbool.h>
 #include <stdlib.h>
 #include "shell.h"
 #include "input.h"
@@ -46,10 +47,38 @@
=20
 struct alias *atab[ATABSIZE];
=20
+STATIC bool validalias(const char *);
 STATIC void setalias(const char *, const char *);
 STATIC struct alias *freealias(struct alias *);
 STATIC struct alias **__lookupalias(const char *);
=20
+/*
+ * POSIX Issue 7, XCU, 2.3.1 Alias Substitution:
+ *   the command name word of a simple command shall be examined
+ *   to determine whether it is an unquoted, valid alias name
+ * POSIX Issue 7, XCU, 2.2 Quoting:
+ *   The various quoting mechanisms are the escape character,
+ *   single-quotes, and double-quotes.
+ *
+ * Trivially, it's impossible to invoke an alias with whitespace inside
+ * (which has to be quoted, and therefore won't be an alias),
+ * with a backslash, or with quotes (likewise).
+ * The same applies to $, &, ), (, ;, >, <, `, and |.
+ *
+ * Additionally, rejecting quotes and other garbage means that we prevent
+ *   alias "a'b=3Dc" "ls&id=3Dcd"
+ * being output as
+ *   a'b=3D'c'
+ *   ls&id=3D'cd'
+ * which explodes and/or executes code when it's evaled back.
+ */
+STATIC
+bool
+validalias(const char *name)
+{
+	return !strpbrk(name, "\t\n \\\"'$&)(;><`|");
+}
+
 STATIC
 void
 setalias(const char *name, const char *val)
@@ -151,7 +180,11 @@ aliascmd(int argc, char **argv)
 				printalias(ap);
 		} else {
 			*v++ =3D '\0';
-			setalias(n, v);
+			if (!validalias(n)) {
+				outfmt(out2, "%s: %s: invalid name\n", "alias", n);
+				ret =3D 1;
+			} else
+				setalias(n, v);
 		}
 	}
=20
--=20
2.30.2

--qi6vuo6d46oaxrhi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOeE1kACgkQvP0LAY0m
WPGDLw/9H+9HNGQ+D0/y5p+cR6gQvNofoZcxfoU3Z4e0vgViDKNzoo9bbND06r60
QXw+03GUwEshzWX/ryUuC8icz0cmcVhiF0xQ6gVjgArEU3x8W+ZRLbc9yCfDdWGR
wcS8D8RcMESGamk6zfN4DwxXJ3/G/hzqLPDPcmIfrgAjECxctbvAPjUSb7jC1LiJ
rBSFxbuxaXPeDmHXJf9KyK8SIpwraqCK24xTPrVbjl/byEy9LhfmXoIFFiQIaPH0
L0njnA2aw8gfPNQp6plt/3YVzN81jHY9QVU9Xohw4GhtUzzqtscYmKmaRWariJJu
cNcA+bRTxJ6DawUSXdhcNcsUbwGEG+J9YN23WvmkfaU45MAGd0VpDgUecxbK5lsu
PBn1psjeGk2ioFXxRVPveo01aWMw6iETGC1PV0Sdb2Az4PP2vzO24YQuG7ouoq36
XBv0XE4Zj6Ehn4aH3+bYGehhNXZGBpu4vGQa6vQyS031BSHBKMvYIcNRneHWS1YE
COoD6GJVVV9k1a58ChuF2wRkuh2BJBLx426l1vICZ1I8ZF44dDFf680l5r3srG9f
8037++xFD7xKMKVboHYdNYwDO76axFF95VHWOFTKnQcSzMPw/YJ9+1bs/vSTSTI+
NW2iw2AMo0Pw6IbYFhpQFlkT+BsK8qVmwKG4hCPYvhgcQHj5MwY=
=m2Ri
-----END PGP SIGNATURE-----

--qi6vuo6d46oaxrhi--
