From: Luigi Tarenga <luigi.tarenga@gmail.com>
Subject: bug in dash compile with buildroot
Date: Tue, 08 Jul 2014 16:23:07 +0200
Message-ID: <53BBFECB.6070003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:45809 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbaGHOWy (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 8 Jul 2014 10:22:54 -0400
Received: by mail-we0-f182.google.com with SMTP id q59so6053336wes.13
        for <dash@vger.kernel.org>; Tue, 08 Jul 2014 07:22:53 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: buildroot@buildroot.org, dash@vger.kernel.org

hi,
I send this bug report to both list because I'm not sure who will find 
this relevant.

I compiled a buildroot image for a laptop with atom so the build is for 
x86_64
architecture. In the build configuration I flagged to include dash and 
this get
compiled as static (this let me test the bug even on the host system).

While writing some test script (actually a init process written in dash) 
I hit this
strange bug:

# dash -c "( echo ciao) &)"
ciao
Segmentation fault

# dash -c "(echo ciao; /bin/true)&"
ciao

# dash -c "(echo ciao; /bin/true; echo ciao)&"
ciao
ciao
Segmentation fault


As you see if I put a subshell in background it dump. If in the same 
subshell I execute
an external command as last command it works.
I write this bug even to the buildroot team because if I rebuild dash 
from the same source
without using the crosscompile the same bug do not happen.

I enable DEBUG in the dash source and tried to narrow it a little , this 
is what I found:

this is the trace with some little more messages inserted by me:
Tracing started.
token "("
pipeline: entered
reread token "("
reread token "("
pipeline: entered
token word echo
reread token word echo
reread token word echo
token word ciao
token ")"
reread token ")"
reread token ")"
reread token ")"
reread token ")"
token "&"
reread token "&"
reread token "&"
reread token "&"
token end of file
reread token end of file
evaltree called
pid 1006, evaltree(0x806b438: 3, 1) called
evalsubshell called
check 2
evaltree called
pid 1006, evaltree(0x806b3e0: 4, 1) called
evalsubshell called
check nofork
check 2
evaltree called
pid 1006, evaltree(0x806b420: 0, 1) called
evalcommand(0x806b420, 1) called
evalcommand arg: echo
evalcommand arg: ciao
redirectsafe after setjmp
check 4
check 6


I modified exraise with 2 check:

void
exraise(int e)
{
#ifdef DEBUG
         if (handler == NULL)
                 abort();
#endif
         INTOFF;

         exception = e;
         TRACE(("check 6\n"));
         longjmp(handler->loc, 1);
         TRACE(("check 7\n"));
}

as you can see check 7 is never reached (ok it's obvious), but I cannot 
find
if the longjmp land correctly somewhere or it's the function that 
trigger the
segfault (I suspect the handler->loc point to nowhere...).
I tried to put a TRACE after every setjmp but didn't find the one that 
is the
target of that longjmp...

maybe the correct one is the one in exitshell() ???

here some info on my setup:

host:
centos 6.5

buildroot version 2014.05

buildroot configuration:
BR2_x86_atom=y
BR2_UCLIBC_CONFIG="board/pinky/uclibc.config"
BR2_TARGET_GENERIC_HOSTNAME="pinky"
BR2_TARGET_GENERIC_GETTY_PORT="tty1"
BR2_TARGET_GENERIC_GETTY_TERM="linux"
BR2_ROOTFS_OVERLAY="board/pinky/overlay"
BR2_LINUX_KERNEL=y
BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/pinky/linux.config"
BR2_PACKAGE_BUSYBOX_SHOW_OTHERS=y
BR2_PACKAGE_HOSTAPD=y
BR2_PACKAGE_HOSTAPD_EAP=y
BR2_PACKAGE_IW=y
BR2_PACKAGE_OPKG=y
BR2_PACKAGE_OPKG_GPG_SIGN=y
BR2_PACKAGE_DASH=y
BR2_PACKAGE_JOE=y
BR2_TARGET_GRUB=y

(dash version 0.5.7, downloaded from buildroot, some patches from debian,
it seems version 0.5.7-3)
I hope you can reproduce this bug on your system with those info.

regards
Luigi
