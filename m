From: Alexey Gladkov <gladkov.alexey@gmail.com>
Subject: [PATCH] [BUILTIN] Fix corruption of reads with byte 0x81
Date: Thu, 24 Feb 2011 14:43:44 +0300
Message-ID: <4D664470.7070707@gmail.com>
References: <4D5C4EE2.9060504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mojo.unsafe.ru ([83.222.2.183]:40519 "EHLO mojo.unsafe.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750975Ab1BXLnt (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 24 Feb 2011 06:43:49 -0500
Received: from localhost.localdomain (unknown [178.176.26.116])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mojo.unsafe.ru (Postfix) with ESMTP id AB9AB8680FB
	for <dash@vger.kernel.org>; Thu, 24 Feb 2011 14:43:45 +0300 (MSK)
In-Reply-To: <4D5C4EE2.9060504@gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Starting with commit 55c46b dash removes CTLESC bytes ('\x81')
from read sequence. This leads to breakage of some UTF8
characters. Like in commit f8231a, this change fixes corruption
by removing the faulty code.

Testcase:

$ /usr/bin/printf '[\u0441]\n'
[=D1=81]
$ /usr/bin/printf '[\u0441]\n' |dash -c 'read c; printf "%s\n" "$c"'
[=C3=91]

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 src/miscbltin.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/src/miscbltin.c b/src/miscbltin.c
index 653c92f..4e88e8d 100644
--- a/src/miscbltin.c
+++ b/src/miscbltin.c
@@ -112,14 +112,12 @@ readcmd_handle_line(char *line, char **ap, size_t=
 len)
 			 * will not modify the length of the string */
 			offset =3D sl->text - s;
 			remainder =3D backup + offset;
-			rmescapes(remainder);
 			setvar(*ap, remainder, 0);
=20
 			return;
 		}
 	=09
 		/* set variable to field */
-		rmescapes(sl->text);
 		setvar(*ap, sl->text, 0);
 		sl =3D sl->next;
 	} while (*++ap);
--=20
1.7.3.5

