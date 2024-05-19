Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C19833D5
	for <dash@vger.kernel.org>; Sun, 19 May 2024 05:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716096014; cv=none; b=LALwLBAOgCG/W4Z2C2cIIuYl4lNPmPJKfG+zW1e0z6nPDe5gi1vUHIBBAWio4TgBg+M+EYxyRWs7QjcgV9MxKAJgM4A8kNXiFCS3wmGucm7L6bul6xI2iNm5dpEpvsJY35Q5YEu5Xh7/Dp68I2tlJ2zDVxCjT4EqzXp3JPBZYcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716096014; c=relaxed/simple;
	bh=hf5tukLhRhYA9Gj9P90DjgOPhiqLV0bIffOFT1AD2h4=;
	h=Date:Message-Id:From:Subject:To; b=nYbypLhzm+2v+fHMAXwbqB2s8RgAQX5XCI13hPx8YhCwdBi7bvtJB/91n6C442DWj0JM6zK/V7c+XTJkxjwtZUkDydR+5mYnhdLKpmKzRlN2xsPpZ3u7UfrkpDLAW4r5G9TcThuJ7LEbFLttrI7EOriGyr8M1WJLB8RYXY6uzXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s8Yxq-00HG9s-1f;
	Sun, 19 May 2024 13:20:07 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 19 May 2024 13:20:07 +0800
Date: Sun, 19 May 2024 13:20:07 +0800
Message-Id: <cover.1716095868.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v4 PATCH 00/13] Add multi-byte supportAdd multi-byte support
To: DASH Mailing List <dash@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

v4 adds pmatch support without fnmatch.

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
  expand: Add multi-byte support to pmatch
  input: Allow MB_LEN_MAX calls to pungetc
  input: Add pgetc_eoa
  parser: Add support for multi-byte characters
  input: Always push in setinputfile
  builtin: Use pgetc in read(1)
  builtin: Process multi-byte characters in read(1)

 src/bltin/test.c |    8 +-
 src/eval.c       |    3 +-
 src/expand.c     | 1041 ++++++++++++++++++++++++++++++++--------------
 src/expand.h     |    2 +
 src/input.c      |  119 ++++--
 src/input.h      |   15 +-
 src/main.c       |    4 +
 src/memalloc.h   |   10 +-
 src/miscbltin.c  |   58 +--
 src/mktokens     |    1 +
 src/mystring.c   |    2 +-
 src/parser.c     |  136 ++++--
 src/parser.h     |    2 +
 src/var.c        |   12 +-
 14 files changed, 986 insertions(+), 427 deletions(-)

-- 
2.39.2

