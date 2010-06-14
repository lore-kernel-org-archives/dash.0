From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] [EVAL] with set -e exit the shell if a subshell exits
	non-zero
Date: Mon, 14 Jun 2010 09:56:03 +0000
Message-ID: <20100614095603.27834.qmail@728ec0bb900c60.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from a.ns.smarden.org ([109.68.224.7]:50946 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755866Ab0FNJ4G (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 14 Jun 2010 05:56:06 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>

Example:

$ dash -c 'set -e; (false); echo here'
here

With this commit, dash exits 1 before echo.

The bug was reported by Stefan Fritsch through
 http://bugs.debian.org/514863

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 src/eval.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/eval.c b/src/eval.c
index 439f881..a0d0f3b 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -251,6 +251,8 @@ checkexit:
 	case NSUBSHELL:
 	case NBACKGND:
 		evalfn = evalsubshell;
+		if (eflag && !(flags & EV_TESTED))
+			checkexit = ~0;
 		goto calleval;
 	case NPIPE:
 		evalfn = evalpipe;
-- 
1.6.0.3

