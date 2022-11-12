Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CF6C4332F
	for <linux-dash@archiver.kernel.org>; Sat, 12 Nov 2022 11:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbiKLLDB (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 12 Nov 2022 06:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiKLLDA (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 12 Nov 2022 06:03:00 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE69D959D
        for <dash@vger.kernel.org>; Sat, 12 Nov 2022 03:02:59 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id bs21so9497014wrb.4
        for <dash@vger.kernel.org>; Sat, 12 Nov 2022 03:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sCNgCSFUqSH34vRZriPDo21L0XXR5uOOwVA/O5ZpSBE=;
        b=SV8M/5UBuCPOa5/fEVD1atO8Ny3PBMG+XDbAj+CpXNmsnNxckwSCqbSqSsQuY0w1KE
         HQ6K+zcxtFvl+xxcTQ9y2YkPRughGw3HKzqDKkd9iKu83vyTGfOMqROHTDiJUXnrkqZW
         /0bZOkIu9sCuIf8Mj2N+cXIg3IYjrDcnabl3knYQx4fa0ALfA4VMrwG22zczix0DOsA2
         N7NeUR+CD8f/DPGBvC3tVT/VTjq6LUjcVmae6uFIEVHbRZwmSB6duKmS/G5DIj6dmy5y
         G7vSXCHOAQLqK/1Yl5QP4eZ49sXnpCLIYREau9/zkhLPntxvlvSyGwNPr7I/XnmJnER3
         bxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sCNgCSFUqSH34vRZriPDo21L0XXR5uOOwVA/O5ZpSBE=;
        b=gZbTwCvFSbBbcgEcZ6zM3A+h0FWiM98R1a6blYCGr/zW/nkUKBGio3W0nLVptFA0Hn
         mvUGcUM+BEqb5s8871UpNfdOwLZ0gDEBCfWhS+IWt4P/ueJno1NcEa4pBSzg6ZDKuYix
         YYtgmA5AB9V2VwJqMtN6q+KHB4Lp6CJiVAt9Ou9hXXoCYq1JNRpR78kZXPlsOYpK+QjH
         S4JkybcspdGMaRMa9Kzhnfe8E9F2wTyWHOLNztyYpHtVegavTtIH041YQHE4tB7v8aiP
         zhK+JCCRs1IjLW9kLZJ0j+Wuv8bHblv0Yje5khjZ9wFZKxCkUMZHAAvoxTIVqn5bdvcz
         Tr+w==
X-Gm-Message-State: ANoB5plBE+VNBZa4r4l3BqN/aGUChcf9Srbuh9LzffQMy46fHFXmGJ6t
        s7as+TllSkU5CdZl6RZl9/V/aNtbrpBfsVaQ7lW5xoVJ9JbOYg==
X-Google-Smtp-Source: AA0mqf70J5KYzXjL82BvWvRawG2eRzsyNjQxH1wrgQFciRZnz8cYX1fPB/odKmV8ySYo5Byjy23BsNifk1VwSEB5Ncw=
X-Received: by 2002:a5d:6e89:0:b0:228:dd1d:8a42 with SMTP id
 k9-20020a5d6e89000000b00228dd1d8a42mr3328869wrz.375.1668250978081; Sat, 12
 Nov 2022 03:02:58 -0800 (PST)
MIME-Version: 1.0
From:   Akbarkhon Variskhanov <akbarkhon.variskhanov@gmail.com>
Date:   Sat, 12 Nov 2022 16:02:47 +0500
Message-ID: <CANeoM1GQ6XsittRZAE-hZLQYngjF_B5Rm7f786cB3vLQY6dLmw@mail.gmail.com>
Subject: Re: EXIT trap does not fire
To:     dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

I can confirm this behavior in dash
0.5.11+git20210903+057cd650a4ed-3build1 (on Ubuntu).

Signal terminations are not caught by EXIT. It only catches normal
exits. Unfortunately, the EXIT condition is not well-defined by POSIX,
so it's left to interpretation. In the EXAMPLES section of `trap`,
it's hinted that EXIT should be able to handle all terminations (thus,
acting like a shortcut):

> Set a trap so the logout utility in the directory referred to by the HOME environment variable executes when the shell terminates:
>   trap '"$HOME"/logout' EXIT

In dash:

#!/bin/dash
> /tmp/file
trap 'rm -f /tmp/file' EXIT
read -r input

the action is never executed if the script is sent any terminating
signal (HUP, ABRT, INT, TERM, you name it).

In bash, however, it seems to work fine. The action is executed and
the exit status is preserved.

I'm not sure what The Open Group is planning to do and whether or not
we're getting any clarification regarding this. Until then, I think
it's reasonable to interpret or even expect that the EXIT condition
concerns all kinds of terminations, not just explicit program exits.

To conclude, I just wanna say that

     trap 'cleanup' EXIT

is shorter/cleaner/better/saner than

     trap 'cleanup' HUP ABRT INT QUIT TERM KILL PIPE ...
