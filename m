From: Peter Jakobi <jakobi@acm.org>
Subject: Re: Feature request: set -o pipefail
Date: Thu, 13 Aug 2009 16:35:22 +0200
Message-ID: <20090813143522.GB21918@anuurn.compact>
References: <20090807131833.GA30733@anuurn.compact> <4A82BAC9.9040808@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rs3.shuttle.de ([194.95.249.5]:50261 "EHLO rs3.shuttle.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751910AbZHMOfY (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 13 Aug 2009 10:35:24 -0400
Content-Disposition: inline
In-Reply-To: <4A82BAC9.9040808@byu.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <ebb9@byu.net>
Cc: Peter Jakobi <jakobi@acm.org>, dash@vger.kernel.org

On Wed, Aug 12, 2009 at 06:51:21AM -0600, Eric Blake wrote:

Rehi Eric & *,

[please Cc if you want me to read it :). thx, Peter]

> According to Peter Jakobi on 8/7/2009 7:18 AM:
> > implement  set  -o pipefail. This will allow the user to  request  the
> > return  code  to be the one of the first pipe command with a  non-zero
> > error. 
> 
> That just seems like bloat to me.  Not to mention that it can lead to
> surprising results due to SIGPIPE (that is, there are cases where 'command
> | head' should be considered successful, even though command exited from
> SIGPIPE, where using bash's 'set -o pipefail' will make it look like a
> failure).

Please  don't assume that I want pipefail to be always on: 

There won't be any surprises at all if it is a 'set -o' option and off
by default.


Wrt  bloat,  I  sincerely hope that my request won't double  the  code
size.  I've  even gladly skip on implementing the return  code  status
array  :). I wouldn't have made the suggestion if I'd assume it to  be
bloat or introduce tons of extra code...


As  for sigpipe, of course, it SHOULD occur. And if pipefail is on, it
should be reported even from non-tail stages of the pipe.

And  it's  easy  enough to ignore, it you know that  your  list  might
contain  processes  that may legally create ignorable SIGPIPE:

   (cat LARGEFILE | head -1;true)  | cat
   cat LARGEFILE | ( perl -0pe : | head -1) | cat 

will do quite nicely. Even dd will do in a pinch:

   # gnu dd *bs options are slightly counter-intuitive: 
   # both bs and one of ibs/obs required)
   cat LARGEFILE | ( dd bs=500M obs=1 | head -1) | cat 


> > The  lack  of  which  can be quite painful in  scripting,  even  if  a
> > bourne-shell/posix subset would otherwise be quite sufficient.
> 
> system "exec 3>&1; s=$(exec 4>&1 >&3; { mv -i foo bar </dev/tty 2>&1; echo
> $? >&4; } | tee -a LOG) && exit $s"

Yes.  Oleg pointed me to the even more complete sample of  pipestatus,
which made for an interesting read (thanx Oleg!).

But  that's exactly why I wrote _painful_ (and even pipestatus isn't a
general workaround).

Consider  larger  system-level  scripts,  init.d-scripts,  daemons  or
scripts e.g. in perl using system().


Given  that  Debian/Ubuntu wants to use dash for /bin/sh,  this  issue
gains  some importance, unless you want me and anyone at larger  shops
to  replace  /bin/sh being dash again with the previously  used  bash.
Which  would  be  a shame, given the push the dash project  gained  by
Debian's recent move.

-- 
cu
Peter
jakobi@acm.org
