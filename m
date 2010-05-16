From: Jilles Tjoelker <jilles@stack.nl>
Subject: [PATCH] [EXPAND] Fix corruption of redirections with byte 0x81.
Date: Mon, 17 May 2010 00:55:54 +0200
Message-ID: <20100516225554.GA92724@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:52289 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752920Ab0EPWz5 (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 16 May 2010 18:55:57 -0400
Received: from turtle.stack.nl (turtle.stack.nl [IPv6:2001:610:1108:5010::132])
	by mx1.stack.nl (Postfix) with ESMTP id 65A8C1DD687
	for <dash@vger.kernel.org>; Mon, 17 May 2010 00:55:54 +0200 (CEST)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

In other ash variants, a partial implementation of ksh-like cmd >file*
adds and removes CTLESC bytes ('\x81') in redirection filenames,
preserving 8-bit transparency. Long ago, dash removed the code to add
the CTLESC bytes, but not the code to remove them, causing corruption of
filenames containing CTLESC. This commit removes the code to remove the
CTLESC bytes.

The CTLESC byte occurs frequently in UTF-8 encoded non-Latin text.

This bug has been reported various times to Ubuntu and Debian (e.g.
Launchpad Ubuntu #422298). This patch is the same as the one submitted
by Alexander Korolkov in Ubuntu #422298.

Signed-off-by: Jilles Tjoelker <jilles@stack.nl>
---
 src/expand.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/src/expand.c b/src/expand.c
index 48c45e5..f2f964c 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -210,8 +210,6 @@ expandarg(union node *arg, struct arglist *arglist, int flag)
 		exparg.lastp = &exparg.list;
 		expandmeta(exparg.list, flag);
 	} else {
-		if (flag & EXP_REDIR) /*XXX - for now, just remove escapes */
-			rmescapes(p);
 		sp = (struct strlist *)stalloc(sizeof (struct strlist));
 		sp->text = p;
 		*exparg.lastp = sp;
-- 
1.7.1
