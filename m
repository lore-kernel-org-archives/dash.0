Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97055C07E95
	for <linux-dash@archiver.kernel.org>; Fri, 16 Jul 2021 12:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 707CA613EB
	for <linux-dash@archiver.kernel.org>; Fri, 16 Jul 2021 12:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbhGPMt0 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 16 Jul 2021 08:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbhGPMtZ (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 16 Jul 2021 08:49:25 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A40C06175F
        for <dash@vger.kernel.org>; Fri, 16 Jul 2021 05:46:31 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id go30so14955603ejc.8
        for <dash@vger.kernel.org>; Fri, 16 Jul 2021 05:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=86Ks3GZKkAUBpLbz5fNdAj6BFhBmNV3NwAbS/Mv20Pk=;
        b=l6Z1Rnm4XJzKsDIjcUur901Z7Y+sYNWBHIQjfh/IsvzKn67bx3OsHKQdmufYXG8Qcj
         P7bcNnHGDNANeyAGJmDcjeaPwKOIGWij1cRwCdRTn1B4sMLT+D3nizdXQXz2QuhfxIY9
         XEkfQpif+D2+i63qGPmYiyQM3jgidJ7518Kd8mIt+TofLAVKr5aBY66YzRf3tEv/u2W5
         oLcgs0+E+mORXDjUnKMQ9tP75cVGghc9vHYOSwQkY0rM9fvLBDuwVprw44DPa3cls2HX
         sN5AsqtoBV7F3dXJiE724ibFOWoJdIcj0BSxFBueyo+JwQhdvATiSWoRrmb6HxtiOcZu
         b24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=86Ks3GZKkAUBpLbz5fNdAj6BFhBmNV3NwAbS/Mv20Pk=;
        b=nd88S689e+rLrIbmCAddCKdYKU5MkMIs95+TcJrws1bJCTVXEjabjwmajujJr2+7Ab
         ivfF5qdtDyxOZLei6qSYwAL5GS2BYUtB0EPA5iD4L/J9XTkjYPoKmVvw8e60TO9cgTEp
         5SKsGrV1tvdE+2geT3cch1wL2vKNqBEuRWsQNFrNuglo0tMB/PbelMlSSJC+8n0CsEDK
         m5Sys6EdYMUv79CnSx3CPkSRJK6Q5gKV+qEFa2CY92TOaCQdIkZAlmkIn7iKcc6SDutl
         1D56odI9PbshqM11j8hxqjzWPAwkSfjajhHDsXj1y26KJLj4qJxEk2foLOpNGAj22avb
         mcAA==
X-Gm-Message-State: AOAM530zayEoJcSbxXTNEfrkEuVZx10/eOuFa6FJEhqkHM/2socoUQRe
        hAJyGbeMhqt7E3Ows5603HI=
X-Google-Smtp-Source: ABdhPJymjbT04wDs1RYc8yYx6DwWm1s6LFvVY374+SOZxCUCYAK8hpK2SZAtXdPgUI0MKa4001Kgpg==
X-Received: by 2002:a17:907:f98:: with SMTP id kb24mr11440617ejc.554.1626439588765;
        Fri, 16 Jul 2021 05:46:28 -0700 (PDT)
Received: from m553ia.mscalindt.qq ([213.149.150.118])
        by smtp.gmail.com with ESMTPSA id u26sm2846032ejj.4.2021.07.16.05.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 05:46:28 -0700 (PDT)
From:   Dimitar Yurukov <mscalindt@gmail.com>
To:     harald@gigawatt.nl
Cc:     dash@vger.kernel.org, mscalindt@gmail.com
Subject: Re: [PATCH] expand: Recognize '^' as a negation character in BE
Date:   Fri, 16 Jul 2021 15:46:05 +0300
Message-Id: <20210716124605.18722-1-mscalindt@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <0c417093-cc75-7ac6-c2a8-6b46041168c8@gigawatt.nl>
References: <0c417093-cc75-7ac6-c2a8-6b46041168c8@gigawatt.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 16/07/2021 11:00, Harald van Dijk wrote:
> On 16/07/2021 10:42, Dimitar Yurukov wrote:
> > While parsing bracket expression ('[...]'), DASH recognizes only '!' as
> > a special character for negation/inversion, but POSIX specifies '^'.
> > 
> > The POSIX specification (2018 edition) states:
> > 
> >    ^ The <circumflex> shall signify a non-matching list expression when
> >      it occurs first in a list, immediately following a
> >      <left-square-bracket> (see RE Bracket Expression).
> 
> It also states:
> 
>    the <exclamation-mark> character ( '!' ) shall replace the
> <circumflex> character ( '^' ) in its role in a non-matching list in the
> regular expression notation
> 
> and
> 
>    A bracket expression starting with an unquoted <circumflex> character
> produces unspecified results.
> 
> See 2.13.1 Patterns Matching a Single Character.

Oh, my bad, sorry for the noise.

> The patch may still be worthwhile to increase compatibility, but in that
> case the same change also needs to be made to expmeta().

Oops, you are right. Will attach v2.
