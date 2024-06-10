Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA9B101CA
	for <dash@vger.kernel.org>; Mon, 10 Jun 2024 06:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718001911; cv=none; b=To21kXREbYXuLu4aHCK1z4pHNPHFKFhw9qaar6NI97Te9rZf4n4EvB2PTqbAJoPyzNL3IYdYORubSC6c2oTYI3hEzQEQEayxY8DIFx3xtzGVAufHaCrA4UDEyiHXhBow/WXEapGEjuf1KmWHjuYfTOhE4TuuS+/3Pe32rmrTBHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718001911; c=relaxed/simple;
	bh=/InzTxOZfK2uOwbYx+6g/lo8ygHrVUC1HEUOt1AeV2Y=;
	h=Date:Message-Id:From:Subject:To; b=tph0Nt3NX5gIeK0KM3RuCgRleVj+9canivExkmxGbyX1toDHqJi/LmJJdeAJqblt9k4SipFRHwsoh+jwKej3P3UBKbf1WxeCrgxlj3extMrWdR4mhKWJS2Qtw/HbRdSTzsyJ55vnWcybiz3QXfB/1kAz1+qdeLvgjbwrBzTuIPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sGYm5-007V7N-1b;
	Mon, 10 Jun 2024 14:45:02 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 10 Jun 2024 14:45:04 +0800
Date: Mon, 10 Jun 2024 14:45:04 +0800
Message-Id: <cover.1718001832.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 0/3] Add dollar single quote
To: DASH Mailing List <dash@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

This patch series adds support for $' quoting, including \u and \U.

Herbert Xu (3):
  parser: Move non-variable case in parsesub to end
  parser: Merge first and last chkeofmark branches in parsesub
  parser: Add dollar single quote

 src/bltin/printf.c | 156 +++++++++++++++++++++++++++++++++++----------
 src/parser.c       | 108 ++++++++++++++++++++++---------
 src/system.h       |   3 +
 3 files changed, 206 insertions(+), 61 deletions(-)

-- 
2.39.2

