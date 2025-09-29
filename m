Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C052B1F3BA2
	for <dash@vger.kernel.org>; Mon, 29 Sep 2025 09:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138644; cv=none; b=CTvc4JcUYrU5A6I5OZA5mMC1/rgH6H+tl7Ee/+IOKzVmedjy1Y4xnqCCbHkUaZypKLNXZaZTiozhn73GTvB7BEVPaANS1jBHYjr04SEjeVUf6md+dPwsp7CsArtPKksGxrdcfG7aErbHweQJeEPnwJVLCWZLwr9ySoJJHnCTgp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138644; c=relaxed/simple;
	bh=3fXkwIWhrLVae1YnwpjsoWErE1wRQ2RRx3rQnokAElM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ILXOUQH7JTk+Jvk6ndfHVB9tQPisJkMlF2+21k/afRyLcKXZPNgwDpnUH7DZNj3+wryBpY6cNr4e4cYkWtOvsercWqnkyOutbABNPL1ChIvgXiy7d9EhD1yrPg8gdZeSv3kQUf2BdnnlZztapaXQrJdD953cA7gtXrJyGrLSi9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=LBUedj89; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="LBUedj89"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:cc:
	to:subject:message-id:date:from:references:reply-to;
	bh=xBtS6UGM+7OegnrmQ7T/HE+SSvOA/WJWeAG1GcYnT9Y=; b=LBUedj89DA3kPgk9r9PCL0nXUW
	nhwXYenRdGBNBctNQfPJ0Lhioreo+kVeyWo1fofBvmMTbI5DyfTAk4TVedBCkDAXEdsX+DSYCaAIo
	Gmvv/68dJjTa009h3pav+TeUYZCttRSTbbT/CsVfDKPBCI7X8d9nbUV2pYENRKrj061KPRuspUsBs
	EQqR2B8Cyr09r9poQOvWc9fyCIESjp8yZ6SBcp7g79ISAnLp7TLnOwwbkfMrmNRzjxbwkwxzuqmFI
	D9qWB8tOJ6nUoOKrIfLSQI7rxgY6JTK+lEvmr/L+HFkssJIyjXvj+PLreZ8QpVRd88XgbtuQ+fPkz
	78YH9unw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1v3AJo-0098H5-1m;
	Mon, 29 Sep 2025 17:37:17 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 29 Sep 2025 17:37:16 +0800
Date: Mon, 29 Sep 2025 17:37:16 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Brian.Inglis@systematicsw.ab.ca
Cc: dash@vger.kernel.org
Subject: Re: dash 0.5.13 configure config.status truncated running under dash
 0.5.13
Message-ID: <aNpTTNA7XTVQu4Ki@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2afff6a4-d645-4a94-8644-45f669b70da5@systematicsw.ab.ca>
X-Newsgroups: apana.lists.os.linux.dash

Brian.Inglis@systematicsw.ab.ca wrote:
>
> Applied and rebuilt, getting the same failure with identical ERROR messages and 
> symptoms, after building okay with previous dash == sh, then rerunning with 
> latest dash == sh.
> 
> Do the previously highlighted configure script last two config.status generation 
> stanzas seem to have issues, or is that as intended?
>
> It appears that the following _ACEOF\ncat >>$CONFIG_STATUS ... might be 
> misplaced, as it is immediately followed by a list of sed commands.

It looks identical to the configure script that I get from running
autoconf, and my copy works just fine, even with the buggy dash 0.5.13.

> These stanzas come from /usr/share/autoconf{,2.7}/autoconf/status.m4
> included by /usr/share/autoconf{,2.7}/autoconf/autoconf.m4 frozen in
> /usr/share/autoconf{,2.7}/autoconf/autoconf.m4f.
> 
> Or is this an issue that should be raised with the autoconf/autotools team?

Based on the fact we just found two bugs in 0.5.13 that both broke
autoconf, it's probably a dash bug :)

I just checked your original email and your configure script is
identical to mine.

Can you please run configure with set -x and send me the result?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
