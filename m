From: Adam Buchbinder <abuchbinder@google.com>
Subject: [PATCH 2/2] [MAN] Clarify "trap '' signals" syntax in man page
Date: Wed, 11 Jun 2014 16:08:46 -0700
Message-ID: <1402528126-27427-2-git-send-email-adam.buchbinder@gmail.com>
References: <1402528126-27427-1-git-send-email-adam.buchbinder@gmail.com>
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:59098 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbaFKXJF (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 11 Jun 2014 19:09:05 -0400
Received: by mail-pa0-f41.google.com with SMTP id kq14so306685pab.28
        for <dash@vger.kernel.org>; Wed, 11 Jun 2014 16:09:03 -0700 (PDT)
In-Reply-To: <1402528126-27427-1-git-send-email-adam.buchbinder@gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: jrnieder@gmail.com

From: Jonathan Nieder <jrnieder@gmail.com>

When the manpage states

| <action> may be null, which cause the specified signals to be ignored.

it is not immediately obvious what it means for an action to be
null.  Clarify by explicitly referring to an empty string, as
opposed to a NULL pointer or the string "null".

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 ChangeLog | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ChangeLog b/ChangeLog
index 81df8d1..5559a24 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2014-06-11  Jonathan Nieder  <jrnieder@gmail.com>
+
+	* Clarify "trap '' signals" syntax in manual page.
+
 2014-06-11  Adam Buchbinder <adam.buchbinder@gmail.com>
 
 	* Clarify that 0 and EXIT are both acceptable for exit traps.	
-- 
2.0.0.526.g5318336

