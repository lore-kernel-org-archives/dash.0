Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2488393DD5
	for <dash@vger.kernel.org>; Sun, 24 Aug 2025 02:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756003158; cv=none; b=rIT9r6BCmSm2/PcZ1FKqdQ2OCrySPl8aovo2JheymDklX5KvNYmMLX5lq9NXKRhqxf0nBrxp21ipe4IEAt7DIWQmc3LeBf1Z7vhVEJUmpnlMQfbapMAkfP37/43VXCfJ2IZtz/5PW9HrzlhjEez6ZHUECo6QUBN/0QycM0dZGa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756003158; c=relaxed/simple;
	bh=9Ycit4vBju++hBNJBlaWK3fjuz4EaOjOUgfMqYNNgWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJt0XIO1OU0OiDEsz6FdWQOVcMfiV9NqTOGaV/5ZZ/uj0Pkt7uJeOcge4jllr0altLb5mIQagEvy1GhwRz/3vCa156mo6lt5m0MQkFnzxI2UtCqn33YRviV2TKLf0YbP3pjDp8AS1cgdHHqIH6kk5fwXJXwpUBD7KHDHw3r/yso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=KSqcCsa/; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="KSqcCsa/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=4k9GL5y4aEefy61RXizBleGlFEoCYKN1CC5plOGAtpU=; b=KSqcCsa/NzgTh1L6miZJ3fGqys
	Y0iWJDgaB0if7gUGqubvuQ3d0WD9C6/Ug1IEQcm2FaiQ8qLF90vUTxIio8wajEgHsOO/DhowTrWl5
	SFKGA80ii/f/QMjBu18MxSx96uWeRsDo5+Vul6YbgWXI9YFyiEYxOvaHvgrzX+aO7KmWURHl8EXUP
	XW6pM1Ml7AaTwX/O3TyaaU9o3ZpK/M8iYHXcJhBrpX2z7H4ARjP8sGmm7ycOYsTuwGZUvGky+fKZj
	puaIWX+zTytRwxBmwMHGCgx7/CHU5lEmdWlB4zpXy7FERRnP1VvMcNZSir8JqHe/tx8mL6GXDc6Ri
	SfBWYXpw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uq0Nx-00Gjqe-1j;
	Sun, 24 Aug 2025 10:39:06 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 24 Aug 2025 10:39:05 +0800
Date: Sun, 24 Aug 2025 10:39:05 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Denys Vlasenko <dvlasenk@redhat.com>, dash@vger.kernel.org
Subject: Re: Looking at "int vforked" in signal handler is racy
Message-ID: <aKp7SVpkQUtwJ1Qf@gondor.apana.org.au>
References: <dadfa485-b5ee-30d7-7154-362cf2eb04cd@redhat.com>
 <031e429e-e20c-4856-91dd-aedef155aae5@gigawatt.nl>
 <559d8542-bda1-15a0-2e68-9b3ea04db2e7@redhat.com>
 <b6a063f8-9844-4f81-90a8-0f65e7c819bf@gigawatt.nl>
 <aJl4_WsQeHF6PI0N@gondor.apana.org.au>
 <c03cf64c-5e12-4317-861e-16a0bf413d95@gigawatt.nl>
 <44569fdb-3c8e-431f-9e26-25259bd268fe@gigawatt.nl>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44569fdb-3c8e-431f-9e26-25259bd268fe@gigawatt.nl>

On Fri, Aug 22, 2025 at 02:32:54AM +0100, Harald van Dijk wrote:
>
> From a112e6581540bf7d34bb2f47042e8927bcd95d0d Mon Sep 17 00:00:00 2001
> From: Harald van Dijk <harald@gigawatt.nl>
> Date: Fri, 22 Aug 2025 02:05:14 +0100
> Subject: [PATCH] jobs: avoid blocking signals on vfork().
> 
> As pointed out by Denys Vlasenko, we can avoid blocking signals on
> vfork() by making the signal handler of a vfork child immediately
> return. This saves a syscall.
> ---
>  src/jobs.c | 5 +----
>  src/trap.c | 2 +-
>  2 files changed, 2 insertions(+), 5 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
