From: Eric Blake <ebb9@byu.net>
Subject: Re: Feature request: set -o pipefail
Date: Wed, 12 Aug 2009 06:51:21 -0600
Message-ID: <4A82BAC9.9040808@byu.net>
References: <20090807131833.GA30733@anuurn.compact>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from qmta03.emeryville.ca.mail.comcast.net ([76.96.30.32]:32953 "EHLO
	QMTA03.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751285AbZHLMvS (ORCPT
	<rfc822;dash@vger.kernel.org>); Wed, 12 Aug 2009 08:51:18 -0400
In-Reply-To: <20090807131833.GA30733@anuurn.compact>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Peter Jakobi <jakobi@acm.org>
Cc: dash@vger.kernel.org

According to Peter Jakobi on 8/7/2009 7:18 AM:
> implement  set  -o pipefail. This will allow the user to  request  the
> return  code  to be the one of the first pipe command with a  non-zero
> error. 

That just seems like bloat to me.  Not to mention that it can lead to
surprising results due to SIGPIPE (that is, there are cases where 'command
| head' should be considered successful, even though command exited from
SIGPIPE, where using bash's 'set -o pipefail' will make it look like a
failure).

> The  lack  of  which  can be quite painful in  scripting,  even  if  a
> bourne-shell/posix subset would otherwise be quite sufficient.

You can generally achieve what you want with just the posix subset, which
will make your code more portable in the long run.  Here's one idea:

>    system "set -o pipefail; mv -i foo bar </dev/tty 2>&1 | tee -a LOG";

system "exec 3>&1; s=$(exec 4>&1 >&3; { mv -i foo bar </dev/tty 2>&1; echo
$? >&4; } | tee -a LOG) && exit $s"

Basically, save the original stdout in fd 3, then use a command
substitution where we save the substitution's stdout in fd 4, restore the
original stdout, and perform the pipe.  Then, by modifying the first
command of the pipe to feed the result of the command substitution, we are
now able to guarantee non-zero status if either (or both) the mv or tee fail.

-- 
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
