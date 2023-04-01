Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D072C6FD1D
	for <linux-dash@archiver.kernel.org>; Sat,  1 Apr 2023 18:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjDASrH (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 1 Apr 2023 14:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDASrG (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 1 Apr 2023 14:47:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3057694
        for <dash@vger.kernel.org>; Sat,  1 Apr 2023 11:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680374782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7KL4auAq0r4cvRu/M7tmaND1jCrCzgpfxSNdAztRvzE=;
        b=NjJibjXk12u2iguHfClOEEFnzsM+y5cGIhp8Wtooyi1dv8vBUrrep2IbYVWmg2tc8axF15
        0Bt8vKYA57mQwFGOpvoYvfaGbP08jgfUcYPcpNiCqZKugKRcf+7QFWqzvpOHvEoB1bfKyr
        rKlt/T+nsOipiUM4/9fK2VGuxiAPjD8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-7tKK4fYaMuiYBlCpAvcoDw-1; Sat, 01 Apr 2023 14:46:21 -0400
X-MC-Unique: 7tKK4fYaMuiYBlCpAvcoDw-1
Received: by mail-ed1-f70.google.com with SMTP id f15-20020a50a6cf000000b0050050d2326aso35562062edc.18
        for <dash@vger.kernel.org>; Sat, 01 Apr 2023 11:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680374780;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7KL4auAq0r4cvRu/M7tmaND1jCrCzgpfxSNdAztRvzE=;
        b=MyWQN5LJNJ0BXKRVs7hGNfp1Yg1sVpWmilQMzqzCAcwJmyOhdeOeaMBXQftRiz2xmo
         ghi/4z07pgSUgPc+sZ3cR/wvqivJLLWmxQKLIZkEOSv7f7NUFGgnb7q+/ldFyl563ra0
         z4OSH7n1QRiQL4qhpWALCdA8phLH/3tHAEigwQfmjFV0fui5BJz+nfPOZRV7sLYtx2QR
         uWb2m+XFW0dNaMY5u+k9h44x8EBaStxJ9ZCCdZkq8FwFtuUsdq0KtvL0rU25y86sNCmO
         EyzJuDsIH9JLvYbPXVOn0QpX5xYNnIWaj28fhfVr0pWb4aeSoTVsTNzjrtsfaei+FfK1
         v/sA==
X-Gm-Message-State: AAQBX9fRP/IsWq1jQEqRz0qUhA0G1qt844hUqgYVfXM25WpwHOT5y0Dr
        US3BE+cBfh7RVeDbb5vDE23/sHPaxEvYsLOrOu2f53KuUx/jaX/wvejzkejHfck4/7YPqmSCeCe
        PgflHS+5RjgEMB5Qokfv/qos0XfvDkFASgIxPqLT0WkxaxDZ24CxNlguNCb1WEUVOiBX+5HskSQ
        ==
X-Received: by 2002:a05:6402:1842:b0:4fd:21a6:a649 with SMTP id v2-20020a056402184200b004fd21a6a649mr25420685edy.40.1680374780029;
        Sat, 01 Apr 2023 11:46:20 -0700 (PDT)
X-Google-Smtp-Source: AKy350aOiZW7K+VQZTY6+PtrWRks/DWWUnkeuIONkqXJA8C/1tYdjs+Dha9jUAPuDsOaeKdsxtcXXA==
X-Received: by 2002:a05:6402:1842:b0:4fd:21a6:a649 with SMTP id v2-20020a056402184200b004fd21a6a649mr25420676edy.40.1680374779644;
        Sat, 01 Apr 2023 11:46:19 -0700 (PDT)
Received: from [192.168.1.220] ([78.157.137.28])
        by smtp.gmail.com with ESMTPSA id cw23-20020a056402229700b005028e87068fsm1055521edb.73.2023.04.01.11.46.18
        for <dash@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 11:46:19 -0700 (PDT)
Message-ID: <aad32205-1e0a-fea6-0825-8eb45c6ae915@redhat.com>
Date:   Sat, 1 Apr 2023 20:46:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
To:     dash@vger.kernel.org
Content-Language: en-US
From:   Denys Vlasenko <dvlasenk@redhat.com>
Subject: Are there users of ash's "pathopts"? Do other shells have such a
 thing?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

ash allows PATH to contain "%builtin" and "DIR%func"
pseudo-directories.

%builtin shows in what order builtins to be found
relative to searching directories for external commands.

DIR%func allows to have a directory of "auto-loadable" functions.
(dash git tree seems to have an example of it as src/funcs/*).

I tried a few searches on the internet and this feature
seems to be almost entirely not documented. I found exactly one
manpage documenting it:

https://www.unix.com/man-page/minix/1/ash/

     Path Search

        When locating a command, the shell first looks to see if it has a shell function by that name.  Then, if PATH does not contain an entry for
        "%builtin", it looks for a builtin command by that name.  Finally, it searches each entry in PATH in turn for the command.

        The value of the PATH variable should be a series of entries separated by colons.  Each entry consists of a directory name, or a  directory
        name followed by a flag beginning with a percent sign.  The current directory should be indicated by an empty directory name.

        If  no  percent	sign  is  present,  then  the entry causes the shell to search for the command in the specified directory.  If the flag is
        ``%builtin'' then the list of shell builtin commands is searched.  If the flag is ``%func'' then the directory is searched for a file which
        is read as input to the shell.  This file should define a function whose name is the name of the command being searched for.

Here is an example of a user having a problem because he has a PATH with
directory containing "GNU%2fLinux" string in its name:

https://unix.stackexchange.com/questions/126955/percent-in-path-environment-variable

So... maybe we can drop it?

I assume it's rarely (never?) used in the wild.
It interferes with valid directories with percents in names.
It's non-standard, and not a typical feature of other Bourne-like shells
   (maybe we (ash family) are the only ones?)
Code complication to support it is a chore.

