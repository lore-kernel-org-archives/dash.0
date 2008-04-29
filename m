From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: job control (Re: dash race)
Date: Tue, 29 Apr 2008 17:51:54 +0200
Message-ID: <20080429155154.GP24008@flower.upol.cz>
References: <20080427114917.GN24008@flower.upol.cz> <E1JqqRh-0005R5-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from barikada.upol.cz ([158.194.242.200]:50376 "EHLO
	barikada.upol.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933181AbYD2PbK (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 29 Apr 2008 11:31:10 -0400
Received: from flower (flower.upol.cz [158.194.64.22])
	by barikada.upol.cz (Spam Firewall) with ESMTP id E43F911E83E
	for <dash@vger.kernel.org>; Tue, 29 Apr 2008 17:30:54 +0200 (CEST)
Received: from flower (flower.upol.cz [158.194.64.22]) by barikada.upol.cz with ESMTP id eFjEK4b7BRB89liW for <dash@vger.kernel.org>; Tue, 29 Apr 2008 17:30:54 +0200 (CEST)
Received: from olecom by flower with local (Exim 4.63)
	(envelope-from <olecom@flower.upol.cz>)
	id 1Jqs7W-0001Ae-Me
	for dash@vger.kernel.org; Tue, 29 Apr 2008 17:51:54 +0200
Content-Disposition: inline
In-Reply-To: <E1JqqRh-0005R5-00@gondolin.me.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "Herbert Xu (in dash list)" <dash@vger.kernel.org>

> >> >Also, `ps` && `kill` is better implementation of job control. dash's
> >> >interactivity isn't a good one, so what reason is behind shell's job
> >> >control after all?
[...] 
> > You don't understand, that `wait` and job control is interactive shell
> > features adopted from Korn Shell?
> 
> I use this construct all the time in my scripts so I certainly
> consider this to be a grave bug in dash :)

And if it's really so, your scripts are waiting indefinitely (or forever)
or consume all CPU (with such bugs)?

It is signal-related. Clear example of useless and buggy stuff, that
is used my many without much knowledge.


== bug: `wait` returns non zero if `trap` is not empty ==

(counting is done by keyboard to show, that `wait` actually waits)

olecom@flower:~$ test_script='
(sleep 2; echo kill; kill -1 $$)&
echo do wait;
wait || ps hc -t `tty`
'
olecom@flower:~$ bug='
trap ":" 1;
'$test_script
olecom@flower:~$ dash -c "$bug"
do wait
1
2
kill
 4256 pts/15   Ss     0:00 bash
 4475 pts/15   S+     0:00 dash
 4479 pts/15   R+     0:00 ps
olecom@flower:~$ 1
bash: 1: command not found
olecom@flower:~$ 2
bash: 2: command not found
olecom@flower:~$
olecom@flower:~$ notrap='
trap "" 1;
'$test_script
olecom@flower:~$ dash -c "$notrap"
do wait
1
2
kill
olecom@flower:~$ 1
bash: 1: command not found
olecom@flower:~$ 2
bash: 2: command not found
olecom@flower:~$

That's why, i'd advise to use `ps` and/or procfs to poll execution
results right from the kernel; `kill` to terminate or clear processes.
Simply and reliable (at least for scripts).

== m flag ==

olecom@flower:~$ dash +m -c "$b"
do wait
1
2
kill
 4256 pts/15   Ss     0:00 bash
 4487 pts/15   S+     0:00 dash
 4491 pts/15   R+     0:00 ps
olecom@flower:~$ 1
bash: 1: command not found
olecom@flower:~$ 2
bash: 2: command not found
olecom@flower:~$ dash +m -c "$s"
do wait
1
2
kill
olecom@flower:~$ 1
bash: 1: command not found
olecom@flower:~$ 2
bash: 2: command not found
olecom@flower:~$

I.e. it doesn't work.

> Unfortunately I'm awfully busy right now but I'll try to reproduce
> it once I get a chance.  If anyone can get me a patch before then
> it'd be much appreciated :)

It's better to design select()-like thing, as Peter did for `read`.
Document it. Remove job control. No joking.
____
