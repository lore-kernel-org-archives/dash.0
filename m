Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5FEE7C4F1
	for <linux-dash@archiver.kernel.org>; Wed,  4 Oct 2023 20:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjJDUQr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 4 Oct 2023 16:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjJDUQr (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 4 Oct 2023 16:16:47 -0400
Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABB993
        for <dash@vger.kernel.org>; Wed,  4 Oct 2023 13:16:43 -0700 (PDT)
Date:   Wed, 04 Oct 2023 22:16:41 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     "Kuhl, Brian" <brian.kuhl@windriver.com>
Cc:     "dash@vger.kernel.org" <dash@vger.kernel.org>
Subject: Re: Signal names when cross-compiling
Message-ID: <20231004201641._qz4M%steffen@sdaoden.eu>
In-Reply-To: <DM6PR11MB410813D5DE3610ABEB73C6F999CBA@DM6PR11MB4108.namprd11.prod.outlook.com>
References: <19502212.sIn9rWBj0N@earendil>
 <20231004174346.gkjIE%steffen@sdaoden.eu>
 <DM6PR11MB410813D5DE3610ABEB73C6F999CBA@DM6PR11MB4108.namprd11.prod.outlook.com>
User-Agent: s-nail v14.9.24-524-gd5f7c65f62
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Kuhl, Brian wrote in
 <DM6PR11MB410813D5DE3610ABEB73C6F999CBA@DM6PR11MB4108.namprd11.prod.outl\
 ook.com>:
 |When cross compiling you need to break the mksignames compilation apart \
 |from the rule that runs it.
 |You run it against you sysroot for your target arch/platform and it \
 |grabs the correct signals from the sysroot instead of the host.

Hä?

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
