From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: cmd modifiers options: CPU affinity, ASLR, lightweight exec...
Date: Tue, 20 May 2008 01:39:48 +0200
Message-ID: <20080519233948.GM21428@flower.upol.cz>
References: <8499950a0804301800x3577741ex3646035f8350e399@mail.gmail.com> <E1JyET0-0004Zw-0H@flower>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from barikada.upol.cz ([158.194.242.200]:33750 "EHLO
	barikada.upol.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767AbYESXSU (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 19 May 2008 19:18:20 -0400
Received: from flower (flower.upol.cz [158.194.64.22])
	by barikada.upol.cz (Spam Firewall) with ESMTP id 09DCE14A953
	for <dash@vger.kernel.org>; Tue, 20 May 2008 01:18:00 +0200 (CEST)
Received: from flower (flower.upol.cz [158.194.64.22]) by barikada.upol.cz with ESMTP id wHbeay8n9mavyO9g for <dash@vger.kernel.org>; Tue, 20 May 2008 01:18:00 +0200 (CEST)
Received: from olecom by flower with local (Exim 4.63)
	(envelope-from <olecom@flower.upol.cz>)
	id 1JyExI-000621-4W
	for dash@vger.kernel.org; Tue, 20 May 2008 01:39:48 +0200
Content-Disposition: inline
In-Reply-To: <E1JyET0-0004Zw-0H@flower>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash list <dash@vger.kernel.org>

> After today's exercises i'd like to add:
> 
> `sed,c` -- set CPU affinity; maybe some free CPU choice is needed also:
> `sed,c[0]` stick to CPU 0
> `sed,c[1]` to CPU 1, another form
> `sed,cpu[1]`

Use cases:

* my buddy, doing his batch calculations; of course, i can say to him,
  hey there's a sched_setaffinity() thing, see man how to use it, good
  luck. But small hint about how to run it from the shell is more
  enduser-friendly, i think.

  Seeing how his `taylor` solver bounces from one CPU to other (with
  my X/qemu) i'm not happy.

* algothims with easy to parallel uses (like that with `sed`) will be
  easily configured and tested to run in one particular set up. One
  main binary, cmd options, some pipe I/O + this shell exec feature.

> good (i.e. slower) random number generation, obviously flexible
> run-time configuration of this stuff on exec time will be needed.
> 
> `sed,rnd[-]`
> `sed,r[+]`

`sed,r[++]` -- good randomization
`set -F[rnd++++]` -- even better (i.e. OK, i can wait)

`set -F[rnd:$(read_ethernet_now)]` -- another choice
`set -F[rnd:$(read_framebuffer bs=512 seek="$seed")]`


This leads us to capabilities support and flexible checking it in `test`
and setting in `exec`. Don't know about interfaces here, though.
capset()/capget(), seems not that much.
____
