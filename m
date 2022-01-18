Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104BEC433F5
	for <linux-dash@archiver.kernel.org>; Tue, 18 Jan 2022 08:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbiARIoI (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 18 Jan 2022 03:44:08 -0500
Received: from mail.gigawatt.nl ([51.68.198.76]:44328 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229943AbiARIoI (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 18 Jan 2022 03:44:08 -0500
Received: from [IPV6:2a02:8010:68a1:0:e69:c5c8:93ab:b95] (unknown [IPv6:2a02:8010:68a1:0:e69:c5c8:93ab:b95])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 8BDD910DE;
        Tue, 18 Jan 2022 08:44:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 8BDD910DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1642495446;
        bh=++INrNxaDd4dvVVQknw9ggN183X8UG63BQ5LKEPLim4=; l=1399;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SgCFrjjf+qq60LklkkD221864wZ+5ty8B/jAw/4Vm9NABVTHspoP6YoOygRFhzaij
         LMXJ5NA2P7fgCsfwDFPMoGb5O2oFws3UbeJ++ek5N/sw9YRfzDK9gR6dgn+qlJwgnZ
         IFkllo33ckupe46PIg2yA69fi/x6C+pznjuyapAs=
Message-ID: <c31fb498-0f82-dcdc-b1c6-212b8c919c07@gigawatt.nl>
Date:   Tue, 18 Jan 2022 08:44:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] expand: Always quote caret when using fnmatch
Content-Language: en-GB
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     calestyo@scientia.org, dash@vger.kernel.org
References: <YeZadfOkUDdN7JqS@gondor.apana.org.au>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <YeZadfOkUDdN7JqS@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 18/01/2022 06:13, Herbert Xu wrote:
> This patch forces ^ to be a literal when we use fnmatch.
> 
> Fixes: 7638476c18f2 ("shell: Enable fnmatch/glob by default")
> Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
> Suggested-by: Harald van Dijk <harald@gigawatt.nl>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/src/expand.c b/src/expand.c
> index aea5cc4..04bf8fb 100644
> --- a/src/expand.c
> +++ b/src/expand.c
> @@ -47,6 +47,9 @@
>   #include <string.h>
>   #ifdef HAVE_FNMATCH
>   #include <fnmatch.h>
> +#define FNMATCH_IS_ENABLED 1
> +#else
> +#define FNMATCH_IS_ENABLED 0
>   #endif
>   #ifdef HAVE_GLOB
>   #include <glob.h>
> @@ -1693,8 +1696,11 @@ _rmescapes(char *str, int flag)
>   			notescaped = 0;
>   			goto copy;
>   		}
> +		if (FNMATCH_IS_ENABLED && *p == '^')
> +			goto add_escape;
>   		if (*p == (char)CTLESC) {
>   			p++;
> +add_escape:
>   			if (notescaped)
>   				*q++ = '\\';
>   		}
> 

The loop that is modified by this patch is only taken after any qchars 
are seen, so for e.g.

   var=abc
   echo ${var#[^a]}

it has no effect. More importantly though, _rmescapes is used to modify 
strings in place. This patch causes _rmescapes to try and grow strings, 
which cannot ever work. A test case for this is

   case aa in \a[^a]) echo match ;; esac

which fails with a segfault after this patch is applied.

Cheers,
Harald van Dijk
