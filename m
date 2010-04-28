From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] [EVAL] fix parse_command_args to reliably parse --
Date: Wed, 28 Apr 2010 22:11:43 +0200
Message-ID: <20100428201143.3496.qmail@e3594ea3db687a.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from a.ns.smarden.org ([109.68.224.7]:41970 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757010Ab0D1US0 (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 28 Apr 2010 16:18:26 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org

parse_command_args() returning a **argv pointer with *argv == 0 makes
dash segfault in find_command().  To reproduce run

 dash -c 'command --'

With this commit, parse_command_args() returns 0 if *argv is null after
parsing --, and so fixes the subsequent segfault.

Reported by Jonny through http://bugs.debian.org/579543

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 src/eval.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/eval.c b/src/eval.c
index 2f195af..62d9d5d 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -651,7 +651,8 @@ parse_command_args(char **argv, const char **path)
 		if (!(c = *cp++))
 			break;
 		if (c == '-' && !*cp) {
-			argv++;
+			if (!*++argv)
+				return 0;
 			break;
 		}
 		do {
-- 
1.7.0.3

