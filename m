From: "Oleg Verych" <olecom@gmail.com>
Subject: Re: Redirections (Re: Features.)
Date: Mon, 12 Nov 2007 05:12:43 +0100
Message-ID: <8499950a0711112012l62a4917cu49d9074e58d2fc67@mail.gmail.com>
References: <8499950a0711111734j5e1862d9k4874a058a59d330f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:5190 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbXKLEMp (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 11 Nov 2007 23:12:45 -0500
Received: by nf-out-0910.google.com with SMTP id g13so991417nfb
        for <dash@vger.kernel.org>; Sun, 11 Nov 2007 20:12:44 -0800 (PST)
In-Reply-To: <8499950a0711111734j5e1862d9k4874a058a59d330f@mail.gmail.com>
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dAsh <dash@vger.kernel.org>

> > >    5.2 IMHO making user accessible file descriptors in range of [3-9] is
> > >        kind of silly, when open() returns lowest available fd number,
> > >        and shell have no semantics of saying "no, this fd is used
> > already".
> > >
> > >        Making them in higher and wider region, say in [100-255] is
> > >        quite reasonable. Making them as special variables, like
> > >        parameters `$1' are, makes even more sense, thus preventing any
> > >        potential problems.
> > >
> >
> > Everyone is using 3-9 though.  I would suggest just moving the lower
> > limit higher, e.g. 3-99.

I don't know how heavily system() is used. Based on my shell scripting
experience in Debian, i'd say not that much. And i doubt program(er)s
care about having their opened fds above suggested by POSIX number 9
before system().

Of course shell will be blamed, if something non trivial, e.g. opening
and manipulating of FDs other than STDIO[0-2], is being ran.

Realizing this now, i understand why apt-get/C++ and dpkg/C were so
unhappy in some places with my scripting (mainly `geloiwa').
____
