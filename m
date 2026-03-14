Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80789248F47
	for <dash@vger.kernel.org>; Sat, 14 Mar 2026 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773480903; cv=none; b=gxEg/2dKs7fBsovZvYAS/P7SkGsy92W7avT58JgjHthkEoXfuOUXPfYwmaBEytMd4NzgpVPyO5ixBFWTdCGKmSdveVBOkR1zjhxN1vvwIu42uXtPdG5jZ1EbycQ7PYCsBIRuXxElBjUv/qA0MnNTvyduoVKmBeq83lJO1ygAvBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773480903; c=relaxed/simple;
	bh=4xC57d/EJ/TBZ+9meCyqSoaMcMGZp1jEhDA+EWFaDFc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SRLgodFtKeOruT/Nbgp+JR0vZS/JJ49jIrzf6Fr7CVzufvRDLYFhsHVZ0xuK/TgUmnA8adCjBJqSVbQdCeq9Mi8390QG0XWPeRicK1lemogFX/jqqR7n3XGw4MLi27bTZYQmT+JodYXDmqUH9sLfU6XYNBn+FDzqBcEhJq7PMVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=F+fLP55A; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="F+fLP55A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=GHOTXku2AYg1sYoit/uU7ciG22MeVICknQkT8N98osw=; b=F+fLP55ADfUhEimQIZ5oU9z1kN
	fltfwYxFcH4vmB6WaXKAhv1CoSzrOqq/lIwChnqc/9YJXpZxxNjPnlDNeWabVVozekMubwmuenHS9
	n70KSxokhz4MJEyzFJqy7aH5I491wuj1sV2vBuHQKofgMvtxVkpxVaOTpyV3Qegpso/lmODbQufGt
	HTwJORPspTR/aeZolgQ02lUol3COSfhaUDOGXAPmr5HRt8M9Bre2jNF6d8C5BqJziTydWn0jkIB8o
	ApG33aQkwh73iZxqOf6j31tKGjVjoeOFn34QIPQIPfUeLNMWDp2/pUAnwt4pCTtoectmWRBwQL1rr
	ess7Bupg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w1LOb-00ENEv-2f;
	Sat, 14 Mar 2026 17:34:58 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 14 Mar 2026 18:34:57 +0900
Date: Sat, 14 Mar 2026 18:34:57 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: classabbyamp <dev@placeviolette.net>
Cc: dash@vger.kernel.org
Subject: Re: regression in parameter expansion with backslash escaped strings
Message-ID: <abUrwVbgnvXBymLE@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11d5b164-f43e-4f8d-a3cc-895199bfe01c@placeviolette.net>
X-Newsgroups: apana.lists.os.linux.dash

classabbyamp <dev@placeviolette.net> wrote:
> 
> dracut-ng reports an issue with dash 0.5.13.1, where parameter expansion 
> of strings containing backslash-escaped sequences interprets the 
> sequences. This behaviour was bisected to
> 776424a8f9158bfe9f53aa55f931af9f73437caf parser: Add dollar single quote
> 
> A simple reproducing case is:
> 
> #!/bin/sh
> 
> str_replace() {
>     local in="$1"
>     local s="$2"
>     local r="$3"
>     local out=''
> 
>     while [ "${in##*"$s"*}" != "$in" ]; do
>         chop="${in%%"$s"*}"
>         out="${out}${chop}$r"
>         in="${in#*"$s"}"
>     done
>     printf -- '%s' "${out}${in}"
> }
> 
> str_replace "/dev/disk/by-label/dracut" '/' '\x2f'
> echo
> _name=$(str_replace "/dev/disk/by-label/dracut" '/' '\x2f')
> echo "_name=$_name"
> 
> In bash and dash 0.5.12, this produces:
> 
> \x2fdev\x2fdisk\x2fby-label\x2fdracut
> _name=\x2fdev\x2fdisk\x2fby-label\x2fdracut
> 
> In dash 0.5.13.1, this produces:
> 
> \x2fdev\x2fdisk\x2fby-label\x2fdracut
> _name=/dev/disk/by-label/dracut
> 
> Github issue: https://github.com/dracut-ng/dracut-ng/issues/2280

Yes this was an intentional change.  Note that echo in dash has
always interpreted escape sequences, as required by POSIX.

It's just that the supported escape sequences have been expanded
with the dollar single quote feature addition.

Note that mksh behaves in the same way as dash.

If you want to print a string verbatim, you should use printf
instead of echo:

	printf '%s\n' "$str"

instead of

	echo "$str"

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
