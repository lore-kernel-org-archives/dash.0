Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABEDC433EF
	for <linux-dash@archiver.kernel.org>; Fri, 11 Mar 2022 04:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbiCKE0p convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 10 Mar 2022 23:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiCKE0o (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 10 Mar 2022 23:26:44 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F6519F46D
        for <dash@vger.kernel.org>; Thu, 10 Mar 2022 20:25:41 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 51B91120E62
        for <dash@vger.kernel.org>; Fri, 11 Mar 2022 04:25:41 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 72618120D50
        for <dash@vger.kernel.org>; Fri, 11 Mar 2022 04:25:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1646972740; a=rsa-sha256;
        cv=none;
        b=Zo3OWGFwohBgjaGY4sBGF52x6179Z5e4tUJ8uOR1mkevKJLs3NkkYQCKvf9Flgo4JvDDkF
        EQmxXheHZcAyJgcR79HEeFMgykhHnv2SR4zsoSmLqcZghRcN1SlZ+6qBtM+2+Ji7hVPs+f
        EVaFGs/9OX+35oFu6Tax043lEVtRKmMNmNcScs6Bd6cUdc+Gy+3W6rI2wsIZT7FUw+qbuo
        77ZCERgKMTsWee1csRDZtprocVKncejeVa9qmHR8aZMYRo6iVbWxa8PBan/SSrMgQRT/qH
        kqkCS0VncPhbhMcxfBoD8l01FA91scOg1qM3x+QozXjXeniLXwTS7FPXtOsmIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1646972740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=AtcmuRlf/csav7NY5XC4YEvwRBBM8YSF22azzCe50O0=;
        b=MksYKcpC2HKD779ad1UWvctxtNfH1RMN7pMSmDzLetBZL1mFApicITh1LkiRgu0H3fDRpV
        4ZYY1RY0u14XLCj/NKkdoF1S1L4ysz2ZH+8a5o/goF1Z5czIywzwmiMKxDG4vrE9Vh6Jwh
        1N9s6XjsucX3DQgYvHxLLXaqarP63S8QNadwlKlEbWiYBq6rC67Agn6a8bvB8SFH7xFnzr
        O0ueV2J2dPLHEK2rrn/2zowzvd4S7yKKYY3zwv5MzE4ISCBccQ6LcspfP6OyyiuXemY9vH
        /q/8ojX6+uJQslTzH6WHKJU/mf5cdwCJkYjuYyMnseWr3kGKJV3Dg15qllWQGQ==
ARC-Authentication-Results: i=1;
        rspamd-56df6fd94d-fxzfl;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.121.210.153 (trex/6.5.3);
        Fri, 11 Mar 2022 04:25:41 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Scare-Hook: 5c75af2b240fd23e_1646972740945_2778218775
X-MC-Loop-Signature: 1646972740945:2545382006
X-MC-Ingress-Time: 1646972740945
Received: from ppp-46-244-246-77.dynamic.mnet-online.de ([46.244.246.77]:56248 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1nSWqO-000374-AT
        for dash@vger.kernel.org; Fri, 11 Mar 2022 04:25:38 +0000
Message-ID: <3574fa7e81a2c56fdb720ea0df259ae3df92c3b2.camel@scientia.org>
Subject: possible wrong behaviour when -s and -c are both used
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     dash@vger.kernel.org
Date:   Fri, 11 Mar 2022 05:25:33 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.43.3-1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hey.

I've noted that dash gives different behaviour when both -s and -c are
used, depending on their order:

calestyo@heisenberg:~$ cat script
date
calestyo@heisenberg:~$

calestyo@heisenberg:~$ dash -s -c 'echo foo' script
foo
$     <--- this is dash's prompt, and it reads input from stdin
calestyo@heisenberg:~$ dash -c 'echo foo' -s script
foo
calestyo@heisenberg:~$ 


POSIX specifies[0]:
> -c
>    Read commands from the command_string operand.
>    ...
>    No commands shall be read from the standard input.


So I'd say -c is ought to override -s ... but in any case I'd guess
it's unintended that the order of the two changes the behaviour?!


Thanks,
Chris.


[0] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sh.html
