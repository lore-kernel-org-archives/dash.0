Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E065C76196
	for <linux-dash@archiver.kernel.org>; Mon,  3 Apr 2023 12:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjDCMkq (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 3 Apr 2023 08:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjDCMkp (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 3 Apr 2023 08:40:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8BF6E8D
        for <dash@vger.kernel.org>; Mon,  3 Apr 2023 05:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680525597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ReoskarKVMVUJ5SjuawN/fxsgl6ZLzGdhMDR6PzhpMk=;
        b=PV4t8rntRONYOVeowd0nhS/+yiAKTg39x1cxdJMXUSdBeNVIGvPS9SMHPwWYlcqR8JOTut
        3CWyVXa5Tp5PMhEJdf8+RSrbVS4Q02D9XDRxLzO2Nu0CNEZPGdFI2jjvK76ezzxxUO4CIK
        WJWq3eqHmqIYVQtgdFPBl8i5ohZ7lHM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-XcuKh2N0Nqec_W1FKnWRKw-1; Mon, 03 Apr 2023 08:39:49 -0400
X-MC-Unique: XcuKh2N0Nqec_W1FKnWRKw-1
Received: by mail-ed1-f70.google.com with SMTP id b6-20020a509f06000000b005029d95390aso4535257edf.2
        for <dash@vger.kernel.org>; Mon, 03 Apr 2023 05:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680525587;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ReoskarKVMVUJ5SjuawN/fxsgl6ZLzGdhMDR6PzhpMk=;
        b=AyeCbPSWq65NJAec6+2qyr6m+idQsH8JHWY74eCIVsiB3f1yGrwuGOJtkspmvn2S6X
         w6g00/GQ7/MC+AtdBU4j4vIhG7PC3rm3qqfJ+LzL8mtZbqAzKn6A2aFOXhgg+uGQvCR7
         4VGpvnRoPMQnoD8wys0UB1B9Pt/XF2hTMglnc9yEatvvqNRPy0VC5G1HIpLqmN5GyYj3
         id57oks/PxOveRJHKXL4m2/hxc8sNUWOJmQlhOWHkyDscfiW9Wi5wVI2TlcFg9i+mQ0m
         hCvYNv0VtZDkMWb7wO9QTwRn+JtfugFwR7fr9gc5YlISxoLVl/EEVZAX9PEFsLmBozaY
         e9vQ==
X-Gm-Message-State: AAQBX9dV0ZMt45M+kK35ya/izFGTFguR0P0O177QhAksdiDfTDUrQh9v
        E3JGWEFqe7DMgJ1LSdTRdDwUHnXY66Z4nnjZurzZ0FNntkPsnx0nCnU9H0xHJNnZKFTyxB7t1nm
        tsLLZYZ/BIeRMrueGFTKsZzpXQeEalayhZUKA1hH8ILitTnnaxD5sWkGKQh4nEa2yO35D5v6OoA
        ==
X-Received: by 2002:a17:907:9a0d:b0:947:55ad:dd00 with SMTP id kr13-20020a1709079a0d00b0094755addd00mr12538431ejc.26.1680525587767;
        Mon, 03 Apr 2023 05:39:47 -0700 (PDT)
X-Google-Smtp-Source: AKy350YMMA9axXjxyvYSutpGez0BRvHCdWEMDdC7LoTrxfOfmThh05/Qe+9vZI+NfFM6AIygerR0AA==
X-Received: by 2002:a17:907:9a0d:b0:947:55ad:dd00 with SMTP id kr13-20020a1709079a0d00b0094755addd00mr12538413ejc.26.1680525587350;
        Mon, 03 Apr 2023 05:39:47 -0700 (PDT)
Received: from [10.43.17.4] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id xd2-20020a170907078200b0094809142160sm3075661ejb.55.2023.04.03.05.39.46
        for <dash@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 05:39:47 -0700 (PDT)
Message-ID: <0c8f5c54-f0fe-6e58-4359-3110c6c7469b@redhat.com>
Date:   Mon, 3 Apr 2023 14:39:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
To:     dash@vger.kernel.org
Content-Language: en-US
From:   Denys Vlasenko <dvlasenk@redhat.com>
Subject: BUG in chkmail() - incorrect check for padvance() stop condition
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

chkmail(void)
{
         ...
         for (mtp = mailtime; mtp < mailtime + MAXMBOXES; mtp++) {
                 int len;

                 len = padvance_magic(&mpath, nullstr, 2);
                 if (!len)  <================================== WRONG, should be "len < 0"
                         break;
                 p = stackblock();
                 if (*p == '\0')
                         continue;
                 for (q = p ; *q ; q++);
                 q[-1] = '\0';
		...

The bug is not noticed only because after MAXMBOXES iterations,
we exit the for() loop:

newfstatat(AT_FDCWD, "/var/spool/mail/user", 0x7ffd08acd420, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/var/spool/mail/use", 0x7ffd08acd420, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/var/spool/mail/us", 0x7ffd08acd420, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/var/spool/mail/u", 0x7ffd08acd420, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/var/spool/mail/", {st_mode=S_IFDIR|0775, st_size=4096, ...}, 0) = 0
newfstatat(AT_FDCWD, "/var/spool/mail", {st_mode=S_IFDIR|0775, st_size=4096, ...}, 0) = 0
newfstatat(AT_FDCWD, "/var/spool/mai", 0x7ffd08acd420, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/var/spool/ma", 0x7ffd08acd420, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/var/spool/m", 0x7ffd08acd420, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/var/spool/", {st_mode=S_IFDIR|0755, st_size=4096, ...}, 0) = 0
write(2, "$ ", 2# )                       = 2
read(0, "", 1)

and no visible problem is seen.

