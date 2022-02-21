Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7B2C433EF
	for <linux-dash@archiver.kernel.org>; Mon, 21 Feb 2022 19:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbiBUTPq (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 21 Feb 2022 14:15:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbiBUTPo (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 21 Feb 2022 14:15:44 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D4A21E34
        for <dash@vger.kernel.org>; Mon, 21 Feb 2022 11:15:20 -0800 (PST)
Received: (Authenticated sender: stephane@chazelas.org)
        by mail.gandi.net (Postfix) with ESMTPSA id EF38B1C0005;
        Mon, 21 Feb 2022 19:15:16 +0000 (UTC)
Date:   Mon, 21 Feb 2022 19:15:15 +0000
From:   Stephane Chazelas <stephane@chazelas.org>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     Eric Blake <eblake@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        calestyo@scientia.org, dash@vger.kernel.org
Subject: Re: [v2 PATCH] expand: Always quote caret when using fnmatch
Message-ID: <20220221191515.gz2js45fm3ya265u@chazelas.org>
References: <YeZadfOkUDdN7JqS@gondor.apana.org.au>
 <c31fb498-0f82-dcdc-b1c6-212b8c919c07@gigawatt.nl>
 <YeejsuVQaGCkQ97t@gondor.apana.org.au>
 <20220220071544.7odyx5urgcwjsobd@chazelas.org>
 <20220221163908.hykzez677nlmve6x@redhat.com>
 <6232ed8d-1c18-49ce-a7be-9e382245b5cc@gigawatt.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6232ed8d-1c18-49ce-a7be-9e382245b5cc@gigawatt.nl>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

2022-02-21 17:06:13 +0000, Harald van Dijk:
[...]
> > If you want to escape ^ to always be treated as a literal when calling
> > fnmatch(), you have to spell it something like [[=^=]...], not [\^...]
> > (that is, since \^ inside [] does NOT treat the \ as an escape
> > character, but as yet another literal character as part of the brakcet
> > group, you instead have to resort to calling out the literal character
> > ^ via alternative spellings such as by a collation equivalent).
> 
> This is correct for regular expressions, unspecified for shell patterns in
> general after bug 1234 was resolved, and always incorrect for fnmatch()
> after bug 1190 was resolved. In fnmatch(), backslash has to work even inside
> bracket expressions. Whether it had to may not previously have been clear in
> the standard, but it has been made clear now and that is also how it works
> in glibc. That part of the patch is not a problem.
[...]

Thanks, and sorry about that. I was actually the one raising bug
1234 and misremembered the outcome.

case $var in ([\!x])

is specified, but:

pattern='[\!x]'
case $var in ($pattern)

is not indeed, so, the behaviour  of:

sh -c 'case "\\" in ($1) echo match; esac' sh '[\^x]'

is unspecified, so even though that patch changes the behaviour
in this instance, it's still not a conformance bug.

-- 
Stephane
