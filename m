From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: OPTIND
Date: Fri, 23 Aug 2013 21:28:21 +1000
Message-ID: <20130823112820.GH10632@gondor.apana.org.au>
References: <alpine.LMD.2.00.1303222137440.10619@cfa.johnson>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([178.18.16.133]:57671 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755159Ab3HWL2X (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 23 Aug 2013 07:28:23 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LMD.2.00.1303222137440.10619@cfa.johnson>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "Chris F.A. Johnson" <dash@cfajohnson.com>
Cc: dash@vger.kernel.org

commit a14c418aee9d4ccd7cf888024e318b300173099f
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Fri Aug 23 21:27:42 2013 +1000

    [VAR] Initialise OPTIND after importing environment
    
    On Sat, Mar 23, 2013 at 01:46:20AM +0000, Chris F.A. Johnson wrote:
    >
    >   According to both the dash man page and the POSIX spec, "When the
    >   shell is invoked, OPTIND is initialized to 1."
    >
    >   However, it actually takes the value of the environment variable
    >   if it exists:
    >
    > $ OPTIND=4 dash -c 'echo "$OPTIND"'
    > 4
    > $ OPTIND=4 bash -c 'echo "$OPTIND"'
    > 1
    > $ OPTIND=4 ksh -c 'echo "$OPTIND"'
    > 1
    > $ OPTIND=4 ksh93 -c 'echo "$OPTIND"'
    > 1
    
    This patch fixes this by initialising OPTIND after importing the
    environment.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 9500c87..4276676 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,6 +1,7 @@
 2013-08-23  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Propagate EXP_QPAT in subevalvar.
+	* Initialise OPTIND after importing environment.
 
 2013-03-12  Peter Rosin <peda@lysator.liu.se>
 
diff --git a/src/var.c b/src/var.c
index c35e925..fa24854 100644
--- a/src/var.c
+++ b/src/var.c
@@ -142,6 +142,8 @@ INIT {
 		}
 	}
 
+	setvarint("OPTIND", 1, 0);
+
 	fmtstr(ppid + 5, sizeof(ppid) - 5, "%ld", (long) getppid());
 	setvareq(ppid, VTEXTFIXED);

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
