From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: memalloc.c patch
Date: Sat, 27 Jun 2009 21:32:29 +0800
Message-ID: <20090627133229.GB23267@gondor.apana.org.au>
References: <20090522195011.9388.qmail@riemann.fmi.uni-sofia.bg> <20090610050456.GA16563@gondor.apana.org.au> <20090610063335.20442.qmail@riemann.fmi.uni-sofia.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:50852 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1749667AbZF0Nca (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 27 Jun 2009 09:32:30 -0400
Content-Disposition: inline
In-Reply-To: <20090610063335.20442.qmail@riemann.fmi.uni-sofia.bg>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Nikola Vladov <v20-two_dash_patches@riemann.fmi.uni-sofia.bg>
Cc: dash@vger.kernel.org

On Wed, Jun 10, 2009 at 09:33:35AM +0300, Nikola Vladov wrote:
>
> diff -urN dash-0.5.5.1_orig/src/memalloc.c dash-0.5.5.1/src/memalloc.c
> --- dash-0.5.5.1_orig/src/memalloc.c	Wed Jan 14 01:37:13 2009
> +++ dash-0.5.5.1/src/memalloc.c	Wed Jun 10 09:09:23 2009
> @@ -97,18 +97,19 @@
>   */
>  
>  /* minimum size of a block */
> -#define MINSIZE SHELL_ALIGN(504)
> +/* #define MINSIZE SHELL_ALIGN(504) */
> +typedef struct { void *next; size_t size; } __alloc_t;
> +#define MINSIZE (512  -SHELL_ALIGN(sizeof(void*) + sizeof(__alloc_t)))

I'm a little uneasy about this calculation.  This is very much
dependent on the underlying malloc implementation.  For all we
know, this could turn out to be better or worse if libc changes
under us.

However, I suppose making it slightly smaller can't hurt that
much.  While if the underlying malloc keeps metadata inline then
we gain 512 bytes per amlloc.

But how about rewriting the above as just

	512 - sizeof(void *) * 2

It would be a lot simpler :)

>  struct stack_block {
>  	struct stack_block *prev;
> -	char space[MINSIZE];
> +	char space[4];
>  };
>  
> -struct stack_block stackbase;
> -struct stack_block *stackp = &stackbase;
> -char *stacknxt = stackbase.space;
> -size_t stacknleft = MINSIZE;
> -char *sstrend = stackbase.space + MINSIZE;
> +static struct stack_block *stackp = 0;
> +char *stacknxt = 0;
> +char *sstrend = 0;
> +size_t stacknleft = 0;

= 0 is redundant.

I like this rewrite though.  But please split it into a separate
patch since it is not directly related to the change in MINSIZE.

Remember, one patch, one change.  Oh and please send one patch
per email :)
 
> diff -urN dash-0.5.5.1_orig/src/memalloc.c dash-0.5.5.1/src/memalloc.c
> --- dash-0.5.5.1_orig/src/memalloc.c	Wed Jan 14 01:37:13 2009
> +++ dash-0.5.5.1/src/memalloc.c	Wed Jun 10 09:21:21 2009
> @@ -99,6 +99,12 @@
>  /* minimum size of a block */
>  #define MINSIZE SHELL_ALIGN(504)
>  
> +#if defined(__dietlibc__) || defined(MALLOC_USES_MMAP_FOR_BIG_BLOCKS)
> +typedef struct { void *next; size_t size; } __alloc_t;
> +#include <sys/shm.h>	/* PAGE_SIZE */
> +#define XXXSIZE (PAGE_SIZE -SHELL_ALIGN(sizeof(void*) + sizeof(__alloc_t)))
> +#endif
> +
>  struct stack_block {
>  	struct stack_block *prev;
>  	char space[MINSIZE];
> @@ -123,6 +129,10 @@
>  		struct stack_block *sp;
>  
>  		blocksize = aligned;
> +#ifdef XXXSIZE
> +		if (stackp && blocksize < XXXSIZE)
> +			blocksize = XXXSIZE;
> +#endif
>  		if (blocksize < MINSIZE)
>  			blocksize = MINSIZE;
>  		len = sizeof(struct stack_block) - MINSIZE + blocksize;

What defines MALLOC_USES_MMAP_FOR_BIG_BLOCKS?

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
