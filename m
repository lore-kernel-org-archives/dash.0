From: steve <steve@lonetwin.net>
Subject: [BUG] apache CustomLog pipe to a python script with sys.stdin.read()
 behaves weirdly with dash as system shell
Date: Tue, 31 Jan 2012 03:04:45 +0530
Message-ID: <4F270CF5.5070408@lonetwin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from s10-chicago.accountservergroup.com ([108.163.194.234]:50178
	"EHLO s10-chicago.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752232Ab2A3WWS (ORCPT
	<rfc822;dash@vger.kernel.org>); Mon, 30 Jan 2012 17:22:18 -0500
Received: from [115.252.158.242] (helo=laptop.lonetwin.net)
	by s10-chicago.accountservergroup.com with esmtpa (Exim 4.69)
	(envelope-from <steve@lonetwin.net>)
	id 1RrysE-00011A-VP
	for dash@vger.kernel.org; Mon, 30 Jan 2012 15:34:51 -0600
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi,

I do not claim to understand what is happening here but I am reporting this as a
dash bug because I've seen this occur only with dash. Here is a description of
the problem:

The Apache module mod_log_config has a directive CustomLog[1] which lets you
send logs to a command rather than a file using the syntax like:

CustomLog "|/path/to/your/command" common

When apache executes, it then forks off a process for this command and executes
it using the default system shell.

I recently noticed that a python script that I had being using in this manner to
process logs for a long time now without any issues, suddenly started consuming
100% cpu, after a system update. When I investigated further, I realized that it
boiled down to a section of the script which was spinning the cpu. It did
something like:

import sys

while True:
    for line in sys.stdin:
        <do something with line>

so, it seemed like sys.stdin was not blocking. An strace proved me right and I
saw read() on stdin returning 0 even tho' no data was being written to the pipe.

After a lot of head-scratching and slow thinking I realized that the one thing
that had altered recently was the system-shell which I had set to /bin/dash (as
an aptitude --safe-upgrade recommend I do). I did a dpkg-reconfigure dash, said
'no' to use dash as the system shell and restarted apache. Lo and behold,
sys,stdin started blocking on read()s.

So, like I said, I don't know who was misbehaving, it could've been apache,
dash, or python but I have a strong feeling it is dash since the apache
CustomLog directive has been around for a long time and it is the RIGHT
THING(TM) for sys.stdin to block until there is input if the stdin of the script
is a pipe.

Now, the strange bit is I haven't been able to reproduce this on the prompt, ie:
using ` cat |/bin/dash -c test_script.py `, which leads me to believe this might
have to do something with dash run from within a daemon.

I am willing to help with any additional info. that might prove to be useful.

btw:
apache2 2.2.16-6+squeeze4
dash    0.5.5.1-7.4
python  2.6.6-3+squeeze6

Also, I think, this person ...

http://stackoverflow.com/questions/7056306/python-wait-until-data-is-in-sys-stdin

...might've hit the same problem (no that is not me), so, I guess this is a
fairly common use-case.

cheers,
- steve

[1] http://httpd.apache.org/docs/2.0/mod/mod_log_config.html#customlog
-- 
random spiel: http://lonetwin.net/
what i'm stumbling into: http://lonetwin.stumbleupon.com/
