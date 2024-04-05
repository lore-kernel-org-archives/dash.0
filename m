Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DDD15FA77
	for <dash@vger.kernel.org>; Fri,  5 Apr 2024 08:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712306930; cv=none; b=AsZQWEwkrUQcOvB6RRI9xZk5rhZ7PiFNKZ19D84j8bQGB77ORByV1Z32gCK2yi5QpmDk40HhsrL+3pDnGgtkalNuPMN+2RttftVkQPVxk3mfU7/diA2xfLbdhLQlUSrNDfbIPFTJv/pWSBWetTR7GSjfobQn5waJ7PXkF21ojHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712306930; c=relaxed/simple;
	bh=Olax7bttMiHRuW+oIVFWEDwx8fOC4Wdxlc9Q90+CCg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ii8q2tB53t0K7OzA1HrSSgW5sNNlbHx88e0Fs5HQUQ2KVbOYZaQhL8Ti4lkS/ESZEcGxhO8Lin+Ws4zaxPYtXrnF2YqKiK6MWft0xE+mauLizCTIzfD6SCK66AC6bwddhb3w2z0ELI+5M3bfe8fyUc+nGbjq2zgn8OEta51h2Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rsfFb-00FVFr-10; Fri, 05 Apr 2024 16:48:44 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Apr 2024 16:49:00 +0800
Date: Fri, 5 Apr 2024 16:49:00 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Ron Yorston <rmy@frippery.org>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] jobs: Report creation of background jobs
Message-ID: <Zg+6/PsA7tHAqLrf@gondor.apana.org.au>
References: <61501d4a.OSIdlouybdqIzH3I%rmy@frippery.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61501d4a.OSIdlouybdqIzH3I%rmy@frippery.org>

On Sun, Sep 26, 2021 at 08:12:10AM +0100, Ron Yorston wrote:
> Although it doesn't seem to be in POSIX it's relatively common
> for interactive shells to report details of jobs run in the
> background.  bash, ksh and tcsh report job id and pid while
> the Bourne shell from Unix V7 reports only the pid.
> 
> This from bash:
> 
>    $ sleep 100 & sleep 200 &
>    [1] 4626
>    [2] 4627
>    $ sleep 300 | sleep 400 &
>    [3] 4636
>    $ jobs -l
>    [1]   4626 Running                 sleep 100 &
>    [2]-  4627 Running                 sleep 200 &
>    [3]+  4635 Running                 sleep 300
>          4636                       | sleep 400 &
> 
> Unlike reporting of job completions such messages are not controlled
> by 'set -m'.
> 
> ash has never supported reporting of the creation of background
> jobs.  Add this feature to dash.
> 
> Signed-off-by: Ron Yorston <rmy@frippery.org>
> ---
>  src/jobs.c | 2 ++
>  1 file changed, 2 insertions(+)

Thanks but as minimalism is one of the primary goals of dash
I won't be applying this.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
