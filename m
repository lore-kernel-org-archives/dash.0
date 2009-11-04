From: Eitan Adler <eitanadlerlist@gmail.com>
Subject: trouble building dash
Date: Wed, 4 Nov 2009 21:19:10 +0200
Message-ID: <a0777e080911041119i13ae41ddye25c7dd21e8df175@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:44353 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbZKDTTZ (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 4 Nov 2009 14:19:25 -0500
Received: by yxe17 with SMTP id 17so6638053yxe.33
        for <dash@vger.kernel.org>; Wed, 04 Nov 2009 11:19:30 -0800 (PST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Here is the output from ./configure && gmake

if gcc -DHAVE_CONFIG_H -I. -I. -I..  -include ../config.h -DBSD=1
-DSHELL -DIFS_BROKEN  -Wall -g -O2 -MT nodes.o -MD -MP -MF
".deps/nodes.Tpo" -c -o nodes.o nodes.c; \
        then mv -f ".deps/nodes.Tpo" ".deps/nodes.Po"; else rm -f
".deps/nodes.Tpo"; exit 1; fi
gcc -include ../config.h -DBSD=1 -DSHELL -DIFS_BROKEN  -g -O2 -Wall
-o mksignames mksignames.c
./mksignames
gmake[3]: *** [signames.c] Segmentation fault: 11 (core dumped)
gmake[3]: *** Deleting file `signames.c'
gmake[3]: Leaving directory `/home/eitan/dash/dash-0.5.5.1/src'
gmake[2]: *** [all] Error 2
gmake[2]: Leaving directory `/home/eitan/dash/dash-0.5.5.1/src'
gmake[1]: *** [all-recursive] Error 1
gmake[1]: Leaving directory `/home/eitan/dash/dash-0.5.5.1'
gmake: *** [all] Error 2


$ uname -a
FreeBSD AlphaBeta 8.0-RC2 FreeBSD 8.0-RC2 #0: Sun Oct 25 08:55:51 UTC
2009     root@almeida.cse.buffalo.edu:/usr/obj/usr/src/sys/GENERIC
i386

Can anyone help me figure out whats going on?

(also tiny spelling error in configure --help)
  --enable-static         Build statical linked program
should be
  --enable-static         Build statically linked program
I think
