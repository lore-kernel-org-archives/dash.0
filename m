Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A302C12002
	for <linux-dash@archiver.kernel.org>; Mon, 19 Jul 2021 05:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E227E610A1
	for <linux-dash@archiver.kernel.org>; Mon, 19 Jul 2021 05:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhGSFQa (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 19 Jul 2021 01:16:30 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:51440 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhGSFQa (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 19 Jul 2021 01:16:30 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1m5Las-0003ig-9m; Mon, 19 Jul 2021 13:13:30 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1m5Laq-0004Cj-BG; Mon, 19 Jul 2021 13:13:28 +0800
Date:   Mon, 19 Jul 2021 13:13:28 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dimitar Yurukov <mscalindt@gmail.com>
Cc:     mscalindt@gmail.com, dash@vger.kernel.org, harald@gigawatt.nl
Subject: Re: [PATCH v2] expand: Recognize '^' as a negation character in BE
Message-ID: <20210719051328.GA16142@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716125027.18824-1-mscalindt@gmail.com>
X-Newsgroups: apana.lists.os.linux.dash
Organization: Core
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Dimitar Yurukov <mscalindt@gmail.com> wrote:
> While performing bracket expression ('[...]'), DASH recognizes only '!'
> as a special character for negation/inversion, but POSIX specifies '^'.
> 
> The specification (2018 edition):
> "
> 9.3.3 BRE Special Characters
> 
> ^ The <circumflex> shall signify a non-matching list expression when it
>  occurs first in a list, immediately following a <left-square-bracket>
>  (see RE Bracket Expression).
> "

This is incorrect and ^ cannot be used in a portable script.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
