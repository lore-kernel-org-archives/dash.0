Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E899CC4332F
	for <linux-dash@archiver.kernel.org>; Tue, 22 Nov 2022 14:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiKVOAJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 22 Nov 2022 09:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiKVOAI (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 22 Nov 2022 09:00:08 -0500
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599FA663D3
        for <dash@vger.kernel.org>; Tue, 22 Nov 2022 06:00:02 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 185E72615BA;
        Tue, 22 Nov 2022 13:59:59 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id DE130260FFE;
        Tue, 22 Nov 2022 13:59:57 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1669125598; a=rsa-sha256;
        cv=none;
        b=2aZ4z2a5Z8DMvTl0CMZtoxQpUhtZ2bnnluHtv2nXWc+by9y+XxcSHF2lTOQ8skPf481MIt
        SqQck+qQTzCGmF+jkq69GelEdxqcSRqeYlUz8yqENywoZM63FChmUKXk+QpUNpPilA0t/2
        LEr38RJGh1bOxUjr1Wt4gN15ziYbBbsJOG3QHKO+m7/Xd7t8ceIY2ecAZYG2HJ0j/js+VG
        N4uq7OSTBEyx6oConAB62RccoEdkbV3fvopH7PciAi8VaFZXVffGE74lUbeOPtYtjiloVa
        8qsmx6YuQ2rY5IQoTuE5elvZYietu7dttAmJ1pkyhyYRDJOBSArFcgU9jFtQEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1669125598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NYrhZe1eXpzIy7ggu7A4ZqDlk8T7Zjc8taLEVY4p4gE=;
        b=qf7TQVUO+hQjIoXfoWgeSaj/w14+lVPted6TdP1+b3wXDSCFfUW3oRFv3yv66AVehXTt3C
        GntkHiVYcwjulYsSHmCBfTHBXbonsxXw/bTUhwrCr9u1SP8CfelyDUn7NeIE5c5j2tZX1f
        1FVfZjJI3OENPPnzWhUH7ras3AHj/bYo090r8khHz9jsFp6BLjQMJOSihx9jxrGLjgmc/1
        oQK/EKFYdpcvTnKJzPBkxH23axr/0YNBZbPVm56+iCbOD7eff63MLXTsyCQyFTcUKlenzb
        ZYVrtC7qVs//vesGImJnkokP9tn+1oqTLFrH1RhwXBJ7Cq5S+QYWRhQV4WRiZQ==
ARC-Authentication-Results: i=1;
        rspamd-65567d767-t8fmx;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Zesty-Ruddy: 5401c86373849ace_1669125598531_698926689
X-MC-Loop-Signature: 1669125598531:2528053377
X-MC-Ingress-Time: 1669125598531
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.103.24.54 (trex/6.7.1);
        Tue, 22 Nov 2022 13:59:58 +0000
Received: from p57b04dfc.dip0.t-ipconnect.de ([87.176.77.252]:37998 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1oxToW-0006FJ-MI;
        Tue, 22 Nov 2022 13:59:56 +0000
Message-ID: <a7f286acb171df0b0356895afaecd73185248d2d.camel@scientia.org>
Subject: Re: segfault with invalid shell script
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     dash@vger.kernel.org
Date:   Tue, 22 Nov 2022 14:59:50 +0100
In-Reply-To: <cc8169ff-1d09-9f6f-5208-0404b1a4fdfc@gigawatt.nl>
References: <b2e298215b3d51d8284296484caa138faddaa0e4.camel@scientia.org>
         <6af07303-357f-6274-6c16-df00835c7f6c@gigawatt.nl>
         <b03e330140ee8f8bd963ed7de0abb7cc55028797.camel@scientia.org>
         <cc8169ff-1d09-9f6f-5208-0404b1a4fdfc@gigawatt.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.1-1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Mon, 2022-11-21 at 22:25 +0000, Harald van Dijk wrote:
> > 
> There is a patch tracker, 
> <https://patchwork.kernel.org/project/dash/list/>, but I am not aware
> of 
> a bug tracker.

For now I've also filed it downstream in the Debian bug tracker:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1024635

just that it doesn't get accidentally forgotten until it's fixed.

Thanks,
Chris.
