Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244807E0F4
	for <dash@vger.kernel.org>; Fri, 16 Feb 2024 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708101207; cv=none; b=LI6flp9cp+JB9utVoPf9rPKyVf+qT7LXLI6V06FpoA0EzuY8HYY+LgxNTP2PpolB+D6Fd5/1uZD84lGVoHehWM6UP2Fnlp8JHzpj/8QKymYsqNE74qdS1dgqvcvBccDVLGQShgA9MZGM/ttJIhv3jYxDy4nn+e/4V0RMWygHy6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708101207; c=relaxed/simple;
	bh=LU6edrgM9ArsOmDxZq9TxpNLcVIxpBb9/sgainEL7vo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B8H+g4Sm3bFr+ev2qvVZRo8QyuntS9Rv+f5q1egbmj/51rJLXQFDFlprTj/+YGSi5Cp4Iau+sjWeNEni1xBQOQaWvhSIi2AVgXXmfo8amABy0qsTNsAsoIFWzDF9e8CCfmfQGEcXR1SaVYwxhOmCiq9AeouP0Hvug46FBtMgNz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+OkavjR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+OkavjR"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41242be3460so6337605e9.1
        for <dash@vger.kernel.org>; Fri, 16 Feb 2024 08:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708101203; x=1708706003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HXqSQGaW6wyqnxpQA/qilgbJhv0pohUYx1JjPT/9xs0=;
        b=e+OkavjRHWlUXGLZJ6VA9iEspKpUf3PeTB1obTQsqn+WMncTHck9xADAx47gUmcrww
         oRRip3p+4Yv6SdKXlsv13K3F69u5+K+Ru6vT7la9n4fKVwswZkVxXaVqGw6SX/CAyOPy
         hYc0Xrx/pOAy7HAxOKiW5ZhkY0RMPIFgjCLzEQuaejCY31fwfLLHSpNEZfH+pWPn38Mc
         kGpvqiOFj+zbyJHz0A91jQ2IDp3db2xF3Aykjlq+ci+2eKZIEv7I32gMS/urTpyQEcH4
         vtODUvCUK3K4bhDSEV1hRlSHr6i/kINEBBMDrTxTrhifNInFVyDnO8hxtpEKWMkQ6iCr
         mRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708101203; x=1708706003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HXqSQGaW6wyqnxpQA/qilgbJhv0pohUYx1JjPT/9xs0=;
        b=YbFNNqUNy0ohTSoUT/YdGi1f0OX5iIuAq4IzsasXpM/iO0ljavf0e3NdjaWEnGP20K
         yaGpyRm4v5ooY8i9xu+B+Wgw21pq/a2b3Vpv14+R/vziNXNd7FdbJCcWIp1kYTL4XPyz
         k0+K3ViN4PUAawiQVje0FuUGQoJ3JfvyMgMYRPBX04hvy6WR012mJLLpdUOYJTqFFOG+
         UVOtLTrhS/rmOWx+0MPphAdIqrNgTCKjVfWdOZCb1jTq4sQhiRDqtcC2OnT/nSW2Pzom
         empiKqarPpmK6dJTyyb6DrI7RMbg8LNwtknDSkiGxiexfFqlbQWs1KLa4HP/V8qfpdMS
         aDzQ==
X-Gm-Message-State: AOJu0YwbCKeDjLYpDomOYRuTu3QHo1QfO4McVz4BzwRCZtHVPCFOlcLv
	i0xG1ebOWASqAs7wIgQbeCF45M2243RVu9R8kkCCZrLuzK3g0S4r/USjKXAr1NQ=
X-Google-Smtp-Source: AGHT+IFCjld2Qx1M81DdltHZ26xQPaF+VwenEN+L0gK+Tg9O2dQbtccdoQ+tJodGLSQEOHNAqo5TcA==
X-Received: by 2002:a05:600c:4688:b0:412:3b33:d130 with SMTP id p8-20020a05600c468800b004123b33d130mr1803101wmo.25.1708101203245;
        Fri, 16 Feb 2024 08:33:23 -0800 (PST)
Received: from kali.home (lfbn-ren-1-787-165.w83-197.abo.wanadoo.fr. [83.197.114.165])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c228600b00410ac2d6b40sm2801070wmf.8.2024.02.16.08.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 08:33:22 -0800 (PST)
From: Fabrice Fontaine <fontaine.fabrice@gmail.com>
To: dash@vger.kernel.org
Cc: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: [PATCH] configure.ac: drop -Wl,--fatal-warnings
Date: Fri, 16 Feb 2024 17:33:19 +0100
Message-ID: <20240216163319.860768-1-fontaine.fabrice@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop -Wl,--fatal-warnings with --enable-static to avoid the following
static build failure:

configure:4778: checking for strtod
configure:4778: /home/autobuild/autobuild/instance-8/output-1/host/bin/powerpc-buildroot-linux-uclibcspe-gcc -o conftest -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -mabi=spe -mfloat-gprs=single -Wa,-me500 -Os -g0  -static -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -static -Wl,--fatal-warnings conftest.c  >&5
/home/autobuild/autobuild/instance-8/output-1/host/lib/gcc/powerpc-buildroot-linux-uclibcspe/8.4.0/../../../../powerpc-buildroot-linux-uclibcspe/bin/ld: warning: conftest has a LOAD segment with RWX permissions
collect2: error: ld returned 1 exit status

[...]

In file included from arith_yylex.c:44:
system.h:74:22: error: static declaration of 'strtod' follows non-static declaration
 static inline double strtod(const char *nptr, char **endptr)
                      ^~~~~~

Fixes:
 - http://autobuild.buildroot.org/results/a54fdc7d1b94beb47203373ae35b08d9cea8d42c

Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 5524650..6993364 100644
--- a/configure.ac
+++ b/configure.ac
@@ -34,7 +34,7 @@ fi
 AC_ARG_ENABLE(static, AS_HELP_STRING(--enable-static, \
 				     [Build statical linked program]))
 if test "$enable_static" = "yes"; then
-	export LDFLAGS="-static -Wl,--fatal-warnings"
+	export LDFLAGS="-static"
 fi
 
 AC_ARG_ENABLE(fnmatch, AS_HELP_STRING(--disable-fnmatch, \
-- 
2.43.0

