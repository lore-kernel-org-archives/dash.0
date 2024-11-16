Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE9458222
	for <dash@vger.kernel.org>; Sat, 16 Nov 2024 11:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731756294; cv=none; b=Wi6cKSgUcPXoxUxnIb0dUr+VpwZjrfW0QA8dFXa/ZeLpZb8HvYG7eugg/hvVFpFUk6Dkgd6yg7R5N6RiI5g05iveJya3G3EfES1gOln7bMhSsLBpIXeKCq6ID8cW6WV4nkCnkUzldWdnFzWhxiUKjC5uR5G4XyVr8a9tAC5TRGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731756294; c=relaxed/simple;
	bh=X63a+ltj1KZspRHlpWjH6VDlI2vRV8EfL/sLrqVjux8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NXIzur/hXGtQxoisqKpRnxAP7kfPtirlLbJ21LnzwNboRMt6tL4IhumCmjshZe40P6ZejjjnQXuN0qkJU/DE/qykAUeKt0LWTwki/BaLEXa6ZaBeNjyGff5AnkeDJZ8X8VcAFUMtfiVqFylFTkq7yoEslDeEhU9b/ipfpu28SD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=cmfWKfdi; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="cmfWKfdi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fNWQjz7ObJsl6HLz9tLkv/n4KABzfO6b8f6LGeIzVj0=; b=cmfWKfdiqJ57rxvM2HjeDe+Mz1
	lmGJLqeKogglKuCXVRhzrPMIuHytn95TCOCPIaN1cARN56TRtqQpRQYCeHyePImrfQsan2dFcCKac
	lFUz+z59oStQowR4zk/bCVjWOrfQ+zOZA1YinovhbQtJnOECZnf7dsV712/H9RL+F3E3PkGiqvfQG
	1O5BWyJTiLQNrWSYD/DJ1EumcBJeWs04ivyBQthDxZKFeJbaf166OLuXwYzAocT1GVDDAl2LGtP/Y
	KZicmwUgk5hvZNGa1InXnsXyDlTXiRR1Aurw/NAJ3OZi7h8ZyD01ydQhAPNWcUF/EEI7unUSLMHbK
	udC+WyDQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tCGv1-00HGSn-12;
	Sat, 16 Nov 2024 19:24:48 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 16 Nov 2024 19:24:47 +0800
Date: Sat, 16 Nov 2024 19:24:47 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: dash@vger.kernel.org, mail@christoph.anton.mitterer.name
Subject: Re: [PATCH 1/1] man: Clarify the `trap` condition `EXIT`
Message-ID: <ZziA_96e2pBqD_Of@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023195623.148722-2-calestyo@scientia.org>
X-Newsgroups: apana.lists.os.linux.dash

Christoph Anton Mitterer <calestyo@scientia.org> wrote:
> From: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>
> 
> Signed-off-by: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>
> ---
> src/dash.1 | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
