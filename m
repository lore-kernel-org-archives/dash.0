Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17177284688
	for <dash@vger.kernel.org>; Wed, 20 Aug 2025 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755701357; cv=none; b=R8Hn0eeTUofT/VoK8GbxG5BZ5k5BW7hJfnZwX6DJT5TEI0+UyRo24nAVlBCKAgTigFWyGslT7nT7tNoMujHQaIL6kpGA8JSE24PNGrLFneoLujPWhNOtAp+d2DhiScpX0v7EmriBtNS1bI2LM9jL9EgtGXYtFPuP+YLoVGam1QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755701357; c=relaxed/simple;
	bh=cIMpbYbsZXxn3g8RNwXHjkz1yHswGZeCOjfkFfeRToc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References; b=YymuveA09K9+Ih7qo92g/JLQZvfOmxD/+eXLqrUMrDQwF5HztOoYSOe95R33UF5r6FBzhGx6eWLwB8pLAL2zfYRum08W5UO0LUHbYkAP9buurOFQ/brArTbcNdEhxHnD879t7D6dgq5ibOyv+EL8DrDmLOotYLyaOLUR+HWpNzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=pass smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=T0VEkWFC; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="T0VEkWFC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1755701352; x=1756368018; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:openpgp:blahblahblah:author:from:
  subject:date:to:cc:resent-author:resent-date:resent-from:resent-sender:
  resent-to:resent-cc:resent-reply-to:resent-message-id:in-reply-to:
  references:mime-version:content-type:content-transfer-encoding:
  content-disposition:content-id:content-description:message-id:
  mail-followup-to:openpgp:blahblahblah;
 bh=5+zbGNzIBVW47rF6KJH8gxX14dl6qcpXnL40WO0R5EI=;
 b=T0VEkWFCW9A5OzYkx5TtuHhXcZTKSgF45ywt6YWk/dnPxqSSp11CKsNoD7MStws4vTY+5q9D
  lnIPYBxHJcwd2eLkVQJnI8YqBAEuaEWhNTur5dzCP/Oi8W7fi7h/Plk7SZtxeVEpSS4T8bcvXf
  WV25e9S4b+sUgS7NEZprl1/vqLSfyDzgrn+srGrOJ1YyGq/ALEsmKaBdQkH5vqkDYWkKHXK6oC
  gyvWCeqsNvYyJbrlGYeFSK1V/xm/mUJhFX530JqEHOH39+TI0d90g+1A6rbw1iFOMiMhJs45QB
  6G0ufz8pdnLbdMgcQraDVK2+nHdYR+6M75py+NWrxfqyxAXg==
Date: Wed, 20 Aug 2025 16:49:12 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Aleksander Ushakov <aushakov@astralinux.ru>, dash@vger.kernel.org
Subject: Re: [PATCH] left shift of negative value do_binop
 src/arith_yacc.c:111:12
Message-ID: <20250820144912.gzw-kNXj@steffen%sdaoden.eu>
In-Reply-To: <29c58d93-1b11-4a6b-a78f-774dc33b9cf8@gigawatt.nl>
References: <1abb4964-b5ee-42d8-bbb8-959594d61665@astralinux.ru>
 <e79e39bc-02b8-4ad7-ba03-7e4d00061c3e@astralinux.ru>
 <3a37b273-3da1-45f6-a303-3c0796bd0532@gigawatt.nl>
 <024b5e9f-6112-4224-b095-f7e54b8971b4@astralinux.ru>
 <ef041d50-cb3b-44be-aa81-402912b42997@gigawatt.nl>
 <20250820112753.FJo-4m6j@steffen%sdaoden.eu>
 <20250820113344.cw2oHltI@steffen%sdaoden.eu>
 <20250820121405.UGuB1dZ3@steffen%sdaoden.eu>
 <29c58d93-1b11-4a6b-a78f-774dc33b9cf8@gigawatt.nl>
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

Harald van Dijk wrote in
 <29c58d93-1b11-4a6b-a78f-774dc33b9cf8@gigawatt.nl>:
 |On 20/08/2025 13:14, Steffen Nurpmeso wrote:
 |> Steffen Nurpmeso wrote in
 |>   <20250820113344.cw2oHltI@steffen%sdaoden.eu>:
 |>|Steffen Nurpmeso wrote in
 |>| <20250820112753.FJo-4m6j@steffen%sdaoden.eu>:
 |>||Harald van Dijk wrote in
 |>|| <ef041d50-cb3b-44be-aa81-402912b42997@gigawatt.nl>:
 |>|||On 20/08/2025 01:33, Aleksander Ushakov wrote:
 |>|||> Well, if we take bash with UBSAN instrumentation and try to use a
 |>| ...
 |>|||I did that in my own version back in 2019, with the exception of subtly
 |>| ...
 |>|||<https://github.com/hvdijk/gwsh/commit/c4d6f1b1613c228db1e157a2136c53f5\
 |>|||5\
 |>|||b4530c8>.
 |>|||As those commits show, there are quite a few more cases to consider \
 |>|||than
 |>|||left shifts of negative values.
 |>||
 |>||We (i am only a MUA though, since busybox did not take the code,
 |>||and kept their broken implemenation; will try again at some time)
 |>||all return -2 for "-1 << 1", at least on this hardware etc etc.
 |>||You then return 0 from looking at the commitdiff!?!
 |>|
 |>|ah no forget that rubbish, the test is about rval.
 |> 
 |> Ah.  However, may i suggest one thing?  You test against
 |> "(uintmax_t) b >= INTMAX_WIDTH)" and say "excessive
 |> shift counts do not lose the high bits".
 |> On at least x86 (where i have been educated) excessive shift
 |> counts are reduced to &(bits-1) aka %BITS_OF_XY_INT.  I have no
 |> overview on how other platforms do it, plus i have forgotten
 |> whether that behaviour is possibly standardized by any language.
 |> But i am used to that, and am possibly not alone with this.

 |This is what I was referring to with "subtly changing behaviour that 
 |differed across architectures". This behaved differently across 
 |architectures, taking only the low bits of the shift count is what x86 
 |does but is not universal, and I did not think it would be sensible to 
 |implement that on other platforms where it never worked that way. The 
 |behaviour I picked is what would have been the result if excessive shift 
 |counts hadn't been explicitly undefined, it's simply that e.g. a shift 
 |by 123 is equivalent to 123 shifts by 1.

Ok, but i am not with you regarding that then.  (Do you can name
"other platforms"?)  I think the other shells are not either.
As a little bit laxe one regarding all that i want to point to
the email [1] (thread start [2], if you really want and do not
read it anyway), especially

  I hear and understand what you're saying. I think what I'm
  trying to point out, is that in C, as it was originally
  implemented, in expressions "a + b", "a >> 1", "++a", C
  "does what the machine does".  That's a very different thing
  from having rational, safe, predictable language semantics
  for operations on types - but it was also a strength, and a
  simple way to describe what C would do, deferring to machine
  semantics. I believe one place in C89/C90 where this is stated
  explicitly, as "do what the machine does"

  [1] https://www.tuhs.org/pipermail/tuhs/2025-August/032386.html
  [2] https://www.tuhs.org/pipermail/tuhs/2025-August/032381.html

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
