From: Seb <sbb@tuxfamily.org>
Subject: Can't kill a job
Date: Fri, 6 Jul 2012 19:53:02 +0200
Message-ID: <20120706195302.710ced19.sbb@tuxfamily.org>
Reply-To: dash@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:54994 "EHLO
	smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757859Ab2GFRxu (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 6 Jul 2012 13:53:50 -0400
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 53598D1AA89
	for <dash@vger.kernel.org>; Fri,  6 Jul 2012 19:53:47 +0200 (CEST)
Received: from ed.bebop.lan (unknown [88.181.135.123])
	by smtp2-g21.free.fr (Postfix) with SMTP id 1A6F44B005A
	for <dash@vger.kernel.org>; Fri,  6 Jul 2012 19:53:00 +0200 (CEST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hello,

I encounter a problem with the "kill" command. If I execute the
following script:

  #!/bin/sh
  sleep 2 &
  jobs -p %1
  kill %1
  wait

I get the following result:

  2636
  /tmp/debug.sh: 4: kill: No such process


The job is well seen by jobs, but mysteriously not by kill.

I've read the last messages relative to this question on the list.
These ones state the -m option should then be passed to dash. It
indeed fixes the problem, but it results in a very verbose output
useless in a non-interactive environment, and it does not prevent the
default behaviour to be IMHO somewhat inconsistent ("jobs %1" works,
"wait %1" works, but not "kill %1"). Moreover, it seems POSIX
encourages "kill" to work in the same way whatever the state of
the job control setting is:

 The jobs utility is not dependent on the job control option, as are
 the seemingly related bg and fg utilities because jobs is useful for
 examining background jobs, regardless of the condition of job
 control. When the user has invoked a set +m command and job control
 has been turned off, jobs can still be used to examine the background
 jobs associated with that current session. Similarly, kill can then
 be used to kill background jobs with kill% <background job number>.

 http://pubs.opengroup.org/onlinepubs/009695399/utilities/jobs.html
 ("RATIONALE" section)

So maybe it might be a good idea to change the default behaviour of
kill here. It would allow to increase the dash compatibility with the
other shells without betraying the POSIX standard (at least its
spirit).

My 2=C2=A2,
Seb.

P-S. BTW, on the same page (section APPLICATION USAGE), POSIX also
encourages to allow "$(jobs)" to work in the expected useful way.
