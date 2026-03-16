Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35742DCBF4
	for <dash@vger.kernel.org>; Mon, 16 Mar 2026 04:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773635249; cv=none; b=AK9kKeQMdY9P0XQyl6DizmUaf3U3CWZST6xcTZ0pIZNTfStZoW6ZeMNBMe/+gWtnTf5gWwITLQCEhoQW0GZwWJcv9ZJTWSjixcInU76S2KI9TMMGbkKVk0iP6e62Uqxqb138Wqu4nEJNWn909Ki7ZIn+JdBQggeOequXWHERAkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773635249; c=relaxed/simple;
	bh=KpKNRJtMEQbbmbRsnq5l5QBQuZ/6dXlpUR82hpTil8M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZDPoj/PlpNRuWKppqPhTRvXhplR0ELnNzbmTlXdbzy+qoawQngSMy4S0LXesMVR4PJJFEyicOjc4eLy+xWSbIj20RRkaecjDm8Ug7Ej1NRpKgbHTagOjPzIkLadU/614RG0q9iuNrz7sI0PfNTxC1nYaujTY246hm1Zjgagd9W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=rB1Swizw; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="rB1Swizw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=0nyHouMBpQmB9cZH64zQmVLoDLsmOSzb9YhLtd/kYxU=; b=rB1Swizw1zGEtNeCgAwOeE7wNp
	5b2gdq8tOSfgpO4/EsjkUkkdh91WCWwvMfgvG3U2yZRaE8ZL7jiPDXPkkl1WKSAXnZQav8kT5YHxo
	mtXI7MtmbC2VTF6/NIJBlIZgegrU9iQ+0GcSTY/zdpLG9hZloDElkl9eeczb+KUc3ZnvWMktyITg7
	Bznn1aO+SR0hGLYC+UZTt4KpbR/E1qvdKgc1IhdhA/GEu0ggCEo2tlxKQWZnYI1+RmJL+9fx0XiqS
	pRduOY01Hb/kUfP6w5sTcAKORuZj/tzNCtAdjiPf72Wg754+XFP/MR5s54xYkwfHKG38+xdbPajyl
	eCENS4VA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w1zY4-00EjNs-1Y;
	Mon, 16 Mar 2026 12:27:25 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 16 Mar 2026 13:27:24 +0900
Date: Mon, 16 Mar 2026 13:27:24 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: dash@vger.kernel.org
Subject: Re: trstring() has \ooo octal printing code, it's buggy
Message-ID: <abeGrH5FA6kz4ZjD@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK1hOcMsRRQsgp+pyNmui2v+gMx6zFf6nLa89jzeid-AfcKv8w@mail.gmail.com>
X-Newsgroups: apana.lists.os.linux.dash

Denys Vlasenko <vda.linux@googlemail.com> wrote:
> Good day,
>                                putc('\\', tracefile);
>                                putc(*p >> 6 & 03, tracefile);
>                                putc(*p >> 3 & 07, tracefile);
>                                putc(*p & 07, tracefile);
> 
> The last three putc need '0' added to the char value:
> they need to print '0...'7' bytes, not 0...7

Please send a patch.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
