Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDB4C76196
	for <linux-dash@archiver.kernel.org>; Mon,  3 Apr 2023 11:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjDCLzT (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 3 Apr 2023 07:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjDCLzS (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 3 Apr 2023 07:55:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9494D7A9F
        for <dash@vger.kernel.org>; Mon,  3 Apr 2023 04:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680522870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xeLHv8c1vnAMod/n6+K9pCFNao0igkTaucjrfvfJX5o=;
        b=i+wUZCXN5oHeAZSR16g06KEfoWJO9XLWrrSlCCYy9sll/fYpgOyySXxMf7QtiSaSI7X14b
        uwhVCGMJsfTojqbpKj6dAYDeZTi6FEcNvqg4CVs5mOoczkvOKK7rCyyRU3IOkqg0VtV3SG
        y0wfBTV2ozgVaMOndtObWdtSJyWLugo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-402-gOXdvmfTNIiy8wlbCefPoQ-1; Mon, 03 Apr 2023 07:54:29 -0400
X-MC-Unique: gOXdvmfTNIiy8wlbCefPoQ-1
Received: by mail-ed1-f72.google.com with SMTP id t26-20020a50d71a000000b005003c5087caso40454607edi.1
        for <dash@vger.kernel.org>; Mon, 03 Apr 2023 04:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680522868;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xeLHv8c1vnAMod/n6+K9pCFNao0igkTaucjrfvfJX5o=;
        b=1au3XXipClaJcElrfYtBsfZ14K9aXvQNIrsjii23nUtX5yu7DbnjyDC2Ec2OWJv3pE
         z4w/O68ZwJSelXX5IFKKKa7NSRvYKuzibuQNrpHhRTuoCKIWng66p+QKJ33LaiY6G9gs
         iBLZkbjPoXMF0KTVOD5aXfH3AMf3rmG5+VgFMczeABsQzi3E3YO5rNxN8A+zOuqKV9pR
         uT5Vzo8Ty4+Cng2QEIevxUWYQJaNJbYpYf0Ya+Mi01pEOwC3ox6yJl5gVy4sBq0lpAos
         Nbimw/9310+haiCBP8CQ43STQ7PDGUOc5xstnqRQmToCEZ0mjzKK39y3/gu+7dDQxJBL
         hT0g==
X-Gm-Message-State: AAQBX9d7220AeZqCZPD6F2YAvUWQR9GFgZALwNKQETA8Vb7/FN3S2rav
        zx6u3ePXy3HW/ra2sOoO4DGMPT3niqthbnlzB6/VTjfBVpQjBra5MXw+5bB1FRq4DuDs/RJbx0C
        Jp3t9O2Cl8o2Zb0UKNwBuaA==
X-Received: by 2002:a17:907:7244:b0:947:92c9:6aa4 with SMTP id ds4-20020a170907724400b0094792c96aa4mr14425158ejc.4.1680522868045;
        Mon, 03 Apr 2023 04:54:28 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZSP94/IElBTFQ/J5pRw1zkfDsbagoYqgaswMyw9MUW/AWJKrk0slTOVE7XXWQyAPPV+03JQw==
X-Received: by 2002:a17:907:7244:b0:947:92c9:6aa4 with SMTP id ds4-20020a170907724400b0094792c96aa4mr14425140ejc.4.1680522867761;
        Mon, 03 Apr 2023 04:54:27 -0700 (PDT)
Received: from [10.43.17.4] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id um4-20020a170906cf8400b00928e0ea53e5sm4442187ejb.84.2023.04.03.04.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 04:54:27 -0700 (PDT)
Message-ID: <75dffdbc-d554-696e-0f6c-cb2d24dc80a6@redhat.com>
Date:   Mon, 3 Apr 2023 13:54:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Are there users of ash's "pathopts"? Do other shells have such a
 thing?
Content-Language: en-US
To:     Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org
References: <aad32205-1e0a-fea6-0825-8eb45c6ae915@redhat.com>
 <d92f3379-6d24-e4a9-035b-e928c13760c6@redhat.com>
 <3d9dd3d5-b8ae-3cf8-1e81-ef46cf9cf95a@gigawatt.nl>
From:   Denys Vlasenko <dvlasenk@redhat.com>
In-Reply-To: <3d9dd3d5-b8ae-3cf8-1e81-ef46cf9cf95a@gigawatt.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 4/3/23 13:35, Harald van Dijk wrote:
> On 03/04/2023 10:35, Denys Vlasenko wrote:
>> But it's not necessary, right? chkmail() does not actually uses
>> pathopts. It can just call padvance_magic(..., 0)
>> so as to ignore them.
> 
> chkmail() does use pathopt. It is used to customise the message that gets printed:
> 
>          if (!changed && statb.st_mtime != *mtp) {
>              outfmt(
>                  &errout, snlfmt,
>                  pathopt ? pathopt : "you have mail"
>              );
>          }

I missed this. Thank you.

