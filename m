Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F11C433EF
	for <linux-dash@archiver.kernel.org>; Sun, 20 Feb 2022 04:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiBTEW4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 19 Feb 2022 23:22:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiBTEWz (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 19 Feb 2022 23:22:55 -0500
X-Greylist: delayed 423 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 19 Feb 2022 20:22:34 PST
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9132C103
        for <dash@vger.kernel.org>; Sat, 19 Feb 2022 20:22:34 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D48EC821379
        for <dash@vger.kernel.org>; Sun, 20 Feb 2022 04:15:30 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 069858213AD
        for <dash@vger.kernel.org>; Sun, 20 Feb 2022 04:15:29 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1645330530; a=rsa-sha256;
        cv=none;
        b=3LKeMfZSz2lByZrOT2oychMpVHJeOguKKuoijJ902Q6leQgaAAPHt3qs7Z823s23Lc4vhC
        MqGo4rTihBx7a7id7hNpbAkOPFPTmnDJFd7jlwbYX07cWEMtwl2iXd8KFp7Bh8p13CMUzv
        k4un2VvMEz7CDVkndKhcH4CV0+Q7pt0E2ziETtraeqy4sYOfHbE9R0Qxw/YMWkhwUVTv7p
        10mo+NHGS8VKhM9kRK4Ae5N8ggH4LFXnt+A+VNzk+kuNeKf0SnZgNvyQZK2vH7hZPVzFFH
        ZnVhDg8r7X1SDQ7sF2J3RoApJoXuhh1lNcQPdGdTFnWJUi1D5L5VHN1xv7/MoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1645330530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=U9PuIQRaxT9VwiaBNDnAIpd0pw3+hxAiQCiIk/1JmxU=;
        b=KCHW2zMLjH/I3SCedihcRk50yLQHqY+GND6CU2uMhKv1MIqbdh7xjJe60HQ6Oo1lT6qltt
        6POLrZ46jCYeUS314KKCgFRjkqEeWp3JwQaRwKEGrjBirxovQI8B7H6BF7YOaIoeKxjc1X
        SYzo7Tk6lMohlESwsFJCTacNxMBIi0kIuNhLNPbAVTqG3BsHf5NigIHlmJpAqNBw0p6KSa
        iIjAzZB3hct6BzCUTulRyCugGGZGPOZHeRK9PgPdPl8KzuYV4vXSDAjYAqaTjh31JJXXyS
        GfqPWu4wfbXDqEZb7d/cDo+kNC58v8mZLRh4Jr3lY7e9iPkN8b1wLWfWizHN8g==
ARC-Authentication-Results: i=1;
        rspamd-788b499c9f-wl59t;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.106.113.39 (trex/6.5.3);
        Sun, 20 Feb 2022 04:15:30 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Arithmetic-Keen: 5e91d01068772a51_1645330530522_1171853867
X-MC-Loop-Signature: 1645330530522:4064201092
X-MC-Ingress-Time: 1645330530522
Received: from ppp-88-217-35-91.dynamic.mnet-online.de ([88.217.35.91]:47604 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1nLdd6-0000dx-6t
        for dash@vger.kernel.org; Sun, 20 Feb 2022 04:15:28 +0000
Message-ID: <2a150a397fcdda7dd357dd5b125ec585acce3a70.camel@scientia.org>
Subject: how is locale/unset intended to work with dash?
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     dash@vger.kernel.org
Date:   Sun, 20 Feb 2022 05:15:23 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.43.2-2 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hey there.

I'm trying to understand how local/unset works with dash... and it
seems to be a bit dangerous.



In bash, e.g., it seems to work like that:
always the var from the next outer scope is used, when
setting/expanding/unsetting

This implies, that bash "shadows" variables, e.g.

$ x=Vtop
$ f1() { local x=V1 ; f2; echo f1 $x ; }
$ f2() { echo f2 $x ; unset -v x ; echo f2 $x ; }
$ echo top $x
$ f1
$ echo top $x

would give this in bash:
top Vtop
f2 V1
f2 Vtop
f1 Vtop
top Vtop

In other words, as soon as x is unset in f2, the f1()'s local x ceases
to exist and the global x is used.

The only exception is, when it is unset in the same scope level in
which it was made locale:

$ x=Vtop
$ f1() { local x=V1 ; f2; echo f1 $x ; }
$ f2() { local x=V2 ; echo f2 $x ; unset -v x ; echo f2 $x ; }
$ echo top $x
$ f1
$ echo top $x

would give this in bash:
top Vtop
f2 V2
f2
f1 V1
top Vtop


in dash, the first one gives:
top Vtop
f2 V1
f2        <- no unshadowing, so we don't see Vtop here
f1
top Vtop

and the second one:
top Vtop
f2 V2
f2        <- no unshadowing, so we don't see V1 here
f1 V1
top Vtop

=> which actually seems more predictable at first... unset basically
acts on the var from the next outer scope... make it unset in that and
probably any further scopes beneath... but not doesn't "unshadow" the
vars from higher scopes.



However,... things can get far more strange:
$ x=Vtop
$ f1() { local x=V1 ; f2 ; echo f1 $x; }
$ f2() { echo f2 $x; unset -v x; echo f2 $x; f3 ; echo f2 $x; }
$ f3() { echo f3 $x; unset -v x; echo f3 $x; }
$ echo top $x
vf1
$ echo top $x

which gives in dash:

top Vtop
f2 V1
f2
f3
f3
f2
f1
top Vtop   <- shouldn't that have been unset by the f3’s unset?
              f1’s x was already gone by then

Is there some kind of "barrier" in dash? Like when there once was a
local variable of some name in some scope, even if that has already
been unset, one cannot go any higher, not even with unset itself?

Could that perhaps be added to the documentation?




btw: in bash the above would give:
top Vtop
f2 V1
f2 Vtop
f3 Vtop
f3
f2
f1
top
=> which is what one would expect given how bash documents unset and
this "unshadowing"


And bash has - it seems - even another speciality:
$ x=Vtop
$ f1() { local x=V1 ; f2 ; echo f1 $x; }
$ f2() { echo f2 $x; unset -v x; echo f2 $x; f3 ; echo f2 $x; }
$ f3() { local x=V3; echo f3 $x; unset -v x; echo f3 $x; }
$ echo top $x
$ f1
$ echo top $x
gives:
top Vtop
f2 V1
f2 Vtop
f3 V3
f3
f2 Vtop
f1 Vtop
top Vtop

=> when the unset is in the *same* scope level as the `local` ... it
doesn't "unshadow".


$ x=Vtop
$ f1() { local x=V1 ; f2 ; echo f1 $x; }
$ f2() { local x=V2; echo f2 $x; unset -v x; echo f2 $x; f3 ; echo f2 $x; }
$ f3() { echo f3 $x; unset -v x; echo f3 $x; }
$ echo top $x
$ f1
$ echo top $x
gives:
top Vtop
f2 V2
f2       <- was unset at the same level, thus no unshadowing
f3       <- apparently also works at levels beneath
f3 V1    <- but when that unsets again, it unshadows again
f2 V1    <- and this even on the higher level, where it didn't
f1 V1       before,.. that one I found quite unpredictable
top Vtop



I don't even dare to say which is better ;-) ... and I know `local` is
not standardised... but given that it's widely used... wouldn't it be
beneficial if bash/dash (and hopefully others) do pretty much the same?




Cheers,
Chris.
