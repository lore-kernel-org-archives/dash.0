From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/4] [INPUT] Introduce preadateof predicate to check for end
 of input
Date: Sun, 10 Apr 2011 02:21:06 -0500
Message-ID: <20110410072106.GA17649@elie>
References: <20110410071734.GA16736@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34989 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876Ab1DJHVN (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 10 Apr 2011 03:21:13 -0400
Received: by iwn34 with SMTP id 34so4675512iwn.19
        for <dash@vger.kernel.org>; Sun, 10 Apr 2011 00:21:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110410071734.GA16736@elie>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Jilles Tjoelker <jilles@stack.nl>, Drake Wilson <drake@begriffli.ch>, Reuben Thomas <rrt@sc3d.org>

From: Jilles Tjoelker <jilles@stack.nl>
Date: Sat, 13 Jun 2009 16:17:45 -0500

For example, this can be used to detect tail calls in the string
passed to -c.

[jn: originally from Jilles as part of FreeBSD SVN r194128]

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Could be squashed with patch 3.  I split it out while considering
using the same trick in cmdloop.

 src/input.c |   17 +++++++++++++++++
 src/input.h |    1 +
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/src/input.c b/src/input.c
index d31c45b..39d7893 100644
--- a/src/input.c
+++ b/src/input.c
@@ -325,6 +325,23 @@ again:
 }
 
 /*
+ * Returns if we are certain we are at EOF. Does not cause any more input
+ * to be read from the outside world.
+ */
+
+int
+preadateof(void)
+{
+	if (parsenleft > 0)
+		return 0;
+	if (parsefile->strpush)
+		return 0;
+	if (parsenleft == EOF_NLEFT || parsefile->buf == NULL)
+		return 1;
+	return 0;
+}
+
+/*
  * Undo the last call to pgetc.  Only one character may be pushed back.
  * PEOF may be pushed back.
  */
diff --git a/src/input.h b/src/input.h
index 50a7797..d123045 100644
--- a/src/input.h
+++ b/src/input.h
@@ -53,6 +53,7 @@ extern char *parsenextc;	/* next character in input buffer */
 int pgetc(void);
 int pgetc2(void);
 int preadbuffer(void);
+int preadateof(void);
 void pungetc(void);
 void pushstring(char *, void *);
 void popstring(void);
-- 
1.7.5.rc0

