From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH] Set SA_RESTART flag on SIGCHLD handler
Date: Tue, 26 Jun 2012 06:03:51 -0400
Message-ID: <4FE98907.4040507@mit.edu>
References: <4F665E77.3060102@mit.edu> <20120319025201.GA24778@burratino> <4F66A6CA.4010002@mit.edu> <20120319033751.GA25237@burratino> <alpine.DEB.2.00.1206210345050.3236@dr-wily.mit.edu> <20120622003628.GD4730@burratino> <4FE43C8C.2040809@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from DMZ-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.36]:60293 "EHLO
	dmz-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754103Ab2FZKDy (ORCPT
	<rfc822;dash@vger.kernel.org>); Tue, 26 Jun 2012 06:03:54 -0400
In-Reply-To: <4FE43C8C.2040809@mit.edu>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: dash@vger.kernel.org, git@packages.debian.org

I wrote this greatly simplified skeleton of the failing Git test, and=20
found that I can reproduce what looks like the same problem, fairly=20
reliably:

$ rm -f fifo
$ mkfifo fifo
$ dash -c 'while echo -n .; do : < fifo & : > fifo; wait $!; done'
=2E..............................dash: 1: cannot create fifo: Interrupt=
ed=20
system call

After running this through strace, it seems clear what went wrong.  The=
=20
parent=E2=80=99s open("fifo", O_WRONLY) is what causes the child=E2=80=99=
s open("fifo",=20
O_RDONLY) to return.  If the child exits immediately, the parent may=20
receive a SIGCHLD before its own open() returns.  Then when its SIGCHLD=
=20
handler exits, open() returns EINTR.

That also explains why the SA_RESTART and restart-on-EINTR patches only=
=20
turned it into a deadlock.  If the open() were restarted now, it would=20
just block to wait for a _second_ reader of the FIFO, which will never=20
arrive.

But if that=E2=80=99s what happened, it seems like a kernel bug to me!=20
Shouldn=E2=80=99t an open() call only be restarted or return EINTR in t=
he case=20
that it hasn=E2=80=99t had any side effects yet and can safely be resta=
rted?

Anders

