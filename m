From: Brian Koropoff <bkoropoff@gmail.com>
Subject: [PATCH 1/2] Fix additional use of 'j' printf length modifier.
Date: Fri, 15 Apr 2011 19:34:39 -0700
Message-ID: <1302921279.2620.6.camel@gemini>
References: <1302921010.2620.3.camel@gemini>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43437 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560Ab1DPCek (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 15 Apr 2011 22:34:40 -0400
Received: by pwi15 with SMTP id 15so1366683pwi.19
        for <dash@vger.kernel.org>; Fri, 15 Apr 2011 19:34:40 -0700 (PDT)
In-Reply-To: <1302921010.2620.3.camel@gemini>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

The printf builtin modifies the user's format strings
by prefixing integer conversion specifications with the
'j' (intmax_t) length modifier.  Since this is not portable,
instead prefix them with the length modifier extracted from
the PRIdMAX constant.

Signed-off-by: Brian Koropoff <bkoropoff@gmail.com>
---
 src/bltin/printf.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/src/bltin/printf.c b/src/bltin/printf.c
index b0c3774..4ac2ee8 100644
--- a/src/bltin/printf.c
+++ b/src/bltin/printf.c
@@ -317,15 +317,16 @@ static char *
 mklong(const char *str, const char *ch)
 {
 	char *copy;
-	size_t len;	
+	size_t len;
+	size_t pridmax_len = strlen(PRIdMAX);
 
-	len = ch - str + 3;
+	len = ch - str + pridmax_len;
 	STARTSTACKSTR(copy);
-	copy = makestrspace(len, copy);
-	memcpy(copy, str, len - 3);
-	copy[len - 3] = 'j';
-	copy[len - 2] = *ch;
-	copy[len - 1] = '\0';
+	copy = makestrspace(len + 1, copy);
+	memcpy(copy, str, len - pridmax_len);
+	memcpy(copy + len - pridmax_len, PRIdMAX, pridmax_len - 1);
+	copy[len - 1] = *ch;
+	copy[len] = '\0';
 	return (copy);	
 }
 
-- 
1.7.1


