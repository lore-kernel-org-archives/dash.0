Received: from mail02.stack.nl (scw01.stack.nl [51.15.111.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D39284E1C
	for <dash@vger.kernel.org>; Tue,  4 Jun 2024 21:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.15.111.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717536889; cv=none; b=GPujB76/zHXRLpRebSKnhgHBAzDXQhm5tp2Zu7ja8gQGeYrwCS65SEFlvCHIIM2gMovMxkaKP0WDhSyBC+on1TGd5gfe/d7XW6vPQAlCxKnnbc3pkc4hTo8+EU2EfvJjQn+fjvUWhOTjsy3WkxP4ZrVwZAHQPOpwi/ni7fVAbw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717536889; c=relaxed/simple;
	bh=jO2yGlyOrBjj4ih3EFM/XONy6PAF+6Nt2nBkujMrfEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovQWxWjvQzfxklZhAv2h5wsxWWfO1Ncdmq5QO+YKnelJ5OjyS5F6zTCEXGu3S+JUd7whhiRURYlIb4Fqg3yF0Wd0Wku6ujoojkoj9vy3oAFqCNZx5epYwG2mhUGSaZ7l9UMcIGyoxTeZTxMYrMWZucFMfIzzMkHslUUdu7cxSEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stack.nl; spf=pass smtp.mailfrom=stack.nl; arc=none smtp.client-ip=51.15.111.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stack.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stack.nl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail02.stack.nl (Postfix) with ESMTP id 3E4F41E0156;
	Tue,  4 Jun 2024 21:28:37 +0000 (UTC)
Received: from mail02.stack.nl ([127.0.0.1])
	by localhost (mail02.stack.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uO9pq6ypRqru; Tue,  4 Jun 2024 21:28:35 +0000 (UTC)
Received: from blade.stack.nl (blade.stack.nl [192.168.121.130])
	by mail02.stack.nl (Postfix) with ESMTP id 367251E0154;
	Tue,  4 Jun 2024 21:28:35 +0000 (UTC)
Received: by blade.stack.nl (Postfix, from userid 1677)
	id 17FEA237C4D; Tue,  4 Jun 2024 23:28:35 +0200 (CEST)
Date: Tue, 4 Jun 2024 23:28:35 +0200
From: Jilles Tjoelker <jilles@stack.nl>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: DASH Mailing List <dash@vger.kernel.org>
Subject: Re: [PATCH] expand: Check d_type in expmeta before recursing
Message-ID: <20240604212835.GA6709@stack.nl>
References: <ZlvMLrrmMR92Bbvq@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlvMLrrmMR92Bbvq@gondor.apana.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Sun, Jun 02, 2024 at 09:34:38AM +0800, Herbert Xu wrote:
> If the directory pointer is not a directory or symlink, do not
> recurse into expmeta.

> +		if (c && dp->d_type != DT_DIR && dp->d_type != DT_LNK)
> +			goto check_int;

Good idea, but DT_UNKNOWN might also be a directory or a symlink to one.

-- 
Jilles Tjoelker
