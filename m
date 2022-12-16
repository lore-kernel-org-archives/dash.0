Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F3DC4332F
	for <linux-dash@archiver.kernel.org>; Fri, 16 Dec 2022 19:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiLPTRj (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 16 Dec 2022 14:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiLPTRh (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 16 Dec 2022 14:17:37 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACE72B18E
        for <dash@vger.kernel.org>; Fri, 16 Dec 2022 11:17:36 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id C5CC4240029
        for <dash@vger.kernel.org>; Fri, 16 Dec 2022 20:17:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1671218254; bh=UXKP2y8f2uvzyPwMuEmCIWOGP7ee4twKQmKHUjRAIb0=;
        h=Date:Subject:From:To:From;
        b=En6op4mtCMpG+zpTXoJ72L00uUlvorEBg6oQZjrJvpkkrXsCsKyvQOizNGSrf8M//
         k3373VJZJsXBThDFgZnkh+t3wYV7/81SoW+VoEsPVc33inP5xjL3X3KQ08i9pUYwI0
         fvgSA3Azgk/Xoj8GstRMd3rA3CMbSkIzlXSHPngb951YmpMRHJrAdDLlnlJlGvHF3e
         EXpnpQXeBLj1RXw8J/z/f2MxeRbVPIGSSAklQyCVilGtedDHWjmGCaPV/hOd9gQ5RF
         8FpzlEnOX0GMIR4rz6dx73wvzfIrKTRsG2eg2RZsGH0n8wdt7gv0yhDTn9kgIc4I9l
         fsyWvCNSRNy+A==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4NYf4Z39tbz6tmc
        for <dash@vger.kernel.org>; Fri, 16 Dec 2022 20:17:34 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 16 Dec 2022 19:16:25 +0000
Message-Id: <CP3HEJE65V29.14FPDPIQBKE1J@morphine>
Subject: Re: [PATCH v3 2/2] man: printf: in 'X, X is a byte under dash
From:   "Tom Schwindl" <schwindl@posteo.de>
To:     <dash@vger.kernel.org>
References: <50b331b19b78fd56c5b2190f1f922a755e5f3270.1671063918.git.nabijaczleweli@nabijaczleweli.xyz> <05324b17e76eef2401dbc3ee7d64366134a42d1d.1671063918.git.nabijaczleweli@nabijaczleweli.xyz>
In-Reply-To: <05324b17e76eef2401dbc3ee7d64366134a42d1d.1671063918.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Thu Dec 15, 2022 at 1:25 AM CET, =D0=BD=D0=B0=D0=B1 wrote:
> Multiple issues:
>   * the encoding is not always ASCII
>   * what ASCII code is assigned to =D1=8F
>   * dash isn't internationalised
>     (this is nonconformant but out of scope),
>     and uses the next /byte/; in a UTF-8 locale:
>       $ printf %d\\n \'=C4=85
>       196
>       $ printf %d\\n \'=D1=8F
>       196
>     this is in contrast to POSIX (and bash), which says:
>       > If the leading character is a single-quote or double-quote,
>       > the value shall be the numeric value in the underlying codeset
>       > of the character following the single-quote or double-quote.
>     (i.e. mbrtowc(&val, argv[n], ...))
> ---
>  src/dash.1 | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/src/dash.1 b/src/dash.1
> index 310f34e..38cf020 100644
> --- a/src/dash.1
> +++ b/src/dash.1
> @@ -1552,9 +1552,7 @@ otherwise it is evaluated as a C constant, with the=
 following additions:
>  .It
>  A leading plus or minus sign is allowed.
>  .It
> -If the leading character is a single or double quote, the value is the
> -.Tn ASCII
> -code of the next character.
> +If the leading character is a single or double quote, the value of the n=
ext byte.

s/of/is/

sounds better to me.

--
Best Regards,
Tom Schwindl
