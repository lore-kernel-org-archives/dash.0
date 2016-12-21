From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: jobs
Date: Wed, 21 Dec 2016 14:08:03 +0100
Message-ID: <96ce58d9-482a-f2ca-7092-ff41fd1273a4@gigawatt.nl>
References: <20161221123450.GA59868@www.stare.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from home.gigawatt.nl ([83.163.3.213]:37314 "EHLO home.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750721AbcLUNIK (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 21 Dec 2016 08:08:10 -0500
In-Reply-To: <20161221123450.GA59868@www.stare.cz>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jan Stary <hans@stare.cz>, dash@vger.kernel.org

Hello,

On 21/12/2016 13:34, Jan Stary wrote:
 > Hello,
 >
 > trying to keep my shell scripts portable,
 > I am also testing on systems which use dash;
 > for instance, /bin/sh is dash in Ubuntu.
 > That's where my scripts fail because of
 > how the "jobs" builtin behaves.
 >
 > First of all, "jobs" is not even mentioned in
 > http://git.kernel.org/cgit/utils/dash/dash.git/tree/src/dash.1

Indeed, it's a built-in command, so it would make sense to document it 
along with the other built-in commands.

 > Some basic functionality seems to be broken.
 > Start three background jobs:
 >
 >   $  md5sum < /dev/random &
 >   $  md5sum < /dev/random &
 >   $  md5sum < /dev/random &
 >
 > What jobs am I running?
 >
 >   $ jobs
 >   [3] + Running                    md5sum 0</dev/random
 >   [2] - Running                    md5sum 0</dev/random
 >   [1]   Running                    md5sum 0</dev/random
 >
 > Good. How many is that?
 >
 >   $ jobs | wc -l
 >   0

This is discussed in <https://www.spinics.net/lists/dash/msg01161.html>. 
It's certainly not desired behaviour and equally certainly not what 
POSIX intends, given that POSIX gives examples involving $(jobs -p). 
Arguably though, it may be what POSIX requires, and even if not, it's 
not clear exactly what POSIX does require. I offered to try to come up 
with a patch to make it behave more sensibly if there was a reasonable 
chance it would be accepted, but the dash maintainer (Herbert Xu) hasn't 
commented on this yet. Hoping to hear his ideas on what should work and 
what shouldn't.

A slightly less bad workaround than redirecting to a temporary file 
might be to save each PID in a variable immediately after creating the 
background process, using $!.

Cheers,
Harald van Dijk
