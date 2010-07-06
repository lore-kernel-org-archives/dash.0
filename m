From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] [EVAL] with set -e exit the shell if a subshell exits
	non-zero
Date: Tue, 6 Jul 2010 17:51:33 +0800
Message-ID: <20100706095133.GB15580@gondor.apana.org.au>
References: <20100614095603.27834.qmail@728ec0bb900c60.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:38390 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970Ab0GFJvj (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 6 Jul 2010 05:51:39 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by fornost.hengli.com.au with esmtp (Exim 4.69 #1 (Debian))
	id 1OW4oQ-0005uS-EF
	for <dash@vger.kernel.org>; Tue, 06 Jul 2010 19:51:34 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 4.69)
	(envelope-from <herbert@gondor.apana.org.au>)
	id 1OW4oP-0004BB-WC
	for dash@vger.kernel.org; Tue, 06 Jul 2010 17:51:34 +0800
Content-Disposition: inline
In-Reply-To: <20100614095603.27834.qmail@728ec0bb900c60.315fe32.mid.smarden.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On Mon, Jun 14, 2010 at 09:56:03AM +0000, Gerrit Pape wrote:
> Example:
> 
> $ dash -c 'set -e; (false); echo here'
> here
> 
> With this commit, dash exits 1 before echo.
> 
> The bug was reported by Stefan Fritsch through
>  http://bugs.debian.org/514863
> 
> Signed-off-by: Gerrit Pape <pape@smarden.org>

Applied with slight change:

commit a92255d6fa8b8efb0f9fb093b77ac601fe3e9ede
Author: Gerrit Pape <pape@smarden.org>
Date:   Tue Jul 6 17:50:37 2010 +0800

    [EVAL] Check exit for eval NSUBSHELL
    
    Example:
    
    $ dash -c 'set -e; (false); echo here'
    here
    
    With this commit, dash exits 1 before echo.
    
    The bug was reported by Stefan Fritsch through
     http://bugs.debian.org/514863
    
    Signed-off-by: Gerrit Pape <pape@smarden.org>
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 3f5e24c..0e367a6 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2010-07-06  Gerrit Pape <pape@smarden.org>
+
+	* Check exit for eval NSUBSHELL.
+
 2010-07-06  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Fix loss of variables when hash collides.
diff --git a/src/eval.c b/src/eval.c
index 58739f5..5b8d36b 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -251,7 +251,7 @@ checkexit:
 	case NSUBSHELL:
 	case NBACKGND:
 		evalfn = evalsubshell;
-		goto calleval;
+		goto checkexit;
 	case NPIPE:
 		evalfn = evalpipe;
 		goto checkexit;
 
Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
