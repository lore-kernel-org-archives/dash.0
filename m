Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBDACDB482
	for <linux-dash@archiver.kernel.org>; Wed, 18 Oct 2023 19:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjJRTIT (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 18 Oct 2023 15:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjJRTIR (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 18 Oct 2023 15:08:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A4D109
        for <dash@vger.kernel.org>; Wed, 18 Oct 2023 12:08:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F61C433C8;
        Wed, 18 Oct 2023 19:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697656095;
        bh=ZiBfzE6+qQPI57w+HRXmYofYgojcwSrAzgVoexEQlWY=;
        h=Date:From:To:Subject:From;
        b=AiJT7GupIDktCS5DLDNooOsu6GmlHUDANmiUFWxb+rcdTY2rJh1xkDRCwb2G2zEHD
         G6YwwljU37JGdgVzak9NMDDGe52D1lnlEj12CCmRzBhzqrM0r1m8Y73VqFEN6lOcGi
         usYh9bZBMtB5w0Azer7WjO+KMSJPTbwBiqjdL/jo=
Date:   Wed, 18 Oct 2023 15:08:14 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     dash@vger.kernel.org
Subject: Migrating the dash list to new vger infrastructure
Message-ID: <20231018-overstate-hubcap-edee89@meerkat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Good day!

I'd like to migrate the dash@vger.kernel.org list to the new infrastructure.
We're still doing it list-by-list to make sure that we don't run into scaling
issues with the new infra.

The process should be fully transparent and without downtime, so can be done
at any time if you give the go-ahead.

Best wishes,
-K
