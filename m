From: Rink Springer <rink@rink.nu>
Subject: [PATCH] Remove dependency on fmatch.h if it does not exit
Date: Fri, 2 Feb 2018 08:44:55 +0100
Message-ID: <20180202074455.GD1669@rink.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8t9RHnE3ZwKMSgU+"
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.zhmu.nl ([37.247.37.64]:30282 "EHLO mail.zhmu.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750795AbeBBHy2 (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 2 Feb 2018 02:54:28 -0500
Received: from mail.zhmu.nl (mail.zhmu.nl [37.247.37.64])
        by mail.zhmu.nl (Postfix) with ESMTP id 4EC3E6433
        for <dash@vger.kernel.org>; Fri,  2 Feb 2018 08:44:56 +0100 (CET)
Received: from mail.zhmu.nl ([37.247.37.64])
        by mail.zhmu.nl (anathema.codehulu.net [37.247.37.64]) (amavisd-new, port 10024)
        with ESMTP id FpGAj58FAPZg for <dash@vger.kernel.org>;
        Fri,  2 Feb 2018 08:44:55 +0100 (CET)
Received: from gloom.zhmu.nl (mail.zhmu.nl [37.247.37.64])
        by mail.zhmu.nl (Postfix) with ESMTP id C41756426
        for <dash@vger.kernel.org>; Fri,  2 Feb 2018 08:44:55 +0100 (CET)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[ Ugh; forgot to attach patch - apologies, I need more coffee ]

Dear all,

Attached is a trivial patch that removes the assumption that fnmatch.h
is available - the configure script already checks for fnmatch(3) and
supplies its own implementation if necessary, but fnmatch.h is always
included.

Let me know what you think.

Regards,
Rink

--8t9RHnE3ZwKMSgU+
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="dash-fnmatch.diff"

Do not assume we can include fnmatch.h

Signed-off-by: Rink Springer <rink@rink.nu>

diff --git a/src/expand.c b/src/expand.c
index 2a50830..1ab5757 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -45,7 +45,9 @@
 #include <inttypes.h>
 #include <limits.h>
 #include <string.h>
+#ifdef HAVE_FNMATCH
 #include <fnmatch.h>
+#endif
 #ifdef HAVE_GLOB
 #include <glob.h>
 #endif

--8t9RHnE3ZwKMSgU+--
