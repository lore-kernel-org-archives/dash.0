From: Nikola Vladov <v20-malloc@riemann.fmi.uni-sofia.bg>
Subject: Re: memalloc.c patch ( 3*sizeof(void*) )
Date: Sat, 27 Jun 2009 19:45:59 +0300
Message-ID: <20090627164559.1499.qmail@riemann.fmi.uni-sofia.bg>
References: <20090522195011.9388.qmail@riemann.fmi.uni-sofia.bg> <20090610050456.GA16563@gondor.apana.org.au> <20090610063335.20442.qmail@riemann.fmi.uni-sofia.bg> <20090627133229.GB23267@gondor.apana.org.au> <20090627152933.1235.qmail@riemann.fmi.uni-sofia.bg> <20090627160507.GA24139@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from riemann.fmi.uni-sofia.bg ([62.44.100.74]:1042 "HELO
	riemann.fmi.uni-sofia.bg" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754769AbZF0Qwj (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 27 Jun 2009 12:52:39 -0400
Content-Disposition: inline
In-Reply-To: <20090627160507.GA24139@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org

On Sun, Jun 28, 2009 at 00:05:07AM +0800, Herbert Xu wrote:
> > "2" above is too small.  SHELL_ALIGN is 2*sizeof(void *).
> >
> > Then we must have
> >          buf_size + shell_align + malloc_meta_data <= 512.
> 
> shell_align doesn't add anything if the value is already aligned.

It's depends.  Next is from stalloc
	blocksize = aligned;
		if (blocksize < MINSIZE)
			blocksize = MINSIZE;
		len = sizeof(struct stack_block) - MINSIZE + blocksize;
		      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                  

When I speak for shell_align I mean ^^^^ above.
 
> > I have tested next and they works OK.
> >    MINSIZE (512  -SHELL_ALIGN(sizeof(void*) * 3))
> >    MINSIZE (512  -sizeof(void*) * 4)
> 
> OK, and you've also tested 512 - sizeof(void *) * 2 to make sure
> that it doesn't work? If so we should pick the * 3 variant.

"2" does not work.  "3" works actually good.  I supposes
that malloc uses 2*sizeof(void*) meta-data.
SHELL_ALIGN(sizeof(void*) * 3) is 
16 bytes on i386
24 bytes on x86_64
  
> > For malloc which uses sbrk (like DL-malloc) the above does not
> > help.  In my opinion in this case we have to use
> > fist 512, second 1024, third 2048, all other 4096 chuks.
> 
> Does it hurt though? If not we should just make this unconditional.

No, it does not hurt.  It can be also default.  My patch
with XXXSIZE do this only with one "if".  I using it 2-3 months.
 
Doubling the chunk is not easy.  It must be a little bellow 
1024,, 2048, 4096 as described above!  One i386 dash (for test) 
is available on http://62.44.100.74/vladov/tmp/dash.gz

BTW are there any plans to remove vsnprintf from output.c
It dash uses only %s, %d, %f, %-20s
May be I'll write a simple vsnprintf which understands only
above formats.  

> PS Please do reply-to-all instead of reply-to-author.

Sorry!

Nikola
