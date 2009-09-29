From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH 1/2] [EVAL] with set -e exit the shell if a subshell exits non-zero
Date: Tue, 29 Sep 2009 12:24:16 +0000
Message-ID: <20090929122416.30193.qmail@6a1040822577be.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from a.ns.smarden.org ([212.42.242.37]:1201 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753902AbZI2MYO (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 29 Sep 2009 08:24:14 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

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
index 2f195af..af3742f 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -250,6 +250,8 @@ checkexit:
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

