From: Guido Berhoerster <guido+kernel.org@berhoerster.name>
Subject: Re: [PATCH] Allow == as synonym for = in test
Date: Tue, 8 Mar 2011 01:05:57 +0100
Message-ID: <20110308000557.GC5987@wopr.local.invalid>
References: <E1PwMwp-0001iy-B5@fenris.runbox.com>
 <20110306234845.GC18385@elie>
 <E1PwOzt-0007C2-Qw@fenris.runbox.com>
 <20110307103457.GA5987@wopr.local.invalid>
 <E1Pwbqm-00056z-0V@garm.runbox.com>
 <20110307220048.GE15732@elie>
 <E1PwjSv-0004ZG-3B@fenris.runbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from multivac.heapoverflow.de ([83.169.16.167]:41009 "EHLO
	multivac.heapoverflow.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989Ab1CGX74 (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 7 Mar 2011 18:59:56 -0500
Content-Disposition: inline
In-Reply-To: <E1PwjSv-0004ZG-3B@fenris.runbox.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "David A. Wheeler" <dwheeler@dwheeler.com>
Cc: dash@vger.kernel.org

* David A. Wheeler <dwheeler@dwheeler.com> [2011-03-08 00:03]:
> Dan Muresan:
> > ...the crusade against "bashisms" has broken so many scripts and wasted so
> > many man-hours for Debian / Ubuntu users.

The hard work of many Debian maintainers fixing broken shell
scripts and pushing these changes upstream is certainly not
wasted time but a great service to other platforms as well by
improving portability. If you want bash or ksh scripts to work
why do you use dash?

> Right.  Many existing scripts depend on "==", not "=", and its implementation is trivial.

That is a very weak argument as it applies to many such features,
the question is whether to create precendent here and where that'll
go.

-- 
Guido Berhoerster
