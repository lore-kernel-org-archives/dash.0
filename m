Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031D8C433EF
	for <linux-dash@archiver.kernel.org>; Fri, 11 Mar 2022 17:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350624AbiCKRQc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 11 Mar 2022 12:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350621AbiCKRQc (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 11 Mar 2022 12:16:32 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81015198EC8
        for <dash@vger.kernel.org>; Fri, 11 Mar 2022 09:15:28 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 48C994C13F0;
        Fri, 11 Mar 2022 17:15:27 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id F22914C165F;
        Fri, 11 Mar 2022 17:15:17 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1647018924; a=rsa-sha256;
        cv=none;
        b=eE1zYmuc+mALTUxS8Yh7WZ1rb3Ay9YyjcPOs9CwBUv/mUJOFc/qVrvJ7SUNHlGJ4TVM/oP
        Vm+DRH49xheMiswnmxVXqbm/n0nb1z/L2jBZDJO7JgP9DXNMGrH7eUYB96X6LCKhpucQyL
        +IqbRTTrzxYEUVWJ1KCE2AyicI7fuTUii5hKw+KHSPX6ZlWEqmGxrOvOS4Deis/BqWaCyh
        OaF0ctXBhPObckwQTZBz9X1lgwciTU82EqLVRC3HNTReFcWvQO/FLStKageI5RtXyrj/P2
        3cxn8FqC59jJKd8m6tom66itfqrhuiSzpA2JoiCYXj1cSVi3w0VIxudQuu1Urg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1647018924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V6MI7QfddyAAv6aWyjMqIuKKUkiJAoHECvL5XVLYOWA=;
        b=MfaluOxMf91Cn5GKkPqjFFE2vvkcMHPkdmaGsA4dpq9toPy/pwBBhW6+aBmOVvX08N+Lb9
        LaV68cozbfZ6dDeAq2J40rhGdKftcy8rlUnO8Ph0gvfzJYuLfcC9i3DPytSvn2d16cLTPF
        1mgwL7jv79Ic+RIgbrGDFgeCNesGl1ERcTf4LpQHhVD7fbIPeJDcw/tc9yvJpaArflzS9W
        /V8lyrg4/7aLZdPFUtsbPxW8DMfEvWyM/k6ny7BPAFJ8KoAiE+zjU7ldHcBWw5LJL8njnA
        OZYQL5fRtqL5FvzoE8DmYiO5xpjJ+lXHancm0s/zUD13XWsrw/L2Jlw79tKkbA==
ARC-Authentication-Results: i=1;
        rspamd-56df6fd94d-m8vhp;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.120.38.157 (trex/6.5.3);
        Fri, 11 Mar 2022 17:15:27 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Spill-Battle: 048c39f943f520d9_1647018927000_1096094303
X-MC-Loop-Signature: 1647018927000:3280099374
X-MC-Ingress-Time: 1647018927000
Received: from ppp-46-244-246-77.dynamic.mnet-online.de ([46.244.246.77]:40586 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1nSirC-0000td-6W; Fri, 11 Mar 2022 17:15:16 +0000
Message-ID: <0e27baca7b331b12b1cc5dbc7764222abfd660ef.camel@scientia.org>
Subject: Re: possible wrong behaviour when -s and -c are both used
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org
Date:   Fri, 11 Mar 2022 18:15:11 +0100
In-Reply-To: <fdfed8d3-d654-74de-67f5-85d21ae4c630@gigawatt.nl>
References: <3574fa7e81a2c56fdb720ea0df259ae3df92c3b2.camel@scientia.org>
         <fdfed8d3-d654-74de-67f5-85d21ae4c630@gigawatt.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.43.3-1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Fri, 2022-03-11 at 10:12 +0000, Harald van Dijk wrote:
> This has -s and -c options. Contrary to your analysis below, as has
> been 
> answered on your Austin Group bug report, this has unspecified 
> behaviour. dash can do whatever it wants here.

Well with respect to that, I'd have also been fine if the standard
clearly says that this is unspecified.


> This only has a -c option. -s appears after 'echo foo', which is a 
> non-option, and is therefore also a non-option.

Stupid me, so obvious... *facepalm*


> The syntax to have both -s and -c options, but have -s appear after -
> c, is
> 
>    dash -c -s 'echo foo' script
> 
> which behaves the same as the -s -c case.

But still (even if POSIX leaves that open)... is this intended
behaviour by dash, that one can use -s and -c and it does actually
both?

It's not directly mentioned in the manpage (i.e. that both can be used
at the same time, and in which order these would then happen).
And the SYNOPSIS in the manpage would also rather imply that it's not
intended:
> SYNOPSIS
>     dash [-aCefnuvxIimqVEbp] [+aCefnuvxIimqVEbp] [-o option_name] [+o option_name] [command_file [argument ...]]
>     dash -c [-aCefnuvxIimqVEbp] [+aCefnuvxIimqVEbp] [-o option_name] [+o option_name] command_string [command_name [argument ...]]
>     dash -s [-aCefnuvxIimqVEbp] [+aCefnuvxIimqVEbp] [-o option_name] [+o option_name] [argument ...]

So I thought maybe it's just working by accident.


Cheers,
Chris.
