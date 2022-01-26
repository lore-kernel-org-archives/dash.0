Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446C4C28CF5
	for <linux-dash@archiver.kernel.org>; Wed, 26 Jan 2022 06:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbiAZG5k (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 26 Jan 2022 01:57:40 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:60432 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237299AbiAZG5g (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 26 Jan 2022 01:57:36 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nCcFI-0002CS-1M; Wed, 26 Jan 2022 17:57:33 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 26 Jan 2022 17:57:31 +1100
Date:   Wed, 26 Jan 2022 17:57:31 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Berthold Lorke <berthold@lorke.de>
Cc:     dash@vger.kernel.org
Subject: Re: PS1 is not implemented as specified in IEEE Std 1003.1-2017
Message-ID: <YfDw2yS+Ct+BGJZ1@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdc481b1-79b4-7f93-97da-8a4b01c41be0@lorke.de>
X-Newsgroups: apana.lists.os.linux.dash
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Berthold Lorke <berthold@lorke.de> wrote:
> Hello!
> 
> The POSIX standard specifies for PS1 
> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html
> 
> 
> ```
> PS1
> 
> Each time an interactive shell is ready to read a command, the value of 
> this variable shall be subjected to parameter expansion and written to 
> standard error. The default value shall be "$ ". For users who have 
> specific additional implementation-defined privileges, the default may 
> be another, implementation-defined value. The shell shall replace each 
> instance of the character '!' in PS1 with the history file number of the 
> next command to be typed. Escaping the '!' with another '!' (that is, 
> "!!" ) shall place the literal character '!' in the prompt. This volume 
> of POSIX.1-2017 specifies the effects of the variable only for systems 
> supporting the User Portability Utilities option.
> ```

Dash doesn't support the full set of UPU options and that includes
history.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
