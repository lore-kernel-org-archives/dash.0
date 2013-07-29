From: Luigi Tarenga <luigi.tarenga@gmail.com>
Subject: possible bug in job control
Date: Mon, 29 Jul 2013 23:44:42 +0200
Message-ID: <CAKkO-EgtZw6EuoBz1ishWc-V7LNOzFO98O7A8T=Rqq42DA_T1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:53640 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755168Ab3G2Vom (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 29 Jul 2013 17:44:42 -0400
Received: by mail-ob0-f182.google.com with SMTP id wo10so10691976obc.27
        for <dash@vger.kernel.org>; Mon, 29 Jul 2013 14:44:42 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

hi list,
while writing a script to execute parallel ssh command on many host I found
a strange behavior of dash. I can replicate it with a very simple script but
didn't find any documentation about dash or POSIX that can explain it.

tested on centos 6.4 (dash 0.5.5.1) and wih dash compiled from source (0.5.7)
the following script reports error:

#!/bin/dash

sleep 3 &
sleep 3 &
sleep 3 &
sleep 3 &

#/bin/true
jobs -l

wait %1
wait %2
wait %3
wait %4

[vortex@lizard ~]$ ./dash-0.5.7/src/dash test.sh
[4] + 4569 Running
[3] - 4568 Running
[2]   4567 Running
[1]   4566 Running
prova: 14: wait: No such job: %4
[vortex@lizard ~]$ echo $?
2

if you uncomment /bin/true it works or if you add one more job it work again:

#!/bin/dash

sleep 3 &
sleep 3 &
sleep 3 &
sleep 3 &
sleep 3 &

#/bin/true
jobs -l

wait %1
wait %2
wait %3
wait %4
wait %5

[vortex@lizard ~]$ ./dash-0.5.7/src/dash prova
[5] + 4590 Running
[4] - 4589 Running
[3]   4588 Running
[2]   4587 Running
[1]   4586 Running


the script fails with 4 and 8 jobs, works with 1 2 3 5 6 7 9.
jobs -l have no other efffect than printing job list (this is ok).
executing one external binary (like /bin/true) between sleeps and wait
make it works. putting and internal command in backgroup like : &
(so it spawn another subprocess) make it works. using %% in the last
wait make it works.

what do you think? it this a bug?

thanks in advance
Luigi
