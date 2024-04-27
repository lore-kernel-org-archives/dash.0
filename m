Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AC5482E1
	for <dash@vger.kernel.org>; Sat, 27 Apr 2024 11:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714216021; cv=none; b=tPgCG0fIqOgOayK0uh6x5XIDVvicOZdTnamsuuTgBsaYQjVBrN4nqWjKLUYDfK5+9+QcZ9cK43rulcoJR/XYynYtdT4GUw1g33zcSthF8RHBlyLM9+orCpteZGCkG40fa2XWCxDN30PyrJP+VRUE09WAyqdJHsDNQ2VWJsX2wvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714216021; c=relaxed/simple;
	bh=iFn5lTUITv0tDf3c1vA10qyU+j2pBMQwwMrWc55/ETI=;
	h=Message-Id:From:Date:Subject:To; b=WseN9TyXzyx+2ETXpAxiw1rfFxwMEzKu7bmIQjbCBNu3kFtrFaC/f57jbpenkDfb/KILxso2rz9k0IgzfW+xHpWXpV58rsjEtkgoAeQDxYALMVU/Y9WAl6v51NE3aAc2nEbCWvgHMboVSzpzgJP1XSDGUU1O+Q6xHuopMDCArbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s0ftP-0079lS-32;
	Sat, 27 Apr 2024 19:06:56 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 27 Apr 2024 19:07:14 +0800
Message-Id: <cover.1714215826.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Sat, 27 Apr 2024 19:03:46 +0800
Subject: [PATCH 0/8] Add multi-byte support
To: DASH Mailing List <dash@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

This patch series adds multi-byte support to dash.  For now only
fnmatch is supported as the native pmatch function has not been
modified to support multi-byte characters.

Herbert Xu (8):
  shell: Call setlocale
  shell: Use strcoll instead of strcmp where applicable
  expand: Count multi-byte characters for VSLENGTH
  expand: Process multi-byte characters in subevalvar
  expand: Process multi-byte characters in expmeta
  expand: Support multi-byte characters during field splitting
  input: Allow MB_LEN_MAX calls to pungetc
  parser: Add support for multi-byte characters

 src/bltin/test.c |   8 +-
 src/expand.c     | 489 +++++++++++++++++++++++++++++++++++------------
 src/expand.h     |   1 +
 src/input.c      |  58 ++++--
 src/input.h      |  11 +-
 src/main.c       |   4 +
 src/mystring.c   |   2 +-
 src/parser.c     | 127 +++++++++---
 src/parser.h     |   1 +
 9 files changed, 519 insertions(+), 182 deletions(-)

-- 
2.39.2

