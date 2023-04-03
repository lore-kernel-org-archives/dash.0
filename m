Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF0AC76196
	for <linux-dash@archiver.kernel.org>; Mon,  3 Apr 2023 12:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjDCMnX (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 3 Apr 2023 08:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjDCMnW (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 3 Apr 2023 08:43:22 -0400
Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73E00658F
        for <dash@vger.kernel.org>; Mon,  3 Apr 2023 05:43:21 -0700 (PDT)
Received: from [192.168.178.37] (uk.gigawatt.nl [51.148.134.205])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id B008F141E;
        Mon,  3 Apr 2023 13:43:20 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl B008F141E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1680525800;
        bh=L2yRCbz+lv5K29CoXWNgEtuxUpMEo0JJcYJCYSe2z6Y=; l=600;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=YPOyRQs8AKaGMauiCuSZljgSpaFE0axbhjLH/e4VBPf3yexcvsERTsgm061sSL9W9
         CH/5ZNYv7zBjYDjkFLhkZmCN2EaM5XtRmvxU2f41WyzzAscmKOHCHX1TFvhkD1O6B1
         sIIMvyruwkXnlPUlUd/qFNxoDJ74bDg6R9J3fii4=
Message-ID: <f663be4b-6e80-f0c4-702f-c58af060ac75@gigawatt.nl>
Date:   Mon, 3 Apr 2023 13:43:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:110.0) Gecko/20100101
 Thunderbird/110.0
Subject: Re: BUG in chkmail() - incorrect check for padvance() stop condition
Content-Language: en-US
To:     Denys Vlasenko <dvlasenk@redhat.com>, dash@vger.kernel.org
References: <0c8f5c54-f0fe-6e58-4359-3110c6c7469b@redhat.com>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <0c8f5c54-f0fe-6e58-4359-3110c6c7469b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 03/04/2023 13:39, Denys Vlasenko wrote:
> chkmail(void)
> {
>          ...
>          for (mtp = mailtime; mtp < mailtime + MAXMBOXES; mtp++) {
>                  int len;
> 
>                  len = padvance_magic(&mpath, nullstr, 2);
>                  if (!len)  <================================== WRONG, 
> should be "len < 0"

You are correct. A patch for this has been submitted, 
<https://patchwork.kernel.org/project/dash/patch/20211002203732.6175-1-june@causal.agency/>, 
but is still pending.

Cheers,
Harald van Dijk
