From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: Question about job control in non-interactive shells
Date: Fri, 13 Jan 2012 16:49:26 +0100
Message-ID: <20120113154926.GA42715@stack.nl>
References: <tntr4z8j1fk.fsf@waterbuck.yellow.cert.org>
 <20120109163745.GA23825@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:50743 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932216Ab2AMQA0 (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 13 Jan 2012 11:00:26 -0500
Content-Disposition: inline
In-Reply-To: <20120109163745.GA23825@burratino>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Michael Welsh Duggan <mwd@cert.org>, dash@vger.kernel.org

On Mon, Jan 09, 2012 at 10:37:45AM -0600, Jonathan Nieder wrote:
> Michael Welsh Duggan wrote:
> > I am trying to determine why:

> >   dash -c "sleep 5 & kill %1"

> > results in:

> >   dash: 1: kill: No such process

> You are probably looking for the -m option.

The cause is that the -m option ("job control") enables running commands
in separate process groups, and dash follows literally what POSIX says
about kill %job: a background process group should be signaled; however,
there is no background process group. Some shells signal one or more
processes they know are part of the job in this case, but dash calls
kill() on a process group that is guaranteed not to exist.

-- 
Jilles Tjoelker
