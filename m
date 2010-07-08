From: maximilian attems <max@stro.at>
Subject: dash klibc DEBUG compile trouble
Date: Thu, 8 Jul 2010 10:48:34 +0200
Message-ID: <20100708084834.GB6829@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:54300 "EHLO
	baikonur.stro.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751Ab0GHIsm (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 8 Jul 2010 04:48:42 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: klibc@zytor.com

on top of the two easy patches I sent I am seeing this one:
usr/dash/exec.c: In function =E2=80=98find_command=E2=80=99:
usr/dash/exec.c:290: error: storage size of =E2=80=98statb=E2=80=99 isn=
=E2=80=99t known
usr/dash/exec.c:299: warning: implicit declaration of function =E2=80=98=
stat64=E2=80=99
usr/dash/exec.c:290: warning: unused variable =E2=80=98statb=E2=80=99
make[2]: *** [usr/dash/exec.o] Error 1


hmm which include is exec.c missing?
netbsd ash seems to have evolved using stat and no longer stat64,
any hint what I should do here to make this compile:
~/src/klibc$ make   KLIBCKERNELSRC=3D`pwd`/../linux-2.6 EXTRA_KLIBCCFLA=
GS=3D"-DDEBUG=3D1"

it be cool to be able to compile klibc again with global debug on. :)
