From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 2/3] Revert "Eliminated global exerrno."
Date: Thu, 7 Oct 2010 10:56:49 +0800
Message-ID: <20101007025649.GA14649@gondor.apana.org.au>
References: <20100605160651.GA60028@stack.nl> <20100614095451.26362.qmail@43559bb7971308.315fe32.mid.smarden.org> <20100628065326.GA25667@gondor.apana.org.au> <20101006100420.GA361@burratino> <20101006100804.GB361@burratino> <20101006102930.GA6573@gondor.apana.org.au> <20101006105531.GB475@burratino> <4CAC68FD.4040602@redhat.com> <20101007010241.GB1276@burratino> <20101007010458.GD1276@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:55236 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466Ab0JGC44 (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 6 Oct 2010 22:56:56 -0400
Content-Disposition: inline
In-Reply-To: <20101007010458.GD1276@burratino>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, Gerrit Pape <pape@smarden.org>, dash@vger.kernel.org, "Krzysztof A. Sobiecki" <sobkas@gmail.com>, Jari Aalto <jari.aalto@cante.net>

On Wed, Oct 06, 2010 at 08:04:58PM -0500, Jonathan Nieder wrote:
> This reverts commit c0e07c010e5abdea1a7d1357edb1d08adac529cb.
> 
> Yes, it is nicer to pass the exit status through the exitstatus
> global, but look at the consequences:
> 
>  $ sh -c 'exec nonexistent'; echo $?
>  exec: 1: nonexistent: not found
>  2
>  $ sh -c 'exec .'; echo $?
>  exec: 1: .: Permission denied
>  2
> 
> According to POSIX:
> "If command is not found, the exit status shall be 127. If command is
> found, but it is not an executable utility, the exit status shall
> be 126."
> 
> Make it so again.
> 
> Reported-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Actually the bug is elsewhere.  This patch works for me.

commit 7f684260a2426ac61c06d2e4822429b00437ae24
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Thu Oct 7 10:55:15 2010 +0800

    [BUILTIN] Fix EXEXEC status clobbering
    
    evalcommand always clobbers the exit status in case of an EXEXEC
    which means that exec always fails with exit status 2 regardless
    of what it actually returns.
    
    This patch adds the missing check for EXEXEC so that the correct
    exit status is preserved.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 1dfe241..2faaedd 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2010-10-07  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Fix EXEXEC status clobbering.
+
 2010-09-08  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Fix ifsfirst/ifslastp leak.
diff --git a/src/eval.c b/src/eval.c
index 5b8d36b..b966749 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -854,7 +854,7 @@ bail:
 			int i;
 
 			i = exception;
-			if (i == EXEXIT)
+			if (i == EXEXIT || i == EXEXEC)
 				goto raise;
 
 			status = (i == EXINT) ? SIGINT + 128 : 2;

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
