From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] avoid more undefined handler
Date: Wed, 25 May 2011 14:38:09 +0200
Message-ID: <874o4jc5vy.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:43359 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756968Ab1EYMiQ (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 25 May 2011 08:38:16 -0400
Received: from mx.meyering.net (unknown [82.230.74.64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id E2ADD94021B
	for <dash@vger.kernel.org>; Wed, 25 May 2011 14:38:10 +0200 (CEST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Clang also warned about this:

    ANALYZE: eval.c evalpipe
    eval.c:575:10: warning: Assigned value is garbage or undefined
                    prevfd = pip[0];
                           ^ ~~~~~~

Here's a fix:

2011-05-25  Jim Meyering  <meyering@redhat.com>

	avoid more undefined handler
	* src/eval.c (evalpipe): Ensure that pip[0] is defined before used.


From dca635b44d289eeb6b7d0fb6a60db37fb61bc863 Mon Sep 17 00:00:00 2001
From: Jim Meyering <meyering@redhat.com>
Date: Wed, 25 May 2011 14:35:24 +0200
Subject: [PATCH] avoid more undefined handler

* src/eval.c (evalpipe): Ensure that pip[0] is defined before used.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 src/eval.c |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/src/eval.c b/src/eval.c
index 911fb2c..a93e602 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -547,6 +547,7 @@ evalpipe(union node *n, int flags)
 	prevfd = -1;
 	for (lp = n->npipe.cmdlist ; lp ; lp = lp->next) {
 		prehash(lp->n);
+		pip[0] = -1;
 		pip[1] = -1;
 		if (lp->next) {
 			if (pipe(pip) < 0) {
--
1.7.5.2.609.g6dbbf
