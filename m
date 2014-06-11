From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] [MAN] Clarify "trap '' signals" syntax in manual page
Date: Wed, 11 Jun 2014 16:21:37 -0700
Message-ID: <20140611232137.GJ8557@google.com>
References: <1402528126-27427-1-git-send-email-adam.buchbinder@gmail.com>
 <20140611231305.GG8557@google.com>
 <20140611231738.GH8557@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:53470 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754285AbaFKXVl (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 11 Jun 2014 19:21:41 -0400
Received: by mail-pb0-f42.google.com with SMTP id ma3so56837pbc.1
        for <dash@vger.kernel.org>; Wed, 11 Jun 2014 16:21:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140611231738.GH8557@google.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Adam Buchbinder <abuchbinder@google.com>
Cc: dash@vger.kernel.org, Adam Buchbinder <adam.buchbinder@gmail.com>

When the manpage states

| <action> may be null, which cause the specified signals to be ignored.

it is not immediately obvious what it means for an action to be
null.  Clarify by explicitly referring to an empty string, as
opposed to a NULL pointer or the string "null".

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 ChangeLog  | 4 ++++
 src/dash.1 | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/ChangeLog b/ChangeLog
index 3f59ac2..765b9b6 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2014-06-11  Jonathan Nieder <jrnieder@gmail.com>
+
+	* Clarify "trap '' signals" syntax in manual page.
+
 2014-06-11  Adam Buchbinder <adam.buchbinder@gmail.com>
 
 	* Clarify that 0 and EXIT are both acceptable for exit traps.
diff --git a/src/dash.1 b/src/dash.1
index a07a52d..68bd5fe 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -2076,7 +2076,9 @@ or
 .Li EXIT ,
 the action is executed when the shell exits.
 .Ar action
-may be null, which cause the specified signals to be ignored.
+may be empty
+.Li ( "''" ) ,
+which causes the specified signals to be ignored.
 With
 .Ar action
 omitted or set to `-' the specified signals are set to their default action.
-- 
2.0.0.526.g5318336

