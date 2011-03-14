From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] [DEBUG] Use va_copy when reusing a va_list
Date: Mon, 14 Mar 2011 01:29:27 -0500
Message-ID: <20110314062909.GA18712@elie>
References: <20110313163259.GA24451@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:32808 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753756Ab1CNG3g (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 14 Mar 2011 02:29:36 -0400
Received: by gwaa18 with SMTP id a18so1699598gwa.19
        for <dash@vger.kernel.org>; Sun, 13 Mar 2011 23:29:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110313163259.GA24451@elie>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

When tracing (with the DEBUG compile-time option set to 1 or 2),
exverror calls TRACEV to print its arguments before passing them on.
So the arguments are consumed by the time exvwarning looks for them,
resulting in a segfault:

 $ sh -c '"'
 sh: Syntax error: Unterminated quoted string
 $ sh -o debug -c '"'
 sh: Segmentation fault (core dumped)

Make a copy with va_copy to avoid this.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
v1 left out va_end.  Sorry for the nonsense.

 src/error.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/src/error.c b/src/error.c
index f1a358d..db2eb62 100644
--- a/src/error.c
+++ b/src/error.c
@@ -143,8 +143,11 @@ exverror(int cond, const char *msg, va_list ap)
 {
 #ifdef DEBUG
 	if (msg) {
+		va_list aq;
 		TRACE(("exverror(%d, \"", cond));
-		TRACEV((msg, ap));
+		va_copy(aq, ap);
+		TRACEV((msg, aq));
+		va_end(aq);
 		TRACE(("\") pid=%d\n", getpid()));
 	} else
 		TRACE(("exverror(%d, NULL) pid=%d\n", cond, getpid()));
-- 
1.7.4.1

