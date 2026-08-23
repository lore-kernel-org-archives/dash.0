Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C383803F7
	for <dash@vger.kernel.org>; Sun, 23 Aug 2026 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787509631; cv=none; b=AF8MBLSJtQOMT9VomjD2xvp9pAOyzzZaQ7RD5Gy/qV/lIHR8cJe7PtE9CLTBKGgQBaGE3JTATO6oLeBfo4+kwHE8fm3ghxwISORbojl9zMEtfB19lmnrdbvYL0EYZ1uCqjHMiZH0PkLpOS83yoJaFfYCaW63pwOtE7tTiQ5erAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787509631; c=relaxed/simple;
	bh=vR9wZuJPvo3++UOiClzK36fuNqSFZiD5e/0qkARDFXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E6xjYzllfP/0PQGNxe3yfwuu495lrrJBMKrChnKodr5lmyrVUQQTOYuxxrCyBPH8wvfmzPqTpsaNog051NX1t3xa2Xb7CtTJY9PM3n3wp6dZG+//uTb4VKEIF4w3MTVAC8yYa+MobXdxc8uWurnluAzldQkA4FuRh3q1mQw+GfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iml6wPJ9; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iml6wPJ9"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66d03ff78abso484134d50.2
        for <dash@vger.kernel.org>; Sun, 23 Aug 2026 11:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787509629; x=1788114429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9eJDIWbymqMGg5yu4h2/8hRFavLF2uvxX7tgsiXNG+M=;
        b=iml6wPJ9/2TD/eYyHwbWP36jzZZufMRGFBGzEtlinall7L7YCWw/SfQGV3f6MHC2cp
         E5jXSGZeOhlHO6QRtaxJhdHbACBsVjvkU4CmFhNIjhNXSqQXlIQaHB/DUZm7P6akiTNq
         TnYDrW3pD1Al7nsqfnpMtaBhF3Xw6uP9wALYn8x9CPzU1pIXxJchxzyEaN4ALZkAmOMe
         vjFvItgmP4GLlzp7eAV9+9xlYsNL9neLW0CymYPJYPyEVqKjA2fwnbEGmG6jvVGnHnl6
         nK2Ga8bNSUC6aesqVhZL1m0O9+PTunl6iTSZZ1nllTtrG6gZTeDCAD7yniul9B74ZUWO
         H4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787509629; x=1788114429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9eJDIWbymqMGg5yu4h2/8hRFavLF2uvxX7tgsiXNG+M=;
        b=NwISMVN5ViaqxDv4oDyKhukydRiZWUJ4t0UfVC9ESwQZxKiolQykRzYrDyOTTLJ3sn
         LYDTnU9M4AegzZ9WrKPZ2HJk2l+eZEMAoRtqCsCYGDtgtjCDi6ED40aN4Uljm2kKY0hx
         svH9Mp5Q6g07FHhvi1XKcJsDTrbjMIDogg2tzoSzN9EdhpEs/6b8n/8yHGls6EMa02Bh
         9j5B8EZIY+9AYAJkVP2ZemaCSE96co+jNkGYM2mDz9IUF9cQWlea26vF27RR1300BzTB
         L6F4QbR70Eyaszp0AaQLgxa+xSsi1VkRQqZ1Qxx6xMfygHY+uPS7YIEHEg3xgGQTVIT2
         hCpg==
X-Gm-Message-State: AFuF++nHR+3mHlb1ljSKRNscSQUPMWoIOgFayqOkF2HT961KdYbOYsN5
	oVlkVGSJOrCmmCS54MVvsxYA50RF0PGjjk6fkjswDy5FaWxbTwbaNDE=
X-Gm-Gg: AR+sD10mhLqjusgj0mEn8C6gUDOwkvCU7F/0CTZAbzPLSHFJL3PJRvRKrkuKQrV85Rd
	yMUMfoYww3hppmeW6Q3cEwvRJcvjrb/bLTzI7dtl7/cfBb0XMPbCkUYYkORsjw1b/hkOd5uAgKa
	drotbNxFfsATX7vnmkx1n0WQ1yY5eFIOC40x7afOzuOEWQc4k8US6DKTFExtYFMm4Y9JUt4H8zR
	ZdJaMvCI87NRliv2smHkJnh0vC1MFoSLI1lFi/yE4mc4Hrj30EXhBTsR3bhoOeHjWY/pfdfV2XQ
	TkX8G8/oi3C83t+zOYriVhS7SsOwYWLvfL/F02qQlthDogR6+DjEyZfuZ65T6LQT0/jBX/8oEzV
	JEl3uC0Dxqf4mH2gtpMFmsneLdENMFGl1+ySr+eWjaVvKHQiU5N/xw9wc26HpkIcK/z2nCFjg1Q
	tRnCGJw2x+wzks+cbnbrPkNSRxs+pBPJk7PgBL7c111FQtoSg=
X-Received: by 2002:a05:690e:1341:b0:667:c532:a188 with SMTP id 956f58d0204a3-66ce49e66f2mr7124831d50.8.1787509628924;
        Sun, 23 Aug 2026 11:27:08 -0700 (PDT)
Received: from 3511.attlocal.net ([2600:1702:7a3e:17b0::3c])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66d04ede7d0sm570247d50.20.2026.08.23.11.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 11:27:08 -0700 (PDT)
From: svav2021@gmail.com
To: herbert@gondor.apana.org.au
Cc: dash@vger.kernel.org,
	Arav Verma <svav2021@gmail.com>
Subject: [PATCH] case: Implement fallthrough (;&) operator
Date: Sun, 23 Aug 2026 13:26:35 -0500
Message-ID: <20260823182703.31754-1-svav2021@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arav Verma <svav2021@gmail.com>

Add support for the fallthrough operator, as specified
in POSIX.1-2024, (defect 449). The ;& operator allows
execution to continue to the next case pattern without
re-evaluating the switch expression

Signed-off-by: Arav Verma <svav2021@gmail.com>
---
 src/eval.c   | 35 +++++++++++++++++++++++++----------
 src/mktokens |  1 +
 src/parser.c | 14 ++++++++++----
 3 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/src/eval.c b/src/eval.c
index 0f2a7ba..f9acea5 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -451,6 +451,7 @@ evalcase(union node *n, int flags)
 	union node *patp;
 	struct arglist arglist;
 	int status = 0;
+	int fallthrough = 0;
 
 	errlinno = lineno = n->ncase.linno;
 	if (funcline)
@@ -460,19 +461,33 @@ evalcase(union node *n, int flags)
 	expandarg(n->ncase.expr, &arglist, FNMATCH_IS_ENABLED ? EXP_TILDE :
 					   EXP_TILDE | EXP_MBCHAR);
 	for (cp = n->ncase.cases ; cp && evalskip == 0 ; cp = cp->nclist.next) {
-		for (patp = cp->nclist.pattern ; patp ; patp = patp->narg.next) {
-			if (casematch(patp, arglist.list->text)) {
-				/* Ensure body is non-empty as otherwise
-				 * EV_EXIT may prevent us from setting the
-				 * exit status.
-				 */
-				if (evalskip == 0 && cp->nclist.body) {
-					status = evaltree(cp->nclist.body,
-							  flags);
+		int matched = 0;
+		
+		if (fallthrough) {
+			matched = 1;
+		} else {
+			for (patp = cp->nclist.pattern ; patp ; patp = patp->narg.next) {
+				if (casematch(patp, arglist.list->text)) {
+					matched = 1;
+					break;
 				}
-				goto out;
 			}
 		}
+		if (matched) {
+			int terminator = cp->type >> 8;
+			if (evalskip == 0 && cp->nclist.body) {
+				int eval_flags = flags;
+				if (terminator == TFALLTHRU)
+					eval_flags &= ~EV_EXIT;
+				status = evaltree(cp->nclist.body, eval_flags);
+				if (terminator != TFALLTHRU)
+					goto out;
+			} else if (terminator != TFALLTHRU)
+				goto out;
+			
+			if (terminator == TFALLTHRU)
+				fallthrough = 1;
+		}
 	}
 out:
 	return status;
diff --git a/src/mktokens b/src/mktokens
index dcef676..b7cd0ff 100644
--- a/src/mktokens
+++ b/src/mktokens
@@ -51,6 +51,7 @@ TPIPE	0	"|"
 TLP	0	"("
 TRP	1	")"
 TENDCASE 1	";;"
+TFALLTHRU 1    ";&"
 TENDBQUOTE 1	"`"
 TREDIR	0	redirection
 TWORD	0	word
diff --git a/src/parser.c b/src/parser.c
index e44b3c3..ede908f 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -463,10 +463,12 @@ next_case:
 
 			checkkwd = CHKNL | CHKKWD;
 			if ((t = readtoken()) != TESAC) {
-				if (t != TENDCASE)
+				if (t != TENDCASE && t != TFALLTHRU)
 					synexpect(TENDCASE);
-				else
+				else {
+					cp->type = NCLIST | (t << 8);
 					goto next_case;
+				}
 			}
 		}
 		*cpp = NULL;
@@ -833,11 +835,15 @@ xxreadtoken(void)
 				RETURN(TOR);
 			pungetc();
 			RETURN(TPIPE);
-		case ';':
-			if (pgetc_eatbnl() == ';')
+		case ';': {
+			int nextc = pgetc_eatbnl();
+			if (nextc == ';')
 				RETURN(TENDCASE);
+			else if (nextc == '&')
+				RETURN(TFALLTHRU);
 			pungetc();
 			RETURN(TSEMI);
+		}
 		case '(':
 			RETURN(TLP);
 		case ')':
-- 
2.47.3

