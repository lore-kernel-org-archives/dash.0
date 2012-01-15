From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Question about job control in non-interactive shells
Date: Sun, 15 Jan 2012 14:53:19 +1100
Message-ID: <20120115035319.GA30190@gondor.apana.org.au>
References: <20120113154926.GA42715@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:54163 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754953Ab2AODxe (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 14 Jan 2012 22:53:34 -0500
Content-Disposition: inline
In-Reply-To: <20120113154926.GA42715@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: jrnieder@gmail.com, mwd@cert.org, dash@vger.kernel.org

Jilles Tjoelker <jilles@stack.nl> wrote:
> On Mon, Jan 09, 2012 at 10:37:45AM -0600, Jonathan Nieder wrote:
>> Michael Welsh Duggan wrote:
>> > I am trying to determine why:
> 
>> >   dash -c "sleep 5 & kill %1"
> 
>> > results in:
> 
>> >   dash: 1: kill: No such process
> 
>> You are probably looking for the -m option.
> 
> The cause is that the -m option ("job control") enables running commands
> in separate process groups, and dash follows literally what POSIX says
> about kill %job: a background process group should be signaled; however,
> there is no background process group. Some shells signal one or more
> processes they know are part of the job in this case, but dash calls
> kill() on a process group that is guaranteed not to exist.

Right.  And you don't even need %1:

	dash -c "sleep 5 & kill $!"

works just fine.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
