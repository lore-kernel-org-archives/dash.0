Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4A8C3DA7D
	for <linux-dash@archiver.kernel.org>; Tue,  3 Jan 2023 11:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjACLzB (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 3 Jan 2023 06:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjACLzA (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 3 Jan 2023 06:55:00 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A55DD2E0
        for <dash@vger.kernel.org>; Tue,  3 Jan 2023 03:54:59 -0800 (PST)
Received: from [192.168.178.37] (uk.gigawatt.nl [51.148.134.205])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id C66501214;
        Tue,  3 Jan 2023 11:54:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl C66501214
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1672746898;
        bh=rw43ZldVQ+kblMt6PE14hcB8N/5KCliF7dw4JiJcDbU=; l=322;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O68GxVXIu7l0tuPUEYm8CFywSaya6Kc0ft5d8Lv7qWsRoA9Vg30o4hnndazFc7mlz
         sLTUWRztiGzCQyvZgpvXVlrgdccRI8svpO4PTgyvq9fri0hJ5a6RLfhrzXDOrLunaY
         Hw/t38886lyAN/8EFZ08IPqEqHqMIKBSsYGkBQ8Y=
Message-ID: <9a6c2bc5-11aa-db99-8db5-541060624b01@gigawatt.nl>
Date:   Tue, 3 Jan 2023 11:54:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101
 Thunderbird/109.0
Subject: Re: [v3 PATCH] input: Read standard input byte-wise
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org
References: <Y7PIHqN4ic4UBOBb@gondor.apana.org.au>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <Y7PIHqN4ic4UBOBb@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 03/01/2023 06:15, Herbert Xu wrote:
> Your patch breaks history support since that relies on there
> being a whole line in the input buffer.

Does it? preadbuffer() knows to call history() with the H_APPEND flag to 
append a next chunk of input to what was already added to the buffer.

Cheers,
Harald van Dijk
