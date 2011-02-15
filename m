From: Dan Muresan <danmbox@gmail.com>
Subject: set -m under setsid doesn't create pgrp's
Date: Tue, 15 Feb 2011 12:45:58 +0200
Message-ID: <AANLkTikxM==3q9AtL-SU+kqDjLheBbYde=BWMB6bom4+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65447 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139Ab1BOKqB (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 15 Feb 2011 05:46:01 -0500
Received: by bwz15 with SMTP id 15so293794bwz.19
        for <dash@vger.kernel.org>; Tue, 15 Feb 2011 02:45:59 -0800 (PST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

dash (0.5.5.1-3ubuntu2) doesn't seem put jobs in their own pgrp when
setsid'ed, as required by the "set -o monitor" (set -m) option:


$ cat >test.sh <<EOF
#!/bin/sh
set -m
sh -c 'while :; do sleep 3; done' &
set +m
echo "Waiting for $!"; wait; echo Done
EOF

$ setsid test.sh
Waiting for 25828
$ kill -- -25828
kill: (-25828) - No such process
$ ps -Leo pid,ppid,pgrp,cmd  # pgrp of job is pid of test.sh

This does not happen with bash, or if running the script directly
without setsid.

This bug makes it hard to write some scripts robustly.


-- 
Dan Muresan
http://alumnus.caltech.edu/~muresan/
