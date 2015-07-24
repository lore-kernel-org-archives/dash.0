From: Aleksandar Ristovski <aleksandar.ristovski@gmail.com>
Subject: shell: dash - large file support
Date: Fri, 24 Jul 2015 14:50:48 -0400
Message-ID: <CAPaOzWwJkwozmDrk2BA5xHF+E6iM5mDrV9ORz=4RiFCdsKYbZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:33213 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865AbbGXSuu (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 24 Jul 2015 14:50:50 -0400
Received: by wicmv11 with SMTP id mv11so75253666wic.0
        for <dash@vger.kernel.org>; Fri, 24 Jul 2015 11:50:49 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hello,

For builds that build 32-bit dash, configure misses to setup large
file support resulting in issues with large files.

For example:
...dp/dash-0.5.8/build$ ls -l /tmp/largefile.sh
-rw-rw-r-- 1 aristovski aristovski 3794653588 Jul 24 14:12 /tmp/largefile.sh
...dp/dash-0.5.8/build$ ./src/dash /tmp/largefile.sh
./src/dash: 0: Can't open /tmp/largefile.sh


Where dash was configured (on a 64-bit platform) like so:

...dp/dash-0.5.8/build$ CFLAGS=-m32 ../configure && make -j8


Now, if I make the change in configure.ac and reconfigure the project,
I get proper operation:

...0.5.8.patched/build$ ./src/dash /tmp/largefile.sh
Running...
...


(the actual working of the 'largefile.sh' is removed for brevity)


Thank you,

Aleksandar Ristovski


Patch:


--- dash-0.5.8/configure.ac     2014-09-28 04:19:32.000000000 -0400
+++ dash-0.5.8.patched/configure.ac     2015-07-24 14:41:05.855055430 -0400
@@ -4,6 +4,9 @@ AC_CONFIG_SRCDIR([src/main.c])

 AC_CONFIG_HEADERS(config.h)

+dnl On 32-bit builds, check for large file support
+AC_SYS_LARGEFILE
+
 dnl Checks for programs.
 AC_PROG_CC
 AC_GNU_SOURCE
