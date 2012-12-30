From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] [MAN] 0 and EXIT both work for exit traps.
Date: Sun, 30 Dec 2012 12:06:15 -0800
Message-ID: <20121230200615.GC6475@elie.Belkin>
References: <1356881335-11024-1-git-send-email-adam.buchbinder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:56301 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872Ab2L3UGV (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 30 Dec 2012 15:06:21 -0500
Received: by mail-pb0-f43.google.com with SMTP id um15so6734095pbc.16
        for <dash@vger.kernel.org>; Sun, 30 Dec 2012 12:06:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1356881335-11024-1-git-send-email-adam.buchbinder@gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Adam Buchbinder <adam.buchbinder@gmail.com>
Cc: dash@vger.kernel.org

Adam Buchbinder wrote:

> I saw a discussion in which there was some confusion over whether or not
> you can use a symbolic name, since the manpage doesn't specifically say so.

Looks good to me, with one nit:

[...]
> +	* Clarify that 0 and EXIT are both acceptable for exit traps.	

A trailing tab seems to have snuck in.

How about the following on top (for application with "am --scissors")?

-- >8 --
Subject: [MAN] Clarify "trap '' signals" syntax in manual page

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
index f39999e9..d6536954 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2012-12-30  Jonathan Nieder  <jrnieder@gmail.com>
+
+	* Clarify "trap '' signals" syntax in manual page.
+
 2012-12-29  Adam Buchbinder <adam.buchbinder@gmail.com>
 
 	* Clarify that 0 and EXIT are both acceptable for exit traps.
diff --git a/src/dash.1 b/src/dash.1
index 3a1c2749..b47364d9 100644
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
1.8.1.rc3

