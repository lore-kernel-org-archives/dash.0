Received: from mail02.stack.nl (scw01.stack.nl [51.15.111.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5A610A2C
	for <dash@vger.kernel.org>; Fri, 19 Apr 2024 21:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.15.111.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713562474; cv=none; b=r6Mx/yHYnrue/9tMwXxAoYK/b3YBp3htVd6te6Kr1sNOEHnLBmxYKNcUhH7VIb0YaxxGUzxgsGijoNbP3+xjM8TJ2oh3P4nhSs5do8PMeWIunhTFrByocckqKN9Zz10NEShCDbV4LV5xdHNMYWF0/q1gGwbW6GQXFBMXthzx56c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713562474; c=relaxed/simple;
	bh=3FcVCTrlarHj42JEraaLD4xOAZ/dZfOPtxudFS82cvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuJXKc5yx8sGxnNXoLNqRfJwR3u1JML4lZVrYvXoRUtGafDmu+uP+KGC+DpRScQ8wpf+JYMPVlGtJJCcqiy1qQMdyS47EYkkntHMBX0sy4+b1qlPA9Ge2Qi1oTEnR2srwkWcdfpR/KnTqfOIakIut12vm4vl/W50Mhx5DibjHCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stack.nl; spf=pass smtp.mailfrom=stack.nl; arc=none smtp.client-ip=51.15.111.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stack.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stack.nl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail02.stack.nl (Postfix) with ESMTP id DE6AE1E014B;
	Fri, 19 Apr 2024 21:24:48 +0000 (UTC)
Received: from mail02.stack.nl ([127.0.0.1])
	by localhost (mail02.stack.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S8DJnTa-Ec4M; Fri, 19 Apr 2024 21:24:46 +0000 (UTC)
Received: from blade.stack.nl (blade.stack.nl [192.168.121.130])
	by mail02.stack.nl (Postfix) with ESMTP id DC3CB1E002E;
	Fri, 19 Apr 2024 21:24:46 +0000 (UTC)
Received: by blade.stack.nl (Postfix, from userid 1677)
	id BD667237C4D; Fri, 19 Apr 2024 23:24:46 +0200 (CEST)
Date: Fri, 19 Apr 2024 23:24:46 +0200
From: Jilles Tjoelker <jilles@stack.nl>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] redir: Use memfd_create instead of pipe
Message-ID: <20240419212446.GA24704@stack.nl>
References: <ZhuLCZfwRfflgv0v@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhuLCZfwRfflgv0v@gondor.apana.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Sun, Apr 14, 2024 at 03:51:37PM +0800, Herbert Xu wrote:
> Use memfd_create(2) instead of pipe(2).  With pipe(2), a fork
> is required if the amount of data to be written exceeds the pipe
> size.  This is not the case with memfd_create.

Since a memfd does not behave identically to a pipe, this should be
tested carefully. A memfd does not behave identically to a regular file
either. It may affect programs started from the shell that read
here-documents.

Using pipe or memfd conditionally based on the length of the
here-document and whether memfd_create(2) fails transiently might cause
even more obscure issues.

I suggest using either a pipe for all here-documents or a memfd for all
here-documents. The shell should fall back from memfd_create(2) to
pipe(2) only if memfd_create(2) is not supported or fails for a
persistent reason like [ENOSYS] or [EPERM]; in this case, the shell
should remember the failure and immediately use pipe(2) for subsequent
here-documents.

The dup/close dance with the memfd will look silly in syscall traces,
although it is functionally fine.

-- 
Jilles Tjoelker
