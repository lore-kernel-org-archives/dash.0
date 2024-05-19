Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FC333D5
	for <dash@vger.kernel.org>; Sun, 19 May 2024 05:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716096182; cv=none; b=YuQe27tVM/See5/8NzbLThzY4HbIwfYLK7L8LQMJ641LSLWnt/DRAspj+aE4HwCIPm8jyylPCsMyA0DCVsH3e7B1IW4s/VCYd5gCYo7v8RPQ+66IGZXTmFE/GPpDEpl+dabiZdAEY4pK85oxCMOshEiOpiTQ1bP8RErdRr2u7gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716096182; c=relaxed/simple;
	bh=RdimNYEl8Lrw/W1AVopy5eErePW6GKD+obQijyCbCBg=;
	h=Date:Message-Id:From:Subject:To; b=BXjU5gzrVG3+Cp4hVaLWpTli1C8ydN2UnRvc8h5kkv6PT3ACKWA0wBQZFjncM+NGpO1FCRmjeyTBG0/OpB4+DxDjvrFWawbzna6ScdqJaF6bZs4rystIPb7edgfJd5JALwLn1V757iYJJAt1MTtykx3o5YSkhfWRTsuybQ1ra0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s8Z0Z-00HGHq-2p;
	Sun, 19 May 2024 13:22:57 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 19 May 2024 13:22:57 +0800
Date: Sun, 19 May 2024 13:22:57 +0800
Message-Id: <cover.1716096097.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v2 PATCH 0/3] Improve performance when reading stdin
To: DASH Mailing List <dash@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

v2 rebases on the new multibyte patch-set.

The performance when reading stdin has regressed after we started
reading one byte at a time.  This patch series uses lseek(2) and
tee(2) to recover performance where possible.

Herbert Xu (3):
  input: Move newline loop into preadbuffer
  input: Use lseek on stdin when possible
  input: Use tee(2) for stdin pipe

 configure.ac  |   2 +-
 src/eval.c    |   3 +
 src/init.h    |   1 +
 src/input.c   | 208 +++++++++++++++++++++++++++++++++++++++-----------
 src/input.h   |   4 +
 src/jobs.c    |   3 +
 src/mkinit.c  |   6 ++
 src/options.c |   2 +-
 src/redir.c   |  26 ++++---
 src/system.h  |   7 ++
 src/trap.c    |   1 +
 11 files changed, 205 insertions(+), 58 deletions(-)

-- 
2.39.2

