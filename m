Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B494926FA77
	for <dash@vger.kernel.org>; Tue, 29 Apr 2025 21:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745963284; cv=none; b=q7A+uJklX5SsqrV+P+S1Me3TgThCYPzaJ9k1tVEHs8k9HQ/imT2/C/01R2XKf4JCI/3vMhIAw4uQDTkdDD9v5h7Pt+rKJboF0hOB4S2C5y9cX+MQY29UWXqxoMmPGJe2SHREs8LayAyv9dLgBODbrD3rKQr+pL0oyjmFGYfHsB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745963284; c=relaxed/simple;
	bh=5Yih2VnBPIUh+mc1lpW3d7rD++XPcYuD8quErzO2uy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l352Dc/G9sXmDcN2OmDr2d5YlX+oKn5M2CggwLdfNx5pxkkrqGs/FNQwf3Z7HX7mpdRhsl2rIrZ7Yr1rGFNGRxrsQ83sH6nVnBZ9ENAdwgDmtOliCPHFumzON7MUZlNSsukrkJY2QqIT5/07RGzS/bGDDUClevk2nSSqbI0R+Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/e3iIEL; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/e3iIEL"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2aeada833so60462266b.0
        for <dash@vger.kernel.org>; Tue, 29 Apr 2025 14:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745963281; x=1746568081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnVzj145rGy5Bvj9nXWYtn2TAxaVA1dkFubLKrMZN88=;
        b=E/e3iIELDYDDNbqWPb6uATvkPkFpI4kQ3Nv8PyftvEYLBNAQ49fdyP7qWMiUhuRwEP
         526BYXQXP7TvelUosXct0kKAN9Nee3OaqVytGffKl8hALa1zwpKLB7TXvUt09+xsM+fx
         uaKED187QfkBI+ZT1S7IkxHx4EHVpRJS4naDtbYbYQGdtWN4iZicW9mdEAMtSNzY+yus
         Uzzy2houzeADEpZJgLmXnUh/MC4H58Zmyu5kRjnGXFkIL/4w/+U4F6jMoiK5UGxUNg0j
         C85RQXZo5qDV0ZMeJpROSvfpD040iK8Tvjmx6qObVYEchj2MLMLXXP1Fy4fP8S1rJ0J+
         anCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745963281; x=1746568081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnVzj145rGy5Bvj9nXWYtn2TAxaVA1dkFubLKrMZN88=;
        b=fEpgLjqyM38obmmRBVyXEko7qsKzA+ek2SbfPUy9TJJHd4nf9A1E0sdOgBGkOQAHiS
         rm2K3l6yxBF+QjuY6a8a1CkfPFf0dkOzrHYv/Hld93yOWbigY+WbFux+dFXBpCw0rI0w
         iYqiLbu88eDHDWgTyHJABAQOJ/+Jo//dhwGp19i9At6+81Hv8406PgVIEDMpw3N4sxu9
         SyaSRMUd3yGUbkNZe4udmqDeN4yt/RlVo42WB5mrT8WKLW8bkpEvtJ2or1SH7RvQcTcj
         vmPhdOKTbaXiHgsC+PvWZlUBWdqyPS6XmIaVP8enze8SOUCiVjl6me/ha0GhQ3UWMRYn
         tHIg==
X-Gm-Message-State: AOJu0YyOtCr0G4LRaOi+fhWeooG0RHquuqSrgLMbX8PaVTlBAJ5Tj5Jg
	xFzTn2PJ6Tu6NcCzc0aAHMNFvmzXtipYWYk4BokEeU/76AbSSKOylf8gLg==
X-Gm-Gg: ASbGncs9vrCUVeWBM3W4G5xcUIW7RyK2i2/4H0yUWH0sEZVLqNXg2NqL6s0jCQIsNxP
	9u45FSzJvrLWz2ymhQ/uhYkMaBHmyGbpP2Qiwn2c7lcVYmARPSQozwSQvQU2IhiWXKkq/T3gL7B
	w/9sMJSbl+dO+Mb9edjYIrt2yc3N/X949RJtsgCaev1DV3bj6uLQrgbSjLnRImruB3J0AbolS1x
	CFi4FWNm7N7vD61FlqS/z/KIW0BkwHkPDaxefkr9G1BW8c9TCeYDoDbWzq/ca1y/nskR18RdmbG
	fAbKqyKoQWJi2/fqX5dTL+ZItADgtd1dApubIov+mZr6hshr7UpuOJ7Hc7tl8R6FNHSm8ZiEFhy
	pr6VoKTAUlXs0yQ==
X-Google-Smtp-Source: AGHT+IGsrGNWmaRU7OiQBvHhbR8li1VDysyb5KvKDjRpz98nNo7PjIIy+86X0NpdjKggbNo1jMkWKA==
X-Received: by 2002:a17:907:7e9d:b0:ac7:b231:9554 with SMTP id a640c23a62f3a-acedf68d7e1mr37712366b.11.1745963280726;
        Tue, 29 Apr 2025 14:48:00 -0700 (PDT)
Received: from localhost.localdomain (92-70-146-242.biz.kpn.net. [92.70.146.242])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1abdsm850984266b.177.2025.04.29.14.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 14:48:00 -0700 (PDT)
From: Zurab Kvachadze <zurabid2016@gmail.com>
To: dash@vger.kernel.org
Cc: Zurab Kvachadze <zurabid2016@gmail.com>
Subject: [PATCH 2/2] expand: pmatch(): Fix buffer overread caused by passing array of chars as string
Date: Tue, 29 Apr 2025 23:47:32 +0200
Message-ID: <20250429214732.22390-3-zurabid2016@gmail.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250429214732.22390-1-zurabid2016@gmail.com>
References: <20250429214732.22390-1-zurabid2016@gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strpbrk() accepts two null-terminated string arguments. stop[] is char
array that is not null-terminated but is still passed as a second
argument to strpbrk. This causes buffer overread, which is detected by
AddressSanitizer.

This commit adds an explicit null-terminated to the end of the array.

Signed-off-by: Zurab Kvachadze <zurabid2016@gmail.com>
---
 src/expand.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/expand.c b/src/expand.c
index 171c135..8cff60d 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -1890,7 +1890,9 @@ static __attribute__((noinline)) int ccmatch(char *p, const char *mbc, int ml,
 
 static int pmatch(char *pattern, const char *string)
 {
-	char stop[] = { 0, CTLESC, CTLMBCHAR };
+    /* stop should be null-terminated as it passed as a string to
+     * strpbrk. */
+	char stop[] = { 0, CTLESC, CTLMBCHAR, '\0' };
 	const char *q;
 	unsigned mb;
 	char *p;
-- 
2.45.3

