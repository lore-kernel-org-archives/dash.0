Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862E3C76196
	for <linux-dash@archiver.kernel.org>; Mon,  3 Apr 2023 09:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjDCJnX (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 3 Apr 2023 05:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjDCJmy (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 3 Apr 2023 05:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42496C179
        for <dash@vger.kernel.org>; Mon,  3 Apr 2023 02:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680514921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=93sLoA12+YuwHqdD6cyUxhhgP+ROwhifoGjThvQI3zs=;
        b=V4zsqURuX1TEMahqxRhZf0ATLj7T5dlfbjYfCg1uQ2B1OgDOPnTiC/gDRBIqgOpKRZLds6
        4dh22wvAjYRQ+bvCQStOPEyaVAuINLGthazblFHt2jb9vz6q+L3mCkbGuhDrKih8t8STda
        gzKPnxEk2rD92zYfaaXtFSZax+W6Enc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-5AZI37lFM6mdHTROp95jFg-1; Mon, 03 Apr 2023 05:35:50 -0400
X-MC-Unique: 5AZI37lFM6mdHTROp95jFg-1
Received: by mail-ed1-f69.google.com with SMTP id i42-20020a0564020f2a00b004fd23c238beso40227738eda.0
        for <dash@vger.kernel.org>; Mon, 03 Apr 2023 02:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680514549;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=93sLoA12+YuwHqdD6cyUxhhgP+ROwhifoGjThvQI3zs=;
        b=IU15R2s2DNmX0AL5atNIo8w0YQWyjes0+aaYR59RyjsmLvP+Ru1SdRyTw2cxpaeWoF
         XGJkZK9IH5qGZlJ3sWIfVvOUxWfMzjqdM+9RKEUjQ5SaLowHpK/y+/gWMb/6sfdlsJmD
         tvmwRQ0CquhwkKA0Ec/N00s4neXKt3xIm9S8K3dzcFBrzzCI1mbQ84T7JZU7warxd7NU
         tI8pRHDW9zvtKagIB+R/+hkwQsnHlVj7qG/47JaP93J92/wirCBOR8QCFs1tvwP7I0Cx
         LOVV9rSD//jnsYAW1b9OVAdmJLjeSperfyCRMhVe/v229m4W1bwntYI7qkLLNHvCEb0A
         mt+w==
X-Gm-Message-State: AAQBX9duHfX5u8/99Tfinq6/oRgJp7f45So03MTUoQD97ZgzsNbfLvK+
        PBxmyCFOrsYf8OALiUYtrfOggR4GZ/0AtmSnSuNTiDznyGgObGxiH3V9bIrEkGpsLPx2n4jT0v1
        adQflGX3cWpE3csZEzNNa9vFQt/UmEfcJqiaeN8wl0MhKzcIoIWlFqw82UGAfF/QAI6QZXRGkeQ
        ==
X-Received: by 2002:a17:907:75f2:b0:88a:1ea9:a5ea with SMTP id jz18-20020a17090775f200b0088a1ea9a5eamr31867192ejc.65.1680514549373;
        Mon, 03 Apr 2023 02:35:49 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y1HYt7yaFiSAoL9KPkyFLik2mnK3EFZylmX51ob4GZG1yZi3s5BBNQ69LXdCHu0oSgMF/bBw==
X-Received: by 2002:a17:907:75f2:b0:88a:1ea9:a5ea with SMTP id jz18-20020a17090775f200b0088a1ea9a5eamr31867177ejc.65.1680514549031;
        Mon, 03 Apr 2023 02:35:49 -0700 (PDT)
Received: from [10.43.17.4] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id oz16-20020a170906cd1000b008b17de9d1f2sm4404896ejb.15.2023.04.03.02.35.48
        for <dash@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 02:35:48 -0700 (PDT)
Message-ID: <d92f3379-6d24-e4a9-035b-e928c13760c6@redhat.com>
Date:   Mon, 3 Apr 2023 11:35:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Are there users of ash's "pathopts"? Do other shells have such a
 thing?
Content-Language: en-US
From:   Denys Vlasenko <dvlasenk@redhat.com>
To:     dash@vger.kernel.org
References: <aad32205-1e0a-fea6-0825-8eb45c6ae915@redhat.com>
In-Reply-To: <aad32205-1e0a-fea6-0825-8eb45c6ae915@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 4/1/23 20:46, Denys Vlasenko wrote:
> ash allows PATH to contain "%builtin" and "DIR%func"
> pseudo-directories.
> 
> %builtin shows in what order builtins to be found
> relative to searching directories for external commands.
> 
> DIR%func allows to have a directory of "auto-loadable" functions.
> (dash git tree seems to have an example of it as src/funcs/*).


On a related note, chkmail() used to iterate over MAILPATH
using padvance(), the function which detects "pathopts".

In commit a068bf7aa310e8d36ae11c2aec47af1446a18827
"exec: Stricter pathopt parsing"
padvance() was modified, and old behavior
is retained in the form padvance_magic(..., 2),
which treats any %text as pathopt (not only %builtin and %func).

chkmail() now uses padvance_magic(..., 2) call,
presumably as exact 1:1 equivalent of old code.

But it's not necessary, right? chkmail() does not actually uses
pathopts. It can just call padvance_magic(..., 0)
so as to ignore them.

If so, then code for padvance_magic(..., 2) is unused
and can be removed. Only "magic" values of 0 and 1 will be in use.

