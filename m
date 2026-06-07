Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A11A1A08AF
	for <dash@vger.kernel.org>; Sun,  7 Jun 2026 05:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780809928; cv=none; b=lWyayWDkEOdLis+1j6P61cgPSWTYpP5VNqasvG/DVo16eROmSfKQ09sXRzrSw82iy3+aEnyDepqx2ABVIQP43Hcury7AgxIO5TcXcCn8FXKf4TsL/NB5HUV40so7mpdawy9ACQxwSquSZrgiBljn+MpKBlCfxOLwLglR/Bm0oDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780809928; c=relaxed/simple;
	bh=uZHNqulLNGT+rUGoPg8V6pjmLNxF1+qGl8EMfeyETco=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KM/uVRratSQxv8K4lU78pV1ZwzV0iQb3AAx4+T0HQqazQ8/1byX0tkionQQEiHcymjCoX9uJlg5V4Gn1+vDowG8Pa+BTMKPUpLrhyBG8rTWBXOQsBD08Cbuz+tqXr1mBqYKgxK8yFfi++26ID14bxvWELGW4sqll2Km+ATo1/5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=hsLXgb12; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="hsLXgb12"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=h3rBD1SHzskcVUaa0MG7uKnOfT9GWZfE3uSgafCtmcU=; b=hsLXgb12QnWgHVO/wdJxQ0a7Bk
	pL0B8B50khuxpVYb3B5L9kFGg/MZq2JPq5kdRfLXbZ4JUVvX7R4ndX+e97aSrvWiv9I6ot2T3zRY3
	iO5CX0lPfpuY+BYKHrJiUn6T/rHhvWOP1i5HL7D9G/e2jHVSSTdypAuTBUy40SNfYyWXq+mgDz8pY
	jNPFFQhUAZw67j8GakSUFQ3SpaTI6kCxz1JMWKoiRnw2OtO9J3od+9WGOyhedH562RG/wyDFNYyTn
	x6juTD89ry/h17jXIqxz04HyKViCqq8bAecaOob2MLp8WYNO2ngy77QGjhjjyxrrDk6ij0aLwxZrt
	dVaGQCWg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wW60Y-003CJl-02;
	Sun, 07 Jun 2026 13:25:15 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 07 Jun 2026 13:25:14 +0800
Date: Sun, 7 Jun 2026 13:25:14 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: =?iso-8859-1?Q?S=E9bastien?= Peterson-Boudreau <seb@stien.dev>
Cc: dash@vger.kernel.org, seb@stien.dev
Subject: Re: [PATCH] Use literal > and < characters
Message-ID: <aiUAuoeHSXuqPH05@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260601044038.11541-2-seb@stien.dev>
X-Newsgroups: apana.lists.os.linux.dash

Sébastien Peterson-Boudreau <seb@stien.dev> wrote:
> \*[...] is groff(1) specific syntax, whereas \*(XX is the standard
> troff(1) syntax.  Furthermore, groff_mdoc(1) lists the literal
> characters `>' and `<' as preferred over the Gt and Lt strings,
> which are only defined for compatibility with legacy documents.
> NetBSD also uses the literal characters for their sh(1) manual
> page (changed in commit 30b9dfc8813e15031a13fc2fc85094b81c71e2b7).
> ---
>> Everything looks good except that your emails has no Subject and
>> so it's been discarded by patchwork:
> Oops! Seems like I handled my gpg key fine, but goobered mail client config.
> Crossing my fingers this time...
> src/dash.1 | 58 +++++++++++++++++++++++++++---------------------------
> 1 file changed, 29 insertions(+), 29 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
