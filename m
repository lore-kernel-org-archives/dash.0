Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E595C43334
	for <linux-dash@archiver.kernel.org>; Mon, 20 Jun 2022 18:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245357AbiFTS11 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 20 Jun 2022 14:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238810AbiFTS10 (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 20 Jun 2022 14:27:26 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380021DA43
        for <dash@vger.kernel.org>; Mon, 20 Jun 2022 11:27:22 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id v4so14401593oiv.1
        for <dash@vger.kernel.org>; Mon, 20 Jun 2022 11:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ZWdBoaa7PeYKqy0NvoWVKxnrCrdDjr2P6QhMM6n9y9I=;
        b=Y5sTzGMHTYRcG0EJ43OKZDhuC7wWZseb6+wuZK1REYGTj2TAmCvK3MqlgVkBp7IfV3
         DMgvEMEorJJhlXU0drtMzobZg4FKOwbPkoXTsmnV0vZ8ii0PMUdNlsnxiHJyTgRuDCM9
         TeM6EjLIw4mBNMIjOMs6LTUt5TJcJd+JtzscSecUuaLwgLIsd14wnirdK6+MSw3K7Epm
         mzjc+xo17pmc65wCRokZT1Ag2yGXBVLlrZOT63nFgkyYnSZ+goqFc0xLIq1Ok0yJLl7Z
         10ozbUkHppkZHkpqDUfmprAUyyHYx00PBItDnbIqfLO4zRXqp/63Vsfl4h42qBqb5tpR
         BaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ZWdBoaa7PeYKqy0NvoWVKxnrCrdDjr2P6QhMM6n9y9I=;
        b=Pt6JaDzVV83cF7/yvEv1GRBawxmOYfquNb8s0HnSsrj/RQLFxcapK3RdnlZBDP1xsR
         DdABsiXm493/s3eGrZhcN8IrA2rLVM/TYQ5MaPTf7rm1T8oaxz4v1+v0joNTi86nCSTz
         sdpb6eRaRPi6ReDvvAzph6Gx5UUZMVayHy2PFvgPsDNsF3J1De4PMul34hVoqrFdvnCG
         OZ+qCM3Asl5E4Wnii4c7cSWVyIf8JcCr09JDfRmijBaIbUpUgmG4sHZRPsczXqgTnbzt
         mvWjNJcf5MVT+wVy4QGXiL4Yc+TOnsKiMEuoNftem0twzKDHtSsgLW7IFlu7MQJ8LILX
         w2PA==
X-Gm-Message-State: AOAM530jStbauRBRAuw4QTkA105Xyxd2/xREtE4iMwItAL3OAOjWDPtR
        akSqaqtORCsFSuSnm3o54f7eWv/nMrK/E01kZafFNB+HALCuqQ==
X-Google-Smtp-Source: ABdhPJxsvOFv7gRY0/P3Sq/6/e+pKseKcSSIArKJ3gVhe48YIJOq0ius0aUG2LcQgP8yFk55AkLSaS09PpBwzHv7Uoo=
X-Received: by 2002:a05:6808:1182:b0:32d:a9d3:4e0 with SMTP id
 j2-20020a056808118200b0032da9d304e0mr17136093oil.146.1655749640810; Mon, 20
 Jun 2022 11:27:20 -0700 (PDT)
MIME-Version: 1.0
From:   Alex Gorinson <algore3698@gmail.com>
Date:   Mon, 20 Jun 2022 14:27:10 -0400
Message-ID: <CAOKKkHc=bt4p1d4hMzFbQeE14mZJJ7d1REpJ-D_BQD02re1Pdw@mail.gmail.com>
Subject: PATCH] expand: Add ifsfree to expand to fix a logic error that causes
 a buffer over-read
To:     dash@vger.kernel.org, Harald van Dijk <harald@gigawatt.nl>,
        herbert@gondor.apana.org.au
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Due to a logic error in the ifsbreakup function in expand.c if a
heredoc and normal command is run one after the other by means of a
semi-colon, when the second command drops into ifsbreakup the command
will be evaluated with the ifslastp/ifsfirst struct that was set when
the here doc was evaluated. This results in a buffer over-read that
can leak the program's heap, stack, and arena addresses which can be
used to beat ASLR.

Steps to Reproduce:
First bug:
cmd args: ~/exampleDir/example> dash
$ M='AAAAAAAAAAAAAAAAA'    <note: 17 A's>
$ q00(){
$ <<000;echo
$ ${D?$M$M$M$M$M$M}        <note: 6 $M's>
$ 000
$ }
$ q00                      <note: After the q00 is typed in, the leak
should be echo'd out; this works with ash, busybox ash, and dash and
with all option args.>

Patch:
Adding the following to expand.c will fix both bugs in one go.
(Thank you to Harald van Dijk and Michael Greenberg for doing the
heavy lifting for this patch!)
==========================
--- a/src/expand.c
+++ b/src/expand.c
@@ -859,6 +859,7 @@
if (discard)
return -1;

+ifsfree();
sh_error("Bad substitution");
}

@@ -1739,6 +1740,7 @@
} else
msg = umsg;
}
+ifsfree();
sh_error("%.*s: %s%s", end - var - 1, var, msg, tail);
 }
==========================
