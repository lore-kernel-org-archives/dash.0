Received: from mail02.stack.nl (scw01.stack.nl [51.15.111.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CBA168C4
	for <dash@vger.kernel.org>; Fri, 19 Apr 2024 21:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.15.111.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713563073; cv=none; b=IKPzdAYzlKbhwEENIZlYj76Gfx6LMlIXIjrfFx/DjEQrMzaJtlW/SGePS+Od9PPb2/XfP0H+viBwQSjB9V/OWONHb2LwQP6WVCW5VEnYN3AAmK5VQgu8/qETCQU521GRfLs10zcl0xozcpaF8Z8GakKqfSYI23NFqhZEbuakQUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713563073; c=relaxed/simple;
	bh=5pHDQc7R0BWIOv+m2k4J2r/CZNDvfAwxezWrkyCtCTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCc4NzqiONQ9gHJ28pqXifhwVD5HfkUoFwSWvGa0K0GnLHbhlX5ea//EATyEViSaLYF9PGm38E3Smbi40MviA9hezSW48tuyZyBLOkCnrd1VXEpM8FbiEg04y8oOsoYdA+GI7WAX/ycLw+s+4IfdsPMqjIiHT7KYf5ozz+l0OtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stack.nl; spf=pass smtp.mailfrom=stack.nl; arc=none smtp.client-ip=51.15.111.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stack.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stack.nl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail02.stack.nl (Postfix) with ESMTP id 8C3821E014B;
	Fri, 19 Apr 2024 21:44:27 +0000 (UTC)
Received: from mail02.stack.nl ([127.0.0.1])
	by localhost (mail02.stack.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TovHUZKiYcGq; Fri, 19 Apr 2024 21:44:25 +0000 (UTC)
Received: from blade.stack.nl (blade.stack.nl [192.168.121.130])
	by mail02.stack.nl (Postfix) with ESMTP id 5911D1E002E;
	Fri, 19 Apr 2024 21:44:25 +0000 (UTC)
Received: by blade.stack.nl (Postfix, from userid 1677)
	id 3DFDF237C4D; Fri, 19 Apr 2024 23:44:25 +0200 (CEST)
Date: Fri, 19 Apr 2024 23:44:25 +0200
From: Jilles Tjoelker <jilles@stack.nl>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org
Subject: Re: [v2 PATCH] trap: Preserve parent traps for trap-only command
 substitution
Message-ID: <20240419214425.GB24704@stack.nl>
References: <ZhuLNH4dCxqs0Ge1@gondor.apana.org.au>
 <Zhz+wALFljSAqnDU@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zhz+wALFljSAqnDU@gondor.apana.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Mon, Apr 15, 2024 at 06:17:36PM +0800, Herbert Xu wrote:
> v2 restricts the preservation to command substitution only and
> only if the command's first word is "trap".

> ---8<---
> Traps are reset when a subshell is started.  When a subshell is
> started for command substitution with a simple command whose first
> word is "trap", preserve the parent trap text so that they can be
> printed.

It looks like this will execute the EXIT trap in a subshell $(trap).

On the other hand, things like $(trap "echo subshell exit >&2" EXIT) and
$(trap "echo other trap >&2" USR1) seem to be handled correctly.

I think the intent of https://austingroupbugs.net/view.php?id=53 is that
things like $('trap') and $(\trap) should also work (although an
expansion that expands to trap need not work).

-- 
Jilles Tjoelker
