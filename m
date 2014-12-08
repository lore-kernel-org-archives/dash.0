From: Stephane CHAZELAS <stephane.chazelas@gmail.com>
Subject: Re: Bug#501566: [MAN] Clarify two redirection mechanisms
Date: Mon, 8 Dec 2014 20:37:38 +0000
Message-ID: <20141208203738.GC4010@chaz.gmail.com>
References: <20141208185005.GA11773@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:53848 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870AbaLHUhl (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 8 Dec 2014 15:37:41 -0500
Received: by mail-wg0-f41.google.com with SMTP id y19so7186054wgg.0
        for <dash@vger.kernel.org>; Mon, 08 Dec 2014 12:37:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141208185005.GA11773@free.fr>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: =?iso-8859-1?Q?St=E9phane?= Aulery <saulery@free.fr>, 501566@bugs.debian.org
Cc: dash@vger.kernel.org

2014-12-08 19:50:05 +0100, St=E9phane Aulery:
>>>> [n1]>&n2    Redirect standard output (or fd n1) to the same "open
>>>>             file description" as on fd n2.
>>>>=20
>>>> [n1]>&n2    Copy fd n2 as stdout (or fd n1)
>>>>=20
>>>> [n1]>&n2    Redirect standard output (or fd n1) to the same
>>>>             resource as currently open on fd n2.

> >> "Resource" is rather unwieldy, how about simply "file"?
> >
> > "file" could be misleading
> >
> > [...]
> >
> > IMO, "resource" is vague enough so as not to give the wrong idea
> > and I like that wording because it conveys the intended
> > mechanism clearly ("redirect to same thing as"). But I agree
> > it's not ideal.
>=20
> It is true that "resource" is dissonant as "file" is too restrictive.=
 The
> term "file descriptor" is used above. Why not use it again?
[...]

If you say redirect fd n1 to fd n2, you confuse people (and I've
seen a lot of people being confused in such a way) as they
start thinking the fds become somehow linked (for instance that
in 2>&1 > file, stderr goes to stdout and then both to "file"
which is not the case). When you start thinking of "&" as
"/address/ of" (yet another improper wording) or "resource
currently open on", that clears that confusion.

If you don't like the "resource" wording, you can always got for
the "copy" one above or the POSIX wording:
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.htm=
l#tag_18_07_05

I've seen "resource" used in the past, I've used it myself a few
times in usenet articles:

https://groups.google.com/d/msg/comp.unix.shell/48beJpLdjNE/jUak98HUekU=
J
https://groups.google.com/d/msg/comp.unix.questions/EQL477tzYKk/J9ysMfq=
c5YIJ
https://groups.google.com/d/msg/comp.unix.aix/WcWsocnEHS0/hgSDWt19SaYJ

(see the aforementioned confusion in some of the messages that
those were replying to).

--=20
Stephane
