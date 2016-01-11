From: Gioele Barabucci <gioele@svario.it>
Subject: [PATCH] man: Document ulimit -v
Date: Mon, 11 Jan 2016 20:12:35 +0100
Message-ID: <56938FD6.3010600@svario.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:53214 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934358AbcAKTMo (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 11 Jan 2016 14:12:44 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcsd-dash@m.gmane.org>)
	id 1aIhtR-00022E-9s
	for dash@vger.kernel.org; Mon, 11 Jan 2016 20:12:41 +0100
Received: from x4db6b989.dyn.telefonica.de ([77.182.185.137])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Mon, 11 Jan 2016 20:12:41 +0100
Received: from gioele by x4db6b989.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Mon, 11 Jan 2016 20:12:41 +0100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Document that `ulimit` can set the `RLIMIT_AS` limit (virtual memory) with
the `-v` flag.

Fixes: https://bugs.debian.org/78556
Reported-by: Vincent Lefevre <vincent@vinc17.net>
Signed-off-by: Gioele Barabucci <gioele@svario.it>
---
 src/dash.1 | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/dash.1 b/src/dash.1
index 832eae7..8b8026d 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -2114,7 +2114,7 @@ printed; for commands and tracked aliases the complete pathname of the
 command is printed.
 .It ulimit Xo
 .Op Fl H \*(Ba Fl S
-.Op Fl a \*(Ba Fl tfdscmlpn Op Ar value
+.Op Fl a \*(Ba Fl tfdscmlpnv Op Ar value
 .Xc
 Inquire about or set the hard or soft limits on processes or set new
 limits.
@@ -2164,6 +2164,9 @@ show or set the limit on the number of processes this user can
 have at one time
 .It Fl n
 show or set the limit on the number files a process can have open at once
+.It Fl v
+show or set the limit on the total virtual memory that can be
+in use by a process (in kilobytes)
 .It Fl r
 show or set the limit on the real-time scheduling priority of a process
 .El
-- 
2.6.4

