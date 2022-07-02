Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EC9C433EF
	for <linux-dash@archiver.kernel.org>; Sat,  2 Jul 2022 00:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiGBAeO (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 1 Jul 2022 20:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiGBAeO (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 1 Jul 2022 20:34:14 -0400
X-Greylist: delayed 315 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Jul 2022 17:34:02 PDT
Received: from munnari.OZ.AU (munnari.coe.psu.ac.th [IPv6:2001:3c8:9009:181::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8049D2F67C
        for <dash@vger.kernel.org>; Fri,  1 Jul 2022 17:34:02 -0700 (PDT)
Received: from jacaranda.noi.kre.to (localhost [IPv6:::1]) by munnari.OZ.AU with ESMTP
        id 2620Sd6D009510; Sat, 2 Jul 2022 07:28:40 +0700 (ICT)
Received: from jacaranda.noi.kre.to (localhost [127.0.0.1])
        by jacaranda.noi.kre.to (8.16.1/8.14.2) with ESMTP id 2620SWbN022242;
        Sat, 2 Jul 2022 07:28:33 +0700 (+07)
From:   Robert Elz <kre@munnari.OZ.AU>
To:     Steffen Nurpmeso <steffen@sdaoden.eu>
cc:     DASH shell mailing list <dash@vger.kernel.org>
Subject: Re: $(()) pre/postfix bug
In-Reply-To: <20220701231439.egWzS%steffen@sdaoden.eu>
References: <20220701231439.egWzS%steffen@sdaoden.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-ID: <25497.1656721712.1@jacaranda.noi.kre.to>
Content-Transfer-Encoding: 8bit
Date:   Sat, 02 Jul 2022 07:28:32 +0700
Message-ID: <3508.1656721712@jacaranda.noi.kre.to>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

    Date:        Sat, 02 Jul 2022 01:14:39 +0200
    From:        Steffen Nurpmeso <steffen@sdaoden.eu>
    Message-ID:  <20220701231439.egWzS%steffen@sdaoden.eu>

  | While doing so i encountered diverging behaviour in between
  | shells, and a bur in dash

Support for ++/-- in sh arith is not required, it l9oks as
if dash does not support them.  Without ++ support ++i is
just + + i

  | (and a memory failure in NetBSD 9 ksh).

that thing is full of bugs.

  | For my own thing i hope i end up like bash (that is: just do it
  | (tm)),

If anything, tgat one is br9ken, tokens are supposed to always
be interpreted left to right, longest possible token matches
(not the one that allows the rest of the expression to parse).

But as ++ support is optional, the rules for it are a bit up
in the air ... but $(( )) is supposed to evwluate just like 
Ç with the various caveats about what is not required.

  | #?0|kent:$ bash -c '(i=10; echo $((++-+++i)))'
  | -11

So that should be equiv to ++ - ++ + i [assuming support for ++]
in which there are two ++ operators not followed (or following)
a var name (aka lvalue).  Error.

  | FreeBSD 13.1
  | #|f-1301-x86:~$ sh -c '(i=10; echo $((++-+++i)))'
  | sh: arithmetic expression: expecting primary: "++-+++i"

We used to do that as well (our arith parser is derived from
theirs, which is derived from dash's with extensions) but no-one ever
understood what a "primary" was (relates to internal implementation
function names) so I altered the err msg.

kre
