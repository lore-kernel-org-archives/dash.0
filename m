From: Chet Ramey <chet.ramey@case.edu>
Subject: Re: [BUG] dash doesn't report syntax error when it should on stray
 "fi"
Date: Mon, 23 Apr 2012 15:27:33 -0400
Message-ID: <4F95AD25.3060200@case.edu>
References: <4F958907.9030508@gmail.com> <20120423170339.GA9635@burratino>
Reply-To: chet.ramey@case.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mpv2.tis.CWRU.Edu ([129.22.105.37]:63630 "EHLO
	mpv2.tis.cwru.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287Ab2DWTdg (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 23 Apr 2012 15:33:36 -0400
In-Reply-To: <20120423170339.GA9635@burratino>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>, dash@vger.kernel.org, chet.ramey@case.edu

On 4/23/12 1:03 PM, Jonathan Nieder wrote:
> Hi Stefano,
> 
> Stefano Lattarini wrote:
> 
>> How to reproduce:
>>
>>   $ dash -c ':; fi'; echo stat = $?
>>   stat = 0
> 
> Since this doesn't affect conforming scripts, I suspect it falls
> squarely within the "patches welcome as long as they don't make dash
> bigger" category.

What are `conforming scripts'?  Scripts without syntax errors?

-- 
``The lyf so short, the craft so long to lerne.'' - Chaucer
		 ``Ars longa, vita brevis'' - Hippocrates
Chet Ramey, ITS, CWRU    chet@case.edu    http://cnswww.cns.cwru.edu/~chet/
