Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE09A303A12
	for <dash@vger.kernel.org>; Sat, 14 Mar 2026 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773480380; cv=none; b=ZXh030tDmWXKk9cvDifd/HH6ypy5UE00huK/N3C/eRJTOYrXRAiacSDXYHdVVZcSTkjtMJW1s4j/EWWUxiQia0h7bac5RIQXoKqQrxZid1uDp2DHcj2hEKe482HUywtA0V2VlyCxjo3RXs0ACONRXrbyAYEHuQiuzSfRZPhID/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773480380; c=relaxed/simple;
	bh=+wbiEVGGnqxb3EcCZG7hi4DcOjCzOVfodiSoN3RJQh4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FNCmlIIIapfe0y6UthakAe164Foa7uPjWapbNv9UD0DhJltISUSaNzeZGv2wlgsuOO8PyKojI2fhr/QaokNF3FIF4Ir8GJK7pqdpGuNXHtYPTxk5T/o+o762rn8w6METRkr71LBcqRXnDmGtH1QJuEw2Gy8N8eet1geCoTeg0OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=EYGn619P; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="EYGn619P"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=i+CW4wZgK/bjLK0ljOle2HBBUGsmOppgELr12YHwlPM=; b=EYGn619PqTjBC5spB5OfSTJkEm
	p+eghfd/5tbFl+9cn2UZf9Fv8DXBReH47zmzW78uRXHqWyDgcxZROSaqoFhf7B46R85QL9frXxT6j
	H1WXMoU7uek0IGUvfpXU7seY+WAMrQgGkL/A2T9uWFxexaYy1G3LRRfZC/sd99AKB4XYgWIUcyOeW
	yOohggU1/wOqNiCekntSXM3vdoobFhL7zv/iix36r4GSiZFdZ/37jeWuXEPaB6BlZ7YlGLyzLV5Lq
	kCHa9urrS0pELG27/Nnrg2uLZgLikoUCzM0LXoCoaqO0dlAWxy4t0NmA0Q90iNCvufVNdCOXxOIO3
	Dvjm3THg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w1LGA-00EN9Y-1y;
	Sat, 14 Mar 2026 17:26:15 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 14 Mar 2026 18:26:14 +0900
Date: Sat, 14 Mar 2026 18:26:14 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Daniel Snider <daniel.snider@upsun.com>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] input: Fix heap buffer overflow in preadbuffer for
 non-SMALL builds
Message-ID: <abUptrjFvOwWM5yL@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB_UPCCnoM-7oU=u51jCDGarLPTM5TzYWVSfhqWHaQP0BFpotQ@mail.gmail.com>
X-Newsgroups: apana.lists.os.linux.dash

Daniel Snider <daniel.snider@upsun.com> wrote:
> From 0242b3e94da8de5043d5b2a8fba2f380347f6eaf Mon Sep 17 00:00:00 2001
> From: Daniel Snider <daniel.snider@platform.sh>
> Date: Fri, 20 Feb 2026 20:37:21 -0600
> Subject: [PATCH] input: Fix heap buffer overflow in preadbuffer for non-SMALL
> builds
> 
> Commit a065467 ("input: Move newline loop into preadbuffer") removed a
> guard that prevented looping back to preadfd when no more characters
> remain in the buffer.  In non-SMALL builds (with libedit), this causes
> preadbuffer to call preadfd again without resynchronising the buffer
> pointer, overwriting heap memory past the allocated IBUFSIZ input buffer.
> 
> Any single-line shell input longer than IBUFSIZ (~8 KB) triggers a heap
> buffer overflow that corrupts glibc malloc metadata, resulting in
> SIGABRT or SIGSEGV.
> 
> Reproducer (requires --with-libedit build):
> 
>  { printf 'export X='; head -c 16000 /dev/zero | tr '\0' A; echo; } > /tmp/t.sh
>  dash -c '. /tmp/t.sh'
> 
> Restore the guard so that "goto again" only fires when no characters
> have been consumed from the current buffer (q == parsefile->nextc),
> matching the pre-a065467 behaviour.
> 
> Signed-off-by: Daniel Snider <daniel.snider@platform.sh>
> ---
> src/input.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Thanks.  This will be fixed with

https://patchwork.kernel.org/project/dash/patch/CAO_NRt5mv7E-qkSA2hE+4HsQMzpczrF9ZAWL-jKbW0Li1F3U0A@mail.gmail.com/
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
