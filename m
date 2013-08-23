From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Crash on valid input
Date: Fri, 23 Aug 2013 21:59:10 +1000
Message-ID: <20130823115910.GI10632@gondor.apana.org.au>
References: <CAPF-yOaPfWdK2c556eTcRuf-thaHEzUcMKa+xa8criaS8uFLUw@mail.gmail.com>
 <51638620.4030603@redhat.com>
 <CAPF-yOZmkcKSpU+jVMsSi6Q8harUYZ-hS5Ugn7SsbBwm-GzhiQ@mail.gmail.com>
 <51638AA0.4080701@redhat.com>
 <51648634.4090708@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([178.18.16.133]:35749 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755282Ab3HWL7Q (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 23 Aug 2013 07:59:16 -0400
Content-Disposition: inline
In-Reply-To: <51648634.4090708@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org, Dan Kegel <dank@kegel.com>, Eric Blake <eblake@redhat.com>

On Tue, Apr 09, 2013 at 09:20:52PM +0000, Harald van Dijk wrote:
> On 09/04/13 05:27, Eric Blake wrote:
> >On 04/08/2013 09:12 PM, Dan Kegel wrote:
> >>Yes, my script was crap, I've fixed it.
> >>
> >>Here's the reproducer.  Called with foo unset.  I think it doesn't
> >>crash without -x.
> >>
> >>#!/bin/dash
> >>set -x
> >>test ! $foo
> >The 'set -x' was indeed the key to reproducing the problem.  In fact,
> >this is the shortest I could make it:
> >
> >dash -cx 'test !'
> >
> It is not limited to 'set -x'. dash continues reading after the NULL
> value in argv, and usually that will be followed by another NULL if
> 'set -x' is not used, but not necessarily.
> 
> $ dash -c 'test ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! !
> ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! !'
> $ dash -c 'test ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! !
> ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! !
> !'
> Segmentation fault
> $ dash -c 'test ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! !
> ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! !
> ! !'
> $
> 
> When [ ! ] is used, the ! is necessarily followed by two NULLs (one
> after the ], and one because the ] is replaced by NULL), so the
> problem is hidden.
> 
> dash should check whether ! is followed by an argument, like bash
> does, which would give an error message without a segmentation fault
> for all three forms above.
> 
> This seems to be easily possible by manually inlining primary() into
> nexpr(), and treating UNOT similarly to STREZ e.a.:

Thanks for the patch.  However, I've decided to fix it like this:

commit b34499f5c851d1a70db95b56bd02eff0329d4a1a
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Fri Aug 23 21:58:55 2013 +1000

    [BUILTIN] Fixed argument parsing crash in test
    
    When nexpr gets an unexpected EOI, this may cause crashes further
    up the call chain because we've advanced t_wp too far.  Fix it by
    checking for EOI in nexpr and only advancing t_wp if we've got more
    arguments.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 4276676..2a39e34 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -2,6 +2,7 @@
 
 	* Propagate EXP_QPAT in subevalvar.
 	* Initialise OPTIND after importing environment.
+	* Fixed argument parsing crash in test.
 
 2013-03-12  Peter Rosin <peda@lysator.liu.se>
 
diff --git a/src/bltin/test.c b/src/bltin/test.c
index 90135e1..baa91a5 100644
--- a/src/bltin/test.c
+++ b/src/bltin/test.c
@@ -268,9 +268,13 @@ aexpr(enum token n)
 static int
 nexpr(enum token n)
 {
-	if (n == UNOT)
-		return !nexpr(t_lex(++t_wp));
-	return primary(n);
+	if (n != UNOT)
+		return primary(n);
+
+	n = t_lex(t_wp + 1);
+	if (n != EOI)
+		t_wp++;
+	return !nexpr(n);
 }
 
 static int

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
