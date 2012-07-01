From: Isaac Jurado <diptongo@gmail.com>
Subject: [PATCH] [BUILTIN] Allow SIG* signal names.
Date: Sun, 1 Jul 2012 12:12:20 +0200
Message-ID: <4ff0274f.c54fb40a.47e2.6814@mx.google.com>
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:44810 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755491Ab2GAKcv (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 1 Jul 2012 06:32:51 -0400
Received: by wgbdr13 with SMTP id dr13so4356337wgb.1
        for <dash@vger.kernel.org>; Sun, 01 Jul 2012 03:32:50 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org

In other shells, both trap and kill builtins accept two form of signal names,
i.e., TERM and SIGTERM.  Even /bin/kill allows the SIG* form.  Having dash fail
by not recognizing the SIG prefix introduces some confusion among users.
---
 src/trap.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/trap.c b/src/trap.c
index 17316c9..a64133c 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -408,6 +408,9 @@ int decode_signal(const char *string, int minsig)
 		return signo;
 	}
 
+	if (string[0] == 'S' && string[1] == 'I' && string[2] == 'G')
+		string += 3;
+
 	for (signo = minsig; signo < NSIG; signo++) {
 		if (!strcasecmp(string, signal_names[signo])) {
 			return signo;
-- 
1.7.10.4
