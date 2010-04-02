From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Invalid signal used with trap causes dash to abort
Date: Fri, 2 Apr 2010 14:01:20 +0800
Message-ID: <20100402060119.GE28307@gondor.apana.org.au>
References: <A612847CFE53224C91B23E3A5B48BAC73EBD7D0507@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:59820 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755729Ab0DBGBX (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 2 Apr 2010 02:01:23 -0400
Content-Disposition: inline
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC73EBD7D0507@xmail3.se.axis.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: "dash@vger.kernel.org" <dash@vger.kernel.org>

commit 2533d0df20e871da156d80078b79d93c8c02f0ad
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Fri Apr 2 13:59:42 2010 +0800

    [BUILTIN] Make trap signal name/number errors non-fatal.
    
    On Wed, Feb 24, 2010 at 10:23:34AM +0000, Peter Kjellerstedt wrote:
    >
    > there seems to be a problem  with the trap implementation in dash
    > (tested with 0.5.4 and 0.5.5.1). If I specify a signal which is not
    > supported, the shell unconditionally aborts. E.g., I had expected
    > the following to print foo (like bash and zsh do):
    >
    > # dash -c 'trap "echo trap executed" UNKNOWNSIGNAL || echo "foo"'
    > trap: 1: UNKNOWNSIGNAL: bad trap
    >
    > This means I cannot write a construct like the following to take
    > advantage of the ERR signal which is present in some shells:
    >
    > trap "echo ERR trap executed" ERR 2>/dev/null || :
    >
    > I also checked the POSIX documentation, and quoting from
    > http://www.opengroup.org/onlinepubs/009695399/utilities/trap.html
    > (exit status): "For both interactive and non-interactive shells,
    > invalid signal names [XSI] [Option Start] or numbers [Option End]
    > shall not be considered a syntax error and do not cause the shell
    > to abort."
    
    This patch replaces sh_error with a outfmt + return 1 in trapcmd
    so that these errors are no longer fatal.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index d57ebc1..bc36ab1 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2010-04-02  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Make trap signal name/number errors non-fatal.
+
 2010-04-02  maximilian attems <max@stro.at>
 
 	* Use TMPDIR in mkbuiltins.
diff --git a/src/trap.c b/src/trap.c
index 16703b3..3f93c46 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -117,8 +117,10 @@ trapcmd(int argc, char **argv)
 	else
 		action = *ap++;
 	while (*ap) {
-		if ((signo = decode_signal(*ap, 0)) < 0)
-			sh_error("%s: bad trap", *ap);
+		if ((signo = decode_signal(*ap, 0)) < 0) {
+			outfmt(out2, "trap: %s: bad trap\n", *ap);
+			return 1;
+		}
 		INTOFF;
 		if (action) {
 			if (action[0] == '-' && action[1] == '\0')

-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
