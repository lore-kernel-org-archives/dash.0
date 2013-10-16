From: Alexander Huemer <alexander.huemer@xx.vu>
Subject: Replacement for declare in dash?
Date: Wed, 16 Oct 2013 14:18:59 +0200
Message-ID: <20131016121859.GA30169@yade.xx.vu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from yade.xx.vu ([78.47.92.94]:53494 "EHLO yade.xx.vu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932406Ab3JPM0p (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 16 Oct 2013 08:26:45 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi,

I wrote a shell script on a non-Debian system and assumed, in my 
greenness, that testing it with #!/bin/bash --posix would ensure that 
the script would run under dash too. I was wrong. Of course that is the 
fault of bash and not dash.
Here is a simplified form of the script:

#!/bin/dash
# This works when run with #!/bin/bash --posix

func() {
        cat /proc/1/environ
}

sudo sh -c "$(declare -f func); func"

Can I do anything equivalent with dash?
I did not find anything in the docs, but hope dies last.
Of course I can swap the function out in a seperate script, but I'd like 
to avoid that.
Thanks in advance for all ideas.

Kind regards,
-Alex
