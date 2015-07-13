From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [BUG] test: -gt: unexpected operator
Date: Mon, 13 Jul 2015 14:06:35 +0800
Message-ID: <20150713060635.GA8106@gondor.apana.org.au>
References: <55A2F88A.4090908@inlv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:48223 "EHLO
	helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbbGMGHn (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 13 Jul 2015 02:07:43 -0400
Content-Disposition: inline
In-Reply-To: <55A2F88A.4090908@inlv.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Martijn Dekker <martijn@inlv.org>
Cc: dash@vger.kernel.org

Martijn Dekker <martijn@inlv.org> wrote:
> I found a bug in dash that affects checking the exit status of '[' or
> 'test' for failure.
> 
> After feeding an illegal number to 'test -t', 'test' will not accept any
> operator (or at least not -gt or -lt) for the next invocation.
> 
> Confirmed in dash 0.5.7, 0.5.8 and current git version.

Thanks for the report.  Does this patch help?

---8<---
Subject: builtin: Reset t_wp_op in testcmd

The global variable t_wp_op needs to be reset every time testcmd
is called or it may cause incorrect parsing of the arguments.

Reported-by: Martijn Dekker <martijn@inlv.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/bltin/test.c b/src/bltin/test.c
index bab9a1f..58c05fe 100644
--- a/src/bltin/test.c
+++ b/src/bltin/test.c
@@ -193,6 +193,8 @@ testcmd(int argc, char **argv)
 		argv[argc] = NULL;
 	}
 
+	t_wp_op = NULL;
+
 recheck:
 	argv++;
 	argc--;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
