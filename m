From: Oleg Verych <olecom@flower.upol.cz>
Subject: job control (Re: dash race)
Date: Fri, 25 Apr 2008 18:17:21 +0200
Message-ID: <20080425161721.GM24008@flower.upol.cz>
References: <4811D0F1.20801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from barikada.upol.cz ([158.194.242.200]:38415 "EHLO
	barikada.upol.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756606AbYDYQBn (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 25 Apr 2008 12:01:43 -0400
Content-Disposition: inline
In-Reply-To: <4811D0F1.20801@gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Alexey Gladkov <gladkov.alexey@gmail.com>
Cc: dash list <dash@vger.kernel.org>

OK, then.

What script tries to do?

> <================================
> #!/bin/dash
> trap "echo TRAP" USR1
> stub() {
> 	echo ">>> STUB $1" >&2
> 	sleep $1
> 	echo "<<< STUB $1" >&2
> 	kill -USR1 $$
> }
> stub 3 &
> stub 2 &
> until { echo "###"; wait; } do
> 	echo "*** $?"
> done
> ================================>

`dash` is forking; inside functions in "background" $$ is parent's pid:

olecom@flower:/tmp$ /bin/dash -s << '#'
stub(){ exec 2>&1
        echo "STUB $$"
        sleep $1
}
stub 1 & echo $! ; stub 2 & echo $!
exit
#

STUB 15418
15419
STUB 15418
15421
olecom@flower:/tmp$


which is kind of strage. Messing with functions especially in background
isn't a good idea. I wonder what is semantics of functions WRT traps,
forks, signals, etc..


olecom@flower:/tmp$ /bin/dash -c 'fu(){ fu; }; fu'
Segmentation fault
olecom@flower:/tmp$ /bin/bash -c 'fu(){ fu; }; fu'
^C
olecom@flower:/tmp$

Also, `ps` && `kill` is better implementation of job control. dash's
interactivity isn't a good one, so what reason is behind shell's job
control after all?
____
