From: Alexey Gladkov <gladkov.alexey@gmail.com>
Subject: [PATCH] Fix gcc 4.4 string literal problem
Date: Mon, 25 May 2009 14:51:36 +0400
Message-ID: <4A1A7838.2030000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mojo.unsafe.ru ([83.222.2.183]:52621 "EHLO mojo.unsafe.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753297AbZEYKwe (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 25 May 2009 06:52:34 -0400
Received: from [172.16.1.2] (dhcp250-217.yandex.ru [87.250.250.217])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mojo.unsafe.ru (Postfix) with ESMTP id D08778680D6
	for <dash@vger.kernel.org>; Mon, 25 May 2009 14:52:31 +0400 (MSD)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com> 
--- 
 src/jobs.c |    2 +- 
 1 files changed, 1 insertions(+), 1 deletions(-) 
 
diff --git a/src/jobs.c b/src/jobs.c 
index b1ab7ab..305189e 100644 
--- a/src/jobs.c 
+++ b/src/jobs.c 
@@ -427,7 +427,7 @@ sprint_status(char *s, int status, int sigonly) 
                                goto out; 
 #endif 
                } 
-               col = fmtstr(s, 32, strsignal(st)); 
+               col = fmtstr(s, 32, "%s", strsignal(st)); 
                if (WCOREDUMP(status)) { 
                        col += fmtstr(s + col, 16, " (core dumped)"); 
                } 
--  
1.6.3.1

