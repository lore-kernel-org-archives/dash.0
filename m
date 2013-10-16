From: Alexander Huemer <alexander.huemer@xx.vu>
Subject: Re: Replacement for declare in dash?
Date: Wed, 16 Oct 2013 17:34:34 +0200
Message-ID: <20131016153434.GB30169@yade.xx.vu>
References: <20131016121859.GA30169@yade.xx.vu>
 <525E9FF6.60401@case.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from yade.xx.vu ([78.47.92.94]:55544 "EHLO yade.xx.vu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756202Ab3JPPef (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 16 Oct 2013 11:34:35 -0400
Content-Disposition: inline
In-Reply-To: <525E9FF6.60401@case.edu>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Chet Ramey <chet.ramey@case.edu>
Cc: dash@vger.kernel.org

On Wed, Oct 16, 2013 at 10:17:26AM -0400, Chet Ramey wrote:
> On 10/16/13 8:18 AM, Alexander Huemer wrote:
> > Hi,
> > 
> > I wrote a shell script on a non-Debian system and assumed, in my 
> > greenness, that testing it with #!/bin/bash --posix would ensure that 
> > the script would run under dash too. I was wrong. Of course that is the 
> > fault of bash and not dash.
> 
> Maybe you should have verified your assumptions first.  That is simply not
> what the --posix option does.  Posix mode makes bash a superset of Posix;
> it's not a nothing-but-what-posix-specifies mode.

Thanks for your answer and also for the answers of Guido Berhoerster and 
Eric Blake. That's correct, my assumption was wrong. I'll try to use the 
cat << trick, let's see if that works, I won't assume anything at the 
moment ;) Also thanks for the hint regarding posh, I didn't know that.

Kind regards,
-Alex
