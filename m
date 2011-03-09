From: Dan Muresan <danmbox@gmail.com>
Subject: Re: jobs in scripts?
Date: Thu, 10 Mar 2011 00:52:10 +0100
Message-ID: <AANLkTinfiEpNmjMLe1uQsrVKOt3pkcQFO_mfMxhCTjHs@mail.gmail.com>
References: <AANLkTinDKV9uCZQPhh8LtX9fAwYix0+9bP5LTXAuSCAL@mail.gmail.com>
	<20110309225413.GA45552@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51840 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390Ab1CIXwM (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 9 Mar 2011 18:52:12 -0500
Received: by bwz15 with SMTP id 15so1105524bwz.19
        for <dash@vger.kernel.org>; Wed, 09 Mar 2011 15:52:10 -0800 (PST)
In-Reply-To: <20110309225413.GA45552@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: dash@vger.kernel.org

Thanks. Well, I am currently using PIDs, $!, kill $pid and kill --
-$pgrp. However, I noticed that **even if I don't wait** for a
background job, the shell somehow auto-reaps dead children:

$ dash -c 'sleep 1 & echo "PID $!"; sleep 1000' &
[1] 7840
PID 7841
$ ps ax | grep [7]841
$

So, since dead children get reaped (instead of becoming zombies for a
while), their PIDs are not "reserved". After a PID wrap-around at
32767, a different process could get the same PID. That makes PIDs
unreliable. I could end up killing a completely unrelated process,
instead of a (possibly zombified) child.

That's why I thought I'd try to see if "jobs" could work more reliably.

> That much is clear. However, "kill" and "jobs -p" are less clear. Their

I only need plain "jobs"... I used "jobs -l" as a convenience in the
example I gave, but plain "jobs" would be enough.

Unfortunately, it seems the "kill %n" does indeed refer to process
groups. I didn't realize this means the shell is not guaranteed to
support "kill %n" unless "set -m" is in effect (and, again, there are
problems with set -m in dash).


-- Dan
