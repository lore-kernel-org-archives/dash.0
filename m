From: Paul Smith <paul@mad-scientist.net>
Subject: Re: [PATCH] Allow == as synonym for = in test
Date: Tue, 08 Mar 2011 10:27:14 -0500
Message-ID: <1299598034.27968.45.camel@homebase>
References: <E1PwMwp-0001iy-B5@fenris.runbox.com>
	 <20110306234845.GC18385@elie> <E1PwOzt-0007C2-Qw@fenris.runbox.com>
	 <20110307103457.GA5987@wopr.local.invalid>
	 <E1Pwbqm-00056z-0V@garm.runbox.com> <20110307220048.GE15732@elie>
	 <E1PwjSv-0004ZG-3B@fenris.runbox.com>
	 <20110308000557.GC5987@wopr.local.invalid>
	 <AANLkTinea9rwpq9M70SazaDCJ-usb5HuLeh=+62onYe9@mail.gmail.com>
Reply-To: paul@mad-scientist.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from oproxy3-pub.bluehost.com ([69.89.21.8]:50488 "HELO
	oproxy3-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755740Ab1CHP1T (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 8 Mar 2011 10:27:19 -0500
In-Reply-To: <AANLkTinea9rwpq9M70SazaDCJ-usb5HuLeh=+62onYe9@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Dan Muresan <danmbox@gmail.com>
Cc: "David A. Wheeler" <dwheeler@dwheeler.com>, dash@vger.kernel.org, Guido Berhoerster <guido+kernel.org@berhoerster.name>

On Tue, 2011-03-08 at 09:17 +0200, Dan Muresan wrote:
> Wherever Linux goes, bash goes too... except for embedded busyboxy
> systems, where everything is customized by hand anyway.

No one ever said you couldn't write shell scripts in bash rather than in
sh, even on Ubuntu.  You just have to use #!/bin/bash at the top, not
#!/bin/sh.  Truth in scripting!


On the other hand, I think you're underestimating the types of software
that would go on an embedded busybox system: I run PXE-booted systems on
blades that have 8+ cores and 24+G RAM, and 10gig ethernet interfaces.
And they use busybox (because who wants to waste ramdisk space on a full
GNU toolset?  I NEED that memory for other things).  And they use a
bunch of other tools that I would dearly love to not have to "customize
by hand".

It's one of the banes of my (professional) life, all the scripts out
there for tools I want to install on my blades, written by people who
think if it runs on Red Hat it's done and that sh == bash (... and who
think they can write their own makefiles/configure environments that are
as good as or better than the GNU autotools--but that's a topic for
another day).


I personally am very grateful to Ubuntu for taking the high road here
and forcing some sanity and consideration back into the scripting
culture.  Little by little things ARE getting better.

