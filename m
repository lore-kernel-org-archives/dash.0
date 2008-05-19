From: Oleg Verych <olecom@flower.upol.cz>
Subject: shell and glibc (Re: Inconsistent parameter expansion)
Date: Mon, 19 May 2008 05:30:47 +0200
Message-ID: <20080519033047.GI21428@flower.upol.cz>
References: <20080518181151.GF21428@flower.upol.cz> <E1JxvOe-0007kT-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from barikada.upol.cz ([158.194.242.200]:36334 "EHLO
	barikada.upol.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107AbYESDJV (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 18 May 2008 23:09:21 -0400
Received: from flower (flower.upol.cz [158.194.64.22])
	by barikada.upol.cz (Spam Firewall) with ESMTP id EB29C145DE4
	for <dash@vger.kernel.org>; Mon, 19 May 2008 05:08:59 +0200 (CEST)
Received: from flower (flower.upol.cz [158.194.64.22]) by barikada.upol.cz with ESMTP id p5TBdayqVrK49Jie for <dash@vger.kernel.org>; Mon, 19 May 2008 05:08:59 +0200 (CEST)
Received: from olecom by flower with local (Exim 4.63)
	(envelope-from <olecom@flower.upol.cz>)
	id 1Jxw5H-0000SH-T7
	for dash@vger.kernel.org; Mon, 19 May 2008 05:30:47 +0200
Content-Disposition: inline
In-Reply-To: <E1JxvOe-0007kT-00@gondolin.me.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash list <dash@vger.kernel.org>

> The fnmatch(3) function is now correct as far as I know but
> glob(3) still seems to be broken.

It seems, small glibc team cannot do much in areas without interest.

Very surprising for me was recent discovery of big performance penalty of
the most simple '^$' regexp; it turned to be glibc RE library problem:

http://bugs.debian.org/475474
(bonus: 4 ways of doing one thing with `sed`, not with `perl`:)

Thus, i think shell -- basic userspace tool, must be reliable with its
implementation. There are many other ways of size reduction (more on
that latter).
____
