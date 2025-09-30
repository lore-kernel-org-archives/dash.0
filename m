Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E041F428F
	for <dash@vger.kernel.org>; Tue, 30 Sep 2025 12:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235172; cv=none; b=qPI/uVysQtdWgP5XmbV0UuM7ClqVYkUzDbLMTPZKlWPD+0oWnyOz/AZ9uyagJFJNNxj94VctoyLH0LPGM5isuJsv4NLVcxRA1avHxtiZi2uA+0qGcq3n56+QuVEMlcirBeLs7hBRIM9dzUcVdyKMIu8+uce7GC8vecPMQSAEhXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235172; c=relaxed/simple;
	bh=mAj54gODozDyidBPtTGus96XRo1rEiqg0oFYWIZobWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0uZri/tnvBk/iBRiIWUiBj3t/VMwyjF4XZH+8VP3Z+xDRSyjgqOZXBLNOk5J96+G4RfQ8VsCpGApX2rrazrexuhQeYTE5aQ7k273yJu9jEg59z9WxYIXYwVF9vXyI2TOU4MYMG4znoVAjdmeS+WdeMfHHcyjdG+Fd+Rde/liBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=NorzGaQc; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="NorzGaQc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:cc:to:subject:message-id:date:from:reply-to;
	bh=J68dFqYseCdf0nox4bjQJdaCis0w/5xMskJ3EWf5Nh8=; b=NorzGaQcgVvYfCoPYtGRB5w6/p
	zjNi30T+YnKsHcFoTJJe5RbjQHtyNF1MJOez3hMYcIA2ge9S+bb0d7by6LVXxuwtJkHMIzC+iXYgm
	YZdjDnqZvX5fruA4lOHWJqChilZeuBxXeW3b4/miYRUBRruyfVhBJOzmkBvzf1XLJ4Jy/DO7JLitc
	CX9VkAyTMTeKqr7xOV/22m5VezVLA24+ey+v8TQh8AKHQQ+dhI7gMMCWwRdB2foNsGF0TLHgeKz0Q
	k+JlYeNtb5xwXKxjnhLO1Iw+rMypsmJrXHtmEbdUgEJlOnstyHrNcPFjjU/BZ7TarbP6uxRZJM+GY
	Haj2gknA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1v3ZQg-009RGY-1y;
	Tue, 30 Sep 2025 20:26:03 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 30 Sep 2025 20:26:02 +0800
Date: Tue, 30 Sep 2025 20:26:02 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Brian Inglis <Brian.Inglis@systematicsw.ab.ca>
Cc: Dash <dash@vger.kernel.org>
Subject: Re: dash 0.5.13 configure config.status truncated running under dash
 0.5.13
Message-ID: <aNvMWqEu-uIiCbGk@gondor.apana.org.au>
References: <ba3014e6-b1f6-4b6b-99ac-524dafd22f33@SystematicSW.ab.ca>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba3014e6-b1f6-4b6b-99ac-524dafd22f33@SystematicSW.ab.ca>

On Sun, Sep 28, 2025 at 05:05:38PM -0600, Brian Inglis wrote:
>
> $ ls -gG dash-0.5.13-1.x86_64/src/dash-0.5.13/configure
> -rwxr-xr-x 1 200409 Sep 28 15:57 dash-0.5.13-1.x86_64/src/dash-0.5.13/configure

Hang on a second, while the configure script that you attached
to the original email is identical to mine (198404 bytes), this
one (200409 bytes) is not.

Can you please attach this configure script please?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
