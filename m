Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712DEC352A1
	for <linux-dash@archiver.kernel.org>; Tue,  6 Dec 2022 05:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiLFF4w (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 6 Dec 2022 00:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiLFF4v (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 6 Dec 2022 00:56:51 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C757126559
        for <dash@vger.kernel.org>; Mon,  5 Dec 2022 21:56:49 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p2QwY-004MCY-PU; Tue, 06 Dec 2022 13:56:39 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 06 Dec 2022 13:56:38 +0800
Date:   Tue, 6 Dec 2022 13:56:38 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     calestyo@scientia.org, dash@vger.kernel.org
Subject: [PATCH] parser: Add VSBIT to ensure subtype is never zero
Message-ID: <Y47ZlpwkQy+jiule@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8710d1c3-d7c9-7332-4bc7-ce243a1cbd37@gigawatt.nl>
X-Newsgroups: apana.lists.os.linux.dash
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Harald van Dijk <harald@gigawatt.nl> wrote:
> On 21/11/2022 13:08, Harald van Dijk wrote:
>> On 21/11/2022 02:38, Christoph Anton Mitterer wrote:
>>> reject_filtered_cmd()
>>> {
>>>      reject_and_die "disallowed command${restrict_path_list:+ 
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
index aea5cc4..6bb1216 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -701,7 +701,7 @@ evalvar(char *p, int flag)
 	int discard;
 	int quoted;
 
-	varflags = *p++;
+	varflags = *p++ & ~VSBIT;
 	subtype = varflags & VSTYPE;
 
 	quoted = flag & EXP_QUOTED;
diff --git a/src/parser.c b/src/parser.c
index 13c2df5..b26f34a 100644
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

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
