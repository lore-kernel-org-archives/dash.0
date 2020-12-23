Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76851C433DB
	for <linux-dash@archiver.kernel.org>; Wed, 23 Dec 2020 19:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 338D5223E4
	for <linux-dash@archiver.kernel.org>; Wed, 23 Dec 2020 19:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbgLWTtF (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 23 Dec 2020 14:49:05 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43815 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726147AbgLWTtA (ORCPT
        <rfc822;dash@vger.kernel.org>); Wed, 23 Dec 2020 14:49:00 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 55D075C0124;
        Wed, 23 Dec 2020 14:48:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 23 Dec 2020 14:48:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=causal.agency;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=wWOkjifVm5VbuTZ2GFdcO1Duoq
        0B7XwyhcX84ZEI+N4=; b=cNqvCBnOtMBd75DEinzJX0oFk2qd1F/olzIb1vm/XF
        EIwhUDjNuzoiHDpN8kjx7ZEMfbIdIC7o+akq3odGMdsNckdUUupyMsFXL1jElwvX
        iuXJNDgA1CT000mO0i4WqZMCaGRgQHs7aQmU1xrJ+gDchXkcig8nsCYkuqK31okw
        qZZn/uOr6CSv0+fyf8ONeY9Txmg6dE1tcapO4Wgpzhzd9ZK/5cJk6s8Z4F2dzAu2
        YC2LQn5jVMTuTHvvLdVmx2CINllbYmOU9iI7M/PYZWVEURPRw5YpWy0pwNIhjGK0
        qJ5Hwjk+ridorxrXnroHIZudyZ17eYzNK+pSLwlHvMQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=wWOkjifVm5VbuTZ2G
        FdcO1Duoq0B7XwyhcX84ZEI+N4=; b=SjirTVW0toOtXHPLNcigie56uTbWjQz2k
        WvWjnoHzz2+vRN2jx2q2zFV4oIwwzwD6EoJ2F3+/LKRW6rwhmFaIUDqc8Y9DiYSh
        h1fWDs/WW1Zcn9iS8z64hPByuPY8fcHX3v9Uw6Ko660VaFTuPKVJYLqVUPDRQex8
        FZs90/jAUz75lhgI8aW+S8uLNGAJPZTEbhP6sfxdk2LUStq2OPWG81U0r3YzDNZ3
        skRT70bH+2xSGGpWK/1Hka6gLSBqa7C/pj2xUEgbprOdNPOVAo4+XzErcW03macb
        MTRzF9bo0WaTsRvJg7DX4Q3rydmZfWD9JkXHGeFKbxgt90uwGxmyg==
X-ME-Sender: <xms:-Z7jX4biHvFuOoe0tahvsImYUp9RAxRf9XTcN4MsRXiTOmqzUbSMvA>
    <xme:-Z7jXzbzKLmoXOImjmyBAGEk6WpdUXEk6pN7g9EoouDDynSGcZ6int39wqmdW36XS
    gnme7RcE-divT0sZU4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddtjedguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfvedrucfotgfgnhhrohgvfdcuoehjuhhnvgestggruhhsrghl
    rdgrghgvnhgthieqnecuggftrfgrthhtvghrnhepueehkeeitefghfdugeelffelvdevhf
    eivdeitdehtefgffdvledukefhhfeiieehnecukfhppedutdegrdduieefrdduledtrddv
    vdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjh
    hunhgvsegtrghushgrlhdrrghgvghntgih
X-ME-Proxy: <xmx:-Z7jXy9qGqISb4kPlma54IKTzpWOLip5L1hVQ0JE-PsdzpkffFGtng>
    <xmx:-Z7jXyrc3KrCfeCyTIl4ig0yPll7PoKA-35ra-6ZlZ2SdX1_m8704A>
    <xmx:-Z7jXzo-08wJE3WpFmtH2-3lWXQAaurbyFi1OhfxDB37IVeROTzsag>
    <xmx:-Z7jX9EW6G1_1Se3VbSXwo5a3deNIWoV_H1Ek6pEcWKe7IeEuZZ6cQ>
Received: from localhost.localdomain (unknown [104.163.190.229])
        by mail.messagingengine.com (Postfix) with ESMTPA id BEDF324005A;
        Wed, 23 Dec 2020 14:48:08 -0500 (EST)
From:   "C. McEnroe" <june@causal.agency>
To:     dash@vger.kernel.org
Cc:     "C. McEnroe" <june@causal.agency>
Subject: [PATCH] Cache the expanded prompt for editline
Date:   Wed, 23 Dec 2020 14:47:41 -0500
Message-Id: <20201223194741.65087-1-june@causal.agency>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Previously, the prompt would be expanded every time editline called the
getprompt callback. I think the code may have been written assuming that
editline only calls getprompt once per prompt, but it may actually call
it many times, for instance every time you type backspace. This results
not only in slower editing from expanding complex prompts repeatedly, it
also consumes more and more stack memory each time getprompt is called.
This can be seen by setting PS1 to some command substitution, typing
many characters at the prompt, then holding backspace and observing
memory usage. Thankfully all this stack memory is freed between prompts
by the stackmark calls around el_gets.

This change causes prompt expansion to always happen in the setprompt
call, as it would when editline is disabled, and a cached copy of the
prompt is saved for getprompt to return every time editline calls it.
Since getprompt is no longer doing expansion, the stackmark calls
surrounding el_gets can be removed.
---
 src/input.c  |  6 +----
 src/parser.c | 64 ++++++++++++++++++++++++++++------------------------
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/src/input.c b/src/input.c
index 17544e7..4167bd1 100644
--- a/src/input.c
+++ b/src/input.c
@@ -152,12 +152,8 @@ retry:
 		static const char *rl_cp;
 		static int el_len;
 
-		if (rl_cp == NULL) {
-			struct stackmark smark;
-			pushstackmark(&smark, stackblocksize());
+		if (rl_cp == NULL)
 			rl_cp = el_gets(el, &el_len);
-			popstackmark(&smark);
-		}
 		if (rl_cp == NULL)
 			nr = 0;
 		else {
diff --git a/src/parser.c b/src/parser.c
index a47022e..d03697b 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -107,6 +107,9 @@ struct heredoc *heredoc;
 int quoteflag;			/* set if (part of) last token was quoted */
 
 
+static char *promptcache;
+
+
 STATIC union node *list(int);
 STATIC union node *andor(void);
 STATIC union node *pipeline(void);
@@ -1541,27 +1544,6 @@ synerror(const char *msg)
 	/* NOTREACHED */
 }
 
-STATIC void
-setprompt(int which)
-{
-	struct stackmark smark;
-	int show;
-
-	needprompt = 0;
-	whichprompt = which;
-
-#ifdef SMALL
-	show = 1;
-#else
-	show = !el;
-#endif
-	if (show) {
-		pushstackmark(&smark, stackblocksize());
-		out2str(getprompt(NULL));
-		popstackmark(&smark);
-	}
-}
-
 const char *
 expandstr(const char *ps)
 {
@@ -1611,22 +1593,23 @@ out:
 	return result;
 }
 
-/*
- * called by editline -- any expansions to the prompt
- *    should be added here.
- */
-const char *
-getprompt(void *unused)
+STATIC void
+setprompt(int which)
 {
+	struct stackmark smark;
 	const char *prompt;
+	int show;
+
+	needprompt = 0;
+	whichprompt = which;
 
 	switch (whichprompt) {
 	default:
 #ifdef DEBUG
-		return "<internal prompt error>";
+		prompt = "<internal prompt error>";
 #endif
 	case 0:
-		return nullstr;
+		prompt = nullstr;
 	case 1:
 		prompt = ps1val();
 		break;
@@ -1635,7 +1618,28 @@ getprompt(void *unused)
 		break;
 	}
 
-	return expandstr(prompt);
+#ifdef SMALL
+	show = 1;
+#else
+	show = !el;
+#endif
+	pushstackmark(&smark, stackblocksize());
+	if (show) {
+		out2str(expandstr(prompt));
+	} else {
+		free(promptcache);
+		promptcache = savestr(expandstr(prompt));
+	}
+	popstackmark(&smark);
+}
+
+/*
+ * called by editline -- return the cached prompt expansion.
+ */
+const char *
+getprompt(void *unused)
+{
+	return promptcache;
 }
 
 const char *const *
-- 
2.29.2

