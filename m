From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/4] [EVAL] Take advantage of EV_EXIT in evalstring
Date: Sun, 10 Apr 2011 02:35:49 -0500
Message-ID: <20110410073549.GC17649@elie>
References: <20110410071734.GA16736@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61409 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754886Ab1DJHfy (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 10 Apr 2011 03:35:54 -0400
Received: by iwn34 with SMTP id 34so4680897iwn.19
        for <dash@vger.kernel.org>; Sun, 10 Apr 2011 00:35:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110410071734.GA16736@elie>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Jilles Tjoelker <jilles@stack.nl>, Drake Wilson <drake@begriffli.ch>, Reuben Thomas <rrt@sc3d.org>

From: Jilles Tjoelker <jilles@stack.nl>
Date: Sat, 13 Jun 2009 16:17:45 -0500

Check if there may be additional data in the string after parsing each
command.  If there is none, let the EV_EXIT flag take effect so a fork
can be omitted in specific cases.

No change in behavior intended --- all current callers leave the
EV_EXIT flag cleared.

[jn: the original from FreeBSD SVN r194128 would unconditionally exit
 if the EV_EXIT bit was set. but for simplicity and consistency with
 other non-evaltree eval* commands, this version relies on the caller
 to exit when the command is empty.  One can insert a

	evaltree(NULL, flags);

 call before popfile() to get the original's semantics.

 Any outstanding bugs are my fault.]

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 src/eval.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/src/eval.c b/src/eval.c
index 5c26133..77a9d00 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -165,7 +165,10 @@ evalstring(char *s, int flags)
 
 	status = 0;
 	while ((n = parsecmd(0)) != NEOF) {
-		evaltree(n, flags);
+		if (preadateof())
+			evaltree(n, flags);
+		else
+			evaltree(n, flags & ~EV_EXIT);
 		status = exitstatus;
 		popstackmark(&smark);
 		if (evalskip)
-- 
1.7.5.rc0

