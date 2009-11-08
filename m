From: Eitan Adler <eitanadlerlist@gmail.com>
Subject: patch to get dash to build on FreeBSD
Date: Sun, 8 Nov 2009 09:33:33 +0200
Message-ID: <a0777e080911072333o1a336148oee139c2e40041907@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:45516 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944AbZKHHds (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 8 Nov 2009 02:33:48 -0500
Received: by fg-out-1718.google.com with SMTP id d23so332316fga.1
        for <dash@vger.kernel.org>; Sat, 07 Nov 2009 23:33:53 -0800 (PST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

mksignames.c fails to build on freeBSD.
If you apply the following patch the shell builds and based on very
limited testing the dash appears to work.

diff -urN dash-0.5.5.1/src/mksignames.c dash/src/mksignames.c
--- dash-0.5.5.1/src/mksignames.c	2009-01-14 01:37:13.000000000 +0200
+++ dash/src/mksignames.c	2009-11-08 09:27:50.000000000 +0200
@@ -34,7 +34,11 @@
  */
 #define LASTSIG NSIG-1

-char *signal_names[2 * NSIG + 3];
+#if defined(__FreeBSD__)
+	char *signal_names[SIGRTMAX];
+#else
+	char *signal_names[2 * NSIG + 3];
+#endif

 #define signal_names_size (sizeof(signal_names)/sizeof(signal_names[0]))

Files dash-0.5.5.1/src/mksignames.core and dash/src/mksignames.core differ
