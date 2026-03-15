Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44974317D
	for <dash@vger.kernel.org>; Sun, 15 Mar 2026 23:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773617266; cv=none; b=CSMziKKbsmggk9nDbxE5p4OSEDcy8dilXVhKQiNHhrw6qnynQUrYupatXFnYc4CXzWo5sBdhLFoAOD/Isvw7DNYCAaJ7E6q4HdlES7VM039cN9Se3BuSAXFPEYVTBPLVh8MpPPDHW6E7edvwITTJQGWOawarUoWM+rHHgWpZZWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773617266; c=relaxed/simple;
	bh=9v/rVO39wZR36CCxqz5C7SK8kx1XJHr8HbAgbO8C4nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MzeMbnq6fh4dEN17Cq13R+9luQiMMxYEUo9zPeMbu+YWQM8DIsl0qBcFVjbutWafAljF4IBRb2dq+37xItraFaXHhTYVZGD48upkNMabcyM3aphbOIxpqYJV6wDroKF/JKhsVKoo9joDK+HvSPMXrqtt3EO4R4RaH8aqpfh6UXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=a3i8Mygi; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="a3i8Mygi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=dxqUg/QbeB+zw6/E7SIvf06neNcspO1WX8ibqHiK5Vs=; b=a3i8Mygih+qIwJynnz9SHDfORy
	jIuqAnKl86LRuei+lSoeU54uYZHAmuFCu9g6Fc4toptaOaXpjyDEw4D1OCilcOlHF49lbgzOshNXq
	ovY2/zm3t9F8rYs8IErnLaqcZGc8aXt8JMxop6K46aBFGxOiyhwDWJDkRCiVFr8BubSguDV8H3nzp
	crrktokaAtzXPmtpq1JAEKAbHozDPUPd8/24gru+G4Or2xDDUVHtkrYMXRgfCoRKjNUHQyvEAPQv5
	h0DeFxPwyNThFWRukezI1pQXRynpax5TKIZXELPZYCYWHwT9fJ4sbME5Xxv8BoIoRFGmpAaQtg4Vc
	kbDwwv5Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w1us1-00Ege0-0R;
	Mon, 16 Mar 2026 07:27:42 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 16 Mar 2026 08:27:41 +0900
Date: Mon, 16 Mar 2026 08:27:41 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Aleksander Ushakov <retes672@gmail.com>
Cc: dash@vger.kernel.org
Subject: Re: [BUG] invalid-shift-base umaskcmd() src/miscbltin.c:258:26
Message-ID: <abdAbSLUM14dPN-z@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADdNFas7pVJoDNaq_kZB-cXZjQZfrNYPKsuPZm6xboqHmJBDtA@mail.gmail.com>
X-Newsgroups: apana.lists.os.linux.dash

Aleksander Ushakov <retes672@gmail.com> wrote:
> I encountered a bug in Dash 0.5.13 and would like to report
> it. The details are  provided below.
> # # miscbltin.c:258:26: runtime error: left shift of 1073741823 by 3

While this is true I don't think it's really a problem.  You're giving
umask a value that doesn't fit into a 32-bit integer, which is why it
overflowed.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
