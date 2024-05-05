Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7507363A5
	for <dash@vger.kernel.org>; Sun,  5 May 2024 09:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714901050; cv=none; b=fu521y7cfzC1QQbd9wcPjuim/O4QWHRoeZz3mwp9bW6QWkUiqp2Jq+oeh5jEvWF/7kvucSs+Eu3RgCSfBkApRtVDUkCXab+wH2huWaH6t+l1kVicuiaCXefR+bT6911ftI0Np4649l3hKcueGf8fK2dQVfhPCUeHQ6uO7dhcVV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714901050; c=relaxed/simple;
	bh=C+QS8Iot4xmJdyiN42WChgjy2LcrSBsqVNNPlddglrs=;
	h=Date:Message-Id:From:Subject:To; b=GUxhCyME6FaIVFwrnjijnyvhUIXNcPdEiK7AcgQPQ42KFwQqkaFPrLl60nYs8pnx2RHT/kWGSO2kx+m7nR+A/f0hslPhX/QowQp9jygViGJphHnce6GnCl7eRyYxIioEC/PYTdgIPb8mG6KFnKLkszUExPE/O29KEMmD5MpI2yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s3Y6G-00Aaj7-2F;
	Sun, 05 May 2024 17:24:05 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 05 May 2024 17:24:05 +0800
Date: Sun, 05 May 2024 17:24:05 +0800
Message-Id: <cover.1714900988.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 0/3] Improve performance when reading stdin
To: DASH Mailing List <dash@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

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

