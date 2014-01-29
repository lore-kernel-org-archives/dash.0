From: Chet Ramey <chet.ramey@case.edu>
Subject: Re: exec command and error checking
Date: Tue, 28 Jan 2014 22:19:51 -0500
Message-ID: <52E87357.4020103@case.edu>
References: <CAEmTpZGqBfdBQDnmw-TozGTXpUxShCC=rWObhaP4zmKFJu4jUw@mail.gmail.com> <20140128131759.GA17217@hal.lan> <20140128215916.GA59221@stack.nl>
Reply-To: chet.ramey@case.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mpv1.tis.CWRU.Edu ([129.22.105.36]:11385 "EHLO
	mpv1.tis.cwru.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755732AbaA2D0e (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 28 Jan 2014 22:26:34 -0500
In-Reply-To: <20140128215916.GA59221@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>, dash@vger.kernel.org
Cc: chet.ramey@case.edu

On 1/28/14, 4:59 PM, Jilles Tjoelker wrote:

>> That's either a bug or an intended deviation from the POSIX
>> standard, you'll have to ask on the bug-bash list about that.

It's a bug in bash.  Bash doesn't exit when the command is on the LHS
of a || or &&.

Chet


-- 
``The lyf so short, the craft so long to lerne.'' - Chaucer
		 ``Ars longa, vita brevis'' - Hippocrates
Chet Ramey, ITS, CWRU    chet@case.edu    http://cnswww.cns.cwru.edu/~chet/
