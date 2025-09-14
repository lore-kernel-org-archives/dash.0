Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048531B6D08
	for <dash@vger.kernel.org>; Sun, 14 Sep 2025 00:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757811095; cv=none; b=RnrriI4BjGMkZPU0E0ogBwF9fr5Mne1mBCx/ACUXXmOV0jz80DE6KdichV43B2NKO2lqdiHJTy+xagL7ONe8vjj31l1ln9RMkAwZ3weAIixQrtbKIMbBuaCrq5e8aWmlDT0hyVdNViMCTvROc1/4uPR+XT7TN8b4836E1Lrh9IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757811095; c=relaxed/simple;
	bh=7mCmYW34yQujDMAqN3DzsviiG55c9jgdaP+1cHyKIrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNWnToVyeJ5z37kB0varmXGqZedyDlss2bOXVS8y3Q0JaVYOSJeejo+GCLHu9nYtzzhAsR60sT1/Z3vypeG++vg/YlCZJtdPlMmmIDgeTwYa7etz4bCZsE601ETKGAQIotlqBEwNbfSLNODDFkB4IdLcP7y/ORsmO570lrMqduE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=W3Sy8H8V; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="W3Sy8H8V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fk37n/ZDi6jwRGSUenGCpB23x2iuYqqxHZa2GV/C01Y=; b=W3Sy8H8V9O/MU9WRoA01VuVQia
	7gEKpX9XsxIiB27xqdfQcOQRgeH857aXpYqJIOw5Id12yHmKqsKWMua322moh/5QWZDzPYOitz93Q
	mkw5bD8CpmJJFF974hAHFQ7gESQSujXKlHSqOcS42K6+nBk7r2Gd64s+g6M+itPIZ9ybys6QrF+7H
	9+wU+kMuUSWpIHroLOMQ7gfEN2oSn2WHyBCM+DtRyZf3zKCAPEKLUlRmt561toGoslg5NSdclv+BW
	DXG0+sH7Zp2/eeXV2X2QwSZgyupz60cRyxbZ1rBKkhcFOSISIu0pDbtu9bOZYPX/Psxo3376QVR0/
	yHebCKqw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uxaiJ-005EtO-2c;
	Sun, 14 Sep 2025 08:51:29 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 14 Sep 2025 08:51:28 +0800
Date: Sun, 14 Sep 2025 08:51:28 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Nathan Mills <the.true.nathan.mills@gmail.com>
Cc: DASH Mailing List <dash@vger.kernel.org>
Subject: Re: I found multiple crash bugs in Dash v0.5.12-115-gb4ef25d
Message-ID: <aMYRkII_1nI--lPF@gondor.apana.org.au>
References: <CALjJ9ccRuGV9fmydBvwzOua_om7QVoro-nSA-pv+9-nX1KLfGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALjJ9ccRuGV9fmydBvwzOua_om7QVoro-nSA-pv+9-nX1KLfGA@mail.gmail.com>

On Fri, Aug 29, 2025 at 07:40:16PM -0700, Nathan Mills wrote:
>
> *Crash v0.5.12-gb4ef25d_try2#5: stack-overflow. cmdloop calls
> evaltree, which calls evalcommand, which calls evalfun, which calls
> evaltree, etc. Dash crashes when reaching 22,448 stack frames deep on
> my machine.
> 
> **Crash v0.5.12-gb4ef25d_try2#5: stack-overflow **
> 
> Base64'd
> SDsJSCgpAEg7CUgAgH9KSCQj6jw+JF8kEGdISDsJSDxIb3JlLH8AgP+A/yM/Cg==
> 
> Minimized (assume the file "empty" does not exist):
> ```
> touch empty
> src/dash -c 'H()H;H<empty'
> ```

This is to be expected.  You're doing infinite recursion, of course
it will eventually fail when the stack is exhausted.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
