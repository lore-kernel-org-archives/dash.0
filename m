Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0627C433EF
	for <linux-dash@archiver.kernel.org>; Wed, 12 Jan 2022 17:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355577AbiALR1l (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 12 Jan 2022 12:27:41 -0500
Received: from mail.gigawatt.nl ([51.68.198.76]:33908 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355566AbiALR1j (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 12 Jan 2022 12:27:39 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Jan 2022 12:27:39 EST
Received: from [IPV6:2a02:8010:68a1:0:e69:c5c8:93ab:b95] (unknown [IPv6:2a02:8010:68a1:0:e69:c5c8:93ab:b95])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 5B849442;
        Wed, 12 Jan 2022 17:20:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 5B849442
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1642008056;
        bh=dCCYixIik4YRMZcTsrqtKLXWE474mWogJSxTOGmQxJk=; l=1876;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=VIp1evD7K5+vma5qCjTxozoJhxZ5v6qrufJ//0s9Krqqh4dBWOjhS3o11IZ9qAB8e
         JO5rNoQzTOMePDy4XlohScgWfOeiD0ZacA5scKNfKUiAtE+PJJ75GSH47wftfjKQ+z
         bwM0CYem2QcIAE6IJEnaj3K29PHOXvrOjAtxuT4Q=
Message-ID: <e341e41f-8c32-b6e4-8be3-8f94fae2677c@gigawatt.nl>
Date:   Wed, 12 Jan 2022 17:20:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: possible wrong behaviour with patterns using a quoted ^ at the
 start of a bracket expression
Content-Language: en-GB
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        dash@vger.kernel.org
References: <09fd70edcf08c75b4f9f2e158e3e6c0832d35d90.camel@scientia.org>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <09fd70edcf08c75b4f9f2e158e3e6c0832d35d90.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hi,

On 12/01/2022 16:25, Christoph Anton Mitterer wrote:
> The results for the run-circumflex seem pretty odd.
> Apparently, the ^ is taken literally, but the other two are negated.

The ^ is not taken literally. The ^ in the pattern is wrongly taken as 
the negation operator, and the ^ in the argument is then reported as a 
match because it is neither . nor a.

This bug (you're right that it's a bug) is specific to builds that use 
fnmatch(). In dash itself, ^ is always assumed as a literal. In builds 
with --disable-fnmatch you get correct results. In builds with 
--enable-fnmatch, because dash assumes ^ is assumed as a literal, dash 
fails to escape it before passing it on to fnmatch(), and the system 
fnmatch() may choose differently from dash on how to deal with unquoted 
^s. What dash should do to get whatever behaviour the system fnmatch() 
chooses is leave unquoted ^s unquoted, and leave quoted ^s quoted. This 
can be achieved by

--- a/src/mksyntax.c
+++ b/src/mksyntax.c
@@ -178,14 +178,14 @@ main(int argc, char **argv)
         add("$", "CVAR");
         add("}", "CENDVAR");
         /* ':/' for tilde expansion, '-' for [a\-x] pattern ranges */
-       add("!*?[=~:/-]", "CCTL");
+       add("!*?[^=~:/-]", "CCTL");
         print("dqsyntax");
         init();
         fputs("\n/* syntax table used when in single quotes */\n", cfile);
         add("\n", "CNL");
         add("'", "CENDQUOTE");
         /* ':/' for tilde expansion, '-' for [a\-x] pattern ranges */
-       add("!*?[=~:/-]\\", "CCTL");
+       add("!*?[^=~:/-]\\", "CCTL");
         print("sqsyntax");
         init();
         fputs("\n/* syntax table used when in arithmetic */\n", cfile);

However, whether this is the correct approach is a matter of opinion: 
dash could alternatively choose to always take ^ as a literal and always 
escape it before passing it on to fnmatch(), overriding whatever 
decision the libc people had taken.

Cheers,
Harald van Dijk
