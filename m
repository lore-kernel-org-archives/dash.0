From: Alexey Gladkov <gladkov.alexey@gmail.com>
Subject: Re: job control (Re: dash race)
Date: Sun, 27 Apr 2008 15:23:57 +0400
Message-ID: <4814624D.6010108@gmail.com>
References: <4811D0F1.20801@gmail.com> <20080425161721.GM24008@flower.upol.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mojo.unsafe.ru ([83.222.2.183]:22457 "EHLO mojo.unsafe.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753733AbYD0LYL (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 27 Apr 2008 07:24:11 -0400
Received: from dhcp250-148.yandex.ru (unknown [83.167.106.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mojo.unsafe.ru (Postfix) with ESMTP id CDD05868056
	for <dash@vger.kernel.org>; Sun, 27 Apr 2008 15:23:55 +0400 (MSD)
In-Reply-To: <20080425161721.GM24008@flower.upol.cz>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
Cc: dash list <dash@vger.kernel.org>

Oleg Verych wrote:
> What script tries to do?

This script forking child process and send to parent signals. If you 
are confused with functions it is possible to replace them by other 
script (see below).

> which is kind of strage. Messing with functions especially in background
> isn't a good idea. I wonder what is semantics of functions WRT traps,
> forks, signals, etc..

Maybe this is not good idea, but shell specification allow this.

Another example:

<============ parent.sh =================
#!/bin/dash
trap "echo TRAP" USR1
./child.sh 3 $$ &
./child.sh 2 $$ &
until { echo "###"; wait; } do
	echo "*** $?"
done
echo "parent end"
========================================>

<============ child.sh =================
#!/bin/ash
echo ">>> STUB $1"
sleep $1
echo "<<< STUB $1"
kill -USR1 $2
========================================>

This example have same problem. The problem not in functions that 
executed in background. The problem in the 'wait' command.

> Also, `ps` && `kill` is better implementation of job control. dash's
> interactivity isn't a good one, so what reason is behind shell's job
> control after all?

I don't understand this.

-- 
Rgrds, legion
