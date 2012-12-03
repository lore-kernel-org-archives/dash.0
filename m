From: Roy <roytam@gmail.com>
Subject: [PATCH] printf: use %ll instead of %j
Date: Mon, 03 Dec 2012 15:42:37 +0800
Message-ID: <op.woqc1kj2dyj81a@2fprep>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:42865 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751293Ab2LCHpB (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 3 Dec 2012 02:45:01 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcsd-dash@m.gmane.org>)
	id 1TfQi7-0004mp-KQ
	for dash@vger.kernel.org; Mon, 03 Dec 2012 08:45:03 +0100
Received: from 203186096001.static.ctinets.com ([203.186.96.1])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Mon, 03 Dec 2012 08:45:03 +0100
Received: from roytam by 203186096001.static.ctinets.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Mon, 03 Dec 2012 08:45:03 +0100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

MSYS libc does not support %j[dXx] format, only %ll[dXx] is supported.

diff --git a/src/bltin/printf.c b/src/bltin/printf.c
index 893295c..12ce660 100644
--- a/src/bltin/printf.c
+++ b/src/bltin/printf.c
@@ -319,11 +319,12 @@ mklong(const char *str, const char *ch)
         char *copy;
         size_t len;

-       len = ch - str + 3;
+       len = ch - str + 4;
         STARTSTACKSTR(copy);
         copy = makestrspace(len, copy);
-       memcpy(copy, str, len - 3);
-       copy[len - 3] = 'j';
+       memcpy(copy, str, len - 4);
+       copy[len - 4] = 'l';
+       copy[len - 3] = 'l';
         copy[len - 2] = *ch;
         copy[len - 1] = '\0';
         return (copy);

