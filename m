Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C561862
	for <dash@vger.kernel.org>; Sat,  4 Oct 2025 04:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759550445; cv=none; b=jC6LwrYCTEgJTiuFuOCZtL5n5nA/lhIvwd/dafvefgb19ET0KdzCyyvrPvmdv0ogc5xiVAQ+ZVwGWPpjkNC9KvTm6YgsNwp5e+jh4RaTaig+DOxM6+JIGoTfzMQjVnOTqQ06GfmTti58shWuKDtbUUdtoGR2KVUAUJEwBG4fBUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759550445; c=relaxed/simple;
	bh=TXXiiq46TzRfuOc2ZXyOisfuKT6kT0OXytkzqYVYLic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilCE9Uo4HaqxQUrgBBuACUnIIpmwFPNONuh0LGRu2Ni2oOUkOZm4evSX2Ux1aoC1aDN79uwGz2waeBUXORhzrOPape4KiQkpxrlZSpGwp4OSCMpxAy9mJRGFO0BM787g/PQuXqVCmCRTBPrLgsKk7OllvjFWhBaIn+emuk+u3MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=lcY07eHQ; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="lcY07eHQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=FmrdGuPIeJlyuk28ouwGnhV9NlV7p/1s9R+xrrT3z1k=; 
	b=lcY07eHQim6QoWdJ8aP/igJecqraox8BZUoDouaETzwLXmL8zGTZQRp4913h/Iex3dNr7xzDc44
	U+N+wR4b/zwvJnGTcxpcL0lVvSB4xici/GYFyDC1uqlNxqfzqETEEe/suh63Ghyz0Af0hS++qJXrC
	zO1qZLnX8qc3ttj3VtEw4DL0riLcDy3RsJyI6At73KpbZTXRFdNYsgBWTdSYxX8A64SNZzrUq3w1F
	8Ii+e4NWhyL/z3ellndmT2kLSzUI6o6YqcIOvdjy3R33leMn4XGFEWN+1jOox1sn8Q8xkA1Dho+0O
	7lHqBnC3xgUWJqUpjWIatFcxAltiwCwUD8KQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1v4tRe-00AN2v-1S;
	Sat, 04 Oct 2025 12:00:31 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 04 Oct 2025 12:00:30 +0800
Date: Sat, 4 Oct 2025 12:00:30 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Brian Inglis <Brian.Inglis@systematicsw.ab.ca>
Cc: Dash <dash@vger.kernel.org>
Subject: Re: dash 0.5.13 configure config.status truncated running under dash
 0.5.13
Message-ID: <aOCb3piwcPXpm_NI@gondor.apana.org.au>
References: <ba3014e6-b1f6-4b6b-99ac-524dafd22f33@SystematicSW.ab.ca>
 <aNvMWqEu-uIiCbGk@gondor.apana.org.au>
 <81470aa2-3689-46a7-84bc-a7781cacf048@systematicsw.ab.ca>
 <aNx4g4eZSsdvXlRH@gondor.apana.org.au>
 <2b8b60af-82f0-437c-a99e-260aafe37b82@systematicsw.ab.ca>
 <aN97a6Nn2C56006t@gondor.apana.org.au>
 <e16023a7-bca3-4537-a8f8-f0e952c70e1b@systematicsw.ab.ca>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e16023a7-bca3-4537-a8f8-f0e952c70e1b@systematicsw.ab.ca>

On Fri, Oct 03, 2025 at 09:19:39PM -0600, Brian Inglis wrote:
>
> Likely the autoreconfig with recently updated automake 1.18 using existing
> /usr/share/autoconf/autoconf/status.m4 stanza:

But it's always been like that.  The code is correct as it is.  The
quotes are split across two here-documents and there is nothing wrnog
with that.

For some reason, when you ran the script with dash 0.5.13, the second
here-document failed silently, thus creating an unterminated quote.

Please help us find the cause by doing a bisection.  As I said my
suspicion lies with the new memfd code which obviously won't be run
on Cygwin so there may be an issue with the fallback path.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
