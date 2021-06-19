Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A96C49361
	for <linux-dash@archiver.kernel.org>; Sat, 19 Jun 2021 12:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BA0061284
	for <linux-dash@archiver.kernel.org>; Sat, 19 Jun 2021 12:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbhFSMrJ (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 19 Jun 2021 08:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbhFSMrJ (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 19 Jun 2021 08:47:09 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BA9C061574
        for <dash@vger.kernel.org>; Sat, 19 Jun 2021 05:44:57 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x16so9898063pfa.13
        for <dash@vger.kernel.org>; Sat, 19 Jun 2021 05:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=EZRZDHPjfjGcaw7Lvdj7s1Qx1nk7LyTlZyk9XUn+vWM=;
        b=OTMS1Pr9I6F51W0HMuJXaQo7Vhv6mm/W2nILL19TjkieAjb4k83miNljWnJ5xenSoU
         s6Dc9PHc2XqkvaInDT6CUP/299qtExmAWHP2P44Df2lvN1nRBqt+L7HUvPTNOYCcq0ZB
         zzSceU3a47syQTeaiE7zCENnF5C+3syUQwlvq946V1PgFs4dRvo3lP7+/wgz/PQDRTVL
         NVzrOvUNID6iWojIpA6b31VWJIVL2KrOrEv737A0fcUjpLkKztxe2yKtLLy4bi5Adm0n
         ZvGLQf4+vLu4j4FXY1b6NIC0Fxqs/1/BslfiGCqvC73q62tabt5RFX+2omJ4sdt4W13o
         trJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=EZRZDHPjfjGcaw7Lvdj7s1Qx1nk7LyTlZyk9XUn+vWM=;
        b=B8cukLPOgW9kzbCFegJX9uOdwByE7UTWtaQssRSS4io69K82YImHu25Wbv39lGHzBH
         Rkl/XUuzA16NuIUt0OWOQdHLhiy/8PQCMAo9Cb3kamgO/KpzoR8aTYwjvbQ3cTLcRkst
         nn+Ikrt2+Zm2pzXK1R17u12Qbu9lSZZJW2+BdHfru+ozGTdqdh6nJGH0pQCZjsR44T59
         X8Pd89TQG0FHBT5AjuDNpzM6HdvPuLhAPMreyVMpHLm63dT2j8IzTpr8f4/XXJ2tDioo
         m2fzuUwUPlokMwZuzqOKPPtINqNyhH3FwP7IQfYr+t9cSCqW9Y7UioZEVrbukT1sMbfT
         zOBQ==
X-Gm-Message-State: AOAM530JGJ1iaLyi7EvPc+vLW4y4gynlN+Sw7PZanVvSdzJEzdMw4CZo
        cvdh6SgoalY+dGCeNUYD4KSHrvr3XSac5IF09Wi4ql4gYgI=
X-Google-Smtp-Source: ABdhPJwpjjl4WRICUHMLiyFZMV7e6/8rmDv8u8Vdwy+8DGvl23Rh9fxVCpU1tL9juchXr+PZr7JsxQcicr9Rzu9zzTk=
X-Received: by 2002:a62:ea1a:0:b029:2ec:9146:30be with SMTP id
 t26-20020a62ea1a0000b02902ec914630bemr9971540pfh.29.1624106697493; Sat, 19
 Jun 2021 05:44:57 -0700 (PDT)
MIME-Version: 1.0
From:   Denys Vlasenko <vda.linux@googlemail.com>
Date:   Sat, 19 Jun 2021 14:44:46 +0200
Message-ID: <CAK1hOcNX1K_o0E7eFDAD2FYE8WCTpj1hUfzyvQstEQ5S=6onHg@mail.gmail.com>
Subject: SEGV parsing of ${#1\x82} and ${#1\x84}
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        DASH shell mailing list <dash@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hi,

CTLVAR and CTLBACKQ are not properly handled if encountered
inside {$#...}. Testcase:

dash -c "`printf 'echo ${#1\x82}'`" 00 111 222

It should execute "echo ${#1 <byte 0x82> }" and thus print "3"
(the length of $1, which is "111").

Instead, it segfaults.

(Ideally, it should fail since "1 <byte 0x82>" is not a valid
variable name, but currently dash accepts e.g. "${#1abc}"
as if it is "${#1}bc". A separate, less serious bug...).
