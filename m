From: Chet Ramey <chet.ramey@case.edu>
Subject: Re: Replacement for declare in dash?
Date: Wed, 16 Oct 2013 10:17:26 -0400
Message-ID: <525E9FF6.60401@case.edu>
References: <20131016121859.GA30169@yade.xx.vu>
Reply-To: chet.ramey@case.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mpv2.tis.CWRU.Edu ([129.22.105.37]:30534 "EHLO
	mpv2.tis.cwru.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934239Ab3JPOXd (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 16 Oct 2013 10:23:33 -0400
In-Reply-To: <20131016121859.GA30169@yade.xx.vu>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Alexander Huemer <alexander.huemer@xx.vu>
Cc: dash@vger.kernel.org, chet.ramey@case.edu

On 10/16/13 8:18 AM, Alexander Huemer wrote:
> Hi,
> 
> I wrote a shell script on a non-Debian system and assumed, in my 
> greenness, that testing it with #!/bin/bash --posix would ensure that 
> the script would run under dash too. I was wrong. Of course that is the 
> fault of bash and not dash.

Maybe you should have verified your assumptions first.  That is simply not
what the --posix option does.  Posix mode makes bash a superset of Posix;
it's not a nothing-but-what-posix-specifies mode.

Chet

-- 
``The lyf so short, the craft so long to lerne.'' - Chaucer
		 ``Ars longa, vita brevis'' - Hippocrates
Chet Ramey, ITS, CWRU    chet@case.edu    http://cnswww.cns.cwru.edu/~chet/
