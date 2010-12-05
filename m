From: Jilles Tjoelker <jilles@stack.nl>
Subject: [PATCH] [EXPAND] Do not split the result of tilde expansion
Date: Sun, 5 Dec 2010 18:31:59 +0100
Message-ID: <20101205173159.GA90217@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:62322 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756144Ab0LERcC (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 5 Dec 2010 12:32:02 -0500
Received: from turtle.stack.nl (turtle.stack.nl [IPv6:2001:610:1108:5010::132])
	by mx1.stack.nl (Postfix) with ESMTP id AD8711DD7CC
	for <dash@vger.kernel.org>; Sun,  5 Dec 2010 18:31:59 +0100 (CET)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

A tilde expansion generates a valid pathname. Splitting it using IFS
either leaves it unchanged or changes it to something unintended.

This fixes FreeBSD sh test expansion/tilde1.0 and does not change the
outcome of the other tests.

This fixes Debian bug #601096.

Example:
  IFS=m HOME=/tmp; printf "%s\n" ~
---
 src/expand.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/src/expand.c b/src/expand.c
index 1b77b7c..60d4798 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -395,7 +395,6 @@ done:
 	*p = c;
 	startloc = expdest - (char *)stackblock();
 	strtodest(home, SQSYNTAX, quotes);
-	recordregion(startloc, expdest - (char *)stackblock(), 0);
 	return (p);
 lose:
 	*p = c;
-- 
1.7.3.2

