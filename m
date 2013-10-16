From: Guido Berhoerster <guido+kernel.org@berhoerster.name>
Subject: Re: Replacement for declare in dash?
Date: Wed, 16 Oct 2013 15:09:56 +0200
Message-ID: <20131016130956.GI19570@hal.local.invalid>
References: <20131016121859.GA30169@yade.xx.vu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from multivac.heapoverflow.de ([78.47.51.218]:57678 "EHLO
	multivac.heapoverflow.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934157Ab3JPNQh (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 16 Oct 2013 09:16:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by multivac.heapoverflow.de (Postfix) with ESMTP id A5CF5207D0
	for <dash@vger.kernel.org>; Wed, 16 Oct 2013 15:08:48 +0200 (CEST)
Received: from hal.local.invalid (p4FC597C8.dip0.t-ipconnect.de [79.197.151.200])
	by multivac.heapoverflow.de (Postfix) with ESMTPSA id A5A4B20391
	for <dash@vger.kernel.org>; Wed, 16 Oct 2013 15:08:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20131016121859.GA30169@yade.xx.vu>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

* Alexander Huemer <alexander.huemer@xx.vu> [2013-10-16 14:26]:
> Hi,
> 
> I wrote a shell script on a non-Debian system and assumed, in my 
> greenness, that testing it with #!/bin/bash --posix would ensure that 
> the script would run under dash too. I was wrong. Of course that is the 
> fault of bash and not dash.
> Here is a simplified form of the script:
> 
> #!/bin/dash
> # This works when run with #!/bin/bash --posix
> 
> func() {
>         cat /proc/1/environ
> }
> 
> sudo sh -c "$(declare -f func); func"
> 
> Can I do anything equivalent with dash?

No.

> I did not find anything in the docs, but hope dies last.

This is even ugly in bash because you're abusing a function as a
variable. And the shell you get with "sudo sh" depends on your
system configuration.
You can embed commands using a here-doc instead of func()...

sudo /bin/dash << "EOF"
cat /proc/1/environ
# ...
EOF

> Of course I can swap the function out in a seperate script, but I'd like 
> to avoid that.

...but this seems to be the right thing to do rather than
embedding a script inside a script.
-- 
Guido Berhoerster
