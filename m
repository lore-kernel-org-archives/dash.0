From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 1/4] input: Make preadbuffer static
Date: Mon, 05 Jan 2015 23:01:52 +1100
Message-ID: <E1Y86M4-0001mB-8A@gondolin.me.apana.org.au>
References: <20150105120030.GA6101@gondor.apana.org.au>
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:35586 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130AbbAEMCD (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 5 Jan 2015 07:02:03 -0500
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>, Eric Blake <eblake@redhat.com>, Oleg Bulatov <oleg@bulatov.me>, dash@vger.kernel.org, Juergen Daubert <jue@jue.li>

The function preadbuffer should be static as it's only used in
input.c.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 src/input.c |    4 ++--
 src/input.h |    1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/input.c b/src/input.c
index f11ac84..aa5dcfc 100644
--- a/src/input.c
+++ b/src/input.c
@@ -109,6 +109,7 @@ EditLine *el;			/* cookie for editline package */
 STATIC void pushfile(void);
 static int preadfd(void);
 static void setinputfd(int fd, int push);
+static int preadbuffer(void);
 
 #ifdef mkinit
 INCLUDE <stdio.h>
@@ -222,8 +223,7 @@ retry:
  * 4) Process input up to the next newline, deleting nul characters.
  */
 
-int
-preadbuffer(void)
+static int preadbuffer(void)
 {
 	char *q;
 	int more;
diff --git a/src/input.h b/src/input.h
index 775291b..90ff6c3 100644
--- a/src/input.h
+++ b/src/input.h
@@ -52,7 +52,6 @@ extern char *parsenextc;	/* next character in input buffer */
 
 int pgetc(void);
 int pgetc2(void);
-int preadbuffer(void);
 void pungetc(void);
 void pushstring(char *, void *);
 void popstring(void);
