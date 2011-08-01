From: Rudolf Polzer <divverent@xonotic.org>
Subject: Re: Bug: temporary assignments vs shell function
Date: Mon, 1 Aug 2011 07:59:42 +0200
Message-ID: <20110801055941.GA10730@div0.qc.to>
References: <20110714083455.GA25362@div0.qc.to> <20110714092615.GA15476@elie> <20110714100915.GA18946@div0.qc.to> <20110731221904.GA74938@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rm.div0.qc.to ([94.23.21.40]:48174 "EHLO rm.div0.qc.to"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753350Ab1HAF7q (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 1 Aug 2011 01:59:46 -0400
Content-Disposition: inline
In-Reply-To: <20110731221904.GA74938@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: Jonathan Nieder <jrnieder@gmail.com>, dash@vger.kernel.org

On Mon, Aug 01, 2011 at 12:19:04AM +0200, Jilles Tjoelker wrote:
> On Thu, Jul 14, 2011 at 12:09:15PM +0200, Rudolf Polzer wrote:
> > I just retested with that very command, and yes, the FreeBSD /bin/sh
> > does behave the "non-POSIX" (and "obvious") way, and so does the
> > Solaris /bin/sh.
> 
> Yes, FreeBSD /bin/sh is not POSIX compliant here. Because the current
> behaviour is explicitly documented and much more useful than the POSIX
> behaviour, I don't really like changing it ;-)

How is it more useful? I can't see any case where it'd help...

But I do understand it's defined like that in the spec, and that is what dash
should follow.

Best regards,

Rudolf Polzer
