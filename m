From: Godmar Back <godmar@gmail.com>
Subject: support for POSIX.1 job control terminal state management in dash
Date: Tue, 23 Jun 2020 08:41:24 -0400
Message-ID: <CAB4+JYKczqr=OO+2kMUE4oNkH_d9Ak9cwv_rk7Fh9jQPzUtTjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <dash-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732507AbgFWMlj (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 23 Jun 2020 08:41:39 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD004C061573
        for <dash@vger.kernel.org>; Tue, 23 Jun 2020 05:41:37 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 17so3061565wmo.1
        for <dash@vger.kernel.org>; Tue, 23 Jun 2020 05:41:37 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi,

POSIX 1003.1 (2008) asks of job control shells this:

"When a foreground (not background) job stops, the shell must sample
and remember the current terminal settings so that it can restore them
later when it continues the stopped job in the foreground (via the
tcgetattr( ) and tcsetattr( ) functions)."

The rationale is, in my view, a sound one: a job control shell should
provide the abstraction that job-control unaware programs executing
under it have unfettered access to their terminal even when subject to
job control.

Unlike other POSIX shells such as ksh, dash 0.5.8-2.10, however, does
not appear to do that. In fact, it appears that no terminal-related
action takes place at all when it learns that a child process has been
suspended via SIGTSTP, and also no action is done when the child is
continued in the foreground.

I would be curious to hear the reasons for why dash chose to deviate
from the POSIX specification in this respect.

 - Godmar
