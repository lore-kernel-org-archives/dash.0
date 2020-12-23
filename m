Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130C5C433E0
	for <linux-dash@archiver.kernel.org>; Wed, 23 Dec 2020 21:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5CCA224B1
	for <linux-dash@archiver.kernel.org>; Wed, 23 Dec 2020 21:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgLWVEb (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 23 Dec 2020 16:04:31 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35989 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727649AbgLWVE0 (ORCPT
        <rfc822;dash@vger.kernel.org>); Wed, 23 Dec 2020 16:04:26 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8B9555C0124;
        Wed, 23 Dec 2020 16:03:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 23 Dec 2020 16:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=causal.agency;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=Cd3n0jBWJ4IjT
        Rw14v52KWoEBcE5cf9zSQWJNnzR0Nk=; b=TnXLoK2hANi0rQaQHxHzeSyvxiplM
        8pTJBfs0lWv9Tb7/jiBtt4Zu7wAREKx01UGLpARSKwaTFJnI0M4ra2Lt0Dybsk9m
        z5nByQMH10CWUbrKLIdTNx2PHR9YTrczFUMfg6HnEKnRqwCq5AjeQ2wbPHbQplzb
        s2duytKJs0++xkjKBqM+40RAFP6lRYgpYipHd7qTPV0GiNwWvwSS/8bbIYaYzep5
        l1JqEMb64RCsZwwxy3/uhBwT7yMiaWOpFb0JJsqPRkr3aUxOJuUYuCX5zcn8biMs
        fxA6381+qd0x1YmHH9n2zkrreadDMu7vABTmnZ7/8v0zDhYGPaDDvjJDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Cd3n0jBWJ4IjTRw14v52KWoEBcE5cf9zSQWJNnzR0Nk=; b=Ray9h3f0
        2jawrnf5XPxJQiQqPCKqpWQ5Vbg7GFYbHKumMyvvWzrA8ha6HzAMgEmvi+bhoOzO
        Y1RfEJzKBA8V5EnCyUfXa/NN3lAZG4fxLRP73hpEaQsoibA7AoxUySLWkFPR4w2F
        bfHHd+YaHAwm24XhfueaerconKSN65N7pww9YG9nslffciWINPkZMBc4IFXQvKya
        BNOSuXNaBduoDq8mR28Wj8mR0TvyYg5lHXHNb08P4kSmxyg3lnQJjcwJOssOV8H8
        7J8/ooowTSoOmUIxR5/UYVnEqQvWKbFpzpl75z+9I5A+G/jUJI8A/nk/7sFkVyT5
        k4MN2r4BYWFeLw==
X-ME-Sender: <xms:krDjXwgVv467Or2SWnH3GzcCUX_9YuTV_xWWJaFNhSniuGELggqclA>
    <xme:krDjX5BAlw9C724Wd4ZtgyMtfnpKDkunfpqIVZgaS-3LTp0yq53JtDDe1RrlYy8s8
    FiI-6Fl77d4PBmAxiI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddtjedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfvedrucfotgfgnhhrohgvfdcuoehjuhhnvgestggruhhs
    rghlrdgrghgvnhgthieqnecuggftrfgrthhtvghrnhepgeejvdeghefgtdfffefgveegle
    etfedthfduieefvdfhffehgfeuffejueejkefgnecukfhppedutdegrdduieefrdduledt
    rddvvdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epjhhunhgvsegtrghushgrlhdrrghgvghntgih
X-ME-Proxy: <xmx:krDjX4E1iOMvZvbyCeHn0rY7yizHcXPo3PC5tNZuYxuEoQqebFtF7A>
    <xmx:krDjXxQa4LaNZbt2QMnmSEz9cSsBjEk4dLr7z2UwCq-nadS39t2y6A>
    <xmx:krDjX9zWjNMCcsXXb-uqMfdZ8lxZ9W6KIg8V-D17i8x3gMAQo-zTPQ>
    <xmx:krDjX2v1LCgEGHWJ-Bg2JNHYsqORUCQbt5UpOetRxf_9JS7FJ169Yg>
Received: from localhost.localdomain (unknown [104.163.190.229])
        by mail.messagingengine.com (Postfix) with ESMTPA id C847F240057;
        Wed, 23 Dec 2020 16:03:13 -0500 (EST)
From:   "C. McEnroe" <june@causal.agency>
To:     dash@vger.kernel.org
Cc:     "C. McEnroe" <june@causal.agency>
Subject: [PATCH v2] Cache the expanded prompt for editline
Date:   Wed, 23 Dec 2020 16:02:57 -0500
Message-Id: <20201223210257.78887-1-june@causal.agency>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201223194741.65087-1-june@causal.agency>
References: <20201223194741.65087-1-june@causal.agency>
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

v2: Missed adding breaks when replacing returns with assignments.

 src/input.c  |  6 +----
 src/parser.c | 66 ++++++++++++++++++++++++++++------------------------
 2 files changed, 37 insertions(+), 35 deletions(-)

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
index a47022e..270a01d 100644
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
@@ -1611,22 +1593,25 @@ out:
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
+		break;
 #endif
 	case 0:
-		return nullstr;
+		prompt = nullstr;
+		break;
 	case 1:
 		prompt = ps1val();
 		break;
@@ -1635,7 +1620,28 @@ getprompt(void *unused)
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

