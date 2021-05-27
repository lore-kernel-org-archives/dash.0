Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FB2C47089
	for <linux-dash@archiver.kernel.org>; Thu, 27 May 2021 08:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57C32613F1
	for <linux-dash@archiver.kernel.org>; Thu, 27 May 2021 08:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbhE0IpG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 27 May 2021 04:45:06 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:40594 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbhE0IpF (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 27 May 2021 04:45:05 -0400
Received: by mail-pg1-f175.google.com with SMTP id j12so3165550pgh.7
        for <dash@vger.kernel.org>; Thu, 27 May 2021 01:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YrxWPTRnqDObvJeOrYwrRNSfrE5oqm82WvpXbLPKilM=;
        b=kXmKBlijVMQUu9nvktZh1kKjWwfE7w4Mk4hGg3FPbGOk1dyX+nAAgQrOA4A0pIUOAE
         i2gFkFnZW+jQRWKRrJ7UeqLgNW22NdxzK0V37drbbKXOl1XzjQiIELGs5mezqmXp36br
         ruHoGFI/44y2zPE217DAG0XaeacpOP8hErDdZNO4MOU4w2/tUoFYeQlxPARzFUq7/zGc
         N64R4DOPTsejc+jtc31mCMVXPtD3xfm3HBVQTN5pNUDvt8y2ha4T7zmmM+aa7I1V4B+5
         S4/r/hxzma4nuebOfz9rDg9w2zgKe/N0XtMS8ZSVrCwseY1Nuo+XEtPd7uGFmcMnsZs9
         ki2g==
X-Gm-Message-State: AOAM5319Tyr2fwzGcyzjd1jMiHee9EdAoSc0o8Azui+2/Iv+gC1OO73M
        MMfkI760V4GXpPajJrPYImoqS9YgMjY=
X-Google-Smtp-Source: ABdhPJyT3FYqUBwUe7pCOw6Yd5FFhcV760eeAte4pulS0IHmu+h8DTs6nVQWBxGslWOTNAurxTVM3A==
X-Received: by 2002:a62:1cd4:0:b029:2d9:f0ef:2b42 with SMTP id c203-20020a621cd40000b02902d9f0ef2b42mr2686041pfc.36.1622105011254;
        Thu, 27 May 2021 01:43:31 -0700 (PDT)
Received: from smtpclient.apple ([2601:647:5300:10fc:c0:7316:9414:edb5])
        by smtp.gmail.com with ESMTPSA id 15sm1411003pjt.17.2021.05.27.01.43.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 May 2021 01:43:30 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: shell: Call CHECK_DECL on stat64
From:   Saagar Jha <saagar@saagarjha.com>
In-Reply-To: <20210526054938.tgkhhh3z5vn2hjyi@gondor.apana.org.au>
Date:   Thu, 27 May 2021 01:43:29 -0700
Cc:     dash@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <27A6D788-7940-4C36-BB1F-45ABC9F3C65B@saagarjha.com>
References: <20210526054938.tgkhhh3z5vn2hjyi@gondor.apana.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

I was able the compilation to succeed with the patch and the binary seemed to work in my basic tests, so it looks good from my side. Thanks for preparing this!

Regards,
Saagar

> On May 25, 2021, at 22:49, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> 
> Saagar Jha <saagar@saagarjha.com> wrote:
>> 
>> Even though stat64 is not in the public headers, AC_CHECK_FUNC will “find” it because the symbol exists at link time for the test, even though it is not meant to be used. What do you think would be the best way to fix this check on this platform? Would it be preferred to check if the headers contain a declaration of the function?
> 
> Yes we should check for a declaration.  Does this patch fix the
> problem?
> 
> ---8<---
> On macOS it is possible to find stat64 at link-time but not at
> compile-time.  To make the build process more robust we should
> check for the header file as well as the library.
> 
> Reported-by: Saagar Jha <saagar@saagarjha.com>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/configure.ac b/configure.ac
> index 44f2f95..466df4c 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -140,11 +140,12 @@ if test "$ac_cv_func_signal" != yes; then
> fi
> 
> dnl Check for stat64 (dietlibc/klibc).
> -AC_CHECK_FUNC(stat64,, [
> +AC_CHECK_DECL(stat64, AC_CHECK_FUNC(stat64))
> +if test "$ac_cv_func_stat64" != yes; then
> 	AC_DEFINE(fstat64, fstat, [64-bit operations are the same as 32-bit])
> 	AC_DEFINE(lstat64, lstat, [64-bit operations are the same as 32-bit])
> 	AC_DEFINE(stat64, stat, [64-bit operations are the same as 32-bit])
> -])
> +fi
> 
> AC_CHECK_FUNC(glob64,, [
> 	AC_DEFINE(glob64_t, glob_t, [64-bit operations are the same as 32-bit])
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

