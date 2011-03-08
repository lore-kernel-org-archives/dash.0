From: Dan Muresan <danmbox@gmail.com>
Subject: Re: [PATCH] Allow == as synonym for = in test
Date: Tue, 8 Mar 2011 09:17:14 +0200
Message-ID: <AANLkTinea9rwpq9M70SazaDCJ-usb5HuLeh=+62onYe9@mail.gmail.com>
References: <E1PwMwp-0001iy-B5@fenris.runbox.com>
	<20110306234845.GC18385@elie>
	<E1PwOzt-0007C2-Qw@fenris.runbox.com>
	<20110307103457.GA5987@wopr.local.invalid>
	<E1Pwbqm-00056z-0V@garm.runbox.com>
	<20110307220048.GE15732@elie>
	<E1PwjSv-0004ZG-3B@fenris.runbox.com>
	<20110308000557.GC5987@wopr.local.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49857 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314Ab1CHHRQ (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 8 Mar 2011 02:17:16 -0500
Received: by bwz15 with SMTP id 15so4355531bwz.19
        for <dash@vger.kernel.org>; Mon, 07 Mar 2011 23:17:15 -0800 (PST)
In-Reply-To: <20110308000557.GC5987@wopr.local.invalid>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "David A. Wheeler" <dwheeler@dwheeler.com>, dash@vger.kernel.org
Cc: Guido Berhoerster <guido+kernel.org@berhoerster.name>

> The hard work of many Debian maintainers fixing broken shell
> scripts and pushing these changes upstream is certainly not

The hardest (and entirely avoidable) work fell on the shoulders of the
"community" who had scripts break mysteriously without so much as a
warning from Debian/Ubuntu. People would all of a sudden receive
errors from well established packages (such as vmware) with absolutely
no clue as to what was wrong.

> wasted time but a great service to other platforms as well by

Wherever Linux goes, bash goes too... except for embedded busyboxy
systems, where everything is customized by hand anyway.

> improving portability. If you want bash or ksh scripts to work
> why do you use dash?

No sane user cares about bash / ksh / *sh in *scripts* -- but once
sh=bash became a de-facto standard, making a change swiftly and "under
the radar" was irresponsible. We are not living in an ideal world, and
I do not wish to debate worthy causes for that inexistent ideal world.

> That is a very weak argument as it applies to many such features,
> the question is whether to create precendent here and where that'll

I actually tend to agree with this (though I still think it's a
bikeshed issue). Now that we've paid the price to port scripts to
dash, why lose the one benefit we ever had?

Still, I wish dash would spend more effort making sure that everything
in SUSv3 works *at least as well* as it does in Bash, and less effort
in debating == vs =. I have had to abandon certain POSIX idioms that
work well in Bash because dash does not (or did not) support them.

Note that even when an upgraded dash fixes a bug, the impact on
distributions lingers on for years: it takes a while for new distros
to incorporate the new dash, and scripts can't know if they are
running on "new" or "old" distros. So dash, the now-default /bin/sh,
should be even more proactive about bugs than a normal package.

-- Dan
