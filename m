From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: 'continue' does not work in files sourced with dotcmd
Date: Sat, 9 Jul 2011 22:07:30 +0800
Message-ID: <20110709140730.GA6901@gondor.apana.org.au>
References: <AANLkTimiFku8Uj9haYAxXWyJQOGSV7Uz3i2k75+aMvTU@mail.gmail.com> <20110707033749.GB16157@gondor.apana.org.au> <4E15B41A.9020601@redhat.com> <20110707144635.GA21272@gondor.apana.org.au> <4E15CE34.40403@redhat.com> <20110708080936.GA28335@gondor.apana.org.au> <20110709130704.GC14262@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:47286 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471Ab1GIOHk (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 9 Jul 2011 10:07:40 -0400
Content-Disposition: inline
In-Reply-To: <20110709130704.GC14262@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: Eric Blake <eblake@redhat.com>, "Taylan Ulrich B." <taylanbayirli@gmail.com>, dash <dash@vger.kernel.org>

On Sat, Jul 09, 2011 at 03:07:04PM +0200, Jilles Tjoelker wrote:
> 
> A fix for dash is below. The dash code is broken in a different way than
> the FreeBSD sh code was, but the patched code is pretty much the same.
> This makes the above test work and does not change the outcome of any
> other tests in the FreeBSD sh testsuite.

You're right.  But I think your patch may introduce a problem
with a return statement inside a dot script.  That should not
have an effect after exiting the script.

Anyway, the following patch based on your idea should fix the
problem.

commit 4f7e206782675b548565ca2bc82bc8c262a0f20e
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Sat Jul 9 22:05:22 2011 +0800

    [BUILTIN] Merge SKIPFUNC/SKIPFILE and only clear SKIPFUNC when leaving dotcmd
    
    Currently upon leaving a dotcmd the evalskip state is reset so
    if a continue/break statement is used within a dot script it would
    have no effect outside of the dot script.
    
    This is inconsistent with other shells.
    
    This patch is based on one by Jilles Tjoelker and only clears
    SKIPFUNC when leaving a dot script.  As a result continue/break
    will remain in effect.
    
    It also merges SKIPFUNC/SKIPFILE as they have no practical difference.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index d3a4acf..dfab8d1 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2011-07-09  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Merge SKIPFUNC/SKIPFILE and only clear SKIPFUNC when leaving dotcmd.
+
 2011-07-08  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Release 0.5.7.
diff --git a/src/eval.c b/src/eval.c
index 95d30f4..c7358a6 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -1039,7 +1039,7 @@ returncmd(int argc, char **argv)
 	 * If called outside a function, do what ksh does;
 	 * skip the rest of the file.
 	 */
-	evalskip = funcline ? SKIPFUNC : SKIPFILE;
+	evalskip = SKIPFUNC;
 	return argv[1] ? number(argv[1]) : exitstatus;
 }
 
diff --git a/src/eval.h b/src/eval.h
index 4e4de30..dc8acd2 100644
--- a/src/eval.h
+++ b/src/eval.h
@@ -61,4 +61,3 @@ extern int evalskip;
 #define SKIPBREAK	(1 << 0)
 #define SKIPCONT	(1 << 1)
 #define SKIPFUNC	(1 << 2)
-#define SKIPFILE	(1 << 3)
diff --git a/src/main.c b/src/main.c
index af987c6..f79ad7d 100644
--- a/src/main.c
+++ b/src/main.c
@@ -242,7 +242,7 @@ cmdloop(int top)
 
 		skip = evalskip;
 		if (skip) {
-			evalskip = 0;
+			evalskip &= ~SKIPFUNC;
 			break;
 		}
 	}

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
