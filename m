From: Chet Ramey <chet.ramey@case.edu>
Subject: Re: [BUG] dash doesn't report syntax error when it should on stray
 "fi"
Date: Mon, 23 Apr 2012 15:48:08 -0400
Message-ID: <4F95B1F8.8080502@case.edu>
References: <4F958907.9030508@gmail.com> <20120423170339.GA9635@burratino> <4F95AD25.3060200@case.edu> <20120423194453.GA13576@burratino>
Reply-To: chet.ramey@case.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mpv1.tis.cwru.edu ([129.22.105.36]:64896 "EHLO
	mpv1.tis.cwru.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397Ab2DWTsK (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 23 Apr 2012 15:48:10 -0400
In-Reply-To: <20120423194453.GA13576@burratino>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Chet Ramey <chet.ramey@case.edu>, Stefano Lattarini <stefano.lattarini@gmail.com>, dash@vger.kernel.org

On 4/23/12 3:44 PM, Jonathan Nieder wrote:
> Chet Ramey wrote:
> 
>> What are `conforming scripts'?  Scripts without syntax errors?
> 
> I meant "conforming POSIX applications".
> 
> A patch for this might even be welcome if it makes dash bigger, if
> that's what you're wondering.

The way I read 2.10.2, Posix requires that the "fi" resolve to the
reserved word `fi' in this case, since it's in a position where a
command name is expected (Rule 1, [Command Name]).  I would think that
would make it a syntax error in any application, conforming or not.

Chet
-- 
``The lyf so short, the craft so long to lerne.'' - Chaucer
		 ``Ars longa, vita brevis'' - Hippocrates
Chet Ramey, ITS, CWRU    chet@case.edu    http://cnswww.cns.cwru.edu/~chet/
