Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65051C433F5
	for <linux-dash@archiver.kernel.org>; Mon, 17 Jan 2022 03:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236931AbiAQDX6 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 16 Jan 2022 22:23:58 -0500
Received: from beige.elm.relay.mailchannels.net ([23.83.212.16]:58475 "EHLO
        beige.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230324AbiAQDX4 (ORCPT
        <rfc822;dash@vger.kernel.org>); Sun, 16 Jan 2022 22:23:56 -0500
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 2359B621320
        for <dash@vger.kernel.org>; Mon, 17 Jan 2022 03:23:55 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 526546214B1
        for <dash@vger.kernel.org>; Mon, 17 Jan 2022 03:23:54 +0000 (UTC)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.106.113.21 (trex/6.4.3);
        Mon, 17 Jan 2022 03:23:54 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Language-Glossy: 438d361810e68ca1_1642389834819_653861786
X-MC-Loop-Signature: 1642389834818:464965786
X-MC-Ingress-Time: 1642389834818
Received: from ppp-88-217-46-204.dynamic.mnet-online.de ([88.217.46.204]:45824 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1n9IcV-0007m9-T1
        for dash@vger.kernel.org; Mon, 17 Jan 2022 03:23:52 +0000
Message-ID: <3709ca54c9001bffd3e690695c3b44d47d50c7c8.camel@scientia.org>
Subject: possible wrong behaviour with patterns double [ with no closing ]
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     dash@vger.kernel.org
Date:   Mon, 17 Jan 2022 04:23:46 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hey.


Assuming a pattern of:
[.*^\]
my understanding was that this would actually mean:
- the literal string [. followed by
- the pattern notation special character * (i.e. any string) followed by
- the literal string ^]

Because ] is escaped, it's to be taken literally and in a pattern a [
without corresponding ] is to be taken literally as well.

That seems to work in dash:
$ case '[.^]' in ([.*^\]) echo match;; (*) echo no match;; esac
match
$ case '[.x^]' in ([.*^\]) echo match;; (*) echo no match;; esac
match
$ case '[.xx^]' in ([.*^\]) echo match;; (*) echo no match;; esac
match


However, adding another [ to the pattern:
[.*^[\]
which should be:
- the literal string [. followed by
- the pattern notation special character * (i.e. any string) followed by
- the literal string ^[]

No longer matches:
$ case '[.^[]' in ([.*^[\]) echo match;; (*) echo no match;; esac
no match
$ case '[.x^[]' in ([.*^[\]) echo match;; (*) echo no match;; esac
no match
$ case '[.xx^[]' in ([.*^[\]) echo match;; (*) echo no match;; esac
no match


Whereas, AFAIU POSIX, it should.

This works, btw. in bash, but neither in busybox sh, nor klibc sh.


Cheers,
Chris.
