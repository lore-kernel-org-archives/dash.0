Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194D328682
	for <dash@vger.kernel.org>; Wed, 28 Jan 2026 04:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769574651; cv=none; b=T2UyEUwkjEqq5bOhdzOIbaObYfQ7HmobVVgupEapsd8AJd1DTBuDxqefgkefjTQchTx/IO5jQsYbG4HwfgbLKH3r+L06dNzjzs0WGcsD00ugzARe4MtGgTfDaeO5mpkgHWn4avn+3vVwxpLB3SqnmnFq+KnBl64bR1IOaywdCGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769574651; c=relaxed/simple;
	bh=iEdUG52w3xWbb8pdgHoGGufmrkFXBpgHCRurBPCGEFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aBAF/Ps2YfwFbcZetvzawuilqTiHW+PK92bH39601flUy5Xffhe1VALYe/um+LOxB+P8r6obtz8ikmO0pzumpZKtjvl81ikbRainZQbgCo/C0t3QEE3OwbT7ehyJFJth+7/GJhy7qoDmFYwMFsLs1mPVy6idGn4LkAZsSqA7qM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=DQ6AqYWP; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="DQ6AqYWP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=R73jVDFmWx9Xe+dQuXSu22OpnKGPJlbLNXt4K5pYsaw=; b=DQ6AqYWPnU83CsKTHYibJ2v8qz
	yf/+UeS3Ug4d8dQI7e6cdETInzgVgsjx7g6Ar6cGoY7GWgYULWBOCR3v6HTKzyi7Y/ffuYjKCC6E+
	OakbOb+wzpcEOLzzCELjqfwRrLI1bHRdfYiWAMD4YYXSUmlaubCb2e1RHO1zBLMyEYcjc9yM2WPj0
	02G6k2a7p8n5yVavRa7VNy4E4fiwIpo9nW5Cj2WEktJh8mt972+ol69nz4jT352vClNPPP66tPm6R
	uqs5V779qGb6UUSWnqiFMv6UPhvV9rOkutVgPvC1dcN3K5dSUJn9H+SzeZUI/OhmfLo7D9odzZsjO
	ej1TVFMA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vkxCW-002eZk-2s;
	Wed, 28 Jan 2026 12:30:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 28 Jan 2026 12:30:44 +0800
Date: Wed, 28 Jan 2026 12:30:44 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jyri-Matti =?iso-8859-1?Q?L=E4hteenm=E4ki?= <jyri-matti@lahteenmaki.net>
Cc: dash@vger.kernel.org
Subject: Re: Behavior change in Dash pipes/read?
Message-ID: <aXmQ9OK72gWxvZn-@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANhYXO9FwbqvSJba8B6p+dzL4AoeA5O85kRxXdzWRe19hMwVtQ@mail.gmail.com>
X-Newsgroups: apana.lists.os.linux.dash

Jyri-Matti Lähteenmäki <jyri-matti@lahteenmaki.net> wrote:
> Hi,
> 
> after upgrading from Dash 0.5.12 to 0.5.13.1 some of my scripts
> stopped working. Here's a test case:
> 
> $ /nix/store/wy9ass74g4yc1x354ydbdlxkfkxxjv2x-dash-0.5.13.1/bin/dash
> -c 'echo hello | { read -r x; echo "$x"; }'
> $ /nix/store/4kjsgkcxqfadycyspzfrf9gg5n5bpc27-dash-0.5.12/bin/dash -c
> 'echo hello | { read -r x; echo "$x"; }' hello
> 
> (with 0.5.12 "hello" is printed, but with 0.5.13.1 it's not)
> 
> Can someone confirm?

Again this sounds like a bug in the tee(2) fallback path.

I just tested the fallback path on Linux and it seems to work.

So I'll need your help in identifying the root cause.  Please
run dash under strace and send me the result.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
