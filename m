From: Jilles Tjoelker <jilles@stack.nl>
Subject: [PATCH] [PARSER] Remove backslash before } in double-quotes in
 variable
Date: Sun, 21 Nov 2010 14:42:22 +0100
Message-ID: <20101121134222.GC17293@stack.nl>
References: <20101119135406.GA24391@gondor.apana.org.au>
 <4CE71991.3020108@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:59525 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752944Ab0KUNmZ (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 21 Nov 2010 08:42:25 -0500
Content-Disposition: inline
In-Reply-To: <4CE71991.3020108@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, jrnieder@gmail.com

The backslash prevents the closing brace from terminating the
substitution, therefore it should be removed.

FreeBSD sh test expansion/plus-minus2.0 starts working, no other tests
are affected.

Example:
  printf "%s\n" ${$+\}} ${$+"\}"} "${$+\}}"
should print } three times, without backslashes.
---
 src/parser.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/parser.c b/src/parser.c
index be20ff7..25f22fd 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -916,6 +916,9 @@ readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
 						c != '$' && (
 							c != '"' ||
 							eofmark != NULL
+						) && (
+							c != '}' ||
+							varnest == 0
 						)
 					) {
 						USTPUTC('\\', out);
-- 
1.7.3.2

