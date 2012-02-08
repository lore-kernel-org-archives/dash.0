From: Chet Ramey <chet.ramey@case.edu>
Subject: Re: bug in handling of ignored traps
Date: Wed, 8 Feb 2012 15:12:01 -0500
Message-ID: <120208201201.AA20769.SM@caleb.ins.cwru.edu>
References: <4F32B081.6090007@redhat.com>
Reply-To: chet.ramey@case.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mpv2.tis.cwru.edu ([129.22.105.37]:57481 "EHLO
	mpv2.tis.cwru.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764Ab2BHUVy (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 8 Feb 2012 15:21:54 -0500
In-Reply-To: Message from eblake@redhat.com of Wed, 08 Feb 2012 10:27:29 -0700 (id <4F32B081.6090007@redhat.com>)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: eblake@redhat.com
Cc: dash@vger.kernel.org, chet@po.cwru.edu

> Per POSIX requirements on trap, dash is properly refusing to let
> non-interactive scripts reset signal handlers via trap if the shell was
> started with an inherited ignored signal handler.  However, dash lies to
> the user, making it impossible to tell if the user is invoking a shell
> in an environment where a signal was inherited as ignored.  ksh and bash
> are nicer about things, and at least let the user query whether a shell
> is treating a particular signal as non-resettable.

I don't think this is a bug.  It's more of a quality-of-implementation
issue.  dash appears to be following the "no error need be reported
when attempting to do so" part of the Posix spec, which is fine.  Bash
did more or less the same thing until bash-4.2.

Chet

-- 
``The lyf so short, the craft so long to lerne.'' - Chaucer
		 ``Ars longa, vita brevis'' - Hippocrates
Chet Ramey, ITS, CWRU    chet@case.edu    http://cnswww.cns.cwru.edu/~chet/
