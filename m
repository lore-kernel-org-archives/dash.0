Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488E7370
	for <dash@vger.kernel.org>; Sun,  2 Jun 2024 01:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717291894; cv=none; b=tynnpTPqdr8Rv8aratUEAW+zhboAx2e0MYIgqkRFIGUUrZDqHOhTln4PO7dYv/ZZrfsxwETOv9k8voQagsLBzZTlVuCkBXB5Gt7aD5y1XqKpZfEM5rCFkWlcV3yt0/GSik/SQRbbX8Miwb65tiAAm+tDnD2n6NWmxCjkJXMByh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717291894; c=relaxed/simple;
	bh=45VUf93VIPwa+YpbajKzxXh+ZLQE98U896ujsEOsJN8=;
	h=Date:Message-Id:From:Subject:To; b=NcfH28clMWUxM12ybZUl28+nqQpa3O1iaqegk/bSqPFswumlWPX5fXaD6m2BsBYQHV3A+uFTIksJ6N6Gs+j5EyYFGBPQGWTfv1l2EqzPSAX99OUYhY7O0HXWx65gNdT7xXKtD96MkniLw432EoVk/KOhXZpc0RKIfckKzLTjUsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sDa4G-004iZF-16;
	Sun, 02 Jun 2024 09:31:29 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 02 Jun 2024 09:31:30 +0800
Date: Sun, 02 Jun 2024 09:31:30 +0800
Message-Id: <cover.1717291846.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v3 PATCH 0/3] Improve performance when reading stdin
To: DASH Mailing List <dash@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

v3 rebases on multibyte patch-set v5.

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

