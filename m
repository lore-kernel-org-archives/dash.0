From: Stephane CHAZELAS <stephane.chazelas@gmail.com>
Subject: Re: Bug#501566: [MAN] Clarify two redirection mechanisms
Date: Tue, 9 Dec 2014 16:54:31 +0000
Message-ID: <20141209165431.GB5708@chaz.gmail.com>
References: <20141208185005.GA11773@free.fr>
 <20141208203738.GC4010@chaz.gmail.com>
 <20141208212203.GA13333@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36430 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757439AbaLIQyf (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 9 Dec 2014 11:54:35 -0500
Received: by mail-wi0-f176.google.com with SMTP id ex7so8545547wid.9
        for <dash@vger.kernel.org>; Tue, 09 Dec 2014 08:54:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141208212203.GA13333@free.fr>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: =?iso-8859-1?Q?St=E9phane?= Aulery <saulery@free.fr>
Cc: 501566@bugs.debian.org, dash@vger.kernel.org

2014-12-08 22:22:03 +0100, St=E9phane Aulery:
> Le lundi 08 d=E9cembre 2014 =E0 08:37:38, Stephane CHAZELAS a =E9crit=
 :
> > 2014-12-08 19:50:05 +0100, St=E9phane Aulery:
> > >>>> [n1]>&n2    Redirect standard output (or fd n1) to the same "o=
pen
> > >>>>             file description" as on fd n2.
> > >>>>=20
> > >>>> [n1]>&n2    Copy fd n2 as stdout (or fd n1)
[...]
> I wonder more and more if Herbert is willing to accept this tiny patc=
h
> or another. I would not be wasting his time if he does not want or ca=
n
> not take care of that. This is free software, there is no obligation.
[...]

What matters here is the mistake fixed in the manual. n>&p has
been around since the end of the 70s. It's unlikely anyone will
learn anything about it from the dash man page.=20

Let's make it:

  [n1]>&n2    Copy file descriptor n2 as stdout (or fd n1)
  [n1]<&n2    Copy file descriptor n2 as stdin (or fd n1)

That's more or less the POSIX wording. It may not be as
descriptive as other ones, but I can't imagine anyone
complaining about the correctness or accuracy of it.

--=20
Stephane
