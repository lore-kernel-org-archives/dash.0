From: Guido Berhoerster <guido+kernel.org@berhoerster.name>
Subject: Re: [PATCH] Allow == as synonym for = in test
Date: Mon, 7 Mar 2011 11:34:57 +0100
Message-ID: <20110307103457.GA5987@wopr.local.invalid>
References: <E1PwMwp-0001iy-B5@fenris.runbox.com>
 <20110306234845.GC18385@elie>
 <E1PwOzt-0007C2-Qw@fenris.runbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from multivac.heapoverflow.de ([83.169.16.167]:58646 "EHLO
	multivac.heapoverflow.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755007Ab1CGKgH (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 7 Mar 2011 05:36:07 -0500
Content-Disposition: inline
In-Reply-To: <E1PwOzt-0007C2-Qw@fenris.runbox.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "David A. Wheeler" <dwheeler@dwheeler.com>
Cc: dash@vger.kernel.org, jrnieder@gmail.com

* David A. Wheeler <dwheeler@dwheeler.com> [2011-03-07 02:12]:
> Jonathan Nieder:
> > Has the Austin Group made a decision
> > on whether this syntax is going to be supported?
> 
> I don't think a decision has been formally made.  Most of the email discussion has been about possibly adding "<" and ">" to the spec, which are not in the current POSIX spec but are already implemented in dash.  The last comment posted on mantis about this extension to POSIX was positive; eblake (manager) said, "adding the other four operators (==, -ot, -nt, -ef) make[s] sense" [http://austingroupbugs.net/view.php?id=375].
> 
> > dash tends to support features that ash and older
> > versions of dash supported (to avoid breaking backward compatibility)
> 
> Busybox's ash *already* supports "==", so I think that's *also* an argument for adding "==".  After all, adding "==" would improve compatibility between busybox ash and dash, and its effect on space and speed is miniscule.  I understand that dash wants to be "lean and mean", but busybox does too, and even busybox supports "==". 
> 
> I think it's reasonably likely that "==" will be added to the POSIX spec, but that's not up to me.  Even if this syntax isn't added to the official standard, I still think it'd make sense to support "==".  It's already implemented in a number of shells, including bash, busybox ash, and ksh.  More importantly, a lot of extant shell scripts use it; many scripts won't work on dash because dash doesn't include "==".

By that argument pretty much every (mis)feature of bash can be
included into dash because people keep writing scripts assuming
/bin/sh == bash which of course will not work on dash.
I consider dash's orientation towards POSIX/SUS compliance and
lack of support for many extensions a feature, it makes it easy
to extend with later POSIX features without breaking backwards
compatibility and allows one to easily spot bashisms in /bin/sh
scripts. Hence I don't think it is a good idea to add this to
dash before it is being standardized.
BTW, dash's test builtin already supports the -ot, -nt, and -ef
operators, unfortunately -ot and -nt behavior differs from all
other implementations [1].

[1] http://www.mail-archive.com/dash@vger.kernel.org/msg00206.html
-- 
Guido Berhoerster
