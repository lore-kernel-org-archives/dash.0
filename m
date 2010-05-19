From: Gerrit Pape <pape@smarden.org>
Subject: wait regression in 3800d4
Date: Wed, 19 May 2010 19:08:56 +0000
Message-ID: <20100519190856.19606.qmail@ea7dd6dfa89c0a.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from a.ns.smarden.org ([109.68.224.7]:42156 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754248Ab0ESTI6 (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 19 May 2010 15:08:58 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi, since commit 3800d49 the wait builtin shows some unexpected
behavior, see http://bugs.debian.org/581425

To reproduce:

 $ dash -c '
 for i in 1 2 3; do
   (sleep $i; echo $i) &
 done
 wait
 echo all done
 sleep 2'
 1
 all done
 2
 3
 $ 

Expected output:
 1
 2
 3
 all done

I don't completely understand commitdiff 3800d49, and didn't find time
to fix the lack of understanding yet, but this patch seems to fix this
specific issue.

Thanks, Gerrit.

diff --git a/src/jobs.c b/src/jobs.c
index a4fada0..57c0854 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -1136,8 +1136,6 @@ waitproc(int block, int *status)
                if (err || !block)
                        break;
 
-               block = 0;
