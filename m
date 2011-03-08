From: Dan Muresan <danmbox@gmail.com>
Subject: Re: [PATCH] Allow == as synonym for = in test
Date: Tue, 8 Mar 2011 17:53:11 +0200
Message-ID: <AANLkTikCce-a05ZHbNd-0C4ajuseg+yPuchW9LSEpQH5@mail.gmail.com>
References: <E1PwMwp-0001iy-B5@fenris.runbox.com>
	<20110306234845.GC18385@elie>
	<E1PwOzt-0007C2-Qw@fenris.runbox.com>
	<20110307103457.GA5987@wopr.local.invalid>
	<E1Pwbqm-00056z-0V@garm.runbox.com>
	<20110307220048.GE15732@elie>
	<E1PwjSv-0004ZG-3B@fenris.runbox.com>
	<20110308000557.GC5987@wopr.local.invalid>
	<AANLkTinea9rwpq9M70SazaDCJ-usb5HuLeh=+62onYe9@mail.gmail.com>
	<1299598034.27968.45.camel@homebase>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40384 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695Ab1CHPxN convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Tue, 8 Mar 2011 10:53:13 -0500
Received: by bwz15 with SMTP id 15so4664442bwz.19
        for <dash@vger.kernel.org>; Tue, 08 Mar 2011 07:53:11 -0800 (PST)
In-Reply-To: <1299598034.27968.45.camel@homebase>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: paul@mad-scientist.net
Cc: "David A. Wheeler" <dwheeler@dwheeler.com>, dash@vger.kernel.org, Guido Berhoerster <guido+kernel.org@berhoerster.name>

> No one ever said you couldn't write shell scripts in bash rather than=
 in
> sh, even on Ubuntu. =A0You just have to use #!/bin/bash at the top, n=
ot
> #!/bin/sh. =A0Truth in scripting!

Please, not *that* red herring again... You know very well that the
existing packages that broke were the problem, not the scripts yet to
be written.

Maybe I've made too many points, so let me summarize:

1) changing from sh=3Dbash to sh=3Ddash in Ubuntu was done without due
publicity for such a monumental upheaval. This should not have been
buried in some bash / dash NEWS.gz, nor in some release notes. This
should have been included in ALL CAPS in all public announcements, on
all forums and above all download links (I'm exaggerating but you get
the point)

2) Before the update, there should have been a campaign promoting the
checkbashisms tool

3) I personally don't think dash was quite mature enough to be the
default shell when the change was made. Maybe it's getting there
today.

4) Now that everyone has paid the large price of a poorly prepared
switch-over, I don't want dash to become more tolerant of non-POSIX
idioms. The one benefit we have from dash is that it forces POSIX
compliance.

> blades that have 8+ cores and 24+G RAM, and 10gig ethernet interfaces=
=2E

Maybe you're not in the best position to argue in this case :) I have
worked before with a few megs of RAM (and even with sub-1M DSP OSs,
but that's different).

> I personally am very grateful to Ubuntu for taking the high road here
> and forcing some sanity and consideration back into the scripting

I believe you. However, many thousands of users were *not* grateful,
and I don't see why the preferences of a minority of developers in
various niches should over-rule the necessities of a majority of
desktop users.

(Actually, we all know why stuff like this happens: Debian is not
market-driven, so users' necessities, or their poor substitute --
money -- do not directly impact its direction)

-- Dan
