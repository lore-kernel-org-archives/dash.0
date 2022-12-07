Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FC7C352A1
	for <linux-dash@archiver.kernel.org>; Wed,  7 Dec 2022 08:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiLGIwn (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 7 Dec 2022 03:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiLGIwN (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 7 Dec 2022 03:52:13 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AF53F06A
        for <dash@vger.kernel.org>; Wed,  7 Dec 2022 00:48:34 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p2q6M-004qTD-FX; Wed, 07 Dec 2022 16:48:27 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 07 Dec 2022 16:48:26 +0800
Date:   Wed, 7 Dec 2022 16:48:26 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org
Subject: [v2 PATCH] parser: Add VSBIT to ensure subtype is never zero
Message-ID: <Y5BTWr28NgVMm8UG@gondor.apana.org.au>
References: <Y47ZlpwkQy+jiule@gondor.apana.org.au>
 <2ec90a7f0cf3f0eebb9092725804f9d0bc4ec756.camel@scientia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ec90a7f0cf3f0eebb9092725804f9d0bc4ec756.camel@scientia.org>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Tue, Dec 06, 2022 at 04:19:39PM +0100, Christoph Anton Mitterer wrote:
> 
> Is that already the final version of the patch? Cause then we could
> ping klibc sh / busybox about it.

Sorry, turns out that the patch was buggy.  Here is an update:

---8<---
Harald van Dijk <harald@gigawatt.nl> wrote:
> On 21/11/2022 13:08, Harald van Dijk wrote:
>> On 21/11/2022 02:38, Christoph Anton Mitterer wrote:
>>> reject_filtered_cmd()
>>> {
>>> ���� reject_and_die "disallowed command${restrict_path_list:+ 
>>> (restrict-path: \"${restrict_path_list//|/\", \"}\")}"
>>> }
>>>
>>> reject_filtered_cmd
>>[...]
>> This should either result in the ${...//...} being skipped, or the "Bad 
>> substitution" error. Currently, what happens instead is it attempts, but 
>> fails, to skip the ${...//...}.
> 
> The reason it fails is because the word is cut off.
> 
> Variable substitutions are encoded as a CTLVAR special character, 
> followed by a byte indicating the type of substitution, followed by the 
> rest of the substitution data. The type of substitution is the VSNORMAL, 
> VSMINUS, etc. seen in parser.h. An invalid substitution is encoded as a 
> value of 0.
> 
> When we define a function, we clone the function body in order to 
> preserve it. Cloning the function body is done by cloning each node. 
> Cloning a "word" node (NARG) involves copying the characters that make 
> up the word up to and including the terminating null byte.
> 
> These two interact badly. The invalid substitution is seen as 
> terminating the word, the rest of the word is not copied, but the 
> expansion code does not have any way of seeing that anything got cut off 
> and happily continues attempting to process the rest of the word.
> 
> If dash decides to issue an error in this case, this is not a problem: 
> the null byte is guaranteed to be copied, and if processing is 
> guaranteed to stop if a null byte is encountered, everything works out.
> 
> If dash decides to not issue an error in this case, the encoding of bad 
> substitutions needs to change to a non-null byte. It appears that if we 
> set the byte to VSNUL, the expansion logic is already able to handle it, 
> but I have not tested this extensively.

Thanks for the analysis Harald!

This patch does basically what you've described except it uses a new
bit to avoid any confusion with a genuine VSNUL.

Fixes: 3df3edd13389 ("[PARSER] Report substition errors at...")
Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/expand.c b/src/expand.c
index fe6215a..2ed02d6 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -704,7 +704,7 @@ evalvar(char *p, int flag)
 	int discard;
 	int quoted;
 
-	varflags = *p++;
+	varflags = *p++ & ~VSBIT;
 	subtype = varflags & VSTYPE;
 
 	quoted = flag & EXP_QUOTED;
diff --git a/src/mystring.c b/src/mystring.c
index ed3c8f6..f651521 100644
--- a/src/mystring.c
+++ b/src/mystring.c
@@ -60,7 +60,7 @@
 char nullstr[1];		/* zero length string */
 const char spcstr[] = " ";
 const char snlfmt[] = "%s\n";
-const char dolatstr[] = { CTLQUOTEMARK, CTLVAR, VSNORMAL, '@', '=',
+const char dolatstr[] = { CTLQUOTEMARK, CTLVAR, VSNORMAL | VSBIT, '@', '=',
 			  CTLQUOTEMARK, '\0' };
 const char cqchars[] = {
 #ifdef HAVE_FNMATCH
diff --git a/src/parser.c b/src/parser.c
index bf94697..a552c47 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -1333,7 +1333,7 @@ badsub:
 			synstack->dblquote = newsyn != BASESYNTAX;
 		}
 
-		*((char *)stackblock() + typeloc) = subtype;
+		*((char *)stackblock() + typeloc) = subtype | VSBIT;
 		if (subtype != VSNORMAL) {
 			synstack->varnest++;
 			if (synstack->dblquote)
diff --git a/src/parser.h b/src/parser.h
index 7d2749b..729c15c 100644
--- a/src/parser.h
+++ b/src/parser.h
@@ -50,6 +50,7 @@
 /* variable substitution byte (follows CTLVAR) */
 #define VSTYPE	0x0f		/* type of variable substitution */
 #define VSNUL	0x10		/* colon--treat the empty string as unset */
+#define VSBIT	0x20		/* Ensure subtype is not zero */
 
 /* values of VSTYPE field */
 #define VSNORMAL	0x1		/* normal variable:  $var or ${var} */

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
