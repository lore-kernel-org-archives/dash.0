From: Eric Blake <ebb9@byu.net>
Subject: Re: test -x should use faccessat, not stat
Date: Fri, 02 Apr 2010 08:57:59 -0600
Message-ID: <4BB605F7.8030505@byu.net>
References: <20100214061137.GA9882@gondor.apana.org.au> <4B794CA2.1080707@byu.net> <20100216120413.GA32318@gondor.apana.org.au> <20100402140353.GA31098@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from qmta14.emeryville.ca.mail.comcast.net ([76.96.27.212]:59561
	"EHLO qmta14.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751443Ab0DBPEA (ORCPT
	<rfc822;dash@vger.kernel.org>); Fri, 2 Apr 2010 11:04:00 -0400
In-Reply-To: <20100402140353.GA31098@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org

According to Herbert Xu on 4/2/2010 8:03 AM:
> After much deliberation (alright, I've simply been busy elsewhere :)
> I've committed this patch.
> 
> commit 1d68712ba2e439f36874c4ed1e3d9ffec177a06c
>     Note that faccessat doesn't handle ACLs when euid != uid, as
>     this case is currently implemented by glibc instead of the kernel,
>     using code similar to the existing dash test.

That faccessat bug is only true for current Linux kernels.  Cygwin
faccessat does the correct thing, even when euid != uid.

Thanks for applying this.

-- 
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
