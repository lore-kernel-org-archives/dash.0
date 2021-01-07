Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D97C433E0
	for <linux-dash@archiver.kernel.org>; Thu,  7 Jan 2021 07:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9A2223120
	for <linux-dash@archiver.kernel.org>; Thu,  7 Jan 2021 07:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbhAGHhH (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 7 Jan 2021 02:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbhAGHhG (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 7 Jan 2021 02:37:06 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC5AC0612F4
        for <dash@vger.kernel.org>; Wed,  6 Jan 2021 23:36:26 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id f14so980741pju.4
        for <dash@vger.kernel.org>; Wed, 06 Jan 2021 23:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kzbvKgWQxsWV3AtjyAwpghvqP+JV7fGXPqm10ZTpfNQ=;
        b=Oo5bubMIQRUubkoeCkM3ErJB2M44FWawDM2V/jJE7y78ybBbOZAFCsOpXgSOzpMw33
         Cwty+rYDAkm9FjkAY4ak1lgvOG2Ngo35XASxAqdYIz0h5Ofty8RvKCej9grRByV9wDWc
         zPLOG+uFESzGpdtQpGt37GvTY0H5xZMXhicdBSsw6y1hVidX9vVwcwXVyV4d7mH0soR8
         av7sOsL6U5Qyki2AE/+gN1bCsHO4hz0V9f1GDEptRthb3t9gfupT+r+l2jlL9+KJHDfL
         NSSntlJjog3FPa8UQHJva2LbawWSdiZHC/NSe+9iTpHSz4CIslZgSnjDJnVq8mUS3dU2
         GN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kzbvKgWQxsWV3AtjyAwpghvqP+JV7fGXPqm10ZTpfNQ=;
        b=Vb+BLwfGpJzMwVKAvDrDr3Vt1r2UEMolnRAytgEfOcuqOau8lO4dmU+C9EIrNuYWvP
         q5RY8A1AX4Mv5fxJrTM61ydIBa0Tsd9qvbPGhyNuCr0hDNPLbEoNEn4giJM/MblQXqlu
         1p/j1WFV3+uCJTR8XCP22LqwUmRyMqDvICOmRMUWFo2DmeCeG30QZTVz+LWDdUaUhJnx
         4vfYQTpNoYlH5KAILs//vWtf60U4NBBeIOCpwGbaGgzfYg/sdttYMm8FfpruHjvG8+nC
         JMTf9fNOgmFr43tRugtZoKdYgj8UX8F05Zlm9s2YbC1vaYBdUQMaI+iiRI12bwwm7J1J
         tCFw==
X-Gm-Message-State: AOAM530d5TaE8OZ4CNf75PWdTGdHMtU1jl65KMOogUXToYZ0Lxp/+j3N
        TgyTo/9L3p6AUVJopdwVtPRRlvCREnZ5rh6wJJY=
X-Google-Smtp-Source: ABdhPJy0BEFKf7KLPi+LbL3DcdhxxlSc45pZApwOk23tVaCkRlcVm/IlsDWxVV41kX/6uijT7tmZ6rLvNgZtK+sKyUc=
X-Received: by 2002:a17:90a:31c3:: with SMTP id j3mr7887809pjf.25.1610004986234;
 Wed, 06 Jan 2021 23:36:26 -0800 (PST)
MIME-Version: 1.0
References: <20210106044512.GA28191@gondor.apana.org.au> <cb36ab63-d039-c4ee-c4f3-28bafea56b3a@gigawatt.nl>
In-Reply-To: <cb36ab63-d039-c4ee-c4f3-28bafea56b3a@gigawatt.nl>
From:   Denys Vlasenko <vda.linux@googlemail.com>
Date:   Thu, 7 Jan 2021 08:36:15 +0100
Message-ID: <CAK1hOcMMRd5d2WTgodJgyF6F3YUpUmDfXeAGTCvA65+wdPn+mw@mail.gmail.com>
Subject: Re: [PATCH] jobs: Block signals during tcsetpgrp
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>, steffen@sdaoden.eu,
        DASH shell mailing list <dash@vger.kernel.org>,
        Jilles Tjoelker <jilles@stack.nl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Wed, Jan 6, 2021 at 10:17 PM Harald van Dijk <harald@gigawatt.nl> wrote:
> On 06/01/2021 04:45, Herbert Xu wrote:
> > This patch implements the blocking of SIGTTOU (and everything else)
> > while we call tcsetpgrp.
> >
> > Reported-by: Steffen Nurpmeso <steffen@sdaoden.eu>
> > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> >
> > diff --git a/src/jobs.c b/src/jobs.c
> > index 516786f..809f37c 100644
> > --- a/src/jobs.c
> > +++ b/src/jobs.c
> > @@ -1512,7 +1512,13 @@ showpipe(struct job *jp, struct output *out)
> >   STATIC void
> >   xtcsetpgrp(int fd, pid_t pgrp)
> >   {
> > -     if (tcsetpgrp(fd, pgrp))
> > +     int err;
> > +
> > +     sigblockall(NULL);
> > +     err = tcsetpgrp(fd, pgrp);
> > +     sigclearmask();
> > +
> > +     if (err)
> >               sh_error("Cannot set tty process group (%s)", strerror(errno));
> >   }
> >   #endif
>
> While this is a step in the right direction, Jilles has already replied
> with an explanation of why this is not enough: if the terminal is in
> TOSTOP mode, it's not just tcsetpgrp() that needs to be handled, it's
> any write as well that may occur while the shell is not in the
> foreground process group. While it may be working according to design
> for messages written when the shell is not supposed to be in the
> foreground process group, it is another story when the shell is both
> responsible for taking itself out of the foreground process group and
> for writing a message. This is made worse by the fact that there is no
> synchronisation with child processes on errors, so even forcibly
> restoring the foreground process group may not be enough: unfortunate
> scheduling may result in a child process immediately setting the
> foreground process group to the child process after the parent process
> attempted to restore it to itself. I have not yet seen a good solution
> for this.

How about not simply allowing traps on SIGTTOU, like other shells do?

It's not like there is real-world need to allow usage of this signal
- it's not customarily used by userspace for inter-process signaling,
unlike e.g. SIGTERM or SIGUSR1/2.
