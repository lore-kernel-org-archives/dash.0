From: Steve Schnepp <steve.schnepp@gmail.com>
Subject: read() builtin doesn't read integer value /proc files (but bash's does)
Date: Wed, 1 Sep 2010 10:10:11 +0200
Message-ID: <AANLkTinTd+29=8EkiTKptoE8nnVphcQ_TW=ezS99LmWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53120 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604Ab0IAIKw (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 1 Sep 2010 04:10:52 -0400
Received: by vws3 with SMTP id 3so6252392vws.19
        for <dash@vger.kernel.org>; Wed, 01 Sep 2010 01:10:52 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: 595063@bugs.debian.org

Hi, I opened bug 595063 on the debian BTS [1] and I was suggested to
resend the email upstream.

So I copied the body of the bug below :

dash's read() builtin seems to read the underlying file 1 char at a
time. This doesn't work with some files under /proc, since procfs isn't
fully POSIX compliant.

With bash it works :

$ bash -c 'read MAX < /proc/sys/kernel/pid_max; echo $MAX'
32768

With dash it only reads the first character :

$ dash -c 'read MAX < /proc/sys/kernel/pid_max; echo $MAX'
3

If we use the cat(1) external program it works :

$ dash -c 'MAX=$(cat /proc/sys/kernel/pid_max); echo $MAX'
32768

After a little digging, it only appears on files that contains just an
integer value. When asked to read with a non-null offset (*ppos != 0),
__do_proc_dointvec() just returns 0 (meaning an EOF) as shown on [2].

I'm aware that the issue isn't strictly a dash one, since it has the
right to read one character at a time. But since fixing procfs to be
conforming to POSIX isn't a realistic option, would it be possible to
have a workaround that doesn't involve an external tool like cat(1) ?

[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=595063
[2] http://lxr.linux.no/#linux+v2.6.32/kernel/sysctl.c#L2371
--
Steve Schnepp
http://blog.pwkf.org/
