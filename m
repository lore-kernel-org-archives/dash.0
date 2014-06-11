From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] [MAN] 0 and EXIT both work for exit traps.
Date: Wed, 11 Jun 2014 16:20:44 -0700
Message-ID: <20140611232043.GI8557@google.com>
References: <1402528126-27427-1-git-send-email-adam.buchbinder@gmail.com>
 <20140611231305.GG8557@google.com>
 <20140611231738.GH8557@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:39834 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbaFKXUr (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 11 Jun 2014 19:20:47 -0400
Received: by mail-pa0-f45.google.com with SMTP id hz1so313333pad.32
        for <dash@vger.kernel.org>; Wed, 11 Jun 2014 16:20:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140611231738.GH8557@google.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Adam Buchbinder <abuchbinder@google.com>
Cc: dash@vger.kernel.org, Adam Buchbinder <adam.buchbinder@gmail.com>

From: Adam Buchbinder <adam.buchbinder@gmail.com>

I saw a discussion in which there was some confusion over whether or not
you can use a symbolic name, since the manpage doesn't specifically say so.

Signed-off-by: Adam Buchbinder <adam.buchbinder@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 ChangeLog  | 4 ++++
 src/dash.1 | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/ChangeLog b/ChangeLog
index 2a39e34..3f59ac2 100644
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

