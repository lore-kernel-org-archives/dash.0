From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] [SHELL] print \n upon EOF (CTRL-D) when run interactively
Date: Wed, 11 Feb 2009 14:43:00 +0000
Message-ID: <20090211144300.18734.qmail@5183352cb764c2.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from a.ns.smarden.org ([212.42.242.37]:2553 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750808AbZBKOtn (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 11 Feb 2009 09:49:43 -0500
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Suggested by jidanni through
 http://bugs.debian.org/476422

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 src/main.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/src/main.c b/src/main.c
index 7d07e2d..5f1ff0e 100644
--- a/src/main.c
+++ b/src/main.c
@@ -228,8 +228,15 @@ cmdloop(int top)
 			if (!top || numeof >= 50)
 				break;
 			if (!stoppedjobs()) {
-				if (!Iflag)
+				if (!Iflag) {
+					if (iflag) {
+						out2c('\n');
+#ifdef FLUSHERR
+						flushout(out2);
+#endif
+					}
 					break;
+				}
 				out2str("\nUse \"exit\" to leave shell.\n");
 			}
 			numeof++;
-- 
1.6.1.2.346.g8600b3.dirty

