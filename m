Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48427C433E0
	for <linux-dash@archiver.kernel.org>; Fri, 29 Jan 2021 22:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E215964DF1
	for <linux-dash@archiver.kernel.org>; Fri, 29 Jan 2021 22:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbhA2WZx (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 29 Jan 2021 17:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhA2WZw (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 29 Jan 2021 17:25:52 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705A8C061573
        for <dash@vger.kernel.org>; Fri, 29 Jan 2021 14:25:12 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id s7so7339224wru.5
        for <dash@vger.kernel.org>; Fri, 29 Jan 2021 14:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=KK8hbig8/J/zywlhAKqJ/FHyLyoYS/DgjdFnt+simoY=;
        b=acIM81Ate7NKos2PmJeMEuC2/gNlwMvd+HZcg0zrOA8ZXO9IOFlwmOmQ2H1+mDHIJT
         iZ0oY5R4mES77v/0A926I1nEiVwAEXJFTADOiImGagx0E6AFML8abk5DKmq9nxmQIL3y
         PeQPotcx9s6TNOl1iP0cXzyafxw4+fKEuyFu9MPFiEYxKYg73tF6TbTWu85bKmbuVbHL
         2L/ZqvdeZPcJ0HoboMtT80xAHlkZ4mQmb1BzBRrSHlXS744mYGKRaQ4nDXgMnRhQ/5qt
         MMY9neV2eswjY51dr3O21L40QW/8ZiFiYPJmqvBQ6sQ/2Jyg3Nf3bIQfbI5jdQW3NyqI
         G3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=KK8hbig8/J/zywlhAKqJ/FHyLyoYS/DgjdFnt+simoY=;
        b=EvTBzxFCPp6JvK5pOyd3jOk52UYut8elZI0dRsQ9VoY9MnrD0lSNp0D+zCe5bNGDLK
         26FG+XCyEWAQLMkb1J4NLCG9WRXnZ73YAzH+0YfU9fiBHEp+kb2u50C5JekOWypePAJk
         N+H4f6+uJ9Rv1kUSeqYvdcsw1oWQryXEfCbVn5b9Xejuh/WxiY8TBlIGCl/v4FATzO7a
         ZHvBPgjSx2kayYEi9ORGlqQoxWU7Bct8+OVOHeWGloCZMYsQK8yw1POdf02Z1H/VRgTv
         JcALKVxgw3bhOw3UjIeWRsU3COgD4+3HlK6jlLUYAE0X9uZoPR3YacVPI4nPvcha1WOX
         tEDA==
X-Gm-Message-State: AOAM530j8WrcgcC625NuRmyLAqQlja+hDZVEXSBD1LDeo13/41u+KPwS
        8qMm4bv30vK1wUf3DxhYww==
X-Google-Smtp-Source: ABdhPJwafeGm7O1vifr4tCHLA+AWUX15806sdg/qoEWnldyfyJgZs4ZwO0JeYcbFCcVH40L/UEbSPw==
X-Received: by 2002:a5d:4f86:: with SMTP id d6mr6905465wru.246.1611959111186;
        Fri, 29 Jan 2021 14:25:11 -0800 (PST)
Received: from teapot ([78.143.195.205])
        by smtp.gmail.com with ESMTPSA id f4sm14452914wrs.34.2021.01.29.14.25.09
        for <dash@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 14:25:10 -0800 (PST)
From:   earnestly <zibeon@googlemail.com>
X-Google-Original-From: earnestly <zibeon@gmail.com>
Date:   Fri, 29 Jan 2021 22:25:09 +0000
To:     dash@vger.kernel.org
Subject: Re: getopts appears to not be shifting $@ when consuming options
Message-ID: <YBSLRXjBSbNmOHP2@teapot>
Mail-Followup-To: earnestly <zibeon@gmail.com>, dash@vger.kernel.org
References: <YBRTFXGM6pLwR5hg@teapot>
 <20210129203650.GA21262@stack.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129203650.GA21262@stack.nl>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Fri, Jan 29, 2021 at 09:36:50PM +0100, Jilles Tjoelker wrote:
> If your actual code is more like:
> 
> set -- -a foo -a bar # for testing
> while getopts :a: arg; do
> ...
> 
> then the script violates the rule I mentioned, and has unspecified
> results.

This, of course, would be the intended use of such a technique.

Having read the a little more of the standard I may have come up with a
solution which both appears to work and without much ugliness.  I hope
it also doesn't violate either the spirit or word of the standard on this
matter:

    #!/bin/sh --

    while getopts :a: arg; do
        case $arg in
            a) set -- "$@" attr="$OPTARG"; shift "$((OPTIND - 1))"; OPTIND=1
        esac
    done
    shift "$((OPTIND - 1))"

It would be quite sad for me to lose this functionality.

P.S. To my amusement this works with bourne as well but shifting needs
     to be undertaken with `expr "$OPTIND" - 1` instead.
