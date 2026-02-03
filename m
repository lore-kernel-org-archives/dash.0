Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF39086348
	for <dash@vger.kernel.org>; Tue,  3 Feb 2026 02:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770086273; cv=none; b=PZmW8qoWZJxYwm6ZMhwkz4jRy8pPzkpqb0wwElWC1YFzcVh8dUKHCkbkTWkNRJVezbvBpyhwgwNS9Xbq92YmSQnKV5V5qj6uHD1pohPFJfYANDAtiDRHzzKCzcMdwpvrrv75jZcOoc/bGjsbyrUnrL+M7SDl1MpMorDk2zEhNRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770086273; c=relaxed/simple;
	bh=+lX+fQx/naeaa7Q9IYVnUD7INI1B+5skSs41Ik7BOqE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OudNLV6Mv7LKOq4kpUQXI9El7KZS3YjCEcHuGXr2nNwa6uIs7mjoG6MOLWkX6iM44mjI9rgmLLpK6q0hIeVDJctGrd34m1BCfVwORnvoTLmdTWeQ0hv8vqu3kkrY9P0VeFgBvLJ8rOxdCCuuSjnpu7f6mllBcSWd0Jez/kEKAtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=D6MTHZhQ; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="D6MTHZhQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=caQiI4pACnpQfbOyuSl+ZH443ll6d5JOMXaipSqVIaE=; b=D6MTHZhQ1cHKfJwBwQHlJwmwSv
	30594mWdGE4exnNCch2NzqSreTQPvUSSBzk753MlC9REcz4ft8nViq8QfALt+L0/smdbpuFPkZEZ/
	kR8Y1I5yjkC5kixCEzzSSpw7+v0QOUFtaHMkmiY7Qrt9dtB77er3THPFhmXUuKf2vO15zDK2WjbVJ
	YT+mb/bAOIyXf6BJ15CERTM2JC5jClNHMyMJ4wDMaUESfmxQXvAcqbTya6Mc81zN2nVlNE8VVY0US
	AzCYrXpBBTaQNoQoIciQAx+7ErsSWFaxDhatdpd9T/Q4ItNh0Q3Ar+zzd/uvEZahl8JjWYML/Ku07
	P+8Z3jQQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vn6IN-0043O2-2s;
	Tue, 03 Feb 2026 10:37:40 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 03 Feb 2026 10:37:39 +0800
Date: Tue, 3 Feb 2026 10:37:39 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Hadrien LACOUR <h.lacour@sim-and-cure.com>
Cc: dash@vger.kernel.org
Subject: Re: dash 0.5.13.1: heredoc parsing failure
Message-ID: <aYFfc-uXWlN8Pbor@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmiXcjdFDh_jMak8S0mq5SjWO4m5K67ZKMu5HPdhPby-uUTgw@mail.gmail.com>
X-Newsgroups: apana.lists.os.linux.dash

Hadrien LACOUR <h.lacour@sim-and-cure.com> wrote:
> [-- text/plain, encoding quoted-printable, charset: UTF-8, 32 lines --]
> 
> Since strace doesn't work on MacOS, I used
> https://github.com/Mic92/strace-macos to get the attached log. No
> `tee` calls, but I see two `read`, the first one returning 549 (which
> is the size of the test script) and the second 0.

Awesome! I can reproduce this now.  So it's not tee(2) fallback
that's the problem, rather the fallback for memfd_create(2).

Also it only happens when the here-document is larger than PIPE_SIZE,
which is when a fork is required.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
