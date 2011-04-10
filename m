From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/4] [EVAL] Make eval flags public
Date: Sun, 10 Apr 2011 02:22:05 -0500
Message-ID: <20110410072204.GB17649@elie>
References: <20110410071734.GA16736@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58245 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600Ab1DJHWL (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 10 Apr 2011 03:22:11 -0400
Received: by iyb14 with SMTP id 14so4668564iyb.19
        for <dash@vger.kernel.org>; Sun, 10 Apr 2011 00:22:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110410071734.GA16736@elie>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Jilles Tjoelker <jilles@stack.nl>, Drake Wilson <drake@begriffli.ch>, Reuben Thomas <rrt@sc3d.org>

From: Jilles Tjoelker <jilles@stack.nl>
Date: Sat, 13 Jun 2009 16:17:45 -0500

Evaltree and its variants support three flags:

 - EV_EXIT means to exit when evaluation is complete (for use by the
   "exec" builtin, pipelines, and subshells).
 - EV_TESTED means that this code is the argument to a conditional.
   If some part of it fails and the -e flag is set, it will not cause
   the shell to exit.
 - EV_BACKCMD is an unused vestige from an experiment long past.

There has been no need to advertise the possible flags outside eval.c
so far because the only external callers, main and cmdloop, always
use 0 (no flags).  Expose the flags in eval.h so that can change.

[jn: originally from Jilles as part of FreeBSD SVN r194128; split up
 for clarity.]

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 src/eval.c |    5 -----
 src/eval.h |    5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/eval.c b/src/eval.c
index 426c03a..5c26133 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -65,11 +65,6 @@
 #endif
 
 
-/* flags in argument to evaltree */
-#define EV_EXIT 01		/* exit after evaluating tree */
-#define EV_TESTED 02		/* exit status is checked; ignore -e flag */
-#define EV_BACKCMD 04		/* command executing within back quotes */
