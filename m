From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: Bug: temporary assignments vs shell function
Date: Mon, 1 Aug 2011 00:19:04 +0200
Message-ID: <20110731221904.GA74938@stack.nl>
References: <20110714083455.GA25362@div0.qc.to>
 <20110714092615.GA15476@elie>
 <20110714100915.GA18946@div0.qc.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:54642 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752907Ab1GaWTH (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 31 Jul 2011 18:19:07 -0400
Content-Disposition: inline
In-Reply-To: <20110714100915.GA18946@div0.qc.to>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Rudolf Polzer <divverent@xonotic.org>
Cc: Jonathan Nieder <jrnieder@gmail.com>, dash@vger.kernel.org

On Thu, Jul 14, 2011 at 12:09:15PM +0200, Rudolf Polzer wrote:
> I just retested with that very command, and yes, the FreeBSD /bin/sh
> does behave the "non-POSIX" (and "obvious") way, and so does the
> Solaris /bin/sh.

Yes, FreeBSD /bin/sh is not POSIX compliant here. Because the current
behaviour is explicitly documented and much more useful than the POSIX
behaviour, I don't really like changing it ;-)

Different from bash in non-posix mode, FreeBSD /bin/sh does persist
assignments before special builtins as required by POSIX.

The original Bourne shell is different again, though. It ignores the
assignments completely and does not even expand them (a
y=${someunsetvar?} assignment is silently ignored).

-- 
Jilles Tjoelker
