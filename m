Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1D02D373D
	for <dash@vger.kernel.org>; Thu, 28 Aug 2025 21:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756415594; cv=none; b=rdETbHBOZtzCboNH6F0/eIlj8NbCC9+9EprS+zgu55vNil6xwy8ZoNpfVsIwadbTWz3e0lGzGxcHsyhzKa3Zul+9KQEDqaEteuSdgS2KtMS6H/Dia15zkNJk3eXrbC8CLVVSGfSGUjkcj0tkyIiOlYO8Mh6nK7jTwjb1yx9z0ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756415594; c=relaxed/simple;
	bh=yywuSRKuG0gRBMXQZfMKWScKAdFaMnEjcbeSKE6XmqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PbyRrttUWiB3ZjeiOSqIDL7thtpsn0JAciyOHWSvOV86HwTvZizhMClCPeaO1jrN3ed+Xl9LlOWX6BJbduSlXGRyxvwLGoL6ByvV23A3nSXEze7Oxj6gnfc44uz9qpWKiyJKq5P279T5wISoJ/Djazs3ttJyEGQJGQSV1BIprZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXfibKfM; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXfibKfM"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-51dcac8c77fso45261137.0
        for <dash@vger.kernel.org>; Thu, 28 Aug 2025 14:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756415591; x=1757020391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uYYODMxgHQFhvnAGPQFcG5b6LvOsAj8dowOcxQG1xa0=;
        b=aXfibKfMnLvngvYdOGK0edxdS7h/YeIdepZXhG4VUeWbb01VMA7w4EMzy62ZT5QDLK
         rtG63uIx2FwYBGI8KEcTMDDFaIdMskip+gRxjRMxvA2CvQxhCynMoyIg7RqbN+D8wINY
         Xmajv5RMKuWQWqlqxzLTfCqA44ATRGOwIvq5Yz+Xumb8MOtKfsS23Xai2vnJ+eC461uv
         L+yu8mZJgSMiLd9AAO7wGxdgT7e6deezTbHkYs8KTsi/eXBB6BXhBpaM505aOch9fJs9
         6rYBdZDWFUu7jwK0SARapGP8EbZMQXfTDajurLoO9rVxcQ/3ghfS6mzOFR4B88Aj+cJx
         IyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756415591; x=1757020391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uYYODMxgHQFhvnAGPQFcG5b6LvOsAj8dowOcxQG1xa0=;
        b=XMJkzkm1TtK7QOHqJ4Lx4x30RcUWfqBCk7ns8Arnds/sW2q4EergiKLR+SvlRFmbxI
         ObWSpkGdaFtswFrjwcoTTtNJFjaBPlbFN43ZF0V6nGmByd9Zinou7CZ02EAZZ3MVYYum
         44Ij24dXYpe3+stR6D9xAUVyPblbtSQOsO5O5Pv3/AOKMOwjFb52bvoU/XbXrXU/nXvj
         uMMSUvGzpD2HZFkn+KyY9LSDs1OR9w0mfYcY41Ivm8zIb7uhrAsYRC442kRNv5v6XgEt
         Drm0jusdAa5HKIGnfY557K/h7TSMOSLE0rxoHIEu0z91ln4GbfGtRb8CR5s1lyOVIXrX
         M4eg==
X-Gm-Message-State: AOJu0YzD7DuddBJap4wmzqUGpGblA4Z+OwP1jrqq4TLZDps8NhpZ1n2C
	vtDDgt5kwgOSAxXMbHDxR279pzcGJNzF8tnVIZtJQmABRyEAEzfELfRETUd9CjKX
X-Gm-Gg: ASbGncsSlXv8HkKSjQZYQwTF3d0maxPtqhSy73YiFpDz9YGy+9CI4P4JQsnteBp11af
	oYI5pAxjYAR0BdXhnqqu+mlOiE598WWGcE+f4fdneAkvxb5WT7WQsCu3d7boi2+PQA/tr63sc/8
	bK7Elki2aP9MQHo6FDa5cnUhh+8f1nieRKRLcKF+5Z/9yEwIgqxMX12Y2p63M+ls/jcIUHNTvMk
	oV4Th8/avcQa9gloDw72YD5p0sJglntmwt6gKx9k/UNtQV5dLpLyEX2nrNCc6bxirv2428eAKcq
	olAh4yK4oGUCWsmOMF/gJqt8bo27lMl0gO+I07OIFaPqbaR8phEuyFMM5AxFPcuRhjDcXiwpFNF
	rNbWu7hOfC/Dz3SFHeBKp2Bq0M2qXo/ZW9Bt/96ZBDla/tNvDD5TkFLv3SHc=
X-Google-Smtp-Source: AGHT+IEUfPjcUoYlEvPIVAcQhMSQioWsHV8nWsY6xs3r6qUTn/TOwE/JpB7gerqFgG3BVbPoWX2IMA==
X-Received: by 2002:a05:6102:2909:b0:526:2d5:6c7a with SMTP id ada2fe7eead31-52604347210mr1025604137.5.1756415591587;
        Thu, 28 Aug 2025 14:13:11 -0700 (PDT)
Received: from localhost.redhat.com ([170.247.111.81])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-894388ff1dasm262911241.2.2025.08.28.14.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 14:13:11 -0700 (PDT)
From: Eduardo Santos <eduardo.experimental@gmail.com>
To: dash@vger.kernel.org
Cc: Eduardo Santos <eduardo.experimental@gmail.com>
Subject: [PATCH] [DNM] builtin: add source for Bash compat
Date: Thu, 28 Aug 2025 18:12:20 -0300
Message-ID: <20250828211219.392014-2-eduardo.experimental@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not merge this patch; it is purely informational.

I tried using DASH in a container image for GitLab CI/CD [1] but the
runner expects the source special builtin from Bash to be available.
This one-liner fixed it for me.

[1] https://docs.gitlab.com/runner/configuration/advanced-configuration/#use-a-posix-compliant-shell

Signed-off-by: Eduardo Santos <eduardo.experimental@gmail.com>
---
 src/builtins.def.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/builtins.def.in b/src/builtins.def.in
index 95e420c..7a7d68a 100644
--- a/src/builtins.def.in
+++ b/src/builtins.def.in
@@ -61,7 +61,7 @@ histcmd		-u fc
 breakcmd	-s break -s continue
 cdcmd		-u cd chdir
 commandcmd	-u command
-dotcmd		-s .
+dotcmd		-s . -s source
 echocmd		echo
 evalcmd		-ns eval
 execcmd		-s exec
-- 
2.51.0

