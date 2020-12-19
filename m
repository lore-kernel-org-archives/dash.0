Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115B2C4361B
	for <linux-dash@archiver.kernel.org>; Sat, 19 Dec 2020 13:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE4C823B17
	for <linux-dash@archiver.kernel.org>; Sat, 19 Dec 2020 13:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgLSNYh (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 19 Dec 2020 08:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgLSNYg (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 19 Dec 2020 08:24:36 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C87C0617B0
        for <dash@vger.kernel.org>; Sat, 19 Dec 2020 05:23:56 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id j1so2940779pld.3
        for <dash@vger.kernel.org>; Sat, 19 Dec 2020 05:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=wIg+4l6WZMnjf1sqFhr90hcoVKNNDkWHTvGJUEZatBA=;
        b=rnm9bsqIUbavv8qL+LulWC/yBg8LJNdulATmNB41mf5hTm8aWBKzS0XbLTvmyNYMgC
         aZImWc1SPWUiWFwsi9ft3FWyl9JueCaGWi9iqRxEUW+vXd+ZnqoxsOhjbcHnuUJYTiiE
         Vl1HYV7TsLvxjfmZqv6RX5dT4byvQUowU7gzqlIvNjIwu9XKv+ohVLP8x43g0GBdVZoL
         2TLVKrW1jk3cB9rIuoMUBliF6g1av9LWzTJ9N0NDgN6SsHSox85EdAEXT3GcUqY/Fstp
         PG83qvVFp/yo0acXBwTM1oUBGcp4GBVdluqhFsLC0wpsXgD1uFppv4KRySROIGNylN9f
         EpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wIg+4l6WZMnjf1sqFhr90hcoVKNNDkWHTvGJUEZatBA=;
        b=RH1oSZ3eYiPWjdj6Qk9XLQLY+2iCXWk/IwM8/FTuNH5O+2xeOcqAJ9rDe2LZVaB9Vj
         C4NbFhL2ViOlYUCVYy8FTN/z0WPVAEEVtT2F27N0dKVTrvenLo3OxoR/2JVQz26kEm85
         cc3yFy98ziBybvspfBG53xIUj5DHKVigs6lwLg0ronA1OYa8heDrbQcz4CSlNelDYWCM
         CGqYqvvXa/OLu08UzM6rKvO3z8zkqMWP/eQVwZCDjHZ17n7XBdVjozM8ip9cOQv1wuk3
         WjmTz4qx/sDlBkciH6RBw56aIHN1iNTYR/CciCjfintMKVn0NcVxbWO+BIhfwfZDIiI5
         5msg==
X-Gm-Message-State: AOAM532SKSSSFpI+kMAq8/04OJfRAxy3/lX5hMNtVWr1MOmyTyh1u2NX
        AyTg1jkKyQ1nlrnGwjFE6lxk5E+i1JeSu/HiM7o=
X-Google-Smtp-Source: ABdhPJwa5TCAjVUIpnREAqkwwZ5nTo9TMHeDSMmcpBtuRZobjMqoEPIKxvuyb2raAnVCrkM9d3bltTgXn0WM+sbX4eM=
X-Received: by 2002:a17:902:b94a:b029:dc:18f2:8063 with SMTP id
 h10-20020a170902b94ab02900dc18f28063mr8900384pls.8.1608384235408; Sat, 19 Dec
 2020 05:23:55 -0800 (PST)
MIME-Version: 1.0
From:   Denys Vlasenko <vda.linux@googlemail.com>
Date:   Sat, 19 Dec 2020 14:23:44 +0100
Message-ID: <CAK1hOcOsHYf+aJwJCDhunWNcXvWrLwObnviPms_CkspYsL6BcQ@mail.gmail.com>
Subject: ungetc is not cleared on error?
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        DASH shell mailing list <dash@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Current git:

$ ;l
dash: 1: Syntax error: ";" unexpected
$ s
COPYING    ChangeLog.O    Makefile.am  aclocal.m4  autom4te.cache
config.h     config.log     configure       dash
dollar_altvalue1.tests  missing  stamp-h1
ChangeLog  Makefile    Makefile.in  autogen.sh  compile
config.h.in  config.status  configure.ac  depcomp  install-sh
  src      trace
