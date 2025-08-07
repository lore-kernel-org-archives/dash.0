Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721955695
	for <dash@vger.kernel.org>; Thu,  7 Aug 2025 20:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597429; cv=none; b=ExR825nJa77WFyMEUVba4T8HLDNKpWPb4XpIF8O2ya8/AJ9JwvxufNIlwtyhAwY9iIpH2vjzwrb/08AQny/ilWiTslaNqEFClULuXRQJ2hK+RQhbX5WIBfVV0DaZ3a5Vs9XjbZcPjf4rqgrB81jAqi8vezb5IqnnwFC6Yl+719s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597429; c=relaxed/simple;
	bh=bda62OYWbkzYpH34LuFV5o1QzK5l11oYiOtYl/JN1CI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XQ3kmglX9uIL+YFBMJiGdKucO47j5A7z/GugHqetRMp7SfjKs235OrEw2E5e87z7HWJTmRIR0UfCSWEUHiTAKXjt8vtIar1XZ2moYdjcpB4ZJNENpybh2YiElQCUA1OM8kD92ZHMO5pCOHaqRTGdE6HrYLS2uuISGBdZjmrcnEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RmAryGsL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RmAryGsL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754597426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WbsS8plvimUg0M1opIfndcG2E8Pk2i6eXFcNurkA6t8=;
	b=RmAryGsLRfYKYlc2dQ49s6SaIpqqBWus/12InFLOafLqfoGMM/IqxiQVZwUwo0IFQg54Oe
	OCI6g2x3op5i1KsUhMu+CKXnfTHLrsNP7naf6dbmw+1nNgNvqo+wm/xyrKF32iJIh1rRfy
	UL3k6MG17nYdrAx7GSR+gb6RjtaqqUE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-lqLYK3bAPM-cFjNlP0htMg-1; Thu,
 07 Aug 2025 16:10:24 -0400
X-MC-Unique: lqLYK3bAPM-cFjNlP0htMg-1
X-Mimecast-MFC-AGG-ID: lqLYK3bAPM-cFjNlP0htMg_1754597424
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23DBD19560AF
	for <dash@vger.kernel.org>; Thu,  7 Aug 2025 20:10:24 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.68])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9A7DF1800285;
	Thu,  7 Aug 2025 20:10:22 +0000 (UTC)
From: Denys Vlasenko <dvlasenk@redhat.com>
To: dash@vger.kernel.org,
	Herbert Xu <herbert.xu@redhat.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Subject: [PATCH] Handle line continuation in unquoted heredocs
Date: Thu,  7 Aug 2025 22:10:10 +0200
Message-ID: <20250807201015.11358-1-dvlasenk@redhat.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Testcases:

cat <<nice
heredoc1
ni\
ce
nice # this isn't heredoc end, the end is above

cat <<-nice
	heredoc2
	\
	ni\
ce
nice # this isn't heredoc end, the end is above

cat <<"nice"
heredoc3
ni\
ce
nice

cat <<-"nice"
	heredoc4
	\
	ni\
ce
	nice

Correct output:

heredoc1
0
heredoc2
0
heredoc3
ni\
ce
heredoc4
\
ni\
ce

Before patch, cases 1 and 2 are mishandled.

A more simplistic apparent solution for cases 1 and 2,
s/pgetc/pgetc_eatbnl/, breaks cases 3 and 4

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
---
 src/parser.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/src/parser.c b/src/parser.c
index aecc18f..edef0ba 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -74,7 +74,7 @@
 
 
 /* Used by expandstr to get here-doc like behaviour. */
-#define FAKEEOFMARK (char *)1
+#define FAKEEOFMARK (struct heredoc *)1
 
 
 
@@ -123,7 +123,7 @@ STATIC void parseheredoc(void);
 STATIC int readtoken(void);
 STATIC int xxreadtoken(void);
 STATIC int pgetc_eatbnl();
-STATIC int readtoken1(int, char const *, char *, int);
+STATIC int readtoken1(int, char const *, struct heredoc *);
 STATIC void synexpect(int) __attribute__((__noreturn__));
 STATIC void synerror(const char *) __attribute__((__noreturn__));
 STATIC void setprompt(int);
@@ -143,7 +143,7 @@ int issimplecmd(union node *n, const char *name)
 	       equal(n->ncmd.args->narg.text, name);
 }
 
-static inline int realeofmark(const char *eofmark)
+static inline int realeofmark(struct heredoc *eofmark)
 {
 	return eofmark && eofmark != FAKEEOFMARK;
 }
@@ -685,9 +685,9 @@ parseheredoc(void)
 			setprompt(2);
 		}
 		if (here->here->type == NHERE)
-			readtoken1(pgetc(), SQSYNTAX, here->eofmark, here->striptabs);
+			readtoken1(pgetc(), SQSYNTAX, here);
 		else
-			readtoken1(pgetc_eatbnl(), DQSYNTAX, here->eofmark, here->striptabs);
+			readtoken1(pgetc_eatbnl(), DQSYNTAX, here);
 		n = (union node *)stalloc(sizeof (struct narg));
 		n->narg.type = NARG;
 		n->narg.next = NULL;
@@ -840,7 +840,7 @@ xxreadtoken(void)
 		case ')':
 			RETURN(TRP);
 		}
-		tok = readtoken1(c, BASESYNTAX, (char *)NULL, 0);
+		tok = readtoken1(c, BASESYNTAX, (struct heredoc *)NULL);
 		if (tok != TBLANK)
 			return tok;
 	}
@@ -994,7 +994,7 @@ static char *dollarsq_escape(char *out)
 #define	PARSEARITH()	{goto parsearith; parsearith_return:;}
 
 STATIC int
-readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
+readtoken1(int firstc, char const *syntax, struct heredoc *eofmark)
 {
 	struct synstack synbase = { .syntax = syntax };
 	int chkeofmark = checkkwd & CHKEOFMARK;
@@ -1233,17 +1233,24 @@ checkend: {
 		int markloc;
 		char *p;
 
-		if (striptabs) {
-			while (c == '\t')
-				c = pgetc();
+		if (eofmark->striptabs) {
+			while (c == '\t') {
+				if (eofmark->here->type == NHERE)
+					c = pgetc();
+				else /* NXHERE */
+					c = pgetc_eatbnl();
+			}
 		}
 
 		markloc = out - (char *)stackblock();
-		for (p = eofmark; STPUTC(c, out), *p; p++) {
+		for (p = eofmark->eofmark; STPUTC(c, out), *p; p++) {
 			if (c != *p)
 				goto more_heredoc;
 
-			c = pgetc();
+			if (eofmark->here->type == NHERE)
+				c = pgetc();
+			else /* NXHERE */
+				c = pgetc_eatbnl();
 		}
 
 		if (c == '\n' || c == PEOF) {
@@ -1748,7 +1755,7 @@ expandstr(const char *ps)
 		goto out;
 	handler = &jmploc;
 
-	readtoken1(pgetc_eatbnl(), DQSYNTAX, FAKEEOFMARK, 0);
+	readtoken1(pgetc_eatbnl(), DQSYNTAX, FAKEEOFMARK);
 
 	n.narg.type = NARG;
 	n.narg.next = NULL;
-- 
2.41.0

