From: "Vitaly Zuevsky" <vitaly.zuevsky@gmail.com>
Subject: RE: Bug#953421: dash: Resident Set Size growth is unbound (memory leak) on an infinite shell loop
Date: Sun, 29 Mar 2020 18:54:14 +0100
Message-ID: <07ce01d605f3$103f1610$30bd4230$@gmail.com>
References: <158376996556.31988.8584094104007124674.reportbug@ec2-34-240-101-198.eu-west-1.compute.amazonaws.com> <CACujMDPfs5mJs8CVaxqM6wkCRANYQ71wTUkvHiNvOg+MPSTECQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39799 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbgC2RyT (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 29 Mar 2020 13:54:19 -0400
Received: by mail-wm1-f67.google.com with SMTP id e9so6736884wme.4
        for <dash@vger.kernel.org>; Sun, 29 Mar 2020 10:54:17 -0700 (PDT)
In-Reply-To: <CACujMDPfs5mJs8CVaxqM6wkCRANYQ71wTUkvHiNvOg+MPSTECQ@mail.gmail.com>
Content-Language: en-gb
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: 'Andrej Shadura' <andrew@shadura.me>, 953421@bugs.debian.org, dash@vger.kernel.org
Cc: 'Debian Bug Tracking System' <submit@bugs.debian.org>

I have now fixed this bug locally.

The leak is in jobtab array (jobs.c). I concluded that the most logical =
approach would be eliminating inconsistency between makejob() and =
dowait() functions. My fix in a forked repo:

https://salsa.debian.org/psvz-guest/dash/-/commit/5e3ea90cb3355d1308c4826=
61a471883d36af5e7

I suspect that imbalance between allocating and freeing jobtab slots was =
introduced at evolving SIGCHLD handling, because I can see two =
waitforjob() calls, wherein the first call could wait for both done jobs =
and gotsigchld is set. At the second call, gotsigchld is cleared and =
waitforjob() does nothing. So 1 of 2 jobtab slots goes astray.

Simplified bug repro steps:

Script
-------
while true
do
  true &
  sleep .1
done

Execution
-------------
# dash Script &

You can now observe resident set size (RSS) is bumped every several =
seconds:
# ps aux |grep 'RSS\|dash'

What do I do to have it peer-reviewed and, potentially, merged into =
mainline?

Cheers,
Vitaly
----------fixDetails:
Function makejob() calls freejob() when appropriate.
Specifically, it detects a free slot in jobtab array by this condition:

(jp->state !=3D JOBDONE || !jp->waited)

The problem is that dowait() never sets waited flag together with =
JOBDONE state.
Consequently, jobtab may leak: repro steps are provided in a bug report =
#953421.

One solution could be not relying on waited flag at all, i.e. converting
the makejob()'s condition into (jp->state !=3D JOBDONE). As an =
alternative,
I am setting waited flag in dowait().
