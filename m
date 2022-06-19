Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A3FC433EF
	for <linux-dash@archiver.kernel.org>; Sun, 19 Jun 2022 06:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbiFSGDS (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 19 Jun 2022 02:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiFSGDS (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 19 Jun 2022 02:03:18 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F217EE2A
        for <dash@vger.kernel.org>; Sat, 18 Jun 2022 23:03:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q9so10531574wrd.8
        for <dash@vger.kernel.org>; Sat, 18 Jun 2022 23:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Nvbev4fpq1z1AGrWPdzE4LO6lJ0Ou32iZ5oP5XddQYM=;
        b=jtSmXYAx02om2wF/YlLfAzIVqqi/AIRGzHIXvlmOy/UkJTqbqEHNidQNm1Ii1OQkki
         pbNAQ53te7C+ZFyAiM8q4ZXs3qiR0PRspkykxrEK4z/FKvOMDfSTtGXX2DMtKDHtrb1v
         x2zzYcHpfontUt13P9cJbsfIMYPOVK81KWDIamdKJS5yQ0fBa8VOZS3TWGC5y3DpPsE+
         buKvJB38flY34cBS19vJrQmjZRAfaAC5vfDjysmy0Lte4lQVI1Tsb8+xOdsZyfMjdLw7
         YleQh8C3xY/zRVRG2xspFhPCaXl3WXbIu+X0yW5t4VgFJaRU/Vuj09eNoFteaM4jaqep
         46Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Nvbev4fpq1z1AGrWPdzE4LO6lJ0Ou32iZ5oP5XddQYM=;
        b=ebEmglOQ/roqQxolRU+Emgw12LxsgQ6mRGD880iho4UFkvVDy5G/iWwnfy8/dD3W9e
         0IjuhWEst+fla++VelEjQBkBrLaekM2xzFnszvpyGEtmLXZ6DDLsXQRUHt/DoChDJkCR
         j1E2DApIJU10gvEn6j8Fv0XCMoldmbefXVqfOa/yaehO+ObaJ7pPwtiQsnnjZ0VUjGZ8
         yLCN/KTH5E0XcsgDpTkbEVrQ8jtcMP1ANwxmVswXIh9EWwrUlua9bp1XflWW1ZWrNguG
         1doQs4MQv/DcBEMNRA7ZNnqYB8N7q8uzYt9QtF19EnMXy6WjeM+8X7wyvq8imA8xUgZ6
         yukA==
X-Gm-Message-State: AJIora/SQo6eSGMS4J3NDEntfytV4qCsQnYYQ/eIVfMW31u2bLGv8KUt
        /Z2+7iT6jR9Xe9Z2wZ3qw4Ze7eXVFODU1wYymGIPscSKXas=
X-Google-Smtp-Source: AGRyM1v1jtMNzydxiQb0eTRKBQt4avPu+Pbbjhb5HlCtsiQXa9bCRw//4F9wVLPnEE4NbNlxZSC7QFw8YqzI/wvbaN8=
X-Received: by 2002:a5d:6d48:0:b0:21a:3b82:b751 with SMTP id
 k8-20020a5d6d48000000b0021a3b82b751mr12406094wri.125.1655618595376; Sat, 18
 Jun 2022 23:03:15 -0700 (PDT)
MIME-Version: 1.0
From:   Akbarkhon Variskhanov <akbarkhon.variskhanov@gmail.com>
Date:   Sun, 19 Jun 2022 11:03:03 +0500
Message-ID: <CANeoM1H9YAPv4y1QLF-bt3j74BmJpxSrH7SwU=EdOOVFvqq56Q@mail.gmail.com>
Subject: COPYING: Copyright information mentions bash
To:     dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Quoting the relevant paragraphs:

This file is part of GNU Bash, the Bourne Again SHell.

Bash is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free
Software Foundation; either version 2, or (at your option) any later
version.

Bash is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
for more details.
