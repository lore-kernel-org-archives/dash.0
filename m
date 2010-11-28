From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [Partial patch] IFS and read builtin
Date: Sun, 28 Nov 2010 21:10:54 +0800
Message-ID: <20101128131054.GD11109@gondor.apana.org.au>
References: <4C71A29C.1080609@gigawatt.nl> <20100908115324.GA17029@gondor.apana.org.au> <20100908120849.GA17121@gondor.apana.org.au> <20101107220420.GA3224@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:55451 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab0K1NLC (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 28 Nov 2010 08:11:02 -0500
Content-Disposition: inline
In-Reply-To: <20101107220420.GA3224@burratino>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org

On Sun, Nov 07, 2010 at 04:04:20PM -0600, Jonathan Nieder wrote:
>
> Another puzzle bisecting to f42e443bb.  This one comes from the
> grub-mkconfig script:
> 
>  $ sh -c 'datadir=/usr/share; pkgdatadir=${datadir}/`cat`' 2>&1 | cat -A
>  cat: M-^\^M^F^HM-4^M^F^HM-(^M^F^H: No such file or directory$
>  cat: M-(^M^F^H: No such file or directory$
> 
> Still reproducible with 016b529.  I'll try to find time to look into
> it, but thought you might like to know nevertheless.

Sure enough it was another leak, hopefully this is the last one :)

commit 49a94e2bab1e4f601a9fbdf9615d9e4e0150e412
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Sun Nov 28 21:09:51 2010 +0800

    [EXPAND] Free IFS state in evalbackcmd
    
    On Sun, Nov 07, 2010 at 04:04:20PM -0600, Jonathan Nieder wrote:
    >
    > Herbert Xu wrote:
    >
    > > commit f42e443bb511ed3224f09b4fcf0772438ebdbbfa
    > > Author: Herbert Xu <herbert@gondor.apana.org.au>
    > > Date:   Wed Sep 8 20:07:26 2010 +0800
    > >
    > >     [EXPAND] Fix ifsfirst/ifslastp leak
    >
    > Another puzzle bisecting to f42e443bb.  This one comes from the
    > grub-mkconfig script:
    >
    >  $ sh -c 'datadir=/usr/share; pkgdatadir=${datadir}/`cat`' 2>&1 | cat -A
    >  cat: M-^\^M^F^HM-4^M^F^HM-(^M^F^H: No such file or directory$
    >  cat: M-(^M^F^H: No such file or directory$
    >
    > Still reproducible with 016b529.  I'll try to find time to look into
    > it, but thought you might like to know nevertheless.
    
    This is the symptom of another leak.  In this case evalbackcmd
    occurs in the middle of an expansion (as it should) but the forked
    child never clears the previous IFS state.
    
    This patch adds the missing ifsfree call.
    
    This wasn't as much of a problem as the previously discovered leaks
    since all it means is that the child gets to carry around the parent's
    expansion state and the child is usually short-lived.
    
    Reported-by: Jonathan Nieder <jrnieder@gmail.com>
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 13572bf..d0a8304 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -19,6 +19,7 @@
 
 	* Fixed trap/return regression due to SKIPEVAL removal.
 	* Allow the originator of EXERROR to set the exit status.
+	* Free IFS state in evalbackcmd.
 
 2010-10-18  Herbert Xu <herbert@gondor.apana.org.au>
 
diff --git a/src/eval.c b/src/eval.c
index 64aabb1..6e5c43e 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -625,6 +625,7 @@ evalbackcmd(union node *n, struct backcmd *result)
 				dup2(pip[1], 1);
 				close(pip[1]);
 			}
+			ifsfree();
 			evaltreenr(n, EV_EXIT);
 			/* NOTREACHED */
 		}

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
