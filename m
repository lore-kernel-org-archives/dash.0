Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D289033D6E6
	for <dash@vger.kernel.org>; Thu, 12 Mar 2026 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309751; cv=none; b=tHIueZpoHIKc/ibOBuYrEzPg+k3nenvD5DU9nLYYfJchtTVIs7h2Zk3l+XMunx6++D8IPbqTZIj6VUQWZqWHlVWIESuw/d+PrznI9oQcNZI+Spxi4Mvq88pWMzgsM+6FfgdRwbNo6sRp/BF9edPXM26YLwfV5ozKpOdwUVCYG50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309751; c=relaxed/simple;
	bh=eWx6GqsP13SjAenijrMQD27xekrApb73vImHB1mrBdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnrcK+s0yE7ixAi/0GZCBKlrQrR2tvbH3OLlmjsu9SkshboshMr2yOYrLfigeACW+BT9fNQFyVnlirs4ILXqfklBYF12GXaCGMn/H7JtmQ2avrod0sfHBYRWHTtdzm/xfZFfnUvss/x6SHlloi5fkq/yzG089yNNeA5qxss0b8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=OkscGxFN; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="OkscGxFN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=Yx/qZg4trrpHWYRrNDHbbNzO/HIvikY6XQLlKs9sexg=; 
	b=OkscGxFN57AYwFaRJpMOuez5xnLW6P5MMZ5Inw/gZgexVU5le9/bJagu96m5rGljD57lFGEbVp/
	GDNzlp/tLZGtsPZEvH5FmDq6/V+hp+hiP4M/U7tv57td1BRafc/rWErz8dXnr7dVaYwnDZ5AASUFO
	6Dnf+hAgDFfu5OgIdgzpXpGP6d3mZxA6vvvBWeRJhlbmc3op3zP7YX/1egSvOtqe/DoivxoVNjpa3
	URFzKtp71ktsIU1/Yg0jVBvA1y1NVj65xQFI82yTE0um3bahMahUR4TKqZmOFKcspSeCXnGeu3zkl
	CctuhQKPaVyDek+KQM0m2OPtwXYG5Rw5hxGg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w0crx-00DlSf-1F;
	Thu, 12 Mar 2026 18:02:18 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 12 Mar 2026 19:02:17 +0900
Date: Thu, 12 Mar 2026 19:02:17 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jyri-Matti =?iso-8859-1?Q?L=E4hteenm=E4ki?= <jyri-matti@lahteenmaki.net>
Cc: dash@vger.kernel.org
Subject: [PATCH] input: Fix preadbuffer loop when libedit is enabled
Message-ID: <abKPKTXEadM1gr9-@gondor.apana.org.au>
References: <CANhYXO-M=zNN3XDN9V3O2XaOvA=3wc1vkogSfyRUWhVCP9_iGA@mail.gmail.com>
 <aYMOgmK_puMi2J3N@gondor.apana.org.au>
 <CANhYXO9A5Y=TJi-TbEvv3ASPFjPjdd+pEfhmjqeMMXOCEoCpzw@mail.gmail.com>
 <aaOaPybgS3vDfbtQ@gondor.apana.org.au>
 <CANhYXO-FCjH6GTGyh3=iRxa+07bADbODsbM3oacfn7Uu6kkH6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANhYXO-FCjH6GTGyh3=iRxa+07bADbODsbM3oacfn7Uu6kkH6g@mail.gmail.com>

On Sun, Mar 01, 2026 at 07:53:22PM +0200, Jyri-Matti Lähteenmäki wrote:
> 
> Git bisect says that commit a065467315dc5f2f312f7e6f1d2e9d05a77b3cb7
> ("input: Move newline loop into preadbuffer") is the first bad one (I
> probably made some mistake earlier when I said commit 6574... would work.):

Indeed that was the buggy commit:

---8<---
The preadbuffer loop to get whole lines is broken because it never
sets lleft before calling preadfd, the latter relies on it to
correctly position the read buffer.

Fix this by setting lleft before preadfd is called.

Reported-by: Jyri-Matti Lähteenmäki <jyri-matti@lahteenmaki.net>
Fixes: a065467315dc ("input: Move newline loop into preadbuffer")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/input.c b/src/input.c
index c36d120..0c2c066 100644
--- a/src/input.c
+++ b/src/input.c
@@ -386,6 +386,7 @@ eof:
 
 again:
 		nr = q - parsefile->nextc;
+		input_set_lleft(parsefile, nr);
 		more = preadfd();
 		q = parsefile->nextc + nr;
 		if (more <= 0) {
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
