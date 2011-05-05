From: Oleg Verych <olecom@gmail.com>
Subject: Re: positional argument bug
Date: Thu, 5 May 2011 18:47:07 +0300
Message-ID: <BANLkTikk977F6f_ZTjGFroVXyont_gCWOw@mail.gmail.com>
References: <BANLkTi=cmXee5Ej2fmhX2dp4FG6U3_1JqQ@mail.gmail.com>
	<20110504024128.GB8187@elie>
	<BANLkTimmAWkEne0SYFDpc4Kq-4ChBJ_dWg@mail.gmail.com>
	<BANLkTimUJX-asm1rBoKHKMH6HU8asWdLPA@mail.gmail.com>
	<20110504050223.GG8187@elie>
	<m3oc3ic2sc.fsf@linux-m68k.org>
	<BANLkTi=n37vhi63Rh1YRh8uqxZ6cyR65wQ@mail.gmail.com>
	<4DC2A4E8.7020904@case.edu>
	<4DC2AFF7.7070007@redhat.com>
	<4DC2B0FD.1000802@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33329 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714Ab1EEPrJ convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Thu, 5 May 2011 11:47:09 -0400
Received: by wya21 with SMTP id 21so1718774wya.19
        for <dash@vger.kernel.org>; Thu, 05 May 2011 08:47:08 -0700 (PDT)
In-Reply-To: <4DC2B0FD.1000802@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: dash@vger.kernel.org

2011/5/5 Eric Blake <eblake@redhat.com>:
> [originally brought up on the bash list as a NetBSD bug, but dash is
> also affected]

So what? I was happy (years back) to have ability to create adressable
arrays using $####... or ${####} if it matters.

> Therefore, in "$10", 10 is not a name, so the longest name is the emp=
ty
> string, and the single-character symbol is used instead, such that th=
is
> MUST be parsed as ${1}0, not as ${10}.

IMHO this would be step back.
--=20
sed 'sed && sh + olecom =3D love'=C2=A0 <<=C2=A0 ''
-o--=3DO`C
=C2=A0#oo'L O
<___=3DE M
