From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: "command -p" does not correctly limit search to a safe PATH
Date: Fri, 26 Sep 2014 17:19:42 +0800
Message-ID: <20140926091942.GB14940@gondor.apana.org.au>
References: <CAL=-wemDL=2-7Rco761LTgGrFeAA_-zvz0ECpk4xZE7QJsGUEg@mail.gmail.com>
 <51E30212.3030901@gigawatt.nl>
 <51E9B46B.10401@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:59960 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059AbaIZJTq (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 26 Sep 2014 05:19:46 -0400
Content-Disposition: inline
In-Reply-To: <51E9B46B.10401@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Craig Loomis <cploomis@gmail.com>, dash <dash@vger.kernel.org>

On Fri, Jul 19, 2013 at 09:49:31PM +0000, Harald van Dijk wrote:
>
> So, how about this, to be applied on top of my previous patch? It
> defaults to using confstr() if available and reporting a hard error at
> run time if that fails, but it can be configured to not use confstr(),
> and/or fall back to a path specified at configuration time:

Thanks for the patch.  But until someone who needs this complexity
steps up, I'm going to stick with the simpler version below:

commit 842050da1c14d7dbe365cd750032fcd8eaaa1db2
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Fri Sep 26 17:18:35 2014 +0800

    [BUILTIN] Set command -p path to /usr/sbin:/usr/bin:/sbin:/bin
    
    Exclude /usr/local from command -p PATH.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index eb3bbc3..ba67b6e 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,6 +1,7 @@
 2014-09-26  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Small optimisation of command -pv change.
+	* Set command -p path to /usr/sbin:/usr/bin:/sbin:/bin.
 
 2014-09-26  Harald van Dijk <harald@gigawatt.nl>
 
diff --git a/src/var.h b/src/var.h
index 79ee71a..872e2db 100644
--- a/src/var.h
+++ b/src/var.h
@@ -107,7 +107,7 @@ extern const char defifsvar[];
 extern const char defifs[];
 #endif
 extern const char defpathvar[];
-#define defpath (defpathvar + 5)
+#define defpath (defpathvar + 36)
 
 extern int lineno;
 extern char linenovar[];

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
