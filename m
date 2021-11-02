Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAB8C433F5
	for <linux-dash@archiver.kernel.org>; Tue,  2 Nov 2021 11:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FF0C6023E
	for <linux-dash@archiver.kernel.org>; Tue,  2 Nov 2021 11:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhKBLP2 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 2 Nov 2021 07:15:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59406 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhKBLP2 (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 2 Nov 2021 07:15:28 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrewsh)
        with ESMTPSA id 71FDA1F44798
Message-ID: <b960ec52-7a7a-db68-cd9d-bc303f82b54f@collabora.co.uk>
Date:   Tue, 2 Nov 2021 12:12:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Fwd: Bug#874264: dash: 'command -v' mistakenly returns a shell script
 whose executable is not set
References: <150453634811.19057.14500938362227373686.reportbug@homedog.cs.tufts.edu>
Content-Language: en-GB
To:     dash <dash@vger.kernel.org>
From:   Andrej Shadura <andrew.shadura@collabora.co.uk>
Organization: Collabora
In-Reply-To: <150453634811.19057.14500938362227373686.reportbug@homedog.cs.tufts.edu>
X-Forwarded-Message-Id: <150453634811.19057.14500938362227373686.reportbug@homedog.cs.tufts.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hi,

Here’s an old bug from 2017, but it was brought to my attention in some 
recent discussion about which "which" is which. There’s also a patch in 
one of the follow-ups, but I’m afraid I don’t know enough about that 
part of code to judge the consequences of it being applied:

https://bugs.debian.org/874264

-------- Forwarded Message --------
Subject: dash: 'command -v' mistakenly returns a shell script whose 
executable is not set
Date: Mon, 04 Sep 2017 10:45:48 -0400
From: Norman Ramsey <nr@cs.tufts.edu>
To: Debian Bug Tracking System <submit@bugs.debian.org>

Package: dash
Version: 0.5.8-2.4
Severity: normal

Dear Maintainer,


I tracked a build bug in s-nail to a problem with dash.  Symptom:
building s-nail tries to run /home/nr/bin/clang, a script whose
executable bit is not set.  We tracked the problem to the result of
running `command -v clang` with /bin/sh:

   nr@homedog ~/n/s-nail> /bin/sh -c 'command -v clang'
   /home/nr/bin/clang
   nr@homedog ~/n/s-nail> ls -l /home/nr/bin/clang
   -rw-rw-r-- 1 nr nr 1009 Aug 29  2011 /home/nr/bin/clang
   nr@homedog ~/n/s-nail> ls -l /bin/sh
   lrwxrwxrwx 1 root root 4 Jan 24  2017 /bin/sh -> dash
   nr@homedog ~/n/s-nail> ksh -c 'command -v clang'
   /usr/bin/clang
   nr@homedog ~/n/s-nail> bash -c 'command -v clang'
   /usr/bin/clang
   nr@homedog ~/n/s-nail> sh -c 'command -v clang'
   /home/nr/bin/clang
   nr@homedog ~/n/s-nail> dash -c 'command -v clang'
   /home/nr/bin/clang
   nr@homedog ~/n/s-nail> fish -c 'command -v clang'
   /usr/bin/clang

When I run `command -v clang` I expect it to answer /usr/bin/clang.



-- System Information:
Debian Release: 9.1
   APT prefers stable
   APT policy: (990, 'stable'), (500, 'stable'), (1, 'experimental')
Architecture: i386 (x86_64)
Foreign Architectures: amd64

Kernel: Linux 4.9.0-3-amd64 (SMP w/4 CPU cores)
Locale: LANG=C, LC_CTYPE=C (charmap=UTF-8) (ignored: LC_ALL set to 
en_US.utf8), LANGUAGE=C (charmap=UTF-8) (ignored: LC_ALL set to en_US.utf8)
Shell: /bin/sh linked to /bin/dash
Init: systemd (via /run/systemd/system)

Versions of packages dash depends on:
ii  debianutils  4.8.1.1
ii  dpkg         1.18.24
ii  libc6        2.24-11+deb9u1

dash recommends no packages.

dash suggests no packages.

-- debconf information:
* dash/sh: true



