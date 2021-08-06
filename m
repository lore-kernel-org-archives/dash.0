Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB4DC4338F
	for <linux-dash@archiver.kernel.org>; Fri,  6 Aug 2021 08:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2228160F59
	for <linux-dash@archiver.kernel.org>; Fri,  6 Aug 2021 08:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241735AbhHFIqS (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 6 Aug 2021 04:46:18 -0400
Received: from mail-40140.protonmail.ch ([185.70.40.140]:14297 "EHLO
        mail-40140.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbhHFIqS (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 6 Aug 2021 04:46:18 -0400
Date:   Fri, 06 Aug 2021 08:45:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1628239561;
        bh=pgsPbZBLnhntmHwaR1SUR5MQaAK+w2MX3LrpePdvV8s=;
        h=Date:To:From:Reply-To:Subject:From;
        b=mxd62uGfzWj6yPOE44am6aTaTXE3WbOewX++xj392mp5JIxnNt77yjtjqqBvp9N0I
         a2olX3dTo3bBp7nejO9Af5PPipKURUJVfbOC/N5BzYcTaIOboQFn0lR5I3ZaZbSkCW
         98hywCo21SjYwj9NAzxuLexDu1lMiwDNbsGnXto0=
To:     "dash@vger.kernel.org" <dash@vger.kernel.org>
From:   Evan Greenup <evan_greenup@protonmail.com>
Reply-To: Evan Greenup <evan_greenup@protonmail.com>
Subject: Add arrow key input support in dash
Message-ID: <vadcxaUwudHIw3-PqrvheMiaoXWZYFKJGs8m26VdcbsmFS6qf2-SqWD3SEvRI1RymevQyewkWL6ktfnjxnT006fzGl7nREa4mErOSEKgv6c=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Although dash is lite and simplified edition of bash, It doesn't support ar=
row key to move the cursor position.

In order to improve performance, a lot of feature in bash are removed in da=
sh.

Add arrow key support will not cost too much performance.

Currently it dash is like that:

```sh
$ echo hello
hello
$ echo ^[[D^[[D^[[D^[[D^[[C^[[C^[[C^[[C^[[A^[[A^[[A^[[A^[[A^[[B^[[B^[[B^[[B=
^[[B

$ ^[[D^[[A^[[C^[[B^[[D^[[A^[[C^[[B^[[D^[[A^[[C^[[B

```

The cursor won't move but only append unexpected character.
