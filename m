Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2245C64E7A
	for <linux-dash@archiver.kernel.org>; Tue,  1 Dec 2020 05:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 452F52087D
	for <linux-dash@archiver.kernel.org>; Tue,  1 Dec 2020 05:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgLAFjX (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 1 Dec 2020 00:39:23 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:47706 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbgLAFjX (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 1 Dec 2020 00:39:23 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kjyN3-0003iS-Ed; Tue, 01 Dec 2020 16:38:38 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 01 Dec 2020 16:38:37 +1100
Date:   Tue, 1 Dec 2020 16:38:37 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Andrej Shadura <andrew.shadura@collabora.co.uk>
Cc:     dash@vger.kernel.org, Michael Biebl <biebl@debian.org>,
        974705@bugs.debian.org
Subject: Re: Changes to job handling cause hangs in wait
Message-ID: <20201201053837.GA26889@gondor.apana.org.au>
References: <0b1af921-f0dc-33e1-eae3-91192c2ec60a@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b1af921-f0dc-33e1-eae3-91192c2ec60a@collabora.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Mon, Nov 16, 2020 at 10:29:16AM +0000, Andrej Shadura wrote:
> 
> I’d like to forward a bug report I received. Michael, who reported it,
> was able to bisect it to 6c691b3, which was the first of the series of
> commits changing job handling.
> 
> I must note that I had troubles debugging it: I was only able to
> reproduce the issue in an autopkgtest virtual machine, but not on my
> normal system nor in a fresh Debian unstable Docker container.

FWIW I'm unable to reproduce it with autopkgtest.  This is what
I get:

root@test0:~# autopkgtest --test-name=timedated systemd-246.6/ -B -- lxc -s autopkgtest-sid
autopkgtest [16:32:45]: starting date: 2020-12-01
autopkgtest [16:32:45]: version 5.15
autopkgtest [16:32:45]: host test0; command line: /usr/bin/autopkgtest --test-name=timedated systemd-246.6/ -B -- lxc -s autopkgtest-sid
autopkgtest [16:33:13]: testbed dpkg architecture: amd64
autopkgtest [16:33:13]: testbed running kernel: Linux 5.9.0-rc1+ #18 SMP PREEMPT Sat Aug 29 23:45:30 AEST 2020
autopkgtest [16:33:13]: @@@@@@@@@@@@@@@@@@@@ unbuilt-tree systemd-246.6/
autopkgtest [16:33:18]: testing package systemd version 246.6-5
autopkgtest [16:33:18]: build not needed
autopkgtest [16:33:18]: test timedated: preparing testbed
Reading package lists... Done
Building dependency tree
Reading state information... Done
Correcting dependencies...Starting pkgProblemResolver with broken count: 0
Starting 2 pkgProblemResolver with broken count: 0
Done
 Done
Starting pkgProblemResolver with broken count: 0
Starting 2 pkgProblemResolver with broken count: 0
Done
The following additional packages will be installed:
  acl libnss-systemd
The following NEW packages will be installed:
  acl libnss-systemd
0 upgraded, 2 newly installed, 0 to remove and 0 not upgraded.
1 not fully installed or removed.
Need to get 255 kB of archives.
After this operation, 577 kB of additional disk space will be used.
Get:1 http://deb.debian.org/debian sid/main amd64 libnss-systemd amd64 246.6-5 [194 kB]
Get:2 http://deb.debian.org/debian sid/main amd64 acl amd64 2.2.53-8 [60.8 kB]
Fetched 255 kB in 1s (489 kB/s)
debconf: delaying package configuration, since apt-utils is not installed
Selecting previously unselected package libnss-systemd:amd64.
(Reading database ... 12641 files and directories currently installed.)
Preparing to unpack .../libnss-systemd_246.6-5_amd64.deb ...
Unpacking libnss-systemd:amd64 (246.6-5) ...
Selecting previously unselected package acl.
Preparing to unpack .../acl_2.2.53-8_amd64.deb ...
Unpacking acl (2.2.53-8) ...
Setting up libnss-systemd:amd64 (246.6-5) ...
First installation detected...
Checking NSS setup...
Setting up acl (2.2.53-8) ...
Setting up autopkgtest-satdep (0) ...
Processing triggers for libc-bin (2.31-4) ...
(Reading database ... 12667 files and directories currently installed.)
Removing autopkgtest-satdep (0) ...
autopkgtest [16:33:29]: test timedated: [-----------------------
original tz: Etc/UTC
timedatectl works
change timezone
reset timezone to original
no adjtime file
UTC set in adjtime file
non-zero values in adjtime file
fourth line adjtime file
no final newline in adjtime file
only one line in adjtime file
only one line in adjtime file, no final newline
only two lines in adjtime file
only two lines in adjtime file, no final newline
unknown value in 3rd line of adjtime file
disable NTP
enable NTP
re-disable NTP
autopkgtest [16:33:32]: test timedated: -----------------------]
autopkgtest [16:33:32]: test timedated:  - - - - - - - - - - results - - - - - - - - - -
timedated            PASS
autopkgtest [16:33:32]: @@@@@@@@@@@@@@@@@@@@ summary
timedated            PASS
root@test0:~# 

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
