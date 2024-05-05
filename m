Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDC26FD3
	for <dash@vger.kernel.org>; Sun,  5 May 2024 09:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714900478; cv=none; b=ZXtpsDdTYmKZSc+9VtnmwivSOGRK4IGFGkpAfpvfhi4xWcwCogqCfYJYDbsz+bbcX8+1U2DyGVRnWy5zClmrkfWtRSeRyc+H9RqrxcfF8N585ok4A4Svw9HgYEdvevOyRN9nwBBPcU/A68EB51tqQaxMJ+9vOnvhmO1lhOENsKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714900478; c=relaxed/simple;
	bh=LlaIy0mZDJZjWrQIKqKW3Ztj5rbGMyRhBb77nGD+zfg=;
	h=Date:Message-Id:From:Subject:To; b=Nj3rSl6n9FfNmI5/Q/VAUWVbuiKcsuv0ui5gbO9tSRH2Nwu/xYQkDBCX7+vSw+s8WVOisoIIbcInKCk2wubpG1r9UhmX4GMSENcUIyFpyKshhbtbX6/eboXLTDqe2mQZmi24Y5Tl7Bfwwg/XqHpR7lyO2FOXgVq4ZFuAxi/onlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s3Xwt-00AaV5-1g;
	Sun, 05 May 2024 17:14:24 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 05 May 2024 17:14:23 +0800
Date: Sun, 05 May 2024 17:14:23 +0800
Message-Id: <cover.1714900377.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v3 PATCH 00/13] Add multi-byte support
To: DASH Mailing List <dash@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

v3 adds support for read(1).

This patch series adds multi-byte support to dash.  For now only
fnmatch is supported as the native pmatch function has not been
modified to support multi-byte characters.

Herbert Xu (13):
  shell: Call setlocale
  shell: Use strcoll instead of strcmp where applicable
  expand: Count multi-byte characters for VSLENGTH
  expand: Process multi-byte characters in subevalvar
  expand: Process multi-byte characters in expmeta
  expand: Support multi-byte characters during field splitting
  input: Allow MB_LEN_MAX calls to pungetc
  input: Add pgetc_eoa
  parser: Add support for multi-byte characters
  input: Always push in setinputfile
  memalloc: Use void * instead of pointer
  builtin: Use pgetc in read(1)
  builtin: Process multi-byte characters in read(1)

 src/bltin/test.c |   8 +-
 src/expand.c     | 487 +++++++++++++++++++++++++++++++++++------------
 src/expand.h     |   1 +
 src/input.c      | 119 ++++++++----
 src/input.h      |  15 +-
 src/main.c       |   4 +
 src/memalloc.c   |  16 +-
 src/memalloc.h   |  10 +-
 src/miscbltin.c  |  58 +++---
 src/mktokens     |   1 +
 src/mystring.c   |   2 +-
 src/parser.c     | 136 ++++++++++---
 src/parser.h     |   2 +
 13 files changed, 612 insertions(+), 247 deletions(-)

-- 
2.39.2

