Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CC9C001DF
	for <linux-dash@archiver.kernel.org>; Fri,  4 Aug 2023 16:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjHDQNp (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 4 Aug 2023 12:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjHDQNo (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 4 Aug 2023 12:13:44 -0400
X-Greylist: delayed 486 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Aug 2023 09:13:43 PDT
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3558B2
        for <dash@vger.kernel.org>; Fri,  4 Aug 2023 09:13:43 -0700 (PDT)
Received: from [10.10.3.121] (unknown [10.10.3.121])
        by mail.ispras.ru (Postfix) with ESMTPS id 05EE440737A6;
        Fri,  4 Aug 2023 16:05:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 05EE440737A6
Date:   Fri, 4 Aug 2023 19:05:35 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     dash@vger.kernel.org
cc:     Vladislav Ivanishin <vlad@ispras.ru>
Subject: bug with --enable-glob
Message-ID: <1a62e3dc-039b-36ae-c314-5f9a93f65841@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hello,

We found a bug where latest dash (v0.5.12) behaves incorrectly
when built with --enable-glob.

To reproduce:

	touch 'echo a'
	dash -c 'trap "echo a/" 0'

This prints

	a

instead of the correct

	a/


We noticed this because it results in contents of giant trap handlers
from configure scripts passed to glob and eventually to syscalls.

Thanks.
Alexander
