Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04551C46467
	for <linux-dash@archiver.kernel.org>; Sun,  8 Jan 2023 00:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjAHAff (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 7 Jan 2023 19:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjAHAfe (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 7 Jan 2023 19:35:34 -0500
X-Greylist: delayed 87 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 07 Jan 2023 16:35:32 PST
Received: from immediate-pryderi.relay-egress.a.mail.umich.edu (relay-egress-host.us-east-2.a.mail.umich.edu [18.216.144.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A636D3B907
        for <dash@vger.kernel.org>; Sat,  7 Jan 2023 16:35:32 -0800 (PST)
Received: from agile-kitsune.authn-relay.a.mail.umich.edu (ip-10-0-74-26.us-east-2.compute.internal [10.0.74.26])
        by immediate-pryderi.relay-egress.a.mail.umich.edu with ESMTPS
        id 63BA0F7C.1BBC2C87.328AE92D.1249519;
        Sat, 07 Jan 2023 19:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umich.edu;
        s=relay-2018-08-29; t=1673138044;
        bh=EcckI+rI1LANBRTK+696GnWpYhmLlyZ8YbXgTXYVM2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CXGxncZz36w2PgLx6Mb7J0Q7I1lTwTD4t8Daopm0Gorgj98Ooj3CU7B55KKa4NNL0
         IGgl3yRele9qK+Z3AIsOlH7IfkI53daNvfx7BIIuDrCa2R0hG+nBmmASm6T5D+G0rV
         o+IcJEvj0D8MvhcJjeZevl9l8soCXFDt3TOrj+obQLAGqwD2dFEXPfm1Olmq8liXpA
         BF40Twb9qON8vf6xNHQpdHhiggY8TK/AQcrf2sQ6FpYkapXECUBxQ1qf4WekDug99q
         IFUAvzhgyTy2OnK+Y8f/O96ISHn2vdskpD4DDtccLtM1aKeuj5Ke2qjxm7Dc1EFsEY
         Jw9mXmRQM7QpQ==
Authentication-Results: agile-kitsune.authn-relay.a.mail.umich.edu; 
        iprev=pass policy.iprev=68.55.98.1 (c-68-55-98-1.hsd1.mi.comcast.net);
        auth=pass smtp.auth=tmgross
Received: from localhost.localdomain (c-68-55-98-1.hsd1.mi.comcast.net [68.55.98.1])
        by agile-kitsune.authn-relay.a.mail.umich.edu with ESMTPSA
        id 63BA0F7B.341A787E.3B432116.1643068;
        Sat, 07 Jan 2023 19:34:03 -0500
From:   Trevor Gross <tmgross@umich.edu>
To:     chris@chrisn.me.uk
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH] jobs: Implement pipefail option
Date:   Sat,  7 Jan 2023 19:34:02 -0500
Message-Id: <20230108003402.73287-1-tmgross@umich.edu>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20220422211013.18195-1-chris@chrisn.me.uk>
References: <20220422211013.18195-1-chris@chrisn.me.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Would it be possible for a maintainer to review this patch? POSIX 2022 must be
nearing release (or already released?) and this option is one of the more
notable additions. Dash is about the only major shell that does not yet support
pipefail [1].

[1] https://unix.stackexchange.com/questions/654885/who-is-responsible-for-providing-set-o-pipefail/654932#654932
