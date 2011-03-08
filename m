From: Dan Muresan <danmbox@gmail.com>
Subject: Re: [PATCH] Allow == as synonym for = in test
Date: Tue, 8 Mar 2011 20:43:02 +0200
Message-ID: <AANLkTikux5cbWvu969u4vT527bKzAyf6VOEOFbnnjL4+@mail.gmail.com>
References: <E1PwMwp-0001iy-B5@fenris.runbox.com>
	<20110306234845.GC18385@elie>
	<E1PwOzt-0007C2-Qw@fenris.runbox.com>
	<20110307103457.GA5987@wopr.local.invalid>
	<E1Pwbqm-00056z-0V@garm.runbox.com>
	<20110307220048.GE15732@elie>
	<E1PwjSv-0004ZG-3B@fenris.runbox.com>
	<20110308000557.GC5987@wopr.local.invalid>
	<AANLkTinea9rwpq9M70SazaDCJ-usb5HuLeh=+62onYe9@mail.gmail.com>
	<20110308181301.GD3948@wopr.local.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63852 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858Ab1CHSnE (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 8 Mar 2011 13:43:04 -0500
Received: by bwz15 with SMTP id 15so82163bwz.19
        for <dash@vger.kernel.org>; Tue, 08 Mar 2011 10:43:03 -0800 (PST)
In-Reply-To: <20110308181301.GD3948@wopr.local.invalid>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Dan Muresan <danmbox@gmail.com>, "David A. Wheeler" <dwheeler@dwheeler.com>, dash@vger.kernel.org
Cc: Guido Berhoerster <gber@opensuse.org>

> Well you know, not the whole world revolves around Linux.

Indeed -- the market "revolves" around Windows. The world of the free
desktops *does* revolve around Linux. And yes, there are others, which
I have used in the past myself (all the BSDs). Any responsible action
should take into account the demographics of the user base, not the
fondness for certain niches.

> And while there are pecularities, writing shell scripts
> using IEEE Std 1003.1-2001 as a baseline is a good starting point
> for achieving portability since most modern Unix or Unix-like OS

Personally I have always strived to do so...

> /bin/sh == bash might be common among Linux distros, however in
> the real world it is neither a de-facto standard nor guaranteed

I know this. As much as you might enjoy it, you're preaching to the
choir :) I was **only** arguing that the Debian / Ubuntu transition to
dash was premature (for both Debian and dash) and improperly handled.

> In the real world software tends to have bugs, other shells have
> bugs, too. Given its resources dash is relatively well-
> maintained, bugs reported on this list are getting addressed.

Eh, not my 2 bugs. One was unanswered by Ubuntu, the other by this
very mailing list. I've since encountered several other good bug
candidates, but chose to rewrite my scripts and work around errors
without digging deeper. What can one do? Even if dash fixes something
today, it'll be several years before one can be sure that the old
version is flushed out of 90% of the desktops...

Now, when you are the default Debian shell, I think the "given its
resources" argument should never, ever be opened. Otherwise one would
be tempted to ask whether dash is suitable for its role...


-- Dan
