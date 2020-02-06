From: Robert Elz <kre@munnari.OZ.AU>
Subject: Re: Bizarre interaction bug involving bash w/ lastpipe + Almquist 'wait'
Date: Fri, 07 Feb 2020 03:43:40 +0700
Message-ID: <15235.1581021820@jinx.noi.kre.to>
References: <f8b210f5-dd59-2c7f-05d4-be0a89316d3d@gigawatt.nl> <10e3756b-5e8f-ba00-df0d-b36c93fa2281@inlv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <dash-owner@vger.kernel.org>
Received: from munnari.OZ.AU ([202.29.151.3]:51700 "EHLO munnari.OZ.AU"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727711AbgBFVCO (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 6 Feb 2020 16:02:14 -0500
In-Reply-To: <f8b210f5-dd59-2c7f-05d4-be0a89316d3d@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Martijn Dekker <martijn@inlv.org>, DASH shell mailing list <dash@vger.kernel.org>, busybox <busybox@busybox.net>, Bug reports for the GNU Bourne Again SHell <bug-bash@gnu.org>, Jilles Tjoelker <jilles@stack.nl>

    Date:        Thu, 6 Feb 2020 19:29:41 +0000
    From:        Harald van Dijk <harald@gigawatt.nl>
    Message-ID:  <f8b210f5-dd59-2c7f-05d4-be0a89316d3d@gigawatt.nl>

  | Nice test.

Yes!

  | and the various ash-based shells do not unblock it.

We do now, the fix for that will be in 9.0 when it is released.
("now" as in as of the past half hour...)

  | Because of that, 
  | they do not pick up on the fact that the child process has terminated.

It was actually a race condition, for me it 'worked' about half the time
(seems to depend whether the wait happens in the parent before or after
the sub-process exits).

kre

ps: that core dump was an "impossible to happen" condition that this
actually made happen, that will be fixed as well, both by actually now
making it impossible like it was supposed to be (by not blocking or
ignoring SIGCHLD, ever) and by testing for it happening anyway...

The secondary fix for that one is still to be committed after I investigate
some more - I know what happened, just need to make sure what will happen
now if this situation which should never occur ever does happen again.

That the 8.1 NetBSD sh seems to work is more just an artifact of how
it runs the race I believe (or guess) - the wait & process invocation code
has changed a lot in 9 (well, 9.0RC2 for now) which seems to have made the
race a close call, instead of one sided.   But that was not an artifact of
the environment for the test, it happens for me on a real -8(ish) type
system as well.

kre
