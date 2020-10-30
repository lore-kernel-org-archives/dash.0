Return-Path: <SRS0=ZXI1=EF=vger.kernel.org=dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9A7C388F9
	for <linux-dash@archiver.kernel.org>; Fri, 30 Oct 2020 12:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70FCE2087E
	for <linux-dash@archiver.kernel.org>; Fri, 30 Oct 2020 12:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="U+uO4CdQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgJ3MUW (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 30 Oct 2020 08:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbgJ3MTn (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 30 Oct 2020 08:19:43 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69305C0613CF
        for <dash@vger.kernel.org>; Fri, 30 Oct 2020 05:19:43 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r10so5039002pgb.10
        for <dash@vger.kernel.org>; Fri, 30 Oct 2020 05:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=7TwH7k82nYPUuE9h8CuKexHnUl2ljtCKaHaz6lQR0E8=;
        b=U+uO4CdQPixQ5C0sQDePoqRYQgRNLUTbE8K055DhE92Xj06Te7SCPpHoEuVLbrRv+i
         dODfF3xnAd15xD/Dgg3WFuNODAd1NRZsVOvmxArsI2F6jSsmdae93aoGXnNvIAbZnXrl
         kpS3mYHbco8s7ItwbL2SXEVbX2T1m6Uta9JrwTgovDJEqYcpvvGsYRD4tdnLvtE3EV7K
         Faz4vMF6fPtEX1YJIqoGFpJQAM+bnE8CBZexy5iWa8i9DeVmnWfiVu99CXlyoeDRoLYV
         z8bcOKLB8TF19Y+EjP5ZPyZfTjA3NpWzkrnGPBI/Levk8N6RiZ3iReW4TlnShRRrELzr
         6nJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=7TwH7k82nYPUuE9h8CuKexHnUl2ljtCKaHaz6lQR0E8=;
        b=IfrXSR65rRuWWRPUz35dAFWBHqYXT+KPUkIrBPWRLJVca20ZnaSpYLG7FhXUHUEk6b
         HDtVgoSZsuY/I70P0S8JoZhVaDI5U1SHbM+4Ef5LH0wPQwEdq1NgQQMpnWEWxNcMdgi+
         euFuwKLiFwxX5LE0vkyNkWIhoWeHx3oC1crEW8UN3gdYYA8vGbcioKMh/N+4YYps46z7
         6/UJe/2S/uqG24VyU0RTWRusDnN7klw3nTTwP5E/vR7LTuO0PsQUj5t/IwCzDmlpHmDn
         W5LZ107+f9VSBqJyzv7+6CSuJBuhltIGCvLov4eK1g0lrk331jEufncSXNLfNcNqpbfQ
         ktaQ==
X-Gm-Message-State: AOAM533E0ATTIoGyN6X+vMHg2G5gM+aX+bPUBBs9xzQON9rWwMn+msJh
        aC08ia6MblPtTJCFxRHvljZ7EhQ1UmtiFUd42M7rfrpQ
X-Google-Smtp-Source: ABdhPJwtMOF1pAeaMrRIeUAsmJ8PdXkaV3s3OYJIrtx6sbMxLtpAERsU8O+BsyZo7RZU8oYOBqwFfT4aQTz3rNzIT3Y=
X-Received: by 2002:a17:90a:9910:: with SMTP id b16mr2573523pjp.39.1604060382914;
 Fri, 30 Oct 2020 05:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <CANSNw=_7LH8NtM558HOn9Se0ZgMjxEus5=6jktkY3HrrBAH71A@mail.gmail.com>
In-Reply-To: <CANSNw=_7LH8NtM558HOn9Se0ZgMjxEus5=6jktkY3HrrBAH71A@mail.gmail.com>
From:   Denys Vlasenko <vda.linux@googlemail.com>
Date:   Fri, 30 Oct 2020 13:19:32 +0100
Message-ID: <CAK1hOcMQP9ZAeF_Vh-Ta_sPeeXPS9_6wsN8V8uS=gu-Fcx8yMQ@mail.gmail.com>
Subject: Fwd: Busybox ash buffering-related issue in error handling
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        DASH shell mailing list <dash@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

This bug happens in dash too
(I assume it's "pungets" counter not being reset on errors):

---------- Forwarded message ---------
From: Sergey Zakharchenko <szakharchenko@digital-loggers.com>
Date: Thu, Oct 29, 2020 at 8:00 AM
Subject: Busybox ash buffering-related issue in error handling
To: Denys Vlasenko <vda.linux@googlemail.com>

It appears that, in the interactive shell, the
input buffer has 1 last character remaining after some syntax errors
are handled. The next command is interpreted with that character
prepended, e.g.:

$ ;l
ash: syntax error: unexpected ";"
$ s
[ls output]

Expected output for reference:

$ ;l
sh: 1: Syntax error: ";" unexpected
$ s
sh: 1: s: not found

Similarly, an input of ;# makes the next command be treated as a
comment and not executed.

I'm observing this on x86-64 112453acf24520b4655f9f36da41d8ac591b1a60,
with default options, but it's the same on earlier versions with
different options and a different platform so it's not new.

Best regards,

--
Sergey Zakharchenko
Digital Loggers, Inc.
