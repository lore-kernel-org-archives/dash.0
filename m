Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83A1C433B4
	for <linux-dash@archiver.kernel.org>; Wed,  7 Apr 2021 23:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 793F861182
	for <linux-dash@archiver.kernel.org>; Wed,  7 Apr 2021 23:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhDGXG0 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 7 Apr 2021 19:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhDGXG0 (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 7 Apr 2021 19:06:26 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68375C061760
        for <dash@vger.kernel.org>; Wed,  7 Apr 2021 16:06:16 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id f29so11708391pgm.8
        for <dash@vger.kernel.org>; Wed, 07 Apr 2021 16:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=eiu45OSDZKRKoeyGkPB+R9uBd+eykAtSPEW2uPaBun8=;
        b=tNbdL3+a4MPnqQKEVDpwFiU7ex5HbnD57KiAiwW4VPbvAhMRi9+z/a9ptlScFFVfwq
         sVg6VMTTec4GGcB3TUygjDvO4tAuufjlrZCNQvTMzbZ8+O/BVEZ8f4ZDjAt/pxyB98Z1
         U/uTFiXIyMiiY3O7kt+Ae0YoEfkvJhVodSqQL/44k5umu4HhBsUhiU4ADsXPlbO6dPiy
         wVO6Qg10fQ95iB4j5/VumYkXyzS484vh82hhZyvQG9Jl9aSz6yn/gP+TNcKwuwxnSkw6
         mGJqueqM3y1yDCNcIvY6Ax1iGr6JIWs9YpNhTlueYC2ys1vNcwn63dEvVf9xWkfmg6w4
         l31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=eiu45OSDZKRKoeyGkPB+R9uBd+eykAtSPEW2uPaBun8=;
        b=LG34wA6ppTtpET6Hj5LrWnGtrNDrtAFGdZaWSlQjFxA/vHmibGyzrQA6lwfngmYr3S
         0wWWO+ojn31e8iMbzcqA9XnwokEVQp+gs5chOIoQRjPynrCX2c8mX/c5OAKfjLjHbyZY
         vnb3AtloLxPOaRNaje/bOVP0TkhauOSt2D4UgXlRkE8S9T2OMofvHIhle6B1NYOxZoZt
         CqsuL0l5yc6PkHJkGT5cD2HKvOY7ezzZKi0/M5rkpc457QhgzXQph7rWojdI+vuJuBZT
         1b+7/YlBCp54xQbX3VDRyTU/UWLTENGCoyP5iB9EX9ETaJ0vQrP8cAZSBE+TBztLBw0n
         hPFg==
X-Gm-Message-State: AOAM533TZiJrsJEh8TGVwc3wkMjAnBm477xaTGxhxg6TMI9UJVsPOVT6
        /VPnqUISr19eMQEm/xaAp8IzPPiDCs1obQ==
X-Google-Smtp-Source: ABdhPJyqTtTgGOaHm9P3T4IA1BeqXcZ0U/KTCrqomOpRUBAwZrxkTaELtrjCy5pkpoRAdZ1IaaHyTw==
X-Received: by 2002:a63:e551:: with SMTP id z17mr5403076pgj.413.1617836775816;
        Wed, 07 Apr 2021 16:06:15 -0700 (PDT)
Received: from localhost ([61.6.233.234])
        by smtp.gmail.com with ESMTPSA id t3sm22601448pfg.176.2021.04.07.16.06.14
        for <dash@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 16:06:15 -0700 (PDT)
Date:   Thu, 8 Apr 2021 07:06:10 +0800
From:   Tim Lee <progscriptclone@gmail.com>
To:     dash@vger.kernel.org
Subject: Remove "hash -v" from man page
Message-ID: <20210407230610.gl3x6z63ejotu6eg@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

src/dash.1 mentions "hash -v":

  hash -rv command ...
      The shell maintains a hash table which remembers the locations of
      commands.  With no arguments whatsoever, the hash command prints
      out the contents of this table.  Entries which have not been
      looked at since the last cd command are marked with an asterisk;
      it is possible for these entries to be invalid.

      With arguments, the hash command removes the specified commands
      from the hash table (unless they are functions) and then locates
      them.  With the -v option, hash prints the locations of the com‐
      mands as it finds them.  The -r option causes the hash command to
      delete all the entries in the hash table except for functions.


However "hash -v" results in an error:

    $ hash -v
    sh: 1: hash: Illegal option -v

The source code [1] shows that only the "-r" option is available; there
is no "-v" option. If there is no "-v" option, then it should be removed
from the documentation.

[1]: https://git.kernel.org/pub/scm/utils/dash/dash.git/tree/src/exec.c#n266
