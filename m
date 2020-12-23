Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE41C433E0
	for <linux-dash@archiver.kernel.org>; Wed, 23 Dec 2020 00:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09456207A8
	for <linux-dash@archiver.kernel.org>; Wed, 23 Dec 2020 00:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgLWArt (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 22 Dec 2020 19:47:49 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:38537 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725300AbgLWAro (ORCPT
        <rfc822;dash@vger.kernel.org>); Tue, 22 Dec 2020 19:47:44 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 4BD2295D;
        Tue, 22 Dec 2020 19:46:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 22 Dec 2020 19:46:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=causal.agency;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=Wsp7GnQ9Xethxhcw6Rzr+hNEN6
        F7YNhAI3bMstGLFew=; b=OSuFeSJVrz2S1sEH1BUHTFddyD7NprkOVCcjf6e8qp
        TSmwlYhWCeyoO/Ie+cpQqEJanbARV2jxsVHPTMI48KyrtFS84pjzKODFiUFZmwlX
        wOPD2BEz28nNGJyk19zDe17/ZYsvGIYjWX5KsRthWHbHYLtW8S4+E4gAOrous0cY
        b2dre78EFC+INAazfsGhkQgRFfE1DVlsCw6y93/EI6AaFFtSABBKDjvwMGWu71fg
        wNvfHqsGHjkhCQWLZn3Ex6Tbqi+V2yqoa7mBe6SojNiIL/ONRAIDOd61Zt7g+COM
        g1yO0SDqnyc8VjtHsa2S8xeINcgPafy9BVCTFYNozkVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Wsp7GnQ9Xethxhcw6
        Rzr+hNEN6F7YNhAI3bMstGLFew=; b=ngaoDoEdcFTUVYfcxl5120qAs2jI5m/q0
        MC4PgpReLMcWPmjmxMOwHfz2coKjWtBbNbXU7iK5pz/jBevhU/hUlDr4bYxhUYid
        BTJfoQJGYgbQCzByVeHea8B9XFLW+Ifajk+f2/EfH9OLhM2f/1olT8ORFVH3M004
        0JX3uXh1oxg+2oIJBTeKz2hXskutufRQiXM6YGtQoeAsyxOSCA6JS+PQQxbQvzzX
        oPf4zzBzCcMTJYyfGlDftmsyFBrdA0CiUM92dMf/8hK3z0CYc08RL7tDhJCrTO+Y
        ufHBMyt6Glrp1oZ+AWCUFxRmi5QQ0hb1WwF+KpXvx1ExYxDNSs6dQ==
X-ME-Sender: <xms:fJPiX2-BifLpiKnW6J5rxM51kwc-MqPHRiotCe8bVW8az_KMYHHZ-w>
    <xme:fJPiX4TSMCwML4HG_DY9PVWjg-PSDN2q1JpZBqnDZkOKH-iPeArYfUWiC6suP1ikk
    iQcWRuV_qjqFi3FYWs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddthedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdevrdcuofgtgfhnrhhovgdfuceojhhunhgvsegtrghushgrlhdr
    rghgvghntgihqeenucggtffrrghtthgvrhhnpeeuheekieetgffhudegleffledvvefhie
    dviedtheetgfffvdeludekhffhieeiheenucfkphepuddtgedrudeifedrudeltddrvddv
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjuh
    hnvgestggruhhsrghlrdgrghgvnhgthi
X-ME-Proxy: <xmx:fJPiXyUhaK8ZFvcwtYElXTANArsN4kTG0gV7XOqXgapJ-xgqBqeZEQ>
    <xmx:fJPiX6ST31Qs7rrHYRq4eT1bf7LpzkCnYHUmVmUAw-Lb6dW3TJiq9A>
    <xmx:fJPiXy02fIXcKjihJOjsZJ_rT_EKFh5q4CV2-HdD055gqjKIMxiYwg>
    <xmx:fJPiX99eS0nkbIC2E61bB4XODIal_MGZVju6DJIuJwKZH0FRC0lwHw>
Received: from localhost.localdomain (unknown [104.163.190.229])
        by mail.messagingengine.com (Postfix) with ESMTPA id 92A401080063;
        Tue, 22 Dec 2020 19:46:52 -0500 (EST)
From:   "C. McEnroe" <june@causal.agency>
To:     dash@vger.kernel.org
Cc:     "C. McEnroe" <june@causal.agency>
Subject: [PATCH] Fail if building --with-libedit and can't find libedit
Date:   Tue, 22 Dec 2020 19:46:50 -0500
Message-Id: <20201223004650.33486-1-june@causal.agency>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Previously, configure --with-libedit would only fail in the case where
libedit is available but its header file histedit.h is not.
---
 configure.ac | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 33f0b08..9d96f5a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -175,7 +175,8 @@ if test "$with_libedit" = "yes"; then
 	AC_CHECK_LIB(edit, history_init, [
 		AC_CHECK_HEADER([histedit.h], [use_libedit="yes"],
 				AC_MSG_ERROR(
-					[Can't find required header files.]))])
+					[Can't find required header files.]))], [
+		AC_MSG_ERROR([Can't find libedit.])])
 fi
 if test "$use_libedit" != "yes"; then
 	AC_DEFINE([SMALL], 1, [Define if you build with -DSMALL])
-- 
2.29.2

