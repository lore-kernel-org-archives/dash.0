Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6724730F7E2
	for <dash@vger.kernel.org>; Tue, 23 Sep 2025 06:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758608971; cv=none; b=tkry2zhCR5oOs3ieNk9z6q2odnhFSbnCOSQVRBwxl5+EQ2etvKcpqMBxRMfLWtyUK506n4iS5kWoMo8XIPPEVcQMHi5oT/ylkOul8Fj4vwSSMKHfhKGN4ZEnmvZa32qKVqFauPDj5oQmRV6nw2ECOWycbZ4NW78jvxJ9/R0QSF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758608971; c=relaxed/simple;
	bh=4ZLMHuiRRylxFoSQb5UyeOYM2bR/Od/ZLXJpKc7BwW8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ndFNL4aKKwIv9sft50eQIWDyROq18ESyq1GZjojbY0uCrZrXztxeIf/PNMgjUopeKKeARPbVEfCXY4FciPcT9eX2GjIDCKKJE1c9ls/nuuf6D/uNIFSeMj0YQmXL9XYYVJvII+/QXo4xFwlCbm+MlGcGlmekrCkvHA/KHZOaGxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=WQiDr7Z6; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="WQiDr7Z6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:cc:
	to:subject:message-id:date:from:references:reply-to;
	bh=0x9bjQx9sKl1vk+T2ym5iIssRKtkILhepGzNLSzgeFc=; b=WQiDr7Z6BC+HMToNpM4OA5KwQA
	m2UyQwUmWbpRiWXZaNe5fykfY1bC2IF7d2mbNeD1GML39jyh6y9m+QGqUwKxjMfgspmBUC9o8U2Xt
	QnXuzrZS+BpcYVXTVvTNuV+BzFY3IItJt2V5PiV9Gnbs+xaiME7ViVaVtImhckEsXoJBdiS47JhaH
	stdZcYkz3SdIVKkStU/hS3EpkFTEzUvhmacKYEC8xJ+dJ87OOOhgiEN784L7bWny4ys9+pkMV9pck
	mRTXyB2NhOhSAfMjjSRR0dOW9jTxo9VUXAgJZlBcvPA7IuvGHbysXw3YRb2zzP+DQjsDzWxMtcSER
	10wnG7Rg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1v0wWi-007bB7-0P;
	Tue, 23 Sep 2025 14:29:25 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 23 Sep 2025 14:29:24 +0800
Date: Tue, 23 Sep 2025 14:29:24 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Reilly Brogan <reilly@reillybrogan.com>
Cc: dash@vger.kernel.org
Subject: Re: bug: 0.5.13 regression in parsing
Message-ID: <aNI-RCggOzN-tyHy@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <105f1d0e-f7c4-431b-b95d-efad442aaa34@reillybrogan.com>
X-Newsgroups: apana.lists.os.linux.dash

Reilly Brogan <reilly@reillybrogan.com> wrote:
>
> (I've uploaded the full libtool script at 
> https://gist.githubusercontent.com/ReillyBrogan/9a4e6a02e5871fdbeb793a549131e197/raw/5a00be91f0cf38df7706eabc4c0eadcac74e84dd/gistfile1.txt)

There's something wrong with this script because it fails with
every shell, including bash:

$ bash -n gistfile1.txt
gistfile1.txt: line 369: syntax error near unexpected token `}'
gistfile1.txt: line 369: `            echo "local: *; };" >> $output_objdir/$libname.ver~'

Did it get corrupted somehow?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
