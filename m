Received: from sienna.cherry.relay.mailchannels.net (sienna.cherry.relay.mailchannels.net [23.83.223.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18511DE4F7
	for <dash@vger.kernel.org>; Wed, 23 Oct 2024 19:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729713397; cv=pass; b=I9fZ9OGF6ArJsG0a9lPwpAtGs0xs6XJGziblcNfbT9YYdGUioQATCzqT3O2GA2rBtkgvhx3QcZ3DuNbbxzgiMCvuQmOHiYKZsXYg9dg3TYZh249FhB8e5KzzwnMXQ9aBVR1TZmgixtDH53qlBdg4n/ffzJZ/uvzjiA0Mx3Ph4iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729713397; c=relaxed/simple;
	bh=mZkfsKob5n1MZg4WiLrmxkhacaMeNVZdVfRIdT9pZhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbYHRQI9DULPXJXLO8vB3fHXZ+V6AOKk0nYqq4iG1+bMk2TBMxB9kuKrKAxLo7MglTigPRWTkpZfIoNU46Cfc6Y8xmPTRL6bWswu3zEvE+YJUpKiJY1mYMKko6L5sEC568q+PuF+5tUQBfPWaT2+6MIRfAVUdG0E+yHKH+VR1zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.223.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 7A8342599A
	for <dash@vger.kernel.org>; Wed, 23 Oct 2024 19:56:29 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-3.trex.outbound.svc.cluster.local [100.103.25.208])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id B22D62528A
	for <dash@vger.kernel.org>; Wed, 23 Oct 2024 19:56:28 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1729713389; a=rsa-sha256;
	cv=none;
	b=ra9oTY+Nt17bOWSkXnu3gmhB/9tbMADnVUtPOBW/X4jwPkYi0pKoRq9oJ25aZNNmP865xj
	EG304kx8I2ERMoX7ew/0BtUr8+6xAIZvLF1gS1z7GtnQ1ClKrZ+uJ/FuVRlyUv/M2BbS6g
	B025GdTU3G5goTTZ5wArhz8J11VNP1hN2YsMGO6hMGR9Y534I7jSWlNS2EdyeCdrZ49CPQ
	OA3ZcdOF2iOMyhUH1LTbj+uLVoGl2Wxcxa5nAEKPZYZziTRV8BFF0vjoiP7J6/ERX7mrfy
	QhmCsrJDGw+Bqlkl3dh+ItY5qLMKkVMEKzyUkvwmB485Qx0JwgFmyMOcgeKs7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1729713389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OEjQFMnBX5LePmPjy5W9B9SpT09rUkdKixYULHTM3j4=;
	b=7/UhFJWrA3ML3Ek08c8C7eiFVNzVNJcnrq/9DSlayEvWvrK1j8myR43rr2nI64olJ9kxte
	kYCHbGnk6CHM2fJIsyr2fNB6Wq71SSlbq8qtqqEjIA0FWGIb8Gnsfiyy3xcNWx8QWCg+6Q
	lWzhaBaYM/aIAZTknBZFF5P3IGgNFJFw6FJNPsq7G7EmK+tYv7XZwx8X/Przi5cD0Pc2p1
	E3/aTLsaxEay5OlMmUlj18SEnT4v177LEQAZJzfV3nZQ8PR4XaZJ0A55hKv8BKyjrAgys9
	qiFmx/cL/LfhyXvG8sBneBsu8i27jDsZu3YJW9sgzYYFrvusicNbxDEWoYlrtw==
ARC-Authentication-Results: i=1;
	rspamd-9bc7b7997-mc4xp;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Decisive-Soft: 7ebb48382d1527ee_1729713389406_865322849
X-MC-Loop-Signature: 1729713389406:641782801
X-MC-Ingress-Time: 1729713389405
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.25.208 (trex/7.0.2);
	Wed, 23 Oct 2024 19:56:29 +0000
Received: from p5b0ed864.dip0.t-ipconnect.de ([91.14.216.100]:62757 helo=heisenberg.scientia.org)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <calestyo@scientia.org>)
	id 1t3hT0-000000013cU-3M7f;
	Wed, 23 Oct 2024 19:56:26 +0000
Received: by heisenberg.scientia.org (Postfix, from userid 1000)
	id 0FA3527D7EAA; Wed, 23 Oct 2024 21:56:25 +0200 (CEST)
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: dash@vger.kernel.org
Cc: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>
Subject: [PATCH 1/1] man: Clarify the `trap` condition `EXIT`
Date: Wed, 23 Oct 2024 21:55:45 +0200
Message-ID: <20241023195623.148722-2-calestyo@scientia.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241023195623.148722-1-calestyo@scientia.org>
References: <20241023195623.148722-1-calestyo@scientia.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: calestyo@scientia.org

From: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>

Signed-off-by: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>
---
 src/dash.1 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/dash.1 b/src/dash.1
index 96ce89e..dbc34c9 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -2157,7 +2157,8 @@ is
 .Li 0
 or
 .Li EXIT ,
-the action is executed when the shell exits.
+the action is executed when the shell exits normally (that is not via an
+unhandled signal like SIGINT).
 .Ar action
 may be empty
 .Li ( "''" ) ,
-- 
2.45.2

