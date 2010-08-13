From: Jilles Tjoelker <jilles@stack.nl>
Subject: [PATCH] [VAR] Fix history (libedit only).
Date: Fri, 13 Aug 2010 15:52:09 +0200
Message-ID: <20100813135209.GB73073@stack.nl>
References: <AANLkTi=7L7EC0xuBF4fqBksFAMAmjEiCc5VgAj75Hg=h@mail.gmail.com>
 <20100808131732.GB83966@stack.nl>
 <AANLkTimKQcUa=dpDVoO9TdiH3A5iW1_hJRsOdDE2LB9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:55822 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S934340Ab0HMNwL (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 13 Aug 2010 09:52:11 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimKQcUa=dpDVoO9TdiH3A5iW1_hJRsOdDE2LB9f@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Wez Furlong <kingwez@gmail.com>
Cc: dash@vger.kernel.org

Git commit 0df96793ef6aa103df228d7dfe56099b7d721a15 "[SHELL] Add
preliminary LINENO support" added the LINENO variable in the middle of
other initialized variables, causing some macros for TERM and HISTSIZE
to break (both of these are only used if libedit support is compiled in,
which is not the case by default).

The breakage is the same as can be seen by setting HISTSIZE=0.

Also add a comment warning about this.

The breakage was reported by Wez Furlong.
---
 src/var.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/var.c b/src/var.c
index 3efc943..25c2216 100644
--- a/src/var.c
+++ b/src/var.c
@@ -78,6 +78,7 @@ const char defifsvar[] = "IFS= \t\n";
 const char defifs[] = " \t\n";
 #endif
 
+/* Some macros in var.h depend on the order, add new variables to the end. */
 struct var varinit[] = {
 #if ATTY
 	{ 0,	VSTRFIXED|VTEXTFIXED|VUNSET,	"ATTY\0",	0 },
@@ -94,11 +95,11 @@ struct var varinit[] = {
 	{ 0,	VSTRFIXED|VTEXTFIXED,		"PS2=> ",	0 },
 	{ 0,	VSTRFIXED|VTEXTFIXED,		"PS4=+ ",	0 },
 	{ 0,	VSTRFIXED|VTEXTFIXED,		"OPTIND=1",	getoptsreset },
-	{ 0,	VSTRFIXED|VTEXTFIXED,		"LINENO=1",	0 },
 #ifndef SMALL
 	{ 0,	VSTRFIXED|VTEXTFIXED|VUNSET,	"TERM\0",	0 },
 	{ 0,	VSTRFIXED|VTEXTFIXED|VUNSET,	"HISTSIZE\0",	sethistsize },
 #endif
+	{ 0,	VSTRFIXED|VTEXTFIXED,		"LINENO=1",	0 },
 };
 
 STATIC struct var *vartab[VTABSIZE];
-- 
1.7.1.1
