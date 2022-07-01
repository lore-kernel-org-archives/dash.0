Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3ADCC433EF
	for <linux-dash@archiver.kernel.org>; Fri,  1 Jul 2022 23:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiGAXOv (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 1 Jul 2022 19:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGAXOv (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 1 Jul 2022 19:14:51 -0400
Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C585A2DD
        for <dash@vger.kernel.org>; Fri,  1 Jul 2022 16:14:49 -0700 (PDT)
Received: from kent.sdaoden.eu (kent.sdaoden.eu [192.0.2.2])
        by sdaoden.eu (Postfix) with ESMTPS id 6B5F616059;
        Sat,  2 Jul 2022 01:14:46 +0200 (CEST)
Received: by kent.sdaoden.eu (Postfix, from userid 1000)
        id EA1058E23F; Sat,  2 Jul 2022 01:14:39 +0200 (CEST)
Date:   Sat, 02 Jul 2022 01:14:39 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     DASH shell mailing list <dash@vger.kernel.org>
Cc:     Robert Elz <kre@munnari.OZ.AU>
Subject: $(()) pre/postfix bug
Message-ID: <20220701231439.egWzS%steffen@sdaoden.eu>
User-Agent: s-nail v14.9.24-259-ge9cf982228
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hello.

I am currently writing a $(()) expression parser, using Dijkstra's
two stack algorithm (heavily impressed by the busybox one).

While doing so i encountered diverging behaviour in between
shells, and a bug in dash (and a memory failure in NetBSD 9 ksh).

For my own thing i hope i end up like bash (that is: just do it
(tm)), but the NetBSD and OpenBSD variants i also like, as they
mimic C and give an understandable error message.

I Cc: some of you, just for your interest.

Ciao.

==
Name:         dash
Path:         /usr/ports/core
Version:      0.5.11.5

#?2|kent:$ dash -c '(i=10; echo $((++-+++i)))'
-10
#?2|kent:$ dash -c '(i=10; echo $((+++++i)))'
10
#?0|kent:vm$ dash -c '(i=10; echo $((+ + + ++i)))'
10

==
GNU bash, version 5.1.16(1)-release (x86_64-pc-linux-gnu)

#?0|kent:$ bash -c '(i=10; echo $((++-+++i)))'
-11

==
BusyBox v1.34.0 (2022-01-03 21:34:20 CET) multi-call binary.

#?0|kent:$ busybox.static sh -c '(i=10; echo $((++-+++i)))'
sh: arithmetic syntax error
#?0|kent:$ busybox.static sh -c '(i=10; echo $((+ + - + ++i)))'
-11

==
FreeBSD 13.1-RELEASE releng/13.1-n250148-fc952ac2212 GENERIC

FreeBSD 13.1
#|f-1301-x86:~$ sh -c '(i=10; echo $((++-+++i)))'
sh: arithmetic expression: expecting primary: "++-+++i"

==
OpenBSD 7.1 (GENERIC.MP) #465: Mon Apr 11 18:03:57 MDT 2022

#?1|o-0701:steffen$ ksh -c '(i=10; echo $((++-+++i)))'
ksh: ++-+++i: ++ requires lvalue
#?1|o-0701:steffen$ ksh -c '(i=10; echo $((+++i)))'
ksh: +++i: ++ requires lvalue
#?1|o-0701:steffen$ ksh -c '(i=10; echo $((++i)))'
11
#?0|o-0701:steffen$ ksh -c '(i=10; echo $((+ + + ++i)))'
11
#?0|o-0701:steffen$ ksh -c '(i=10; echo $((+ + - + ++i)))'
-11

==
NetBSD n-0900 9.0 NetBSD 9.0 (GENERIC) #0: Fri Feb 14 00:06:28 UTC 2020  mkrepro@mkrepro.NetBSD.org:/usr/src/sys/arch/amd64/compile/GENERIC amd64

#?0|n-0900:steffen$ ksh -c '(i=10; echo $((++-+++i)))'
Memory fault
#?2|n-0900:steffen$ sh -c '(i=10; echo $((+++++i)))'
sh: arithmetic expression: incr/decr require var name: "+++++i"
#?2|n-0900:steffen$ sh -c '(i=10; echo $((+ ++i)))'
11
#?0|n-0900:steffen$ sh -c '(i=10; echo $((+ - ++i)))'
-11

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
