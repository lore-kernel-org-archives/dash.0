From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] eval: Prevent recursive PS4 expansion
Date: Wed, 27 May 2020 13:19:10 +1000
Message-ID: <20200527031910.GA6117@gondor.apana.org.au>
References: <20200525134115.GO423431@lena.dartmouth.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:57846 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgE0DTQ (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 26 May 2020 23:19:16 -0400
Content-Disposition: inline
In-Reply-To: <20200525134115.GO423431@lena.dartmouth.edu>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Yaroslav Halchenko <yoh@onerussian.com>
Cc: dash@vger.kernel.org, kyle@kyleam.com

Yaroslav Halchenko <yoh@onerussian.com> wrote:
> 
> I like to (ab)use PS4 and set -x for tracing execution of scripts.
> Reporting time and PID is very useful in this context.
> 
> I am not 100% certain if bash's behavior (of actually running the command
> embedded within PS4 string, probably eval'ing it) is actually POSIX
> compliant, posh seems to not do that; but I think it is definitely not
> desired for dash to just stall:
> 
> - the script:
> 
> #!/bin/sh
> set -x
> export PS4='+ $(date +%T.%N) [$$] '
> 
> echo "lets go"
> sleep 1
> echo "done $var"
> 
> - bash:
> 
> /tmp > bash --posix test.sh 
> +export 'PS4=+ $(date +%T.%N) [$$] '
> +PS4='+ $(date +%T.%N) [$$] '
> + 09:15:48.982296333 [2764323] echo 'lets go'
> lets go
> + 09:15:48.987829613 [2764323] sleep 1
> + 09:15:49.994485037 [2764323] echo 'done '
> done 
> 
> 
> - posh:
> exit:130 /tmp > posh test.sh
> +export PS4=+ $(date +%T.%N) [$$] 
> + $(date +%T.%N) [$$] echo lets go
> lets go
> + $(date +%T.%N) [$$] sleep 1
> + $(date +%T.%N) [$$] echo done 
> done 
> 
> - dash: (stalls it set -x)
> 
> /tmp > dash test.sh        
> +export PS4=+ $(date +%T.%N) [$$] 
> ^C^C

This patch fixes the infinite loop caused by repeated expansions
of PS4.

Reported-by: Yaroslav Halchenko <yoh@onerussian.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/eval.c b/src/eval.c
index 1b5d61d..d10be38 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -78,6 +78,9 @@ int exitstatus;			/* exit status of last command */
 int back_exitstatus;		/* exit status of backquoted command */
 int savestatus = -1;		/* exit status of last command outside traps */
 
+/* Prevent PS4 nesting. */
+MKINIT int inps4;
+
 
 #if !defined(__alpha__) || (defined(__GNUC__) && __GNUC__ >= 3)
 STATIC
@@ -123,6 +126,7 @@ EXITRESET {
 	}
 	evalskip = 0;
 	loopnest = 0;
+	inps4 = 0;
 }
 #endif
 
@@ -855,12 +859,14 @@ bail:
 	}
 
 	/* Print the command if xflag is set. */
-	if (xflag) {
+	if (xflag && !inps4) {
 		struct output *out;
 		int sep;
 
 		out = &preverrout;
+		inps4 = 1;
 		outstr(expandstr(ps4val()), out);
+		inps4 = 0;
 		sep = 0;
 		sep = eprintlist(out, varlist.list, sep);
 		eprintlist(out, osp, sep);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
