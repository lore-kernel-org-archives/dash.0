From: maximilian attems <max@stro.at>
Subject: dash klibc DEBUG more compile trouble
Date: Fri, 9 Jul 2010 16:43:30 +0200
Message-ID: <20100709144330.GA23188@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:39264 "EHLO
	baikonur.stro.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757875Ab0GIQlz (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 9 Jul 2010 12:41:55 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org, klibc@zytor.com

once taken that stat/stat64 appart, histedit appears to be a minefield:

usr/dash/histedit.c:59: error: expected =E2=80=98=3D=E2=80=99, =E2=80=98=
,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or =E2=80=98__at=
tribute__=E2=80=99 before =E2=80=98*=E2=80=99 token
usr/dash/histedit.c:60: error: expected =E2=80=98=3D=E2=80=99, =E2=80=98=
,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or =E2=80=98__at=
tribute__=E2=80=99 before =E2=80=98*=E2=80=99 token
usr/dash/histedit.c: In function =E2=80=98histedit=E2=80=99:
usr/dash/histedit.c:82: error: =E2=80=98hist=E2=80=99 undeclared (first=
 use in this function)
usr/dash/histedit.c:82: error: (Each undeclared identifier is reported =
only once
usr/dash/histedit.c:82: error: for each function it appears in.)
usr/dash/histedit.c:87: warning: implicit declaration of function =E2=80=
=98history_init=E2=80=99
usr/dash/histedit.c:95: error: =E2=80=98el=E2=80=99 undeclared (first u=
se in this function)
usr/dash/histedit.c:111: warning: implicit declaration of function =E2=80=
=98el_init=E2=80=99
usr/dash/histedit.c:114: warning: implicit declaration of function =E2=80=
=98el_set=E2=80=99
usr/dash/histedit.c:114: error: =E2=80=98EL_HIST=E2=80=99 undeclared (f=
irst use in this function)
usr/dash/histedit.c:114: error: =E2=80=98history=E2=80=99 undeclared (f=
irst use in this function)
usr/dash/histedit.c:115: error: =E2=80=98EL_PROMPT=E2=80=99 undeclared =
(first use in this function)
usr/dash/histedit.c:123: warning: implicit declaration of function =E2=80=
=98el_end=E2=80=99
usr/dash/histedit.c:129: error: =E2=80=98EL_EDITOR=E2=80=99 undeclared =
(first use in this function)
usr/dash/histedit.c:132: warning: implicit declaration of function =E2=80=
=98el_source=E2=80=99
usr/dash/histedit.c:141: warning: implicit declaration of function =E2=80=
=98history_end=E2=80=99
usr/dash/histedit.c: In function =E2=80=98sethistsize=E2=80=99:
usr/dash/histedit.c:153: error: =E2=80=98HistEvent=E2=80=99 undeclared =
(first use in this function)
usr/dash/histedit.c:153: error: expected =E2=80=98;=E2=80=99 before =E2=
=80=98he=E2=80=99
usr/dash/histedit.c:155: error: =E2=80=98hist=E2=80=99 undeclared (firs=
t use in this function)
usr/dash/histedit.c:159: warning: implicit declaration of function =E2=80=
=98history=E2=80=99
usr/dash/histedit.c:159: error: =E2=80=98he=E2=80=99 undeclared (first =
use in this function)
usr/dash/histedit.c:159: error: =E2=80=98H_SETSIZE=E2=80=99 undeclared =
(first use in this function)
usr/dash/histedit.c: In function =E2=80=98setterm=E2=80=99:
usr/dash/histedit.c:166: error: =E2=80=98el=E2=80=99 undeclared (first =
use in this function)
usr/dash/histedit.c:167: error: =E2=80=98EL_TERMINAL=E2=80=99 undeclare=
d (first use in this function)
usr/dash/histedit.c: In function =E2=80=98histcmd=E2=80=99:
usr/dash/histedit.c:182: error: =E2=80=98HistEvent=E2=80=99 undeclared =
(first use in this function)
usr/dash/histedit.c:182: error: expected =E2=80=98;=E2=80=99 before =E2=
=80=98he=E2=80=99
usr/dash/histedit.c:191: error: =E2=80=98MAXPATHLEN=E2=80=99 undeclared=
 (first use in this function)
usr/dash/histedit.c:209: error: =E2=80=98hist=E2=80=99 undeclared (firs=
t use in this function)
usr/dash/histedit.c:218: error: =E2=80=98optreset=E2=80=99 undeclared (=
first use in this function)
usr/dash/histedit.c:332: error: =E2=80=98H_PREV=E2=80=99 undeclared (fi=
rst use in this function)
usr/dash/histedit.c:332: error: =E2=80=98H_NEXT=E2=80=99 undeclared (fi=
rst use in this function)
usr/dash/histedit.c:341: warning: implicit declaration of function =E2=80=
=98mkstemp=E2=80=99
usr/dash/histedit.c:357: error: =E2=80=98he=E2=80=99 undeclared (first =
use in this function)
usr/dash/histedit.c:357: error: =E2=80=98H_FIRST=E2=80=99 undeclared (f=
irst use in this function)
usr/dash/histedit.c:358: error: =E2=80=98H_NEXT_EVENT=E2=80=99 undeclar=
ed (first use in this function)
usr/dash/histedit.c:380: error: =E2=80=98H_ENTER=E2=80=99 undeclared (f=
irst use in this function)
usr/dash/histedit.c:191: warning: unused variable =E2=80=98editfile=E2=80=
=99
usr/dash/histedit.c: In function =E2=80=98str_to_event=E2=80=99:
usr/dash/histedit.c:447: error: =E2=80=98HistEvent=E2=80=99 undeclared =
(first use in this function)
usr/dash/histedit.c:447: error: expected =E2=80=98;=E2=80=99 before =E2=
=80=98he=E2=80=99
usr/dash/histedit.c:452: error: =E2=80=98hist=E2=80=99 undeclared (firs=
t use in this function)
usr/dash/histedit.c:452: error: =E2=80=98he=E2=80=99 undeclared (first =
use in this function)
usr/dash/histedit.c:452: error: =E2=80=98H_FIRST=E2=80=99 undeclared (f=
irst use in this function)
usr/dash/histedit.c:464: error: =E2=80=98H_NEXT=E2=80=99 undeclared (fi=
rst use in this function)
usr/dash/histedit.c:467: error: =E2=80=98H_LAST=E2=80=99 undeclared (fi=
rst use in this function)
usr/dash/histedit.c:469: error: =E2=80=98H_NEXT_EVENT=E2=80=99 undeclar=
ed (first use in this function)
usr/dash/histedit.c:486: error: =E2=80=98H_PREV_STR=E2=80=99 undeclared=
 (first use in this function)
make[2]: *** [usr/dash/histedit.o] Error 1
make[1]: *** [all] Error 2
make: *** [klibc] Error 2

this happens on top of the 2 patches sent earlier and is easy to
reproduce:
git clone git://git.kernel.org/pub/scm/libs/klibc/klibc.git
make   KLIBCKERNELSRC=3D`pwd`/../linux-2.6 EXTRA_KLIBCCFLAGS=3D"-DDEBUG=
=3D1"
