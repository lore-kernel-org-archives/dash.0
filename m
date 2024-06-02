Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7775EEBE
	for <dash@vger.kernel.org>; Sun,  2 Jun 2024 01:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717291758; cv=none; b=Ofi566u0GtcqgTtfgdMsw2m3+M4AJnQNn6PnCc0UQvnch9b2BPw9JG0b0jtfWa+zQtOUJPGiQNSAlJw6odSsQekKK4+iSARnzqC6mg8X2QeJowaDReNlQN3Qd+V+s4Q7SWU/Anhpjox29G8xFkoTdi+SbMTCe0c6Nz5jr0ujiQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717291758; c=relaxed/simple;
	bh=gQCPImuQCvasnGuvzbAXTWWj+Z8D256uJwgJGl7/3ps=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=Lsbmtv2gWljIjN0GqXsZi2EsDAEJFTPEO6tYXjadG1l4Es7JjaEEP9Ofsi7KbNaaPkkav7WKVS+FjH83QUurW0mNv6IvHlGqLNDv905fT1WPmJ7vuP6KKm5kJE065kvfauJBbk4IBlcxSKHZCNj1G2a6Ju9KfSFV8tBXdklgMlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sDa23-004iWi-2C;
	Sun, 02 Jun 2024 09:29:12 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 02 Jun 2024 09:29:13 +0800
Date: Sun, 02 Jun 2024 09:29:13 +0800
Message-Id: <73254ee7731cd2f0b5877159920dcf159beba1b3.1717291579.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1717291579.git.herbert@gondor.apana.org.au>
References: <cover.1717291579.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v5 PATCH 13/13] builtin: Process multi-byte characters in read(1)
To: DASH Mailing List <dash@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

Add support for multi-byte characters in read(1) by using getmbc
from the parser.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/miscbltin.c | 19 +++++++++++++------
 src/parser.c    |  2 +-
 src/parser.h    |  1 +
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/src/miscbltin.c b/src/miscbltin.c
index 10d256e..5aa2b24 100644
--- a/src/miscbltin.c
+++ b/src/miscbltin.c
@@ -36,15 +36,16 @@
  * Miscelaneous builtins.
  */
 
+#include <ctype.h>
+#include <inttypes.h>
+#include <limits.h>
+#include <stdlib.h>
 #include <sys/types.h>		/* quad_t */
 #include <sys/param.h>		/* BSD4_4 */
 #include <sys/stat.h>
 #include <sys/time.h>
 #include <sys/resource.h>
 #include <unistd.h>
-#include <stdlib.h>
-#include <ctype.h>
-#include <inttypes.h>
 
 #include "error.h"
 #include "expand.h"
@@ -151,8 +152,10 @@ readcmd(int argc, char **argv)
 	goto start;
 
 	for (;;) {
+		unsigned ml;
 		int c;
 
+		CHECKSTRSPACE((MB_LEN_MAX > 16 ? MB_LEN_MAX : 16) + 4, p);
 		c = pgetc();
 		if (c == PEOF) {
 			status = 1;
@@ -160,9 +163,14 @@ readcmd(int argc, char **argv)
 		}
 		if (c == '\0')
 			continue;
+		ml = getmbc(c, p, 0);
+		if (ml) {
+			p += ml;
+			goto record;
+		}
 		if (newloc >= startloc) {
 			if (c == '\n')
-				goto resetbs;
+				goto record;
 			goto put;
 		}
 		if (!rflag && c == '\\') {
@@ -172,13 +180,12 @@ readcmd(int argc, char **argv)
 		if (c == '\n')
 			break;
 put:
-		CHECKSTRSPACE(2, p);
 		if (strchr(qchars, c))
 			USTPUTC(CTLESC, p);
 		USTPUTC(c, p);
 
+record:
 		if (newloc >= startloc) {
-resetbs:
 			recordregion(startloc, newloc, 0);
 start:
 			startloc = p - (char *)stackblock();
diff --git a/src/parser.c b/src/parser.c
index 1a2f5df..a4d3291 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -883,7 +883,7 @@ static void synstack_pop(struct synstack **stack)
 	*stack = (*stack)->next;
 }
 
-static unsigned getmbc(int c, char *out, int mode)
+unsigned getmbc(int c, char *out, int mode)
 {
 	char *const start = out;
 	mbstate_t mbst = {};
diff --git a/src/parser.h b/src/parser.h
index 14bfc4f..7a9605b 100644
--- a/src/parser.h
+++ b/src/parser.h
@@ -95,6 +95,7 @@ const char *getprompt(void *);
 const char *const *findkwd(const char *);
 char *endofname(const char *);
 const char *expandstr(const char *);
+unsigned getmbc(int c, char *out, int mode);
 
 static inline int
 goodname(const char *p)
-- 
2.39.2

