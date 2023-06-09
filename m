Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC08CC7EE25
	for <linux-dash@archiver.kernel.org>; Fri,  9 Jun 2023 21:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjFIVsG (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 9 Jun 2023 17:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjFIVsG (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 9 Jun 2023 17:48:06 -0400
X-Greylist: delayed 444 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Jun 2023 14:48:03 PDT
Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF59635BE
        for <dash@vger.kernel.org>; Fri,  9 Jun 2023 14:48:03 -0700 (PDT)
Date:   Fri, 09 Jun 2023 23:29:15 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     S M <mythrowy777@hotmail.com>
Cc:     "dash@vger.kernel.org" <dash@vger.kernel.org>
Subject: Re: Interested in porting Dash to Readline
Message-ID: <20230609212915.WlLQf%steffen@sdaoden.eu>
In-Reply-To: <DS7PR19MB445697AF96162841BB1C95FCE351A@DS7PR19MB4456.namprd19.prod.outlook.com>
References: <DS7PR19MB445697AF96162841BB1C95FCE351A@DS7PR19MB4456.namprd19.prod.outlook.com>
User-Agent: s-nail v14.9.24-478-ga870796086
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

S M wrote in
 <DS7PR19MB445697AF96162841BB1C95FCE351A@DS7PR19MB4456.namprd19.prod.outl\
 ook.com>:
 |Hello.
 |
 |I think I might be able to substitute Libedit in Dash with Readline \
 |and submit a patch, but first I need to know if such a change would \
 |be accepted. I think its main advantage is that it supports file complet\
 |ion out of the box.
 |
 |Let me know what you think.

I think i have seen fly by changes of Christos Zoulas/NetBSD to
improve just that somewhen in the last ~two weeks.
Hm.  Oh, no, one was in April and the other in February ;--)

  commit 75a3596d0aae9e93695d4198f06f780ab286022d
  Author:     christos <christos@NetBSD.org>
  AuthorDate: 2023-02-03 22:01:42 +0000
  Commit:     christos <christos@NetBSD.org>
  CommitDate: 2023-02-03 22:01:42 +0000

      Add a entry point for the complete function for FreeBSD compatibility with sh.

...

  commit 28b9ef37392aa2ab85fd1222dc56c57847741817
  Author:     christos <christos@NetBSD.org>
  AuthorDate: 2023-04-24 20:02:53 +0000
  Commit:     christos <christos@NetBSD.org>
  CommitDate: 2023-04-24 20:02:53 +0000

      PR/57376: Jorge Giner: readline file completion does not quote; do the same.

Quoting Dalai Lama (50 years in India jubilee) "it is all there".
FreeBSD bin/sh/histedit.c:sh_matches() as well as :sh_complete()
(all BSD licensed).

 |Thank you.
 --End of <DS7PR19MB445697AF96162841BB1C95FCE351A@DS7PR19MB4456.namprd19.\
 prod.outlook.com>

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
|~~
|..and in spring, hear David Leonard sing..
|
|The black bear,          The black bear,
|blithely holds his own   holds himself at leisure
|beating it, up and down  tossing over his ups and downs with pleasure
|~~
|Farewell, dear collar bear
