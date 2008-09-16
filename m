From: maximilian.bernoecker@lrz.tum.de (Maximilian =?iso-8859-1?Q?Bern=F6c?=
	=?iso-8859-1?Q?ker?=)
Subject: [PATCH] added missing )
Date: Tue, 16 Sep 2008 15:54:22 +0200
Message-ID: <87r67ki4c1.fsf@ID-132527.user.dfncis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mout4.freenet.de ([195.4.92.94]:45193 "EHLO mout4.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753652AbYIPNy1 (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 16 Sep 2008 09:54:27 -0400
Received: from [195.4.92.10] (helo=0.mx.freenet.de)
	by mout4.freenet.de with esmtpa (ID agabuga@freenet.de) (port 25) (Exim 4.69 #65)
	id 1Kfb0b-0002Mo-MD
	for dash@vger.kernel.org; Tue, 16 Sep 2008 15:54:25 +0200
Received: from p5498d85e.dip.t-dialin.net ([84.152.216.94]:48716 helo=linmax.dahoam)
	by 0.mx.freenet.de with esmtpsa (ID agabuga@freenet.de) (TLSv1:AES256-SHA:256) (port 25) (Exim 4.69 #65)
	id 1Kfb0b-0007YJ-BN
	for dash@vger.kernel.org; Tue, 16 Sep 2008 15:54:25 +0200
Received: from max by linmax.dahoam with local (Exim 4.63)
	(envelope-from <maximilian.bernoecker@lrz.tum.de>)
	id 1Kfb0Y-0007oX-Vs
	for dash@vger.kernel.org; Tue, 16 Sep 2008 15:54:22 +0200
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

added missing ) in src/cd.c
---
 src/cd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/cd.c b/src/cd.c
index 624801d..3770664 100644
--- a/src/cd.c
+++ b/src/cd.c
@@ -258,7 +258,7 @@ getpwd()
 #else
 	char buf[PATH_MAX];
 
-	if (getcwd(buf, sizeof(buf))
+	if (getcwd(buf, sizeof(buf)))
 		return savestr(buf);
 #endif
 
-- 
1.5.3.7

