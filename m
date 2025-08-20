Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6728831DDBE
	for <dash@vger.kernel.org>; Wed, 20 Aug 2025 21:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755724300; cv=none; b=RGxRiEm5Gh0G5r5TVveqCXc1gO71LRhk1eJ3goDWqNnaSPgMwnG2fNIAlIrvQHiZ84tWp3iNFa8cuLav3HIPf/FXtf/eVE0eH3nx7prVEp8iyw/aicfe5zNHyPWRQp4qPzyNEyybr0vXijoaJwIQAb/+8fKiOjTKosT5x4pTvPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755724300; c=relaxed/simple;
	bh=lBKu5ydSvOHMllG4Gr3WVzqqv1a6Czsb9JCT1UZ5IBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References; b=bt15RaSS5WX0qD4Ma8VSqjiXH6nfot6Obvn4iZtyj9R7bTn4tuUvETElvigB4la5I9xXK3OBmPKXDDo7dMy3HIdlJtXBZjHEUokWBO5nSEVaXUh7NG7iaRDxWI7oaEPNDjlXIRwC18pnyrDgGLKPVovcLWKEeKlQIEOtY/Z9kiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=pass smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=bnM7BhqJ; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="bnM7BhqJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1755724292; x=1756390958; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:openpgp:blahblahblah:author:from:
  subject:date:to:cc:resent-author:resent-date:resent-from:resent-sender:
  resent-to:resent-cc:resent-reply-to:resent-message-id:in-reply-to:
  references:mime-version:content-type:content-transfer-encoding:
  content-disposition:content-id:content-description:message-id:
  mail-followup-to:openpgp:blahblahblah;
 bh=zw3uzlxs9sGLI0KA55NpjnEUyx+K5lky6TtTHC2Xufg=;
 b=bnM7BhqJOwhQAJeWK2OJ3XP6PhbWKfGQ8/RBbquAl3p2fY71+vIZ2eVGhzw915+02irVcpzc
  ZV3lAk0fqE417uqlMrJk5yZKacFhpC9LHs/KAlp6OLYjnY5nJJcmfak/aw3VOWXBl583vjBFdm
  QAoJ9kUV6vz15J22j/Lp3mtAJYdhSYaTrmmr4pTnTiBQox1XuCcDeSGwzr1e+h54lHEjcChEMi
  n4DeuVBdoBjNnFF4s/7n1SyvcyenerRNYht1N5tSxfz+ku2VIB+weuA0NxmVB9RZil1h/NZb5g
  t1k7y00uXxRqcdDSqCaZIH/UruZQdwFws8xZRlR5xxsTj29A==
Date: Wed, 20 Aug 2025 23:11:30 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Aleksander Ushakov <aushakov@astralinux.ru>, dash@vger.kernel.org
Subject: Re: [PATCH] left shift of negative value do_binop
 src/arith_yacc.c:111:12
Message-ID: <20250820211130.r-9ZHphA@steffen%sdaoden.eu>
In-Reply-To: <3bd5ca92-d09f-440f-ba0e-8e67d36dad50@gigawatt.nl>
References: <1abb4964-b5ee-42d8-bbb8-959594d61665@astralinux.ru>
 <e79e39bc-02b8-4ad7-ba03-7e4d00061c3e@astralinux.ru>
 <3a37b273-3da1-45f6-a303-3c0796bd0532@gigawatt.nl>
 <024b5e9f-6112-4224-b095-f7e54b8971b4@astralinux.ru>
 <ef041d50-cb3b-44be-aa81-402912b42997@gigawatt.nl>
 <20250820112753.FJo-4m6j@steffen%sdaoden.eu>
 <20250820113344.cw2oHltI@steffen%sdaoden.eu>
 <20250820121405.UGuB1dZ3@steffen%sdaoden.eu>
 <29c58d93-1b11-4a6b-a78f-774dc33b9cf8@gigawatt.nl>
 <20250820144912.gzw-kNXj@steffen%sdaoden.eu>
 <3bd5ca92-d09f-440f-ba0e-8e67d36dad50@gigawatt.nl>
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
 <3bd5ca92-d09f-440f-ba0e-8e67d36dad50@gigawatt.nl>:
 |On 20/08/2025 15:49, Steffen Nurpmeso wrote:
 |> Harald van Dijk wrote in
 |>   <29c58d93-1b11-4a6b-a78f-774dc33b9cf8@gigawatt.nl>:
 |>|This is what I was referring to with "subtly changing behaviour that
 |>|differed across architectures". This behaved differently across
 |>|architectures, taking only the low bits of the shift count is what x86
 |>|does but is not universal, and I did not think it would be sensible to
 |>|implement that on other platforms where it never worked that way. The
 |>|behaviour I picked is what would have been the result if excessive shift
 |>|counts hadn't been explicitly undefined, it's simply that e.g. a shift
 |>|by 123 is equivalent to 123 shifts by 1.
 |> 
 |> Ok, but i am not with you regarding that then.  (Do you can name
 |> "other platforms"?)
 |
 |It has been about six years since I looked at that so I don't remember 
 |exactly. I think it was most likely 32-bit ARM where $(( 1 << 65 )) 
 |would result in 0.

I see -- thanks.  No 32-bit ARM all around here, i think i will
finally install an AlpineLinux armv7 VM as soon as possible!

 |>                      I think the other shells are not either.
 |> As a little bit laxe one regarding all that i want to point to
 |> the email [1] (thread start [2], if you really want and do not
 |> read it anyway), especially
 |> 
 |>    I hear and understand what you're saying. I think what I'm
 |>    trying to point out, is that in C, as it was originally
 |>    implemented, in expressions "a + b", "a >> 1", "++a", C
 |>    "does what the machine does".  That's a very different thing
 |>    from having rational, safe, predictable language semantics
 |>    for operations on types - but it was also a strength, and a
 |>    simple way to describe what C would do, deferring to machine
 |>    semantics. I believe one place in C89/C90 where this is stated
 |>    explicitly, as "do what the machine does"
 |
 |If I had seen any way to implement that, I would have. But I saw no such 
 |way, so went with the behaviour that I felt was easiest to justify.

It is undefined behavior ;)

.. i looked, remembering that FreeBSD wants to or already got rid
of ARMv32, what RISC says.  [1] says

  Shift Bits

  RV32 shift instructions use the 5 least significant bits for the
  shift amount (0-31); other bits are ignored. For example, left
  shifting by 32 does nothing (you might expect it to set the
  register to zero).

  GNU assembler errors if you try to shift by an immediate not in
  the range 0-31: Error: improper shift amount (32).

[2] (bad one but) says

  on Alpha, the shift count is masked down to six bits. A longer
  test shows this (in tedious detail):

Itanium not well well.  Well.  I keep it like it is now, i like
that masking.  You do yours :-)

  [1] https://projectf.io/posts/riscv-shift/
  [2] https://community.hpe.com/t5/operating-system-openvms/left-shift-by-more-than-32-bits-gt-undefined-in-dec-c/td-p/5054212


 |Cheers,
 |Harald van Dijk
 --End of <3bd5ca92-d09f-440f-ba0e-8e67d36dad50@gigawatt.nl>

Ciao,

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
