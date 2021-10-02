Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1BDC433F5
	for <linux-dash@archiver.kernel.org>; Sat,  2 Oct 2021 20:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 848F261B2B
	for <linux-dash@archiver.kernel.org>; Sat,  2 Oct 2021 20:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbhJBUjX (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 2 Oct 2021 16:39:23 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:37729 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233460AbhJBUjV (ORCPT
        <rfc822;dash@vger.kernel.org>); Sat, 2 Oct 2021 16:39:21 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id DEC565C007D;
        Sat,  2 Oct 2021 16:37:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 02 Oct 2021 16:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=causal.agency;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=cgZtcsBvBffhHN17XlA7NJKcr9
        zZhHYNhgghDm9ojT0=; b=GdLxyxBxg/SA5Cp7o0uY4gdowtZfkDx8P1NNDHI81R
        1su0A2laf6PXbaklkYnU1ksm8sOBuMtpC9YKiZC9F2g3t1ciObL3ANcoBOD/M4x6
        LebpQOp2GVO9pTMlRMY1yCFyvJfZlZyYSI9n30aouSmu/r6fNyMSYXCuHEJnz+BP
        HNShS3HQROKRPKWThk6Ku1CEOHVDdgoQ+z+9B5i5hvqxLA7iWYOpZRj0UdsKb3IW
        O0eBZiXZJnKhWqs4K+fZIJR3gOglTEh4WiG6J9quqaAOMn0cruDTX9BJuCPqmkn2
        BgaWzsxJbXLwckIZ7gay+6zsdQawEtXzgUDGO8mCOROQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=cgZtcsBvBffhHN17X
        lA7NJKcr9zZhHYNhgghDm9ojT0=; b=BVz0fDbpQIxx4WVP2du9fHTY44axl/Suo
        lBJOkgtdJFIKrk70QftdMm+0kuCfrwV+Bw5UGxzxwy6vtkWrb+pDotfRSzL0iq40
        72KBo+Gwr5DPplxuKnFkMSRqLrM6aFBbeK0fVwsr08yQjcs5EwdY1EmkGcy5KHbL
        5u21rcWdlXL/xFkLf/rUB0py17K7PbUYTVt9gXh0CrS6xbGYVEYwgNOM/OGQEOox
        W1+D9yFy9f63G7pNiRhevh0LCRIgZAsYwU0mofAOFGkOIhoajEA+Atlc/oVBs9EF
        dUPo11up62onIOo9BXTQd398EsYWWdnRPqOolH4+K44533+n8h3NA==
X-ME-Sender: <xms:DsNYYSV-Jiu0H52NhzZ-3khRapHiwsP6vXUtKednOB7LhRG5bYFTSA>
    <xme:DsNYYekPy5yaf1j-MmzZu4K2Hk4U25loAL-6OLJS0AR5ukCBIewNaNeT4owhxWu-U
    HpJ26UKDf8NGs2cwOs>
X-ME-Received: <xmr:DsNYYWZ07eLAs4cOrLKiY9ia9A4rzCcecAFulhks3DAE644HaPbbRp8zhYueeAj4UyATS6cYjUin5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekkedgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfvedrucfotgfgnhhrohgvfdcuoehjuhhnvgestggruhhsrghl
    rdgrghgvnhgthieqnecuggftrfgrthhtvghrnhepueehkeeitefghfdugeelffelvdevhf
    eivdeitdehtefgffdvledukefhhfeiieehnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepjhhunhgvsegtrghushgrlhdrrghgvghntgih
X-ME-Proxy: <xmx:DsNYYZWfmfzoqQA1zRVY7Fkc_nahNpa61C_1wlqiGMJOhPAq1h-P5Q>
    <xmx:DsNYYcmUaCIo6h-lGuJBmy5SPgsDVuzi_5OMGhUsifaJte8ScWeCCA>
    <xmx:DsNYYeeLZpQnwwKY8zgQr5FRM5YGUw6Wl9pSt-1s6xfBBhkTVg09YA>
    <xmx:DsNYYTt48hC3YHxeZ7TW6bHnl-BbGMXG3RyUsdr0YYIA3dALukhvng>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Oct 2021 16:37:34 -0400 (EDT)
From:   "C. McEnroe" <june@causal.agency>
To:     dash@vger.kernel.org
Cc:     "C. McEnroe" <june@causal.agency>
Subject: [PATCH] Fix chkmail loop break condition
Date:   Sat,  2 Oct 2021 16:37:32 -0400
Message-Id: <20211002203732.6175-1-june@causal.agency>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

padvance_magic() returns -1 when there are no more paths left, not
zero.
---
 src/mail.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/mail.c b/src/mail.c
index e6baaa1b..ec5bd103 100644
--- a/src/mail.c
+++ b/src/mail.c
@@ -80,7 +80,7 @@ chkmail(void)
 		int len;
 
 		len = padvance_magic(&mpath, nullstr, 2);
-		if (!len)
+		if (len == -1)
 			break;
 		p = stackblock();
 		if (*p == '\0')
-- 
2.33.0

