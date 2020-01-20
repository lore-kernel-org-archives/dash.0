From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] builtin: Fix seconds part of times(1)
Date: Mon, 20 Jan 2020 17:46:48 +0800
Message-ID: <20200120094648.b23lt2izmg5cz34g@gondor.apana.org.au>
References: <m2r281wn3m.fsf@pomona.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:35516 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgATJqw (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 20 Jan 2020 04:46:52 -0500
Content-Disposition: inline
In-Reply-To: <m2r281wn3m.fsf@pomona.edu>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Michael Greenberg <Michael.Greenberg@pomona.edu>
Cc: "dash@vger.kernel.org" <dash@vger.kernel.org>

On Mon, Jun 10, 2019 at 02:07:11PM +0000, Michael Greenberg wrote:
>
> If folks are opposed to including math.h for some reason, I'm sure the
> computation could be done another way.

Thanks for the patch.  Yes I would like to avoid the libm dependency.
How about something like this:

---8<---
The seconds part of the times(1) built-in is wrong as it does not
exclude the minutes part of the result.  This patch fixes it.

This problem was first noted by Michael Greenberg who also sent
a similar patch.

Reported-by: Michael Greenberg <michael.greenberg@pomona.edu>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/bltin/times.c b/src/bltin/times.c
index 8eabc1f..1166a68 100644
--- a/src/bltin/times.c
+++ b/src/bltin/times.c
@@ -15,16 +15,28 @@
 int timescmd() {
 	struct tms buf;
 	long int clk_tck = sysconf(_SC_CLK_TCK);
+	int mutime, mstime, mcutime, mcstime;
+	double utime, stime, cutime, cstime;
 
 	times(&buf);
-	printf("%dm%fs %dm%fs\n%dm%fs %dm%fs\n",
-	       (int) (buf.tms_utime / clk_tck / 60),
-	       ((double) buf.tms_utime) / clk_tck,
-	       (int) (buf.tms_stime / clk_tck / 60),
-	       ((double) buf.tms_stime) / clk_tck,
-	       (int) (buf.tms_cutime / clk_tck / 60),
-	       ((double) buf.tms_cutime) / clk_tck,
-	       (int) (buf.tms_cstime / clk_tck / 60),
-	       ((double) buf.tms_cstime) / clk_tck);
+
+	utime = (double)buf.tms_utime / clk_tck;
+	mutime = utime / 60;
+	utime -= mutime * 60.0;
+
+	stime = (double)buf.tms_stime / clk_tck;
+	mstime = stime / 60;
+	stime -= mstime * 60.0;
+
+	cutime = (double)buf.tms_cutime / clk_tck;
+	mcutime = cutime / 60;
+	cutime -= mcutime * 60.0;
+
+	cstime = (double)buf.tms_cstime / clk_tck;
+	mcstime = cstime / 60;
+	cstime -= mcstime * 60.0;
+
+	printf("%dm%fs %dm%fs\n%dm%fs %dm%fs\n", mutime, utime, mstime, stime,
+	       mcutime, cutime, mcstime, cstime);
 	return 0;
 }
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
