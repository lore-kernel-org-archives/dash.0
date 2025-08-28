Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FCA1C01
	for <dash@vger.kernel.org>; Thu, 28 Aug 2025 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756371239; cv=none; b=eeNukn0RWto1kqhzGdrbVFLBD860j1eaZSmXfZK1k/5AmMb3LkuQpRo7GjN+tYP9YUCHDUCiE1SrE/KixRhGiJfy7dBhnK06pv67E4DSN17Vby8bS46thHDkIfitDwrs+Vz9ilfVUhBxw+RxoUKfYMgzKZXEFtVcTjDVlHL+aNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756371239; c=relaxed/simple;
	bh=mM/2dcnIdMB1UnIKGMlKmOwpvVSOgzKNaizHx7Wstwk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RDHG34SGNivMp5YeJWfuq1lJeb78hzBFjK7Bj/girumtTCc6iVSpnuoE6uUwhihNwKoaO5RfkHz5jv3ZNsJLhfrr8LM4eBICpybk/+HelUz2p+b6xzUbBsjSR+RHC2ci9quw810wNsyyyHNQw2kJ/JeHGLtKZ3WYMlRkONCzwHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=JYIG8nMi; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="JYIG8nMi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zXFtGvZD3i5t6ofaVic1uvTVvdimkyKtkqfdm0DlJdk=; b=JYIG8nMidwfbeWBukVL/LG2m02
	y46rH/4JYAmKLeYrvokETo9wxV1zrYf0eQLhSN+y3Y4CODbD1W02qfyhRV6NIi9W1ur2lMLTFb3CH
	4XDM2wlmm5rk5RSk+IHedJMNSA7Jd/XUxmYgsjn7lMYx/nbu+wjL2sS+lowNn2vggQdLbYxAzIRA0
	z0PID+PuyYrbtpuyLGKWPb23M/tx3IpMmiI9GTLyv3qxNWA0+1ZNJBYHDdHKXcDHq9q4JyJNi7i5z
	uMrkO9mnzdqfwTCfKcoYW0b69gsPK0CZN2WRs5O51FrdO3g/DobEQfE5uRrjXNrxtiPCUUwMba48G
	4OHKgSqw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1urY8n-000S5I-1y;
	Thu, 28 Aug 2025 16:53:51 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 28 Aug 2025 16:53:49 +0800
Date: Thu, 28 Aug 2025 16:53:49 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Aleksander Ushakov <aushakov@astralinux.ru>
Cc: dash@vger.kernel.org
Subject: Re: [BUG] heap-buffer-overflow(read) padvance_magic() exec.c:232:8
Message-ID: <aLAZHdSmoYSTnF7Y@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8cc15e4-7efc-422e-8e5d-e42e8d74dca7@astralinux.ru>
X-Newsgroups: apana.lists.os.linux.dash

Aleksander Ushakov <aushakov@astralinux.ru> wrote:
> Hello Dash maintainers,
> 
> I encountered a bug in Dash in commit b4ef25d7 and would like to report
> it. The details are provided below.
> =================================================================
> ==19628==ERROR: AddressSanitizer: heap-buffer-overflow on address 
> 0x5020000001f6 at pc 0x653a8d802916 bp 0x7ffd57f3d590 sp 0x7ffd57f3cd50
> READ of size 2 at 0x5020000001f6 thread T0
>     #0 0x653a8d802915 in strcspn (/upstream/dash/src/dash+0x55915) 
> (BuildId: 82ec7cbb990c5349f280ce0bf016a1bca211dffd)
>     #1 0x653a8d8d01af in padvance_magic /upstream/dash/src/exec.c:232:8

This may be a false positive, or strcspn is buggy.  padvance_magic
actually passes vpath.text + 5 to strcspn, and as vpath.text[5] is
NUL, there is no reason for strcspn to read vpath.text + 6.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
