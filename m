Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC7119ADA4
	for <dash@vger.kernel.org>; Sat, 14 Mar 2026 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773481142; cv=none; b=k04UShiKnCwOYZHDorhOlLKcaT66Gm0QpT+cWycyjYSMoI22ZL3nPqSGWv0ldrC6+Aq+lMnfCv9TK3jiz3xQvho+3+Pvly0Vi8nkZ4B8oMzhcgcPGqhVF9cTTkNOd+gCstg40BnRTAOrTzCkHWIeGcK3idtAugY9XQcGFmKTy5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773481142; c=relaxed/simple;
	bh=Y8+YARHkJrJj+7ANo28s4/cKhulvk6v9h6lypdJngBM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=a/PRwtVoXKErJV6jYn4phgU3ccs7psMFN+Ns3xaFopWJ8AKBef4L+9w+n1RGekA5Zfika8wBjmOkO666+m57bgNIoMOgAax9N2V+q/KaX5JNGCahFGuSVQ2PMh1/sU/1VuZh6SmYqdcAGFwU1bXG8sxyRUxsUfTpH23vnJ/QgBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=a6eLwka5; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="a6eLwka5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=SrNhSU8bZYWl/+syIW6iBIqddPRTQ95dFQ1FqvoMguY=; b=a6eLwka5O5VjwDBbs5ptNZbmGn
	UZhl2nAM6A9Ud9+eW/kSrEIyZ5q3+2HN19DBrAs0b9UGe/jhCllJGE48bRnsvMbD3mcl0e5QrS5WQ
	Pwij6cGSnFwm4McTDhvKWgzqigwhlpmp1f/J/S9prqj0KCNCKfPVYQJFPlDRucwyAJu4qL6zLQAnM
	CwDW67wJFlBPKLctEQYiRvbcMOjguFQxcODRywE3qk0nQaRVfTP2apcQInkD84X5xZdjeBC6BmtYg
	igtYKpFRyo32YKbfCqr/Ea4GJeYvPDVM7iLvptONOWWk49Oc1Y7MWA68oMRYD2gZyPORF1tEB4L3H
	NSDnAstw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w1LST-00ENGf-2z;
	Sat, 14 Mar 2026 17:38:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 14 Mar 2026 18:38:57 +0900
Date: Sat, 14 Mar 2026 18:38:57 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Reilly Brogan <reilly@reillybrogan.com>
Cc: dash@vger.kernel.org
Subject: Re: 0.5.13 regression: Coredump
Message-ID: <abUssUBlmBbmAL-0@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cecc45a4-ba27-455a-b8a4-b69c713f2384@reillybrogan.com>
X-Newsgroups: apana.lists.os.linux.dash

Reilly Brogan <reilly@reillybrogan.com> wrote:
>
> I attempted to bisect this however was only able to get a range of 
> possible bad commits due to the gmp configure script exiting earlier 
> with `configure: error: cannot run /usr/bin/dash ./config.sub`. The 
> three commits it could be are the following:
> ```
> # only skipped commits left to test
> # possible first bad commit: [44b15ea09a9ee5872cf477e4ffc6b42ef37d1e46] 
> input: Use tee(2) for stdin pipe
> # possible first bad commit: [b1864ee9f2418f84d918ef101dab972ecf4f852f] 
> input: Use lseek on stdin when possible
> # possible first bad commit: [a065467315dc5f2f312f7e6f1d2e9d05a77b3cb7] 
> input: Move newline loop into preadbuffer
> ```

I wasn't able to reproduce this earlier.  But now that we've fixed
the preadbuffer bug, I wonder if that was the cause of this too.

Did you build dash with libedit?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
