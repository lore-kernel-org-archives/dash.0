Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC18C6379F
	for <linux-dash@archiver.kernel.org>; Wed, 11 Jan 2023 10:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbjAKKNH (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 11 Jan 2023 05:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238580AbjAKKMZ (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 11 Jan 2023 05:12:25 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA465FED
        for <dash@vger.kernel.org>; Wed, 11 Jan 2023 02:11:41 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pFY54-00GNoI-H7; Wed, 11 Jan 2023 18:11:39 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 11 Jan 2023 18:11:38 +0800
Date:   Wed, 11 Jan 2023 18:11:38 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     dash@vger.kernel.org,
        =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Subject: Re: [PATCH v2] alias: fix name quoting in printalias
Message-ID: <Y76LWh1tbSMY9sKz@gondor.apana.org.au>
References: <20230109001219.2ylktzb7uckoeti5@tarta.nabijaczleweli.xyz>
 <20230109001543.vpk6khjtqkjtrjox@tarta.nabijaczleweli.xyz>
 <7f1920ef-dc74-3a34-6453-507bbb349b8b@gigawatt.nl>
 <2251366a-a75e-7901-a47d-b9fa94e53fc5@gigawatt.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2251366a-a75e-7901-a47d-b9fa94e53fc5@gigawatt.nl>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Wed, Jan 11, 2023 at 12:06:04AM +0000, Harald van Dijk wrote:
>
> If there is interest in having this in dash, can adapt and submit it.

Yes please send it to the list.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
