Received: from gbr-app-1.alpinelinux.org (gbr-app-1.alpinelinux.org [213.219.36.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30578338902
	for <dash@vger.kernel.org>; Fri, 16 Jan 2026 17:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.219.36.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768584052; cv=none; b=dzomE24dJfe6SShIKBfa9+989cXdAQamFM0VPI/t0u5/0zggDeDdyOF0HZCqO5Sbzv1+E6Nv/vs2ktWIY08I7Aj5fmLfRNzX3vXhUk8Kdg1fgIikLxesf377/6cdi3WqRnKGto5378//p7jfRUqw4CCVR3HGJX/2pbsxlRfm5qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768584052; c=relaxed/simple;
	bh=I6xK5ADOLAvttv+YMGJHwHP4+25BDSGvP+eX+c3hxWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o2CC2Eshb75c/LdnbHD3nc0yt8Pdtk7Y05cdOXlNHHXe060VvfA4sFhcGuKJ3Y6WnjQY415v3fGokgMsmFGwAEVTtQ75RaOep2QANV4qFf8i+yNxIoH8q8F+rFSAqC4ycMB9maY/Ump8/PSL/rT+NBghIGQV7Hk9ne4iUv4OILU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpinelinux.org; spf=pass smtp.mailfrom=alpinelinux.org; dkim=pass (1024-bit key) header.d=alpinelinux.org header.i=@alpinelinux.org header.b=MAR6JfPy; arc=none smtp.client-ip=213.219.36.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpinelinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpinelinux.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alpinelinux.org header.i=@alpinelinux.org header.b="MAR6JfPy"
Received: from ncopa-desktop.lan (unknown [IPv6:2001:4646:fb05:0:8e82:e9fb:7e47:f299])
	(Authenticated sender: ncopa@alpinelinux.org)
	by gbr-app-1.alpinelinux.org (Postfix) with ESMTPSA id EB5F922051C;
	Fri, 16 Jan 2026 17:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpinelinux.org;
	s=smtp; t=1768583534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=arbGHA85WjI5m/SbUG5lgPII8DRnHJbFZms+9khAJK0=;
	b=MAR6JfPyz7qNBavHWcK686sgCd6pgmtoFfaa0GEy/GwMIFAwdGWLkMbfJFQRznYRmL0FVT
	DJp95QBXdqeiq7QxQ3Y08A/DcAJH7cGGKGEoCtOfXn4qSK0CTxZtiTkUBWC/CuMh8d9Jzz
	nteAv2LgxhQpNaEG/46Hdnh9CBFTsTY=
From: Natanael Copa <ncopa@alpinelinux.org>
To: dash@vger.kernel.org
Cc: Natanael Copa <ncopa@alpinelinux.org>
Subject: [PATCH] expand: fix SIGBUS due to unaligned access
Date: Fri, 16 Jan 2026 18:11:21 +0100
Message-ID: <20260116171203.10248-1-ncopa@alpinelinux.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace direct uint64_t dereference with memcpy() to avoid
SIGBUS on armv7 when p is not 8-byte aligned.

Fixes crashes in dash during IFS splitting on strict-alignment
architectures.

Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
---
 src/expand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Downstream report:
https://gitlab.alpinelinux.org/alpine/aports/-/issues/17896

diff --git a/src/expand.c b/src/expand.c
index 8c8bf0e..4ac9d17 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -1335,7 +1335,7 @@ ifsbreakup(char *string, int maxargs, struct arglist *arglist)
 						unsigned char b[8];
 					} x;
 
-					x.qw = *(uint64_t *)p;
+					memcpy(&x.qw, p, sizeof(x.qw));
 
 					if ((x.qw & 0x8080808080808080))
 						break;
-- 
2.52.0

