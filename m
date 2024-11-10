Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8E022615
	for <dash@vger.kernel.org>; Sun, 10 Nov 2024 06:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731219554; cv=none; b=kJ3+h/OWYFe1TTkpu17ts+lAVc8HWTEUW8xpNr9w4+BjOEhgJ7+5jWAkSCAcNOq34UeMhy6cWiRa5UmJMX92gyvuZVKqOMBiQpZUqUXkX3u8AF4yce58c/3L08iEP2fdSvLhntivEa6tAmVi+PVvBnuI4li1GbhedNSKdZw6OUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731219554; c=relaxed/simple;
	bh=4HTvqlurkG+PPXjglc4THHO7bcShYiagwQCHi8Mtgq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/HAJsEiP2KaNu3Ts03Rf/rYHFKUqE096bte5bGrKZp7oImDFO38ei5T2NZQLznIc/0l6GJsCrpH7PGi8RcbEx2J6lKUhSH+Rv896jESChIcW/QNvs0DMyTBnhsjkIRpeMGIB5R5M8ZkTf4DOXfNK79bVBihrp0GNW3khPqq1kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=fLiFA+Is; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="fLiFA+Is"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=lgbxSDpjQtDA5payZeDtqZxwLP7EW58uzRu4zYJ7AOA=; b=fLiFA+IsJFxC2kmAo/vohhuhkW
	UwdIEUF8YnR/A1qG7h9tBBXQszCvFunOJjnLd0ZzV0+NP3hIWuHpLkmwYIczZfb92CvGEfhcBVkKh
	RbH9t1YskJ+eeU80YJUFGtNYv9tb7fzn+IhvKzFpiWyV9EZcJYQ2oE3x6bdVSm0FLN+TEYhDDKEhe
	u7++cqWnAhFhcZoLfbD9LGjGeNX0G1Cl6JiJawApoSaTyq1XYlJi1ItwKJ6EGhfQWCBC44XfTs0Ei
	kaby5buAsdKZCt5tWvbRYV60HMIOM83lnCFJ7XZR1xJmYPeLuObttDOF63MF4KuRJuOnmj69ThDxK
	o3TLRfTA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tA1Hu-00Fl1W-1R;
	Sun, 10 Nov 2024 14:19:07 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 10 Nov 2024 14:19:06 +0800
Date: Sun, 10 Nov 2024 14:19:06 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: dash@vger.kernel.org
Subject: Re: set -e not ignored in AND-OR list
Message-ID: <ZzBQWqDIAbClvglR@gondor.apana.org.au>
References: <ZzAyYf1ZWcSuPVJZ@gondor.apana.org.au>
 <b16286957f9b3d6409423b3b9b54c84c1c64fcb2.camel@scientia.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b16286957f9b3d6409423b3b9b54c84c1c64fcb2.camel@scientia.org>

On Sun, Nov 10, 2024 at 07:08:10AM +0100, Christoph Anton Mitterer wrote:
> On Sun, 2024-11-10 at 12:11 +0800, Herbert Xu wrote:
> > This is simply undefined behaviour.
> 
> Are you sure that this is undefined? Cause:
> 
> > The -e setting shall be ignored when executing the compound list
> > following the while, until, if, or elif reserved word, a pipeline
> > beginning with the ! reserved word, or any command of an AND-OR list
> > other than the last.
> 
> ... seems to define just that.
> 
> Or do you know of any part in the standard that allows an exception
> from this?

This is a command substitution subshell which is not governed by
what you just quoted.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
