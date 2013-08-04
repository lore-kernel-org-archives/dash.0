From: Seb <sbb@tuxfamily.org>
Subject: Re: --with-libedit as default
Date: Sun, 4 Aug 2013 11:43:50 +0200
Message-ID: <20130804114350.fc97c50b21f4a63ad5f089d3@tuxfamily.org>
References: <CAA4sStkyXjKCfZ8O47r6V-aLPXZ5TiTRJDmys92n5W_N6TFnPA@mail.gmail.com>
	<20130804010244.GL2893@elie.Belkin>
	<CAA4sSt=7K=GXZFnQ741ZBfcUtj3xZ45ir0TCfg9dtekga-DahQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:35043 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753751Ab3HDJs6 (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 4 Aug 2013 05:48:58 -0400
In-Reply-To: <CAA4sSt=7K=GXZFnQ741ZBfcUtj3xZ45ir0TCfg9dtekga-DahQ@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: =?UTF-8?B?TWF1csOtY2lv?= Antunes <mauricio.antunes@gmail.com>
Cc: dash@vger.kernel.org

Le Sun, 4 Aug 2013 02:11:25 -0300
Maur=C3=ADcio Antunes a =C3=A9crit:

> I would like to use dash as an interactive shell. My motivation isn't
> anything more serious than the fact that it has a small documentation=
,
> which I can read and understand easily. Maybe my own memory is the li=
mited
> resource with which I have to deal :)=20

The problem is that enabling the libedit support does not provide you
with auto-completion, AFAIK. This makes it very painful for a use
as a daily interactive shell, isn't it?

Plus, regarding the documentation, all the shells around claim to
comply with POSIX, so you can stick with the dash man page and use
another shell, it will work 90% of the time. You can also directly
refer to the standard:

  http://pubs.opengroup.org/onlinepubs/9699919799/utilities/toc.html

> My current shell uses tree  or
> four initialization files, and I can never remember which one is read
> when. Dash has only one (.profile). I like that.

In fact, dash uses two files: .profile, when you use it as a login
shell, and the file pointed in the ENV environment variable, used in
all invokations as interactive shell. So, it is the same scheme as
bash with .bash_profile and .bashrc.

++
Seb.

P-S. I would also like to use dash as my main shell (not just to
test script portability). I currently use mksh, which seemed to me a
good compromise: smaller and faster than bash, reasonnable
auto-completion support, path facilities (e.g. "ls -d /{e,b}*"), a
good support for UTF-8, and the ability to deal with many
bashisms/kornisms when you really need it:

  https://www.mirbsd.org/mksh.htm

You can also glance the ash in Busybox, which also provides
auto-completion, and is a fork of dash. Just build the ash applet to
get a ~80K shell:

  http://www.busybox.net/
