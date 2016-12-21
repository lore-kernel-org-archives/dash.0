From: Jan Stary <hans@stare.cz>
Subject: jobs
Date: Wed, 21 Dec 2016 13:34:50 +0100
Message-ID: <20161221123450.GA59868@www.stare.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from ns.stare.cz ([79.98.77.229]:59037 "EHLO mx.stare.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751401AbcLUMlc (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 21 Dec 2016 07:41:32 -0500
Received: from www.stare.cz (localhost [127.0.0.1])
        by www.stare.cz (OpenSMTPD) with ESMTP id 3b051bc0
        for <dash@vger.kernel.org>;
        Wed, 21 Dec 2016 13:34:50 +0100 (CET)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hello,

trying to keep my shell scripts portable,
I am also testing on systems which use dash;
for instance, /bin/sh is dash in Ubuntu.
That's where my scripts fail because of
how the "jobs" builtin behaves.

First of all, "jobs" is not even mentioned in
http://git.kernel.org/cgit/utils/dash/dash.git/tree/src/dash.1

Some basic functionality seems to be broken.
Start three background jobs:

  $  md5sum < /dev/random &
  $  md5sum < /dev/random &
  $  md5sum < /dev/random &

What jobs am I running?

  $ jobs
  [3] + Running                    md5sum 0</dev/random
  [2] - Running                    md5sum 0</dev/random
  [1]   Running                    md5sum 0</dev/random

Good. How many is that?

  $ jobs | wc -l
  0

Zero. Hm.

  $ jobs
  [3] + Running                    md5sum 0</dev/random
  [2] - Running                    md5sum 0</dev/random
  [1]   Running                    md5sum 0</dev/random

No, wait, it's three. Let's kill them:

  $ kill `jobs -p`
  dash: 10: kill: Usage: kill [-s sigspec | -signum | -sigspec] [pid | job]... 
  kill -l [exitstatus]

What's the pid list again?

  $ jobs -p
  30783
  30782
  30780


Is this intended? The behaviour descibed above can't be right.
Does the pipe or the `...` run in it's own shell (which indeed has no jobs)?
In that case, I can circumvent this with a temporary file, as in

  $ jobs > /tmp/jobs
  $ wc -l < /tmp/jobs

but doing that instead of a pipe seems backward at best.

	Jan



