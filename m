Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108E82DE70A
	for <dash@vger.kernel.org>; Wed, 20 Aug 2025 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755692051; cv=none; b=egVSi3tCOiKrSrmhG+7pwi9E1DxvnAbxiDR1JMpsOe+UMwWo0wBdXZdgAFxTMQeSGBZQTU4E0O64uswCC1vy6xOOUO9ikoqi0v1dF1yercq6nt7BGINKAlS8En1xFdNZ5wpF/oTxm6kgJrtv+GH6F+BVIVYYYW9hpDnkQa7l1n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755692051; c=relaxed/simple;
	bh=JwTJpMXZ2X3gYswm48/y/qr6SYIE37HrV+YWy6AkTlA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References; b=BQYcOY0FMEBDXvZcvfI7Bhvq/s8ywHSe3wtUSTNYjO6Kt0dFFU+bEhsPSmLBB8w9nDeG9VzSpfP4cHuYNP2nbiYRK0lGwGN940G2g5LvlVkQl4X+mefVT5Az8I6nAtPgWHUvZGhOVIJIkiQuhNqL+kGqDHmR6Mu/ZOyQf1YyU9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=pass smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=HC1pISTM; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="HC1pISTM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1755692046; x=1756358712; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:openpgp:blahblahblah:author:from:
  subject:date:to:cc:resent-author:resent-date:resent-from:resent-sender:
  resent-to:resent-cc:resent-reply-to:resent-message-id:in-reply-to:
  references:mime-version:content-type:content-transfer-encoding:
  content-disposition:content-id:content-description:message-id:
  mail-followup-to:openpgp:blahblahblah;
 bh=XxWkD8FryIDRuWW0jHWqWQLzHsteRoy/0XepIZIk6II=;
 b=HC1pISTMCqEqBXOGMzrph5saUDSwce1nJHqsrAC37+U6IY7VPPwUFs7OA3DDlmSzeJ7Z6d1R
  /g2EGbJVisJEpLpGpQCZBFie6N3Nt7BO+rnF+oxltAgfj6YyGvkoRlS0jcFopVHqD4lYjkcRPV
  jmyV6LvD+6VrJ0cg3qJLns3UTFmJwaOvdWtPwYv+C5fQWDPduUfaMLTejvUkYBgZXoR/KGFkYz
  sM/wx1dfFngBlGEzVEY1pzV1u6XFj5D6J+oGBKfsgutbdkXbPo5vdtRr3a2D8cTqA9JqHL94Zo
  7tUWhJa0esdzX6UYsZdIuGyxb7sQpZnTn4mraatY++z7EvCw==
Date: Wed, 20 Aug 2025 14:14:05 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Aleksander Ushakov <aushakov@astralinux.ru>, dash@vger.kernel.org
Subject: Re: [PATCH] left shift of negative value do_binop
 src/arith_yacc.c:111:12
Message-ID: <20250820121405.UGuB1dZ3@steffen%sdaoden.eu>
In-Reply-To: <20250820113344.cw2oHltI@steffen%sdaoden.eu>
References: <1abb4964-b5ee-42d8-bbb8-959594d61665@astralinux.ru>
 <e79e39bc-02b8-4ad7-ba03-7e4d00061c3e@astralinux.ru>
 <3a37b273-3da1-45f6-a303-3c0796bd0532@gigawatt.nl>
 <024b5e9f-6112-4224-b095-f7e54b8971b4@astralinux.ru>
 <ef041d50-cb3b-44be-aa81-402912b42997@gigawatt.nl>
 <20250820112753.FJo-4m6j@steffen%sdaoden.eu>
 <20250820113344.cw2oHltI@steffen%sdaoden.eu>
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
 <20250820113344.cw2oHltI@steffen%sdaoden.eu>:
 |Steffen Nurpmeso wrote in
 | <20250820112753.FJo-4m6j@steffen%sdaoden.eu>:
 ||Harald van Dijk wrote in
 || <ef041d50-cb3b-44be-aa81-402912b42997@gigawatt.nl>:
 |||On 20/08/2025 01:33, Aleksander Ushakov wrote:
 |||> Well, if we take bash with UBSAN instrumentation and try to use a 
 | ...
 |||I did that in my own version back in 2019, with the exception of subtly 
 | ...
 |||<https://github.com/hvdijk/gwsh/commit/c4d6f1b1613c228db1e157a2136c53f55\
 |||b4530c8>. 
 |||As those commits show, there are quite a few more cases to consider than 
 |||left shifts of negative values.
 ||
 ||We (i am only a MUA though, since busybox did not take the code,
 ||and kept their broken implemenation; will try again at some time)
 ||all return -2 for "-1 << 1", at least on this hardware etc etc.
 ||You then return 0 from looking at the commitdiff!?!
 |
 |ah no forget that rubbish, the test is about rval.

Ah.  However, may i suggest one thing?  You test against
"(uintmax_t) b >= INTMAX_WIDTH)" and say "excessive
shift counts do not lose the high bits".
On at least x86 (where i have been educated) excessive shift
counts are reduced to &(bits-1) aka %BITS_OF_XY_INT.  I have no
overview on how other platforms do it, plus i have forgotten
whether that behaviour is possibly standardized by any language.
But i am used to that, and am possibly not alone with this.

So here and for my thing you now have a credit (not the first, you
are already in THANKS), for that UBSAN fix, less mentioned modulo.

Ciao,

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
