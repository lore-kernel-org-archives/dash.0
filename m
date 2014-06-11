From: Adam Buchbinder <abuchbinder@google.com>
Subject: [PATCH 1/2] [MAN] 0 and EXIT both work for exit traps.
Date: Wed, 11 Jun 2014 16:08:45 -0700
Message-ID: <1402528126-27427-1-git-send-email-adam.buchbinder@gmail.com>
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:53248 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbaFKXI6 (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 11 Jun 2014 19:08:58 -0400
Received: by mail-pd0-f172.google.com with SMTP id fp1so291532pdb.31
        for <dash@vger.kernel.org>; Wed, 11 Jun 2014 16:08:58 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: jrnieder@gmail.com, Adam Buchbinder <adam.buchbinder@gmail.com>

I saw a discussion in which there was some confusion over whether or not
you can use a symbolic name, since the manpage doesn't specifically say so.

Signed-off-by: Adam Buchbinder <adam.buchbinder@gmail.com>
---
 ChangeLog  | 4 ++++
 src/dash.1 | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/ChangeLog b/ChangeLog
index 2a39e34..81df8d1 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2014-06-11  Adam Buchbinder <adam.buchbinder@gmail.com>
+
+	* Clarify that 0 and EXIT are both acceptable for exit traps.	
+
 2013-08-23  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Propagate EXP_QPAT in subevalvar.
diff --git a/src/dash.1 b/src/dash.1
index 6241a61..a07a52d 100644
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
2.0.0.526.g5318336

