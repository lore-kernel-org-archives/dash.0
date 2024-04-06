Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB49EEBB
	for <dash@vger.kernel.org>; Sat,  6 Apr 2024 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395826; cv=none; b=RsiZ/RBCiXUXmyn6UZVTJJBcdcwHT+1F9B8NUUe5QY4b2wmIGOCW551cFeUQf3dmFe7bRrDpI+dHM6hr8jOSEAVwCI6IM5VZpBiIe1tB7qvZuJzT33KA8mwdnaznJwfjL7xNSh5l20a3bFC61fv59gOanQM90QcPqbzMFnzpio4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395826; c=relaxed/simple;
	bh=0stzV5OZ1qCXqFfKyfdwfrw2tOHnNf58g64TcwTnMVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5bq5sJ46N47WeXVmdqZ1wEgV3TDW1dvermcSAo4lZ2UyYq+rP6RsHp+4/5MoCtBMxT4CF5ULUq850oYt4ouQgSva8DWvnnLcgm6VLGE9LbB2YiOU+v/u9LK5c6sMGScAJpqdlL2YGwXrDvolSogp2kyBwYkXAT4gB9/AGdSwQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rt2NP-00Ftw2-5b; Sat, 06 Apr 2024 17:30:20 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 06 Apr 2024 17:30:36 +0800
Date: Sat, 6 Apr 2024 17:30:36 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] man: document what happens when IFS= (and when it's not)
Message-ID: <ZhEWPOt67WBRkkf/@gondor.apana.org.au>
References: <rgn7yvfaitifvmsx7tsu3bicrcrqjbhkai7jdj6q5ja3ccrq3o@musfjdmv7egg>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rgn7yvfaitifvmsx7tsu3bicrcrqjbhkai7jdj6q5ja3ccrq3o@musfjdmv7egg>

On Sat, Apr 22, 2023 at 05:16:21PM +0200, наб wrote:
> A question I just got from a user was "how do I make while read -r l; do
> ...; done < f not strip the initial tabs?". Turns out, the manual is
> silent on this, and POSIX just about implies this behaviour.
> (Indeed, our read is almost verbatim POSIX, and both defer to Field
>  Splitting, but our Field Splitting isn't nearly as detailed,
>  and thank god.)
> Even POSIX spends just one line describing this pivotal behaviour
> (Issue 8 Draft 2.1 line 75044-75045:
> "2. If the value of IFS is null, field splitting shall have no effect,
>     except that if the input is empty the result shall be zero fields.),"
> and when I first encountered this it was also quite surprising to me.
> 
> Spell it out explicitly: IFS= means that input is preserved,
> and the default value means whitespace is stripped from the front.
> Drive it home with an example because it's esoteric (and I know from
>  that user that they first tried searching for read in the manual,
>  but it was not very helpful).
> 
> Reported-by: rozbrajaczpoziomow <rozbrajaczpoziomow@gmail.com>
> ---
>  src/dash.1 | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
