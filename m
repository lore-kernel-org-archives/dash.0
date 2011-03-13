From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] [DEBUG] Use va_copy when we use va_list twice
Date: Sun, 13 Mar 2011 11:33:25 -0500
Message-ID: <20110313163259.GA24451@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37315 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526Ab1CMQdb (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 13 Mar 2011 12:33:31 -0400
Received: by gyf1 with SMTP id 1so601688gyf.19
        for <dash@vger.kernel.org>; Sun, 13 Mar 2011 09:33:31 -0700 (PDT)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

When tracing (if the DEBUG compile-time option was set to 1 or 2),
exverror calls TRACEV to print its arguments before passing them on to
exvwarning.  That consumes the arguments, resulting in a segfault:

 $ sh -c '"'
 sh: Syntax error: Unterminated quoted string
 $ sh -o debug -c '"'
 sh: Segmentation fault (core dumped)

Making a copy with va_copy fixes it.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Ran into this while tracking down a potential ifs leak from
<http://bugs.debian.org/618023>.

 src/error.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/src/error.c b/src/error.c
index f1a358d..e51d827 100644
--- a/src/error.c
+++ b/src/error.c
@@ -143,8 +143,10 @@ exverror(int cond, const char *msg, va_list ap)
 {
 #ifdef DEBUG
 	if (msg) {
+		va_list aq;
+		va_copy(aq, ap);
 		TRACE(("exverror(%d, \"", cond));
-		TRACEV((msg, ap));
+		TRACEV((msg, aq));
 		TRACE(("\") pid=%d\n", getpid()));
 	} else
 		TRACE(("exverror(%d, NULL) pid=%d\n", cond, getpid()));
-- 
1.7.4.1

