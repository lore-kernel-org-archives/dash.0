From: Dan Kegel <dank@kegel.com>
Subject: Crash on valid input
Date: Mon, 8 Apr 2013 19:43:36 -0700
Message-ID: <CAPF-yOaPfWdK2c556eTcRuf-thaHEzUcMKa+xa8criaS8uFLUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:63308 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762730Ab3DICnh (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 8 Apr 2013 22:43:37 -0400
Received: by mail-la0-f44.google.com with SMTP id fr10so2894769lab.3
        for <dash@vger.kernel.org>; Mon, 08 Apr 2013 19:43:36 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

If I check for an empty string like this:

+ test ! $foo

dash crashes.  This occurs both in the version shipped with ubuntu
10.04 and 12.04
as well as with dash from git.

Here's the stack:

Program received signal SIGSEGV, Segmentation fault.
__strcmp_sse4_2 () at ../sysdeps/i386/i686/multiarch/strcmp-sse4.S:221
221 ../sysdeps/i386/i686/multiarch/strcmp-sse4.S: No such file or directory.
(gdb) bt
#0  __strcmp_sse4_2 () at ../sysdeps/i386/i686/multiarch/strcmp-sse4.S:221
#1  0x0805938a in getop (s=0x202b <Address 0x202b out of bounds>) at
bltin/test.c:168
#2  0x08059c91 in t_lex (tp=0x806581c) at bltin/test.c:431
#3  0x080595cb in aexpr (n=UNOT) at bltin/test.c:260
#4  0x08059557 in oexpr (n=UNOT) at bltin/test.c:243
#5  0x080594ba in testcmd (argc=1, argv=0x8065814) at bltin/test.c:219
#6  0x0804c526 in evalbltin (cmd=0x805da1c, argc=2, argv=0x8065810,
flags=0) at eval.c:910
#7  0x0804c383 in evalcommand (cmd=0x80657cc, flags=0) at eval.c:850
#8  0x0804b4ab in evaltree (n=0x80657cc, flags=0) at eval.c:280
#9  0x08052d72 in cmdloop (top=1) at main.c:238
#10 0x08052c76 in main (argc=2, argv=0xbffff944) at main.c:178
(gdb) frame 2
#2  0x08059c91 in t_lex (tp=0x806581c) at bltin/test.c:431
431 op = getop(s);
(gdb) print s
$1 = 0x202b <Address 0x202b out of bounds>

Thanks for dash!
