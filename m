From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/4] [MAIN] Optimize dash -c "command" to avoid a fork
Date: Sun, 10 Apr 2011 02:36:49 -0500
Message-ID: <20110410073649.GD17649@elie>
References: <20110410071734.GA16736@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65069 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754915Ab1DJHgx (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 10 Apr 2011 03:36:53 -0400
Received: by iwn34 with SMTP id 34so4681312iwn.19
        for <dash@vger.kernel.org>; Sun, 10 Apr 2011 00:36:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110410071734.GA16736@elie>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Jilles Tjoelker <jilles@stack.nl>, Drake Wilson <drake@begriffli.ch>, Reuben Thomas <rrt@sc3d.org>

From: Jilles Tjoelker <jilles@stack.nl>
Date: Sat, 13 Jun 2009 16:17:45 -0500

This change only affects strings passed to -c, when the -s option is
not used.

Use the EV_EXIT flag to inform the eval machinery that the string
being passed is the entirety of input.  This way, a fork may be
omitted in many special cases.

If there are empty lines after the last command, the evalcmd will not
see the end early enough and forks will not be omitted. The same thing
seems to happen in bash.

Example:
  sh -c 'ps lT'
No longer shows a shell process waiting for ps to finish.

[jn: ported from FreeBSD SVN r194128.  Bugs are mine.]

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 src/main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/main.c b/src/main.c
index b38dc27..af987c6 100644
--- a/src/main.c
+++ b/src/main.c
@@ -171,7 +171,7 @@ state2:
 state3:
 	state = 4;
 	if (minusc)
-		evalstring(minusc, 0);
+		evalstring(minusc, sflag ? 0 : EV_EXIT);
 
 	if (sflag || minusc == NULL) {
 state4:	/* XXX ??? - why isn't this before the "if" statement */
-- 
1.7.5.rc0

