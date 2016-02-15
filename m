From: Chet Ramey <chet.ramey@case.edu>
Subject: Re: [BUG] 'trap' is not quite POSIX compliant
Date: Mon, 15 Feb 2016 13:46:43 -0500
Message-ID: <56C21D13.1000506@case.edu>
References: <56BF4F91.7080105@inlv.org>
Reply-To: chet.ramey@case.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mpv3-2015.CWRU.Edu ([129.22.103.194]:19434 "EHLO
	mpv3-2015.case.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbcBOSwt (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 15 Feb 2016 13:52:49 -0500
In-Reply-To: <56BF4F91.7080105@inlv.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Martijn Dekker <martijn@inlv.org>, dash@vger.kernel.org
Cc: chet.ramey@case.edu

On 2/13/16 10:45 AM, Martijn Dekker wrote:

> By the way, dash and zsh, as well as bash in non-POSIX mode, also accept
> the counterintuitive and non-POSIX-compliant form "trap EXIT" to unset
> the trap, but other shells don't: bash (POSIX), yash and ksh93 produce
> an error, while mksh/lksh silently ignore that form. What a mess...

The `trap EXIT' is historical Bourne shell behavior, though Posix makes it
an error.

-- 
``The lyf so short, the craft so long to lerne.'' - Chaucer
		 ``Ars longa, vita brevis'' - Hippocrates
Chet Ramey, ITS, CWRU    chet@case.edu    http://cnswww.cns.cwru.edu/~chet/
