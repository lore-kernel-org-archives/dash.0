Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A62C77B7A
	for <linux-dash@archiver.kernel.org>; Sat, 10 Jun 2023 17:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjFJRuF (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 10 Jun 2023 13:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFJRuE (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 10 Jun 2023 13:50:04 -0400
Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6213598
        for <dash@vger.kernel.org>; Sat, 10 Jun 2023 10:50:03 -0700 (PDT)
Date:   Sat, 10 Jun 2023 19:49:59 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     S M <mythrowy777@hotmail.com>
Cc:     "dash@vger.kernel.org" <dash@vger.kernel.org>
Subject: Re: Interested in porting Dash to Readline
Message-ID: <20230610174959.5TEaR%steffen@sdaoden.eu>
In-Reply-To: <DS7PR19MB445653200E02F41EB31397C5E351A@DS7PR19MB4456.namprd19.prod.outlook.com>
References: <DS7PR19MB445697AF96162841BB1C95FCE351A@DS7PR19MB4456.namprd19.prod.outlook.com>
 <20230609212915.WlLQf%steffen@sdaoden.eu>
 <DS7PR19MB445653200E02F41EB31397C5E351A@DS7PR19MB4456.namprd19.prod.outlook.com>
User-Agent: s-nail v14.9.24-478-ga870796086
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

S M wrote in
 <DS7PR19MB445653200E02F41EB31397C5E351A@DS7PR19MB4456.namprd19.prod.outl\
 ook.com>:
 |On Fri, Jun 09, 2023 at 11:29:15PM +0200, Steffen Nurpmeso wrote:
 |> Quoting Dalai Lama (50 years in India jubilee) "it is all there".
 |> FreeBSD bin/sh/histedit.c:sh_matches() as well as :sh_complete()
 |> (all BSD licensed).
 |
 |So is it a licensing concern? I still think Readline is more

I do not think BSD-3-clause disallows bundling within GPL.
But i am a total licensing idiot.

 |featureful as I have worked with both. I did poke around NetBSD's

It surely is.  (Much more so, but also fat.)

 |ash code and remember that it used an internal Libedit header
 |"filecomplete.h" or something along those lines to implement
 |filename completion. Not that porting or re-implementing such
 |internal routines would be particularly hard. If I recall correctly
 |there is a publicfunction in libedit named "_el_fn_complete"
 |that implements something along those lines.
 |
 |If it's a licensing problem then there's no way around it, though
 |I thought that GPL restrictions of this kind would only apply to
 |redistributed binaries linked against readline and not to the 
 |source code itself.

Well it _could_ be possible to compile dash with any editing and
simply use "rlwrap"[1] (cudo Stephen Isard) to hook readline into
dash.  Then your effort has already ended.

  [1] https://github.com/hanslub42/rlwrap

 --End of <DS7PR19MB445653200E02F41EB31397C5E351A@DS7PR19MB4456.namprd19.\
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
