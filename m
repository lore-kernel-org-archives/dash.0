Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007622FB636
	for <dash@vger.kernel.org>; Thu, 21 Aug 2025 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783491; cv=none; b=OXF1HCVgUlwUuC+nRxhdBAOieW5YT9HB+0qve7DEWvR1S+Yrx+Jcntp63bPxZ6QJCN2MKNioaH7HHpCd1VDo+fim982I+9yQEW+5PD/kOtkTckfOBfUGPE+rrjPPsVXM4C4DdUNqU0tUdabP7GI86BJh5qOML1/OyBp2T9h5zxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783491; c=relaxed/simple;
	bh=PBPFPsLkB5//R4znI8I8luwy9nYpA4fnCiGkJq5O0So=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References; b=dV7zntR/kBlYra624jX6FGgXADlu2uUuAl9qp5NMCsp2FMl6aWYsmnvhGWTHwWoKaYamMhyhUGOclVLITYWY/AYoo5eCBtgFGrEUp3rjUYwQhMxu3JjQ+xBMELW/HOw28ijeH4HgOPGO2hW+2gvqg/yNAF9N8YtaOYs4fWZNlzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=pass smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=CLQyJlMm; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="CLQyJlMm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1755783479; x=1756450145; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:openpgp:blahblahblah:author:from:
  subject:date:to:cc:resent-author:resent-date:resent-from:resent-sender:
  resent-to:resent-cc:resent-reply-to:resent-message-id:in-reply-to:
  references:mime-version:content-type:content-transfer-encoding:
  content-disposition:content-id:content-description:message-id:
  mail-followup-to:openpgp:blahblahblah;
 bh=vbwvjkvkTVhCS+uVi2lIMMDYV4MG9UTHXE+p71IQLGY=;
 b=CLQyJlMmrchYWZ+VlPztOqiyMtn6nnsuMXS8hXEf7BQOsi7sO0jg/2IXSfsW27Z+M4Jl9aXH
  Qg5b7y+xzhBzeP3HmobtNNkzuIoH/YO+vNSrRwDG2zLq05OqzDIg618g2QYZewwHy9oAxZudbv
  vN7gufkUqWArbmNlZEZBWRI4I4uWWPIJ6OTj4fKDvJAFQoX2JDenyESCoK67A2Ev4sPDXVqQzw
  2f3vs5xdnNQ65+egNRtda3PI6SM3iDbbYsB/tHAiIn7tcRoW5egbYxnG9IOdkmiwXBQXZcoHKI
  62o2hs0FGdYexlI/ykaTQiT3TUsMydQUeWLWlxtu6E1kD3OQ==
Date: Thu, 21 Aug 2025 15:37:58 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Aleksander Ushakov <aushakov@astralinux.ru>, dash@vger.kernel.org
Subject: Re: [PATCH] left shift of negative value do_binop
 src/arith_yacc.c:111:12
Message-ID: <20250821133758.X1--F_jO@steffen%sdaoden.eu>
In-Reply-To: <20250820211130.r-9ZHphA@steffen%sdaoden.eu>
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
 <20250820211130.r-9ZHphA@steffen%sdaoden.eu>
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
 <20250820211130.r-9ZHphA@steffen%sdaoden.eu>:
 |Harald van Dijk wrote in
 | <3bd5ca92-d09f-440f-ba0e-8e67d36dad50@gigawatt.nl>:
 ||On 20/08/2025 15:49, Steffen Nurpmeso wrote:
 ||> Harald van Dijk wrote in
 ||>   <29c58d93-1b11-4a6b-a78f-774dc33b9cf8@gigawatt.nl>:
 ||>|This is what I was referring to with "subtly changing behaviour that
 ||>|differed across architectures". This behaved differently across
 ||>|architectures, taking only the low bits of the shift count is what x86
 ||>|does but is not universal, and I did not think it would be sensible to
 ||>|implement that on other platforms where it never worked that way. The
 ||>|behaviour I picked is what would have been the result if excessive shift
 ||>|counts hadn't been explicitly undefined, it's simply that e.g. a shift
 ||>|by 123 is equivalent to 123 shifts by 1.
 ||> 
 ||> Ok, but i am not with you regarding that then.  (Do you can name
 ||> "other platforms"?)
 ||
 ||It has been about six years since I looked at that so I don't remember 
 ||exactly. I think it was most likely 32-bit ARM where $(( 1 << 65 )) 
 ||would result in 0.
 |
 |I see -- thanks.  No 32-bit ARM all around here, i think i will
 |finally install an AlpineLinux armv7 VM as soon as possible!

Actually ARM in general seems to act like that, i looked at [1]
for aarch, the ARMv7 docu (newest is PDF anyway) was a bit cryptic
(it only says 1<=X<=31, and that 0==move instruction).
Well good to know, this is then of course different behaviour, if
the greater-than hits.  Though the doc says they inspect a byte
only, if i understood this right, and i wondered how they get
there (i did not know ARM can access "partial registers"), to
compare only 8 of 32/64 bit, in the register case.  Maybe it is
doc misunderstanding.  I should maybe boot an aarch VM and check
it out, ie, if i code ASM, whether say 0x101 is treated as "1", or
as an excess, since the entire register value is 257, say.
Well i do not know.
I like how Alpha, Risc, x86 do it.  Seems easy and cheap.

Anyway, for the MUA, the vexpr command that also offers saturated
and unsigned arithmetic documented "[f]or the bitwise shifts, the
saturated maximum is 63", it is otherwise overflow error, and for
the shell arithmetic i now explicitly document "(Only the 6 least
significant bits of the shift operand are used.)", and so it is
"defined behavior" for this code base of mine.

  [1] https://developer.arm.com/documentation/dui0801/l/A32-and-T32-Instructions/Shift-operations

Thanks!  And Ciao,

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
