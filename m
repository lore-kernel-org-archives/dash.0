Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E1A1392
	for <dash@vger.kernel.org>; Sun, 28 Jul 2024 02:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722132101; cv=none; b=aV30HZlgxKRZNb33uE5eBJ9vCQ0Em8spRNl3kqRHFCUAu0e84lQ72cBhSnN0L1Uv5gArNoYwrCVl0VldSRR80QyhdJpHr/2uEI/74x7L55aJqnTrmWYVtTnlHMERtdMmLRf3HNEKCipdgmGNAMNgsAEL4AzzAhXgyG4YNC2vVdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722132101; c=relaxed/simple;
	bh=ETOMMqkaIKD8QKPRLNTjj1zgMxX85STFDOK8vnYHQIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4xZKsyVeZgD8IaxOMyUMPeBs8l3e399Li4kCEjZW9gcC+MI3xUDcG3FiYIwdBBK4r9GdfV/e21XCwJ6ilgA9cUgEeI63a7wzFYGuwCrA7a0Vi4dpk5hpox0ZRYs9O6wY7u3+yLFbQsnD+LoYnf8CffX68HM1dWuEkp/Mxp0psg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sXt5V-000dZc-17;
	Sun, 28 Jul 2024 10:01:27 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 28 Jul 2024 10:01:26 +0800
Date: Sun, 28 Jul 2024 10:01:26 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Buck Evan <workitharder@gmail.com>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH 1/1] add tests
Message-ID: <ZqWmdr1iGcdBepnI@gondor.apana.org.au>
References: <20240706194424.5412-1-workitharder@gmail.com>
 <20240706194424.5412-2-workitharder@gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706194424.5412-2-workitharder@gmail.com>

On Sat, Jul 06, 2024 at 07:44:16PM +0000, Buck Evan wrote:
>
> diff --git a/test b/test
> new file mode 100755
> index 0000000..8d214f5
> --- /dev/null
> +++ b/test
> @@ -0,0 +1,33 @@
> +#!/bin/sh
> +set -eu
> +export PATH="$PWD/src:$PATH"

It appears that most references to dash are already doing src/dash.
So just change the naked calls to dash to do src/dash instead of
modifying PATH.

> +if [ "$#" -eq 0 ]; then
> +  # default arguments: all tests
> +  set -- ./tests/*
> +fi

Please use tabs for indentation.

> +for test in "$@"; do

This could simply be

	for test; do

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
