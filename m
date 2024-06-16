Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E19A48
	for <dash@vger.kernel.org>; Sun, 16 Jun 2024 05:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718514848; cv=none; b=Pymg6171nmqq8d8l26jW8qhMTUK3GrszgOTtIHpbcBKFjCPFq/Gz+f2lTZ2gpS2tJF85kvi1drCbbWinN5R0peiihY317qi2i4633loi0rp3xRp0SMrM+jY29jkxWTozabVSBG/7P+yYVf7i7XNOCzFqdQBGodpcOAlCHU/Pzu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718514848; c=relaxed/simple;
	bh=newdEBqwNCvMrMhj9VRnxtAa/GLAn911WWkKdqUOiqc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GDINKgNoA5sjzCRltxWzxRXAvcSxIlUbJw3nS59lILcedG9jX23f63qgykM4ocPLDV7iCrevwc2WBDD1jCL7pGB/15muhs1qNYdEpCYT8ikcFxGaxQRorYxSwkBP8Kg/GDDj6PIdK16yzCyXGsEq7Jtn0xulxiMwM1Gbti6v7QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sIi69-000a8C-1Z;
	Sun, 16 Jun 2024 13:06:38 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 16 Jun 2024 13:06:37 +0800
Date: Sun, 16 Jun 2024 13:06:37 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Ilya Kazakevich <ilya.kazakevich@jetbrains.com>
Cc: dash@vger.kernel.org
Subject: Re: Subprocess doesn't get stdin sometimes.
Message-ID: <Zm5y3du0C2MHdhSR@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMQsgbSZnEac=ETYnR6a_ysnAysaHThwY03pnoDxC=p5FqtAag@mail.gmail.com>
X-Newsgroups: apana.lists.os.linux.dash

Ilya Kazakevich <ilya.kazakevich@jetbrains.com> wrote:
> 
> I am not sure if it is a `dash` bug or my scenario isn't correct (it
> works with `bash`, however).

Yes this is a known bug in dash 0.5.12 and prior.  It was fixed
a while ago in the git tree by:

commit 5f094d08c5bcee876191404a4f3dd2d075571215
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Tue Jan 3 14:15:58 2023 +0800

    input: Read standard input byte-wise

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
