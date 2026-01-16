Received: from gbr-app-1.alpinelinux.org (gbr-app-1.alpinelinux.org [213.219.36.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BA42D595B
	for <dash@vger.kernel.org>; Fri, 16 Jan 2026 20:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.219.36.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768597018; cv=none; b=dDvCmNqsrZ6xQql/tLoJCSgbaI4Ospbb0FrLfy+jAsu/x9VB3i6xOh9ePZM59WX6sNiz0x13kx+mFSK+0XhHV7oVj+oPJvzfY6Yng4IjVkxyruyv4NHXUKAyQE3Mj7dtkUPnHu2SLfADaApoFf0sl4mrui9A+iN9yXlzS6+Bc60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768597018; c=relaxed/simple;
	bh=IYvY2pzISKEaCYmBsw/KI/PGmjeQhAtB1pdAJOnqSlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=snXeKLWibCyW1hANABfdNptcPNge/J/oPYNyNSS8xizrBPofw+edGpKbFHHztkVnachTC3y993C+o1enrCBx9kp3MvXadoJK/vypFovgvkRgARu4wkEyn3gIKJ9jVJ3Uh3yBpEMrtHvsYenraGklJ1DnSdAE7ViZlvNlw0KZ2is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpinelinux.org; spf=pass smtp.mailfrom=alpinelinux.org; dkim=pass (1024-bit key) header.d=alpinelinux.org header.i=@alpinelinux.org header.b=IZQJTQcy; arc=none smtp.client-ip=213.219.36.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpinelinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpinelinux.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alpinelinux.org header.i=@alpinelinux.org header.b="IZQJTQcy"
Received: from ncopa-desktop.lan (unknown [IPv6:2001:4646:fb05:0:8e82:e9fb:7e47:f299])
	(Authenticated sender: ncopa@alpinelinux.org)
	by gbr-app-1.alpinelinux.org (Postfix) with ESMTPSA id 214E5222377;
	Fri, 16 Jan 2026 20:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpinelinux.org;
	s=smtp; t=1768597015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gxOnxxTPojmhg+SvwA7eaqsoirkhSAE6k1WNsl5xv8E=;
	b=IZQJTQcyJ1iGvPxzPtnBCvX1Dgn2yhtS1lfCZ3PeTQcyNSMbrHOoYKOvIx2IPGrEZWMtfh
	XocKRxDZQu+Y4abkzPZfQo2Voyjk4mXgZ3G2VJC+TO+RYIr8XLux4iuldxwnwjK7g7a4Uv
	Igwtdh8JkAqfFVPQqvMYguxOdjrrD4I=
From: Natanael Copa <ncopa@alpinelinux.org>
To: dash@vger.kernel.org
Cc: Natanael Copa <ncopa@alpinelinux.org>
Subject: [PATCH v2] expand: fix SIGBUS due to unaligned access
Date: Fri, 16 Jan 2026 21:55:39 +0100
Message-ID: <20260116205645.19074-1-ncopa@alpinelinux.org>
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
 src/expand.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

v2:
- Added a couple more instances of unaligned access.

diff --git a/src/expand.c b/src/expand.c
index 8c8bf0e..98b65ba 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -961,13 +961,14 @@ static size_t memtodest(const char *p, size_t len, int flags)
 	if (likely(!(flags & (expq >> 3 | expq >> 4 | expq >> 8) &
 		     (QUOTES_ESC | EXP_MBCHAR)))) {
 		while (len >= 8) {
-			uint64_t x = *(uint64_t *)(p + count);
+			uint64_t x;
+			memcpy(&x, p + count, sizeof(x));
 
 			if ((x | (x - 0x0101010101010101)) &
 			    0x8080808080808080)
 				break;
 
-			*(uint64_t *)(q + count) = x;
+			memcpy(q + count, &x, sizeof(x));
 
 			count += 8;
 			len -= 8;
@@ -1335,7 +1336,7 @@ ifsbreakup(char *string, int maxargs, struct arglist *arglist)
 						unsigned char b[8];
 					} x;
 
-					x.qw = *(uint64_t *)p;
+					memcpy(&x.qw, p, sizeof(x.qw));
 
 					if ((x.qw & 0x8080808080808080))
 						break;
-- 
2.52.0

