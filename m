From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: [PATCH] Allow == as synonym for = in test
Date: Mon, 07 Mar 2011 18:03:49 -0500 (EST)
Message-ID: <E1PwjSv-0004ZG-3B@fenris.runbox.com>
References: <E1PwMwp-0001iy-B5@fenris.runbox.com>
 <20110306234845.GC18385@elie> <E1PwOzt-0007C2-Qw@fenris.runbox.com>
 <20110307103457.GA5987@wopr.local.invalid>
 <E1Pwbqm-00056z-0V@garm.runbox.com> <20110307220048.GE15732@elie>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <dash-owner@vger.kernel.org>
Received: from aibo.runbox.com ([87.238.52.70]:47724 "EHLO aibo.runbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756345Ab1CGXDu convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Mon, 7 Mar 2011 18:03:50 -0500
Received: from [10.9.9.130] (helo=fenris.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.50)
	id 1PwjSv-0003Vq-4A
	for dash@vger.kernel.org; Tue, 08 Mar 2011 00:03:49 +0100
Received: from mail by fenris.runbox.com with local  (Exim 4.50)
	id 1PwjSv-0004ZG-3B
	for dash@vger.kernel.org; Tue, 08 Mar 2011 00:03:49 +0100
Content-Disposition: inline
Received: from [129.246.225.90] by secure.runbox.com with http
 (uid:258406) (RMM 4.0); for <dash@vger.kernel.org>; Mon, 07 Mar 2011
 23:03:49 GMT
In-Reply-To: <20110307220048.GE15732@elie>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Jonathan Nieder:
> Presumably soon we will know whether
> == is to be part of the "test" builtin in POSIX or is going to be
> allowed in "[[" only.

I presume you mean "required", not "allowed".  POSIX already allows "=="  (several POSIX shells currently implement it), it's just not *required* in test/[.

Which means there's no need to wait; "==" can be added as an aid to users, whether or not it's in POSIX (yet).

It's not clear to me that "[[" will be added.  That was proposed early on as an idea, but to my knowledge one was proposed any specific text to actually *do* that, and it was rejected last time.  On the other hand, "==" has already been proposed, and most of the discussion seemed to think it reasonable.

Dan Muresan:
> ...the crusade against "bashisms" has broken so many scripts and wasted so
> many man-hours for Debian / Ubuntu users.

Right.  Many existing scripts depend on "==", not "=", and its implementation is trivial.

--- David A. Wheeler
