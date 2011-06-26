From: Mike Korbakov <mike-kmv@yandex.ru>
Subject: Porting dash to OpenBSD
Date: Sun, 26 Jun 2011 06:18:59 +0400
Message-ID: <223511309054739@web103.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from forward7.mail.yandex.net ([77.88.61.37]:45699 "EHLO
	forward7.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395Ab1FZC0G (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 25 Jun 2011 22:26:06 -0400
Received: from web103.yandex.ru (web103.yandex.ru [77.88.61.4])
	by forward7.mail.yandex.net (Yandex) with ESMTP id CAF691C1D94
	for <dash@vger.kernel.org>; Sun, 26 Jun 2011 06:18:59 +0400 (MSD)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by web103.yandex.ru (Yandex) with ESMTP id C07FC1D58038
	for <dash@vger.kernel.org>; Sun, 26 Jun 2011 06:18:59 +0400 (MSD)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hello!

Unfortunatly,=9Anot=9Aall=9Asystems=9A(like=9AOpenBSD)=9Ahas=9Abuilt-in=
=9Atexttools=9Alike=9Anl,
that=9Amakes=9Ait=9Adifficult=9Ato=9Aport=9Adash,=9Awith=9Aminimum=9Atr=
oubles.

To reduce dependencies, I=9Asuggest=9Ausing=9Ainstead=9Aof=9Anl other=9A=
tools like awk=9Aor=9Acat
(as=9Aadvised=9Aopenbsd=9Aporters=9Ateam).

Building=9Adash-0.5.6.1=9Awas=9Asuccessfull=9Awith=9Athis=9Apatch:

---=9Asrc/mkbuiltins.orig=9ASat=9AJun=9A=9A5=9A13:34:23=9A2010
+++=9Asrc/mkbuiltins=9A=9A=9A=9A=9A=9ASun=9AJun=9A26=9A02:36:23=9A2011
@@=9A-84,7=9A+84,7=9A@@=9Acat=9A<<\!
=9A=9A*/

=9A!
-sed=9A's/=9A=9A=9A=9A=9A=9A=9A=9A-[a-z]*//'=9A$temp2=9A|=9Anl=9A-v=9A0=
=9A|=9ALC_COLLATE=3DC=9Asort=9A-u=9A-k=9A3,3=9A|
+sed=9A's/=9A=9A=9A=9A=9A=9A=9A=9A-[a-z]*//'=9A$temp2=9A|=9Aawk=9A'{=9A=
print=9A"=9A=9A"=9AFNR-1=9A"=9A=9A"=9A$0=9A}'=9A=9A|=9ALC_COLLATE=3DC=9A=
sort=9A-u=9A-k=9A3,3=9A|
=9Atr=9Aabcdefghijklmnopqrstuvwxyz=9AABCDEFGHIJKLMNOPQRSTUVWXYZ=9A|
=9A=9A=9A=9A=9A=9A=9A=9Aawk=9A'{=9A=9Aprintf=9A"#define=9A%s=9A(builtin=
cmd=9A+=9A%d)\n",=9A$3,=9A$1}'
=9Aprintf=9A'\n#define=9ANUMBUILTINS=9A%d\n'=9A$(wc=9A-l=9A<=9A$temp2)


Would you make these changes in future releases?

Best regards,
Mike Korbakov.
