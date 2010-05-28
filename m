From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Job control bug in revision 3800d4934391b,
Date: Sat, 29 May 2010 09:10:39 +1000
Message-ID: <20100528231039.GA27140@gondor.apana.org.au>
References: <20100528153423.GA3885@jg.home> <20100528224334.GA26879@gondor.apana.org.au> <20100528225321.GA11940@jg.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([216.59.3.182]:51876 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751708Ab0E1XKn (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 28 May 2010 19:10:43 -0400
Content-Disposition: inline
In-Reply-To: <20100528225321.GA11940@jg.home>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Kris Maglione <maglione.k@gmail.com>
Cc: dash@vger.kernel.org

On Fri, May 28, 2010 at 07:01:25PM -0400, Kris Maglione wrote:
>
> That's interesting. I've had three users complain about it so far. strace 
> is attached.

Thanks, I have reproduced it here now.  It looks like it only
happens occasionally on my system.

> [pid 23950] <... read resumed> 0x7fff75f098b7, 1) = ? ERESTARTSYS (To be restarted)
> [pid 23952] <... mmap resumed> )        = 0x2b185172f000
> [pid 23950] --- SIGCHLD (Child exited) @ 0 (0) ---
> [pid 23952] access("/etc/ld.so.preload", R_OK <unfinished ...>
> [pid 23950] rt_sigreturn(0x11 <unfinished ...>
> [pid 23952] <... access resumed> )      = -1 ENOENT (No such file or directory)
> [pid 23950] <... rt_sigreturn resumed> ) = -1 EINTR (Interrupted system call)
> [pid 23953] write(1, "good\n", 5 <unfinished ...>
> [pid 23952] open("/etc/ld.so.cache", O_RDONLY <unfinished ...>
> [pid 23950] exit_group(0)               = ?

So the crux of the issue is that SIGCHLD is causing read to fail
and the shell doing the read to exit.

I'll look into this.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
