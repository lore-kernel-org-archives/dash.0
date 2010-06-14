From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] [EVAL] don't clear eflag when forking subshell
Date: Mon, 14 Jun 2010 09:56:38 +0000
Message-ID: <20100614095638.28024.qmail@e8dcd834951639.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from a.ns.smarden.org ([109.68.224.7]:51141 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755913Ab0FNJ4j (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 14 Jun 2010 05:56:39 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>

According to
 http://www.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html#tag_02_12
"A subshell environment shall be created as a duplicate of the shell
environment, except that signal traps set by that shell environment
shall be set to the default values."

Currently the eflag is cleared when forking a subshell, e.g.

$ dash -c 'set -e ; z=$(false;echo foo) ; echo $z'
foo

With this commit the eflag is preserved for subshells, and dash exits 1
before echo.

The problem was reported by Vincent Lefevre through
 http://bugs.debian.org/514863

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 src/eval.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/src/eval.c b/src/eval.c
index a0d0f3b..bd4b485 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -627,7 +627,6 @@ evalbackcmd(union node *n, struct backcmd *result)
 				dup2(pip[1], 1);
 				close(pip[1]);
 			}
-			eflag = 0;
 			evaltreenr(n, EV_EXIT);
 			/* NOTREACHED */
 		}
-- 
1.6.0.3

