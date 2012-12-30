From: Adam Buchbinder <adam.buchbinder@gmail.com>
Subject: [PATCH] [MAN] 0 and EXIT both work for exit traps.
Date: Sun, 30 Dec 2012 10:28:55 -0500
Message-ID: <1356881335-11024-1-git-send-email-adam.buchbinder@gmail.com>
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-ye0-f176.google.com ([209.85.213.176]:38863 "EHLO
	mail-ye0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754680Ab2L3P53 (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 30 Dec 2012 10:57:29 -0500
Received: by mail-ye0-f176.google.com with SMTP id m1so1901525yen.35
        for <dash@vger.kernel.org>; Sun, 30 Dec 2012 07:57:29 -0800 (PST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Adam Buchbinder <adam.buchbinder@gmail.com>

I saw a discussion in which there was some confusion over whether or not
you can use a symbolic name, since the manpage doesn't specifically say so.

Signed-off-by: Adam Buchbinder <adam.buchbinder@gmail.com>
---
 ChangeLog  |    4 ++++
 src/dash.1 |    4 +++-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/ChangeLog b/ChangeLog
index d84d3b7..73aa14f 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2012-12-29  Adam Buchbinder <adam.buchbinder@gmail.com>
+
+	* Clarify that 0 and EXIT are both acceptable for exit traps.	
+
 2012-06-09  Christoph Mathys <eraserix@gmail.com>
 
 	* Add support for ulimit -r.
diff --git a/src/dash.1 b/src/dash.1
index a9cb491..3a1c274 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -2071,7 +2071,9 @@ The signals are specified by signal number or as the name of the signal.
 If
 .Ar signal
 is
-.Li 0 ,
+.Li 0
+or
+.Li EXIT ,
 the action is executed when the shell exits.
 .Ar action
 may be null, which cause the specified signals to be ignored.
-- 
1.7.7.3

