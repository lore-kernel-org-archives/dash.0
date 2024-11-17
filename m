Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C281CA47
	for <dash@vger.kernel.org>; Sun, 17 Nov 2024 02:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731810630; cv=none; b=P1SeMsI6NMiaGSwQG++tqVclhpOAn4Ktt8ScIFV6HREDixHWBC/t4K30pvf3kRTWRp/yG2Eo0D8HZXNBReEwbGMwUGfuWfa7q2pyML4QPsBa+3yPpQrnlkJ/vMw4++rNwiFDDR/vuMkqwk5lx2Sj3AGwSox1ZY56qJZGlI4ghbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731810630; c=relaxed/simple;
	bh=1WMWRTuzQIeiaP6feOdoQERYyFpqfvI2RTB9LHw5HLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ikJmxFXmoTvfa38tBRmNZd9bv6oNFs2J84J8oYrPyBFc1nGJo2s4sKWgWNXphG6qFRpteEHmTqIKt63zHMxyWyyFOseO+tf5/0Vosf7pMDU7K/NiBAnHD1n9+P/jpZia4HfQVkh5IELJUI8G1FPiz+PElFqzY2H9uUxWJF7zwZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: dash@vger.kernel.org
Cc: Sam James <sam@gentoo.org>
Subject: [PATCH] bltin: fix timescmd with C23
Date: Sun, 17 Nov 2024 02:30:17 +0000
Message-ID: <9f2a8ab063e595188df3fe0546484e5a8156318a.1731810617.git.sam@gentoo.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With C23 and LTO, we get the following warning (or error if promoted to such):
```
src/builtins.c:28:5: error: type of ‘timescmd’ does not match original declaration [-Werror=lto-type-mismatch]
   28 | int timescmd(int, char **);
      |     ^
src/bltin/times.c:15:5: note: type mismatch in parameter 1
src/bltin/times.c:15:5: note: type ‘void’ should match type ‘int’
```

Make the two consistent. This didn't show up before because pre-C23
had unprototyped functions.
---
 src/bltin/times.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/bltin/times.c b/src/bltin/times.c
index 1166a68..252b084 100644
--- a/src/bltin/times.c
+++ b/src/bltin/times.c
@@ -12,7 +12,7 @@
 #endif
 #include "system.h"
 
-int timescmd() {
+int timescmd(int argc, char *argv[]) {
 	struct tms buf;
 	long int clk_tck = sysconf(_SC_CLK_TCK);
 	int mutime, mstime, mcutime, mcstime;
-- 
2.47.0

