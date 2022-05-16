Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041F8C433F5
	for <linux-dash@archiver.kernel.org>; Mon, 16 May 2022 23:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346978AbiEPXMi (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 16 May 2022 19:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238717AbiEPXMh (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 16 May 2022 19:12:37 -0400
X-Greylist: delayed 612 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 May 2022 16:12:36 PDT
Received: from d.mail.sonic.net (d.mail.sonic.net [64.142.111.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC857419A6
        for <dash@vger.kernel.org>; Mon, 16 May 2022 16:12:36 -0700 (PDT)
Received: from ocelot (157-131-248-104.fiber.dynamic.sonic.net [157.131.248.104])
        (authenticated bits=0)
        by d.mail.sonic.net (8.16.1/8.16.1) with ESMTPA id 24GN2NIA031588
        for <dash@vger.kernel.org>; Mon, 16 May 2022 16:02:24 -0700
From:   Forest <forestix@sonic.net>
To:     dash@vger.kernel.org
Subject: [PATCH] man page: redirection operators: fix swapped stdin/stdout
Date:   Mon, 16 May 2022 16:02:24 -0700
Message-ID: <hpl58htt4cqjtgkt4lvqus3fpc8jc5fdls@4ax.com>
X-Mailer: Forte Agent 3.3/32.846
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Sonic-CAuth: UmFuZG9tSVa+r0f9Tk0yFCggYnxbFARRzok7JnZD4ffGRI8LBEgiyN0HZ7iprV+Y3ouHO0oz+BmhxuzHUbj63QJZ0yqr7tL2
X-Sonic-ID: C;ZhV5P2zV7BGnq50guulSsA== M;WpuBP2zV7BGnq50guulSsA==
X-Sonic-Spam-Details: -0.0/5.0 by cerberusd
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

The Redirections section incorrectly claimed that <& replaces stdout
and >& replaces stdin. Swapped them to make it read correctly.

Ref:
https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_07_05

Both errors were followed by extra text that looked like remains of a
mostly-deleted sentence. Removed those.
---
 src/dash.1 | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/dash.1 b/src/dash.1
index ff02237..113a4db 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -402,13 +402,11 @@ Append standard output (or n) to file.
 .It [n] Ns \*[Lt] file
 Redirect standard input (or n) from file.
 .It [n1] Ns \*[Lt]& Ns n2
-Copy file descriptor n2 as stdout (or fd n1).
-fd n2.
+Copy file descriptor n2 as stdin (or fd n1).
 .It [n] Ns \*[Lt]&-
 Close standard input (or n).
 .It [n1] Ns \*[Gt]& Ns n2
-Copy file descriptor n2 as stdin (or fd n1).
-fd n2.
+Copy file descriptor n2 as stdout (or fd n1).
 .It [n] Ns \*[Gt]&-
 Close standard output (or n).
 .It [n] Ns \*[Lt]\*[Gt] file
-- 
