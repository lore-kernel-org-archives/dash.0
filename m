Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F157DC433F5
	for <linux-dash@archiver.kernel.org>; Wed, 12 Jan 2022 18:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356129AbiALSRd (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 12 Jan 2022 13:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349910AbiALSRa (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 12 Jan 2022 13:17:30 -0500
X-Greylist: delayed 3392 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Jan 2022 10:17:30 PST
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FF08C06173F
        for <dash@vger.kernel.org>; Wed, 12 Jan 2022 10:17:30 -0800 (PST)
Received: from [IPV6:2a02:8010:68a1:0:b9db:5ea0:5aa3:fb21] (unknown [IPv6:2a02:8010:68a1:0:b9db:5ea0:5aa3:fb21])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 899E94A5;
        Wed, 12 Jan 2022 18:17:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 899E94A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1642011449;
        bh=QRKZvNJyYXdH22Jd2mP0mnJuv9HEw69FORqegdCHF/Y=; l=1305;
        h=Date:From:Subject:To:References:In-Reply-To:From;
        b=oirXrSQQculcPlgp9j1B5IKMk0BMqk7j4STFbq1w3noiUsNVr0n7bSDcQKg4JeohG
         mVJ/OgVg9Kt9KenTsBtAx3a6QeIwfx6kaYjndlxqlV1LjVF+wv5DGCAk8lAg9qF0NB
         30QFuujf/5LpZg//x5XSaQoOuqGY20oCKfmo92KA=
Message-ID: <944ee473-9ad6-c13f-48cb-690086c2c902@gigawatt.nl>
Date:   Wed, 12 Jan 2022 18:17:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
From:   Harald van Dijk <harald@gigawatt.nl>
Subject: Re: possible wrong behaviour with patterns using a quoted ^ at the
 start of a bracket expression
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        dash@vger.kernel.org
References: <09fd70edcf08c75b4f9f2e158e3e6c0832d35d90.camel@scientia.org>
 <e341e41f-8c32-b6e4-8be3-8f94fae2677c@gigawatt.nl>
 <4a139aa29e7ccaf561d93cd400e37d60feb7bebc.camel@scientia.org>
In-Reply-To: <4a139aa29e7ccaf561d93cd400e37d60feb7bebc.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 12/01/2022 17:47, Christoph Anton Mitterer wrote:
> On Wed, 2022-01-12 at 17:20 +0000, Harald van Dijk wrote:
>> However, whether this is the correct approach is a matter of opinion:
>> dash could alternatively choose to always take ^ as a literal and
>> always
>> escape it before passing it on to fnmatch()
> 
> Well I personally think the best would to *always* take ^ literally,
> whether quoted or not.
> 
> That would match the behaviour of bash and klibc sh, and also seems
> more in the spirit of POSIX (which, while saying that an unquoted ^
> produces undefined behaviour, also says that:
> "( '!' ) shall replace the <circumflex> character ( '^' )""
> 
> ... "replace", not complement.

Actually, in bash, unquoted ^ does act as negation. Same in ksh, which 
is the basis for a lot of POSIX. As for the spirit of POSIX, POSIX does 
say in the rationale that it's unspecified specifically in order to 
allow that:

   The restriction on a <circumflex> in a bracket expression is to allow
   implementations that support pattern matching using the <circumflex>
   as the negation character in addition to the <exclamation-mark>.

But personally, I have no opinion on which action dash should take, as 
long as it gets the right results for quoted ^.

Cheers,
Harald van Dijk
