From: "Oleg Verych" <olecom@gmail.com>
Subject: Redirections (Re: Features.)
Date: Mon, 12 Nov 2007 02:34:55 +0100
Message-ID: <8499950a0711111734j5e1862d9k4874a058a59d330f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:31197 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbXKLBe5 (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 11 Nov 2007 20:34:57 -0500
Received: by nf-out-0910.google.com with SMTP id g13so973541nfb
        for <dash@vger.kernel.org>; Sun, 11 Nov 2007 17:34:56 -0800 (PST)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dAsh <dash@vger.kernel.org>

== 11/12/07, H. Peter Anvin ==
> Oleg Verych wrote:
> >
> >    5.2 IMHO making user accessible file descriptors in range of [3-9] is
> >        kind of silly, when open() returns lowest available fd number,
> >        and shell have no semantics of saying "no, this fd is used
> already".
> >
> >        Making them in higher and wider region, say in [100-255] is
> >        quite reasonable. Making them as special variables, like
> >        parameters `$1' are, makes even more sense, thus preventing any
> >        potential problems.
> >
>
> Everyone is using 3-9 though.  I would suggest just moving the lower
> limit higher, e.g. 3-99.

From the user point of view, keeping track of fds by numbers is very hard.

While procfs example may not be correct one, but anyway it shows a bug
and some fd manipulation inside of "user range".

#
echo  7>&2
echo  '=echo=
' /proc/$$/fd/* '
=ls='
ls -l /proc/$$/fd/*
#

# -- dash --

=echo=
 /proc/7433/fd/0 /proc/7433/fd/1 /proc/7433/fd/10 /proc/7433/fd/2 \
 /proc/7433/fd/3 /proc/7433/fd/7
=ls=
ls: /proc/7433/fd/3: No such file or directory
lrwx------ 1 root root 64 Nov 12 02:35 /proc/7433/fd/0 -> /dev/tty4
l-wx------ 1 root root 64 Nov 12 02:35 /proc/7433/fd/1 -> /tmp/12
lr-x------ 1 root root 64 Nov 12 02:35 /proc/7433/fd/10 -> /tmp/11-.s
l-wx------ 1 root root 64 Nov 12 02:35 /proc/7433/fd/2 -> /tmp/12
l-wx------ 1 root root 64 Nov 12 02:35 /proc/7433/fd/7 -> /tmp/12

# -- bash --

=echo=
 /proc/7435/fd/0 /proc/7435/fd/1 /proc/7435/fd/2 /proc/7435/fd/255 \
 /proc/7435/fd/3
=ls=
ls: /proc/7435/fd/3: No such file or directory
lrwx------ 1 root root 64 Nov 12 02:35 /proc/7435/fd/0 -> /dev/tty4
l-wx------ 1 root root 64 Nov 12 02:35 /proc/7435/fd/1 -> /tmp/12
l-wx------ 1 root root 64 Nov 12 02:35 /proc/7435/fd/2 -> /tmp/12
lr-x------ 1 root root 64 Nov 12 02:35 /proc/7435/fd/255 -> /tmp/11-.s
____
