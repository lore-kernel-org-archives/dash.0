From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: [PATCH] trap: fix memory leak in exitshell()
Date: Tue, 22 Nov 2016 22:51:03 +0100
Message-ID: <20161122215103.GA91593@stack.nl>
References: <20161121214052.32428-1-andreas@gazonk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mailout05.stack.nl ([131.155.140.202]:44640 "EHLO
        mailout.stack.nl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751433AbcKVVvH (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 22 Nov 2016 16:51:07 -0500
Content-Disposition: inline
In-Reply-To: <20161121214052.32428-1-andreas@gazonk.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Andreas Bofjall <andreas@gazonk.org>
Cc: dash@vger.kernel.org

On Mon, Nov 21, 2016 at 10:40:52PM +0100, Andreas Bofjall wrote:
> After dash had executed the exit trap handler, the trap was reset but
> the pointer was never freed. This leak can be demonstrated by running
> dash through valgrind and executing the following shell script:

> 	foo() {
> 	    true
> 	}
> 	trap foo EXIT

> Fix by properly freeing the trap pointer in exitshell().

> Signed-off-by: Andreas Bofjall <andreas@gazonk.org>
> ---
>  src/trap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/trap.c b/src/trap.c
> index edb9938..5418b07 100644
> --- a/src/trap.c
> +++ b/src/trap.c
> @@ -389,6 +389,7 @@ exitshell(void)
>  		trap[0] = NULL;
>  		evalskip = 0;
>  		evalstring(p, 0);
> +		ckfree(p);
>  	}
>  out:
>  	/*

This patch will shut up valgrind in the common case, but does not handle
the general case. The command string may contain an error or invoke the
exit builtin and in either case the command string will be leaked
(SIGINT might be expected to have a similar effect, but behaves
strangely from an EXIT trap in dash).

You can probably use the exception handling already present in the
function to fix this. Note that ckfree() should only be used while
INTOFF is in effect, both to avoid longjmp'ing out of free() and to
ensure exactly one free in the presence of interruptions and errors.

-- 
Jilles Tjoelker
