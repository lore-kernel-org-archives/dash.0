From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: [PATCH] Allow == as synonym for = in test
Date: Sun, 06 Mar 2011 20:12:29 -0500 (EST)
Message-ID: <E1PwOzt-0007C2-Qw@fenris.runbox.com>
References: <E1PwMwp-0001iy-B5@fenris.runbox.com>
 <20110306234845.GC18385@elie>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <dash-owner@vger.kernel.org>
Received: from aibo.runbox.com ([87.238.52.70]:35589 "EHLO aibo.runbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753266Ab1CGBMb convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Sun, 6 Mar 2011 20:12:31 -0500
Content-Disposition: inline
In-Reply-To: <20110306234845.GC18385@elie>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org, jrnieder@gmail.com

Jonathan Nieder:
> Has the Austin Group made a decision
> on whether this syntax is going to be supported?

I don't think a decision has been formally made.  Most of the email discussion has been about possibly adding "<" and ">" to the spec, which are not in the current POSIX spec but are already implemented in dash.  The last comment posted on mantis about this extension to POSIX was positive; eblake (manager) said, "adding the other four operators (==, -ot, -nt, -ef) make[s] sense" [http://austingroupbugs.net/view.php?id=375].

> dash tends to support features that ash and older
> versions of dash supported (to avoid breaking backward compatibility)

Busybox's ash *already* supports "==", so I think that's *also* an argument for adding "==".  After all, adding "==" would improve compatibility between busybox ash and dash, and its effect on space and speed is miniscule.  I understand that dash wants to be "lean and mean", but busybox does too, and even busybox supports "==". 

I think it's reasonably likely that "==" will be added to the POSIX spec, but that's not up to me.  Even if this syntax isn't added to the official standard, I still think it'd make sense to support "==".  It's already implemented in a number of shells, including bash, busybox ash, and ksh.  More importantly, a lot of extant shell scripts use it; many scripts won't work on dash because dash doesn't include "==".

--- David A. Wheeler
