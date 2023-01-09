Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF10FC678DF
	for <linux-dash@archiver.kernel.org>; Mon,  9 Jan 2023 15:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjAIPTF (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 9 Jan 2023 10:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237223AbjAIPSJ (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 9 Jan 2023 10:18:09 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0192625
        for <dash@vger.kernel.org>; Mon,  9 Jan 2023 07:18:07 -0800 (PST)
Received: (Authenticated sender: ganael.laplanche@martymac.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 7F6E4240003
        for <dash@vger.kernel.org>; Mon,  9 Jan 2023 15:18:06 +0000 (UTC)
From:   Ganael Laplanche <ganael.laplanche@martymac.org>
To:     dash@vger.kernel.org
Subject: Monitor mode handling (bug ?)
Date:   Mon, 09 Jan 2023 16:18:02 +0100
Message-ID: <7091680.J8PY2HnTC3@home.martymac.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hello,

Digging into a problem with a project of mine [1], I found dash (0.5.12) 
behaves differently from other POSIX-compliant shells when dealing with 
monitor mode when running in the background.

In the following example, dash immediately sends a SIGTTIN signal that stops 
the process group:

$ cat test.sh
set -m
$ dash test.sh &
[1]  + suspended (tty input)  dash test.sh

while other shells do not:

$ bash test.sh &
[1]  + done       bash test.sh
$ sh test.sh & # (/bin/sh from FreeBSD 13.1-RELEASE)
[1]  + done       sh test.sh
$ ksh93 test.sh &
[1]  + done       ksh93 test.sh

Is that an intended behaviour ?

Also, the following test leads to dash looping indefinitely and eating 100% 
CPU:

$ cat test2.sh
trap '' 21
set -m
$ dash test2.sh &

It remains stuck within the following loop:

https://git.kernel.org/pub/scm/utils/dash/dash.git/tree/src/jobs.c?
h=v0.5.12#n208

Weird... Is that a dash bug or am I missing something?

Best regards,

Ganael.

[1] See https://github.com/martymac/fpart/issues/43 for more context

-- 
Ganael LAPLANCHE <ganael.laplanche@martymac.org>
http://www.martymac.org | http://contribs.martymac.org
FreeBSD: martymac <martymac@FreeBSD.org>, http://www.FreeBSD.org


