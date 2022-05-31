Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3E4C433F5
	for <linux-dash@archiver.kernel.org>; Tue, 31 May 2022 20:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347814AbiEaUjz (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 31 May 2022 16:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347813AbiEaUjx (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 31 May 2022 16:39:53 -0400
Received: from tdc-dmzmx102.arconic.com (tdc-dmzmx102.arconic.com [142.79.57.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D105FB0
        for <dash@vger.kernel.org>; Tue, 31 May 2022 13:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=arconic.com; i=@arconic.com; q=dns/txt; s=arnc;
  t=1654029588; x=1685565588;
  h=from:to:subject:mime-version:message-id:date;
  bh=HYJfP+s9mbf+PTgUB62hiySlij9Th8HnZoD3JI2n0yU=;
  b=da8iJq25pdBK8lxJLTuAubgplTk8hmCKEq/qlKKIbROTuem6gUD2xCHO
   5P79f6FQPi01xnhqVnqqdL+5YYv556VloRrkLR3xDmvpGwgN8AApT0QjK
   qRvaMHaWR61CgUt9rBtmbUM9DYJ0urc5BmQBcUnoiHkE1qSHaBHFAXSna
   mY0z6usdwR1CYh8DQczsj+2mC3EHgXYu9h+Ka4YElCEOycOc9zlwDg6K+
   t4x63esELKR3oDrHNM6h7OOa/6vTmhtP0jI9DgH60sFEpCETE5kkGn+mh
   4WZR0UjDnsJtNseRJRkQfZL1i+hT0MNS7YxmgnHJ1jHwooPJFoyNHualY
   A==;
IronPort-SDR: EcxSF4bZRcmTw8T+R24pztDPmv3nAr+nEi6mQ0lNbSZTtP1flw5SrUBIbpKALHU8bD4uIPl5ao
 tFtyL6Bjkxaw==
IronPort-Data: =?us-ascii?q?A9a23=3AP80/qqvKUgNEPviiQjAqoFFIIOfnVGRcMUV32?=
 =?us-ascii?q?f8akzHdYApBsoF/qtZmKTyEbKuNZGLxfdF/a4W2o05TsJKDn9NrHFdvpCgwH?=
 =?us-ascii?q?3lBpJueD7x1DKtQ0wB+jyH7ofUOA/w2MrEsF+hpCC6FzvuRGuK59yMkiPjWH?=
 =?us-ascii?q?uOU5NPsYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+qUzC3f5s9JACV/43?=
 =?us-ascii?q?orYwP9ZUFQejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5godW7gsepYxV8?=
 =?us-ascii?q?F81/z91Yj+kupDcW3Emafv7BTChtkUHAu6rmBNFoC05lK08MZLwa28O03PQw?=
 =?us-ascii?q?5YolYQL78XYpQQBZ8UgnMwWUxBCFyxle6NH47/KO1C2q8eUyUzNNXDrxp2CC?=
 =?us-ascii?q?WlrbN1Gob8vUAmi8tRdcljhdCuri+utwJqlReR2wMcuNs/mOMUYoH4I8N1zJ?=
 =?us-ascii?q?Z7KWrjFRKzW6dQd1S8oidxRTK+YecMddDdmYBjLZFtEPVJ/NX73p8/w7lGXT?=
 =?us-ascii?q?tGSgAv9SXIL3lXu?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AGRQxrKGG1ZJyCk8DpLqE9MeALOsnbusQ8z?=
 =?us-ascii?q?AXPiFKJyC9Hfbo9fxG8M5w6faWslkssRMb+exoUZPoKRjhHPZOgLX5Vo3PYO?=
 =?us-ascii?q?CJggaVxMoL1/qA/wHd?=
X-IronPort-AV: E=Sophos;i="5.91,230,1647316800"; 
   d="scan'208";a="59863109"
Received: from noatdc-appgtw91.valueaddco.com (HELO NOATDC-APPGTW91.arconic.com) ([10.14.159.21])
  by tdc-dmzmx102.arconic.com with ESMTP; 31 May 2022 16:39:47 -0400
Received: from limsdev.amppcs.noa.alcoa.com ([10.58.23.20]) by NOATDC-APPGTW91.arconic.com with Microsoft SMTPSVC(8.5.9600.16384);
         Tue, 31 May 2022 16:39:47 -0400
From:   charles.fisher@arconic.com
To:     dash@vger.kernel.org
Subject: EXIT trap does not fire
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <NOATDC-APPGTW91Teip00015ab2@NOATDC-APPGTW91.arconic.com>
X-OriginalArrivalTime: 31 May 2022 20:39:47.0635 (UTC) FILETIME=[916F1030:01D8752E]
Date:   31 May 2022 16:39:47 -0400
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

I think that I have found a bug in dash that impacts EXIT trap handling. The behavior is different (and appears correct) in bash, ksh93 and mksh. I am using the EPEL dash package, version 0.5.10.2 for CentOS 7 (full package info included).

I didn't see this already reported on the mailing list; hopefully I am not reporting a duplicate bug, sorry if so.

The ssh-agent used in the context immediately below seems to prevent an EXIT trap from firing upon abnormal termination:

  # cat dashbug_trivial
  #!/bin/dash

  eval $(ssh-agent)

  trap 'eval $(ssh-agent -k)' EXIT

  if ssh-add
  then echo testing
       read junk
  fi

The EXIT does not fire if the user aborts (it fires properly if the user does not abort):

  # ./dashbug_trivial 
  Agent pid 59714
  Enter passphrase for /root/.ssh/id_ed25519: 
  Identity added: /root/.ssh/id_ed25519 (root@bastion.mycompany.com)
  testing
  ^C
  # ps ax | grep agent | grep -v grep
  59714 ?        Ss     0:00 ssh-agent


I am actually iterating over a set of hosts inside the conditional:

  # cat dashbug
  #!/bin/dash

  eval $(ssh-agent)

  trap 'eval $(ssh-agent -k)' EXIT

  if ssh-add
  then while read -r host port user &lt;&9
       do printf '=%s=%d=%s=\n' "$host" "$port" "$user"
          ssh -p "$port" "$user@$host" "$@" 2>&1
       done 9&lt;&lt;-''EndOfHosts
	limsprd.amppcs.noa.alcoa.com 22 root
	darkstar.dpw.alcoa.com 24 root
  EndOfHosts
  fi

The iterative script executes perfectly in dash; the problem is abnormal termination:

  # ./dashbug uptime
  Agent pid 10809
  Enter passphrase for /root/.ssh/id_ed25519: 
  Identity added: /root/.ssh/id_ed25519 (root@bastion.mycompany.com)
  =host1.mycompany.com=22=root=
  13:12:52 up 233 days,  1:58,  0 users,  load average: 0.66, 0.63, 0.54
  =host2.mycompany.com=24=root=
  13:12:52 up 2 days,  1:59,  0 users,  load average: 0.00, 0.00, 0.00
  Agent pid 10809 killed

Oddly, when I left off the trailing "fi" the trap killed the agent:

  # ./dashbug uptime
  Agent pid 9953
  ./dashbug: 15: ./dashbug: Syntax error: end of file unexpected (expecting "fi")
  Agent pid 9953 killed

When I break the password prompt with a control-c, dash does not terminate the agent:

  # ./dashbug uptime
  Agent pid 10072
  Enter passphrase for /root/.ssh/id_ed25519: ^C

  #

I confirmed this with a check of the process list:

  # ps ax | grep agent | grep -v grep
  10072 ?        Ss     0:00 ssh-agent

If I switch this to mksh (or other previously mentioned shells), a control-c does what I expect:

  # head -1 dashbug
  #!/bin/mksh

  # ./dashbug uptime
  Agent pid 10193
  Enter passphrase for /root/.ssh/id_ed25519: ^C
  Agent pid 10193 killed
  #

Is this a problem with dash, or a lack in my understanding?


These are the full details on the CentOS 7 EPEL package for dash:

  # rpm -qi dash
  Name        : dash
  Version     : 0.5.10.2
  Release     : 1.el7
  Architecture: x86_64
  Install Date: Wed 11 Aug 2021 01:45:26 PM CDT
  Group       : System Environment/Shells
  Size        : 159742
  License     : BSD and GPLv2+ and Public Domain and Copyright only
  Signature   : RSA/SHA256, Mon 05 Nov 2018 06:00:50 AM CST, Key ID 72f97b74ec551f03
  Source RPM  : dash-0.5.10.2-1.el7.src.rpm
  Build Date  : Mon 05 Nov 2018 06:00:48 AM CST
  Build Host  : x86-ol7-builder-01.us.oracle.com
  Relocations : (not relocatable)
  Vendor      : Oracle America
  URL         : http://gondor.apana.org.au/~herbert/dash/
  Summary     : Small and fast POSIX-compliant shell
  Description :
  DASH is a POSIX-compliant implementation of /bin/sh that aims to be as small as
  possible. It does this without sacrificing speed where possible. In fact, it is
  significantly faster than bash (the GNU Bourne-Again SHell) for most tasks.
