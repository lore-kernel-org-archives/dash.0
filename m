Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E134A00
	for <dash@vger.kernel.org>; Wed, 24 Jul 2024 03:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721791555; cv=none; b=o0lAg27LiRAV8izd6ox1/sfwSc15ySbCBfZcBet4IivjutJ4yl+lcBSYQvkR9wbhh5hruvlDNLzrJOip038ple5N4AINEmZ2kO2lcqeyVcndnJMFD/uimXH6UlpMmUVVdMhKXYWdv1MM/j0a5YCgzpDJvaNDBQKpBbSg0UZEyD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721791555; c=relaxed/simple;
	bh=VakpzZYVyH/8jQ5g+4Z6dbh3oYGa/ASMj/vMaWhG1dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VU+Ew1HRKRgHfJYY4cSFEuAAV5ubZZ5utHyBBnlVLKU7o+Tv+Ymaa/CvAHE18VYtYEG/yOs6I3Tbc++ZFETipdE64CNlvnmn6IXMXMNkpeNMvujyP9eYy5lQ8EC+dF8lJV1GtedpNSKxVOPG9ZN1LRYy/BedK6aSqKfEahOCSaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sWSWK-000YwT-3D;
	Wed, 24 Jul 2024 11:25:49 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 24 Jul 2024 11:18:31 +0800
Date: Wed, 24 Jul 2024 11:18:31 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: herbertx/dash <reply+AAIFISIPEFYQHXOP4NHZGW6EVN6VJEVBNHHJBCZC6I@reply.github.com>
Cc: herbertx/dash <dash@noreply.github.com>,
	Subscribed <subscribed@noreply.github.com>, dash@vger.kernel.org
Subject: Re: [herbertx/dash] regression in reading variables from pipe for
 external processes (Issue #8)
Message-ID: <ZqByh0vXM6Kkvx2K@gondor.apana.org.au>
References: <herbertx/dash/issues/8@github.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <herbertx/dash/issues/8@github.com>

On Tue, Jul 23, 2024 at 12:04:38PM +0000, arĉi wrote:
> this script
> ```shell
> printf '1\n2\n' | while read i; do
> 	/bin/echo "$i"
> done
> ```
> outputs
> ```
> 1
> ```
> while this script
> ```shell
> printf '1\n2\n' | while read i; do
> 	echo "$i"
> done
> ```
> outputs
> ```
> 1
> 2
> ```
> (as expected)
> both scripts emit second output on release.
> git-bisect revealed this was introduced in 44b15ea09a9ee5872cf477e4ffc6b42ef37d1e46

Thanks for the report.

This means that fallback code-path when tee(2) isn't available
isn't working.  Perhaps the seek testing isn't working as expected.

Unfortunately I couldn't reproduce this on Linux.  Please tell us
what OS you're using and provide a strace of the failing execution.

There was another similar report about this:

https://lore.kernel.org/dash/ZoiiE00rt95pkYYj@gondor.apana.org.au/T/#t

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
