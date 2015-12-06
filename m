From: Gioele Barabucci <gioele@svario.it>
Subject: [PATCH] [BUILTIN] Reject malformed printf specifications with digits
 after '*'
Date: Sun, 6 Dec 2015 15:09:42 +0100
Message-ID: <n41fj7$tj9$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000505020300070602060700"
Return-path: <dash-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:49557 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753132AbbLFOJ4 (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 6 Dec 2015 09:09:56 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcsd-dash@m.gmane.org>)
	id 1a5a0f-0001Hq-DY
	for dash@vger.kernel.org; Sun, 06 Dec 2015 15:09:53 +0100
Received: from x4db6bd17.dyn.telefonica.de ([77.182.189.23])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Sun, 06 Dec 2015 15:09:53 +0100
Received: from gioele by x4db6bd17.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Sun, 06 Dec 2015 15:09:53 +0100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

This is a multi-part message in MIME format.
--------------000505020300070602060700
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello,

I am forwarding a patch related to the bug described at
<https://bugs.debian.org/779618>.

You can find the same patch at
<https://github.com/gioele/dash/commit/ebdd2d7992c4b2bf49d9af2eed33e3c18c86dfc6>.

I refreshed the patch to be compatible with the current code, but left
the original author as the git author. I hope this is fine.

Regards,

--
Gioele Barabucci <gioele@svario.it>




--------------000505020300070602060700
Content-Type: text/x-patch;
 name="0001-BUILTIN-Reject-malformed-printf-specifications-with-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-BUILTIN-Reject-malformed-printf-specifications-with-.pa";
 filename*1="tch"

From ebdd2d7992c4b2bf49d9af2eed33e3c18c86dfc6 Mon Sep 17 00:00:00 2001
From: Patrick Brown <opensource@whoopdedo.org>
Date: Mon, 2 Mar 2015 23:10:09 -0500
Subject: [PATCH] [BUILTIN] Reject malformed printf specifications with digits
 after '*'

Dash doesn't notice when a format string has digits following a * width
specifier.

    $ dash -c 'printf "%*0s  " 1 2 && echo FAIL || echo OK'
    %10s  FAIL

    $ bash -c 'printf "%*0s  " 1 2 && echo FAIL || echo OK'
    bash: line 0: printf: `0': invalid format character
    OK
    $ mksh -c 'printf "%*0s  " 1 2 && echo FAIL || echo OK'
    printf: %*0: invalid conversion specification
    OK

With this patch dash complains about the malformed specifications.

    $ ./src/dash -c 'printf "%*0s  " 1 2 && echo FAIL || echo OK'
    ./src/dash: 1: printf: %*0: invalid directive
    OK

Fixes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=779618

Originally-by: Patrick Brown <opensource@whoopdedo.org>
Forwarded-by: Gioele Barabucci <gioele@svario.it>
---
 src/bltin/printf.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/src/bltin/printf.c b/src/bltin/printf.c
index 9673e10..83077a7 100644
--- a/src/bltin/printf.c
+++ b/src/bltin/printf.c
@@ -175,17 +175,20 @@ pc:
 
 			/* skip to field width */
 			fmt += strspn(fmt, SKIP1);
-			if (*fmt == '*')
+			if (*fmt == '*') {
 				*param++ = getuintmax(1);
-
-			/* skip to possible '.', get following precision */
-			fmt += strspn(fmt, SKIP2);
-			if (*fmt == '.')
 				++fmt;
-			if (*fmt == '*')
-				*param++ = getuintmax(1);
--------------000505020300070602060700--
