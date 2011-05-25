From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] avoid using undefined handler
Date: Wed, 25 May 2011 14:30:53 +0200
Message-ID: <87aaebc682.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:48322 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756863Ab1EYMbH (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 25 May 2011 08:31:07 -0400
Received: from mx.meyering.net (unknown [82.230.74.64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id C909D9401A3
	for <dash@vger.kernel.org>; Wed, 25 May 2011 14:30:54 +0200 (CEST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Clang had some legitimate warnings:

2011-05-25  Jim Meyering  <meyering@redhat.com>

	avoid using undefined handler
	* src/eval.c (evalbltin, evalfun): Set savehandler before calling
	setjmp with the possible "goto *done", where savehandler is used.
	Otherwise, clang warns that "Assigned value is garbage or undefined"
	at the point where "savehandler" is used on the RHS.

From 067f8b4da3005ab226652b19ed796d67bf1fa6d4 Mon Sep 17 00:00:00 2001
From: Jim Meyering <meyering@redhat.com>
Date: Wed, 25 May 2011 14:27:14 +0200
Subject: [PATCH] avoid using undefined handler

* src/eval.c (evalbltin, evalfun): Set savehandler before calling
setjmp with the possible "goto *done", where savehandler is used.
Otherwise, clang warns that "Assigned value is garbage or undefined"
at the point where "savehandler" is used on the RHS.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 src/eval.c |    4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/eval.c b/src/eval.c
index 426c03a..911fb2c 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -911,76 +911,76 @@ out:
 	if (lastarg)
 		/* dsl: I think this is intended to be used to support
 		 * '_' in 'vi' command mode during line editing...
 		 * However I implemented that within libedit itself.
 		 */
 		setvar("_", lastarg, 0);
 	popstackmark(&smark);
 }

 STATIC int
 evalbltin(const struct builtincmd *cmd, int argc, char **argv, int flags)
 {
 	char *volatile savecmdname;
 	struct jmploc *volatile savehandler;
 	struct jmploc jmploc;
 	int status;
 	int i;

 	savecmdname = commandname;
+	savehandler = handler;
 	if ((i = setjmp(jmploc.loc)))
 		goto cmddone;
-	savehandler = handler;
 	handler = &jmploc;
 	commandname = argv[0];
 	argptr = argv + 1;
 	optptr = NULL;			/* initialize nextopt */
 	if (cmd == EVALCMD)
 		status = evalcmd(argc, argv, flags);
 	else
 		status = (*cmd->builtin)(argc, argv);
 	flushall();
 	status |= outerr(out1);
 	exitstatus = status;
 cmddone:
 	freestdout();
 	commandname = savecmdname;
 	handler = savehandler;

 	return i;
 }

 STATIC int
 evalfun(struct funcnode *func, int argc, char **argv, int flags)
 {
 	volatile struct shparam saveparam;
 	struct jmploc *volatile savehandler;
 	struct jmploc jmploc;
 	int e;
 	int savefuncline;

 	saveparam = shellparam;
 	savefuncline = funcline;
+	savehandler = handler;
 	if ((e = setjmp(jmploc.loc))) {
 		goto funcdone;
 	}
 	INTOFF;
-	savehandler = handler;
 	handler = &jmploc;
 	shellparam.malloc = 0;
 	func->count++;
 	funcline = func->n.ndefun.linno;
 	INTON;
 	shellparam.nparam = argc - 1;
 	shellparam.p = argv + 1;
 	shellparam.optind = 1;
 	shellparam.optoff = -1;
 	pushlocalvars();
 	evaltree(func->n.ndefun.body, flags & EV_TESTED);
 	poplocalvars(0);
 funcdone:
 	INTOFF;
 	funcline = savefuncline;
 	freefunc(func);
 	freeparam(&shellparam);
 	shellparam = saveparam;
 	handler = savehandler;
--
1.7.5.2.609.g6dbbf
