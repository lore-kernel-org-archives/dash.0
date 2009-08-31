From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Rergession in readcmd (commit 55c46b7)
Date: Mon, 31 Aug 2009 20:12:32 +1000
Message-ID: <20090831101232.GA894@gondor.apana.org.au>
References: <4A957C5A.6090901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:34306 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750813AbZHaKMe (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 31 Aug 2009 06:12:34 -0400
Content-Disposition: inline
In-Reply-To: <4A957C5A.6090901@gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Alexey Gladkov <gladkov.alexey@gmail.com>
Cc: dash@vger.kernel.org

Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
> Greeting!
> 
> readcmd put trash in the variables.
> 
> Test case:
> 
> $ cat /tmp/conf
> Include common.conf
> FullSpeedCPU yes
> 
> $ cat /tmp/z.sh
> while read option params; do
>  printf '[%s] [%s]\n' "$option" "$params"
> done < /tmp/conf
> 
> Result:
> 
> $ dash /tmp/z.sh
> [Include] [common.conf]
> [FullSpeedCPU] [yesFnf]

Thanks for the report.  It's an off-by-one error causing the
NUL termination to disappear.

diff --git a/ChangeLog b/ChangeLog
index 9d397e4..13c9010 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2009-08-31  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Fix NUL termination in readcmd.
+
 2009-08-11  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Pass EV_TESTED into evalcmd.
diff --git a/src/miscbltin.c b/src/miscbltin.c
index cca0f6c..be746b2 100644
--- a/src/miscbltin.c
+++ b/src/miscbltin.c
@@ -182,7 +182,7 @@ resetbs:
 		backslash = 0;
 	}
 	STACKSTRNUL(p);
-	readcmd_handle_line(stackblock(), ap, p - (char *)stackblock());
+	readcmd_handle_line(stackblock(), ap, p + 1 - (char *)stackblock());
 	return status;
 }
 
Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
