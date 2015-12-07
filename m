From: Jonathan Perkin <jperkin@joyent.com>
Subject: [PATCH] trap: Implement POSIX.1-2008 trap reset behaviour
Date: Mon, 7 Dec 2015 13:18:33 +0000
Message-ID: <20151207131833.GC735@joyent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35027 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755046AbbLGNSi (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 7 Dec 2015 08:18:38 -0500
Received: by wmuu63 with SMTP id u63so140038026wmu.0
        for <dash@vger.kernel.org>; Mon, 07 Dec 2015 05:18:37 -0800 (PST)
Received: from joyent.com (host86-144-234-20.range86-144.btcentralplus.com. [86.144.234.20])
        by smtp.gmail.com with ESMTPSA id s11sm16760914wmb.14.2015.12.07.05.18.36
        for <dash@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 Dec 2015 05:18:36 -0800 (PST)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

POSIX.1-2008 for trap adds the following behaviour:

    If the first operand is an unsigned decimal integer, the shell shall
    treat all operands as conditions, and shall reset each condition to
    the default value.

Whilst the standard specifies an "unsigned decimal integer", we take the
pragmatic approach of enabling this behaviour iff the first operand is a
valid signal, otherwise it is interpreted as an action.  This matches
the behaviour of most other shells in this regard.
---
 src/trap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/trap.c b/src/trap.c
index 82d4263..2d20c3f 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -112,7 +112,7 @@ trapcmd(int argc, char **argv)
 		}
 		return 0;
 	}
-	if (!ap[1])
+	if ((!ap[1]) || (decode_signal(*ap, 0) >= 0))
 		action = NULL;
 	else
 		action = *ap++;
-- 
2.4.9 (Apple Git-60)

-- 
Jonathan Perkin  -  Joyent, Inc.  -  www.joyent.com
