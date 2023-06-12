Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE517C7EE43
	for <linux-dash@archiver.kernel.org>; Mon, 12 Jun 2023 23:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbjFLXJ1 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 12 Jun 2023 19:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjFLXJ0 (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 12 Jun 2023 19:09:26 -0400
Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF5CE4E
        for <dash@vger.kernel.org>; Mon, 12 Jun 2023 16:09:23 -0700 (PDT)
Date:   Tue, 13 Jun 2023 01:09:08 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     Chet Ramey <chet.ramey@case.edu>
Cc:     S M <mythrowy777@hotmail.com>,
        "dash@vger.kernel.org" <dash@vger.kernel.org>
Subject: Re: Interested in porting Dash to Readline
Message-ID: <20230612230908.9kgWH%steffen@sdaoden.eu>
In-Reply-To: <d3076b26-3794-8a34-1d96-4c2156d83b42@case.edu>
References: <DS7PR19MB445697AF96162841BB1C95FCE351A@DS7PR19MB4456.namprd19.prod.outlook.com>
 <20230609212915.WlLQf%steffen@sdaoden.eu>
 <DS7PR19MB445653200E02F41EB31397C5E351A@DS7PR19MB4456.namprd19.prod.outlook.com>
 <20230610174959.5TEaR%steffen@sdaoden.eu>
 <d3076b26-3794-8a34-1d96-4c2156d83b42@case.edu>
User-Agent: s-nail v14.9.24-479-g07982e6ca2
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Chet Ramey wrote in
 <d3076b26-3794-8a34-1d96-4c2156d83b42@case.edu>:
 |On 6/10/23 1:49 PM, Steffen Nurpmeso wrote:
 |> S M wrote in
 |>   <DS7PR19MB445653200E02F41EB31397C5E351A@DS7PR19MB4456.namprd19.prod.out\
 |>   l\
 |>   ook.com>:
 |>|On Fri, Jun 09, 2023 at 11:29:15PM +0200, Steffen Nurpmeso wrote:
 |>|> Quoting Dalai Lama (50 years in India jubilee) "it is all there".
 |>|> FreeBSD bin/sh/histedit.c:sh_matches() as well as :sh_complete()
 |>|> (all BSD licensed).
 |>|
 |>|So is it a licensing concern? I still think Readline is more
 |> 
 |> I do not think BSD-3-clause disallows bundling within GPL.
 |> But i am a total licensing idiot.
 |
 |Readline is licensed using GPL3. You may wish to check whether or not that
 |is compatible with dash's BSD licensing. That's something the dash folks
 |have to decide for themselves.

Ah dash is BSD.  I wrote some (dangling) patches for busybash ash
which is -- i still think -- rooted on dash and is GPLv2 (on top
of "original BSD copyright notice is retained at the end of this
file").

 |>|featureful as I have worked with both. I did poke around NetBSD's
 |> 
 |> It surely is.  (Much more so, but also fat.)
 |> 
 |>|ash code and remember that it used an internal Libedit header
 |>|"filecomplete.h" or something along those lines to implement
 |>|filename completion. Not that porting or re-implementing such
 |>|internal routines would be particularly hard. If I recall correctly
 |>|there is a publicfunction in libedit named "_el_fn_complete"
 |>|that implements something along those lines.
 |>|
 |>|If it's a licensing problem then there's no way around it, though
 |>|I thought that GPL restrictions of this kind would only apply to
 |>|redistributed binaries linked against readline and not to the
 |>|source code itself.
 |> 
 |> Well it _could_ be possible to compile dash with any editing and
 |> simply use "rlwrap"[1] (cudo Stephen Isard) to hook readline into
 |> dash.  Then your effort has already ended.
 |
 |If you use rlwrap, you don't have the insight into the internal state of
 |the application that allows you to do completion on anything more than
 |what readline understands natively (filenames, mostly).

For me personally that is enough -- context-sensitive completion
is a cool thing though.
The way readline does that filename completion is still luxury,
i "designed" the expansion of my mailer with it in mind (surely
rude codewise shall it be compared, and with
line-editor-cpl-word-breaks=:"'@=;|, instead of readline's
rl_basic_word_break_characters=\t\n"\'`@$><=;|&{().

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
