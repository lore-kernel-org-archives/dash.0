Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE251876
	for <dash@vger.kernel.org>; Sun, 28 Apr 2024 03:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714276605; cv=none; b=Py/L7yPeFtlq+xwjDQ8K1BSMWhtS+3x+CnfbwavF/TlodtpJcNay+J7AQvFWI7QdS38ZP2WqKXZQHRGQkAtCuHCWVqCHY5qd6NHovhppsbZlBRrFXtYL6/wUTbVH2QaFCkEemBoWcraOE7/WUBhEh3T+01N6wsRuHjkXvQTssiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714276605; c=relaxed/simple;
	bh=+fo6H3VnPXVINShgbUsWRAy1EsYp0AfKiDycw36wu7U=;
	h=Date:Message-Id:From:Subject:To; b=NqL47cA0GD+fesgZRYaXlcuGqPnmGhKvk8P42Q1HMQpi312vccmjz+h3JPaT6rBx6J5JCaTGF17dqI/5sA33/5YI3p4Q6E3P3mn8HKrNnBEkQwT48xIwclrXy1GvFpzVfAZreCBo471OZeltcNFF0Fwm64TgSUT/9tRa4hLmqHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s0veX-007PYz-2B;
	Sun, 28 Apr 2024 11:56:38 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 28 Apr 2024 11:56:55 +0800
Date: Sun, 28 Apr 2024 11:56:55 +0800
Message-Id: <cover.1714276539.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v2 PATCH 0/8] Add multi-byte support
To: DASH Mailing List <dash@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

v2 fixes a bug in scanright.

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
 src/expand.c     | 487 +++++++++++++++++++++++++++++++++++------------
 src/expand.h     |   1 +
 src/input.c      |  58 ++++--
 src/input.h      |  11 +-
 src/main.c       |   4 +
 src/mystring.c   |   2 +-
 src/parser.c     | 127 +++++++++---
 src/parser.h     |   1 +
 9 files changed, 517 insertions(+), 182 deletions(-)

-- 
2.39.2

