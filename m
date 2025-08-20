Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992CE21CC71
	for <dash@vger.kernel.org>; Wed, 20 Aug 2025 11:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689628; cv=none; b=IdKG8QoZmB3aPRwtMraGY7DVZfPK+Jsnw6sPHM+qoVlTpdQ/EVc6Oy8/XNorxBXUfc+sk6NanZgbxPL1dl8P71/CSy+NsQPc/tLqjRVSrKgxd2c9OS0ipJaNxWEp7dBz7AT/sg4i8N/81ds8O/HFQDj/61ipO11gbxYVfFzRLDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689628; c=relaxed/simple;
	bh=TRN3A+rIthcZdQ1o9Xg9W9AeEj9AyyhJsUm5t8aF0rU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References; b=nyuea159T8vd9bWGevbVyNZeBYHHIrGOMXfAZrLIiGS2ze4UxpL61j9yVcjDtR7v2Di+CAbmBCUmPzKfW7S1G2GWkKZkGWZpFU9TNN79vyF2o0yYzBqKRrugXsx7FxUJP08KtjysyTAArP7SKtjtoT4r8qQ7c4PRgUKZPp45J4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=pass smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=SY0CYYWA; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="SY0CYYWA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1755689624; x=1756356290; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:openpgp:blahblahblah:author:from:
  subject:date:to:cc:resent-author:resent-date:resent-from:resent-sender:
  resent-to:resent-cc:resent-reply-to:resent-message-id:in-reply-to:
  references:mime-version:content-type:content-transfer-encoding:
  content-disposition:content-id:content-description:message-id:
  mail-followup-to:openpgp:blahblahblah;
 bh=p9G9V0W/NuAs3qnQYiKf86IdRei3h4q9vRTdHc5jqns=;
 b=SY0CYYWA5DN0vZKpRbXKyzsiMgAVz7kUW3UMavXReVqF2tp7QZfjrQOTijqBoq6ez5dRNdgl
  Q1wctoylxGjgqAn6m6ZzhtbnccN5NxHmYWDmpWqVuWKIoBtnO0lAj47FeXqqdCHZXrEttky7yP
  06rSyk/yVCH3RuqqlB0xjNKdBoelj4RlcBuGTmksPUbc4/ibH10Syh0sBjldmY1OP77sqdtnKF
  efGS9BTp8yfkyoPxevYn6g/4pZzLQvqA8OQBFB1DAGOzZRQ0B59cH/2OzaCpvaS5UjeKezgMkM
  1En4nK3XW49hGZ3tDr36fmefbK1cjTYaHKuldvPs4rp3npvg==
Date: Wed, 20 Aug 2025 13:33:44 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: Steffen Nurpmeso <steffen@sdaoden.eu>
Cc: Harald van Dijk <harald@gigawatt.nl>,
 Aleksander Ushakov <aushakov@astralinux.ru>, dash@vger.kernel.org
Subject: Re: [PATCH] left shift of negative value do_binop
 src/arith_yacc.c:111:12
Message-ID: <20250820113344.cw2oHltI@steffen%sdaoden.eu>
In-Reply-To: <20250820112753.FJo-4m6j@steffen%sdaoden.eu>
References: <1abb4964-b5ee-42d8-bbb8-959594d61665@astralinux.ru>
 <e79e39bc-02b8-4ad7-ba03-7e4d00061c3e@astralinux.ru>
 <3a37b273-3da1-45f6-a303-3c0796bd0532@gigawatt.nl>
 <024b5e9f-6112-4224-b095-f7e54b8971b4@astralinux.ru>
 <ef041d50-cb3b-44be-aa81-402912b42997@gigawatt.nl>
 <20250820112753.FJo-4m6j@steffen%sdaoden.eu>
User-Agent: s-nail v14.9.25-698-ge40eefb876
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

Steffen Nurpmeso wrote in
 <20250820112753.FJo-4m6j@steffen%sdaoden.eu>:
 |Harald van Dijk wrote in
 | <ef041d50-cb3b-44be-aa81-402912b42997@gigawatt.nl>:
 ||On 20/08/2025 01:33, Aleksander Ushakov wrote:
 ||> Well, if we take bash with UBSAN instrumentation and try to use a 
 ...
 ||I did that in my own version back in 2019, with the exception of subtly 
 ...
 ||<https://github.com/hvdijk/gwsh/commit/c4d6f1b1613c228db1e157a2136c53f55\
 ||b4530c8>. 
 ||As those commits show, there are quite a few more cases to consider than 
 ||left shifts of negative values.
 |
 |We (i am only a MUA though, since busybox did not take the code,
 |and kept their broken implemenation; will try again at some time)
 |all return -2 for "-1 << 1", at least on this hardware etc etc.
 |You then return 0 from looking at the commitdiff!?!

ah no forget that rubbish, the test is about rval.

  ...

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
