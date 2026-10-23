Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.181.231.80
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792735308;
	b=DTh5xHh5IvVLwut9XVxf+qHb8UNOYYlD6ai+U6t+dIUDAbqDKnStIbM9SLSpF0OMXL6K
	 D5l98inqQQE9ecIpIY/TR/GOHXdx+dyCb41a7VuR6AdAmhQ8bR9Pw1XnuJOYUrtq3areD
	 ZNRsPIxynS9Sh9inev7EVHk2T8XXvASMq5occBsAu1CPVYc6J2VYZPJWAFDdCN1vefqj+
	 63kFh4Z8BjfpC12OTr2AXQzAcxwR5qRGju7Sk19SUzPDkkvrYLf6qB8I9QPEwCDQ7gZZG
	 41VBF0Gdt+rZNp39G35kLE4gn5R6GFDEvYCZLkS1T6riFb2fKb7jRs23FuTk9J5hHwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792735308;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Newsgroups;
	bh=mIzMe+9++/Ce2X/XZ0oBAcNeNEuF4QCcc3B44RUNFhk=;
	b=G9V8jOjLRvnrHkcJrSwxu58qWYq5VqwoSDkkcpEXeW54kg0/EecoY4noUqupkfU0XfCP
	 6d9pom+bS4t1/Gb7WzYq7Vv/w9rSj8hfrfkryZZped8XfDeZM6zrkOaWyVzA8S//5VQSv
	 XxL23Q+APxx7TM4Vr/pT+aJw6jXX4vAnGmelWkWLT0WVeO4J2icoAwwmUaX7ChxbCaCCg
	 apALwdxSw/RPHebh989stB/enmWOOUw4BMqCNLLhBDoDJ3J5mrD7vDEvNFzUKsgmtRaRf
	 6sm+fIbZWkuKEZx0dz6k+ORvRut802ZH556DFon8ikdg2M942It5UTL22q8r5iyInfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gondor.apana.org.au;
	spf=pass smtp.mailfrom=gondor.apana.org.au;
	dkim=pass header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=XO8DNE1T;
	arc=none smtp.remote-ip=180.181.231.80
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090C2606A31A
	for <dash@vger.kernel.org>; Fri, 23 Oct 2026 06:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 090C2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=XO8DNE1T
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=mIzMe+9++/Ce2X/XZ0oBAcNeNEuF4QCcc3B44RUNFhk=; b=XO8DNE1TxlEIwuFtgDVsh7j5uD
	cZUoR6OZf2ffiEyH2ZFUAn9/ZFmY6CmhFcb+DErhSjQk8t3oznCSAm++mGQKKPRZiUQ42WVXEy2bR
	UrRKuUZCul7ZYQpQK/0CjUOO47jTHp6R2a5i2LPrC6V9IrzJM/5cdkcaqgcy0hb5MlmvwOWS4D6mq
	k5w3W1eG4XGcQZ6R281ixu1KO86or82A7OAKRQ3C82jYXPBYbPZxDXPUlVqLayIg+3a1Yk3ZiGmOL
	Tc6IxcqJS5HHoGYJq0F9zz9K/SDtXOfAY/8HTPmlCsM29sVX1FiAbLlSQ0pN89knqASzlkCs2LSYx
	bhIxQIng==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1xK8LW-00000006lwV-11vM;
	Fri, 23 Oct 2026 14:01:43 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 23 Oct 2026 14:01:42 +0800
Date: Fri, 23 Oct 2026 14:01:42 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: dash@vger.kernel.org
Subject: Re: struct var::flags never has VSTACK bit?`
Message-ID: <atr4RqkdrX3TGjjY@gondor.apana.org.au>
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Post: <mailto:dash@vger.kernel.org>
List-Help: <mailto:dash+help@vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
List-Owner: <mailto:dash+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK1hOcMy+=6SAKRA02z_DWtLG8OkyDLO3udzrnKdpfuq+C=d-g@mail.gmail.com>
X-Newsgroups: apana.lists.os.linux.dash

Denys Vlasenko <vda.linux@googlemail.com> wrote:
> Good day,
> 
> I can't find where VSTACK bit is ever set.
> Is it unused?

Yes, it's been unused since:

commit 811a36120aef848cd308d56e06bf62e721be853c
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Sat May 19 02:39:55 2018 +0800

    eval: Replace with listsetvar with mklocal/setvareq

Feel free to remove it.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
