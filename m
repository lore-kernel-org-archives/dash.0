From: Zando Fardones <bluesun654@gmail.com>
Subject: [BUG] Here-document redirection with vi/emacs on
Date: Tue, 27 Jun 2017 16:29:32 +0200
Message-ID: <CAPLrsYe1hemq+pOTRERmxc3M0-QrHhGm9PUOhs7pJUN5-cOk6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37126 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752758AbdF0O3f (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 27 Jun 2017 10:29:35 -0400
Received: by mail-wm0-f44.google.com with SMTP id i127so28672269wma.0
        for <dash@vger.kernel.org>; Tue, 27 Jun 2017 07:29:34 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hello,

I think I've found a bug when using the here-document redirection in
an interactive shell. What basically happens is that you can't see the
command output if you set the "vi" or "emacs" options. Please take a
look:

$ set -o vi
$ cat << EOF
> test
> EOF
$ set +o vi
$ cat << EOF
> test
> EOF
test
^ you can see the "test" output only when the vi option is *not* set

$ set -o emacs
$ cat << EOF
> test
> EOF
$ set +o emacs
$ cat << EOF
> test
> EOF
test
^ you can see the "test" output only when the emacs option is *not* set
