From: Cristian Ionescu-Idbohrn <cristian.ionescu-idbohrn@axis.com>
Subject: Re: debian patches to exit with code 127 for nonexistent/directory
 scripts
Date: Tue, 8 Jun 2010 12:36:05 +0200 (CEST)
Message-ID: <1006081227070.5913@somehost>
References: <20100608101908.GA24113@gondor.apana.org.au>
Reply-To: dash@vger.kernel.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <dash-owner@vger.kernel.org>
Received: from miranda.se.axis.com ([193.13.178.8]:56815 "EHLO
	miranda.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565Ab0FHKgJ (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 8 Jun 2010 06:36:09 -0400
Received: from traianus.se.axis.com (traianus.se.axis.com [10.94.24.46])
	by miranda.se.axis.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id o58Aa6as003022
	for <dash@vger.kernel.org>; Tue, 8 Jun 2010 12:36:06 +0200
Received: from localhost (localhost [127.0.0.1])
	by traianus.se.axis.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o58Aa6FU001768
	for <dash@vger.kernel.org>; Tue, 8 Jun 2010 12:36:06 +0200
In-Reply-To: <20100608101908.GA24113@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On Tue, 8 Jun 2010, Herbert Xu wrote:

> Jilles Tjoelker <jilles@stack.nl> wrote:
> > Debian's dash package has some local changes which cause an exit
> > with code 127, as required by POSIX, if a script (passed with dash
> > <filename>) cannot be opened or cannot be read because it is a
> > directory.

My interpretation of the above is that debian's patched dash is POSIX
compliant WRT the named exit code.

> Please report this through Debian's bug tracking system.

Why?

> There is nothing that I can do about this.

Upstream dash is _not_ POSIX compliant WRT the named exit code, seems
to be the meaning of the sentence.  And you can certainly _do_
something about it.

On the other hand, I may have got it all wrong (because of some
language barrier), in which case please accept my apologies.


Cheers,

-- 
Cristian
