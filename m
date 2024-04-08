Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4D91D558
	for <dash@vger.kernel.org>; Mon,  8 Apr 2024 22:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712616874; cv=none; b=VHU1EtnYddoYgOnoDujl5t3fPbk8Kjwxuh6MKv2FlipvK5DeLQcyNjd23xMM23wcJ22uUBLK38YIuzzBcYKZclaFf8RXAWgZE5s6fLaGR5S+asoq1+Fhq18Pwt8OQ0zQxUoi2/e0s7GQcWee8q+Bq6Fx7J0khtK5cYPxOu58tio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712616874; c=relaxed/simple;
	bh=ZkxnrflcxJ5+5xoWoyDo0xetgjXJYcF8xmL40VrkORM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References; b=WeZPJU7kYoPZJl/lUQqh3dmwEXOHp78ccEKU2hYKRBqyPdX4kikSYyIYGNT0HrhSrAr2AnLx0d+Wre+Yh9T0iaIUhxwlmm1pSMhWUL349i0vACQO+LDEisVQRlhBGsLjOix2/yibcz/NEMwAWD6ELdyXBjM4anverxWkUojZT48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=none smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=OkLfG+j+; dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=ieWcDFnV; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="OkLfG+j+";
	dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="ieWcDFnV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1712616862; x=1713283528; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:openpgp:blahblahblah:author:from:
  subject:date:to:cc:resent-date:resent-from:resent-to:resent-cc:
  in-reply-to:references:mime-version:content-type:
  content-transfer-encoding:message-id:mail-followup-to:openpgp:
  blahblahblah; bh=b3C+bitbbE/MKEdHI7gZB9s7p1z3WGTV1Ct0UMwuYrk=;
 b=OkLfG+j+8ChjjhF00axe7gcWZFOWD4Hbd7+sAEnrAyAnJSsxrO+W1I/9azVhOgHvWSBnUlc2
  OQn2+VkXiDOuIOHsEho2VPjyUisFNSppmP9WbxxP5cCWlwrkPngj2PgxN3EDYmXRvaTR/DXIkp
  UlQBwsePewLGwpvul2UxG1nKuTducUbnrtK+OPDNQd22rGmUNF2u/ixy1J9dGR3ZlHWnIhOayC
  dtaOF0hD53KUULBfscqwmMfnNGkfW4pRY+dkePMiDM9vxlVCJs8OcQW3eAwpB7naOIpSGlZJVh
  bmoCOhFDDDBSbOalsnQC2VNKWJ2N6+fA4owF+g3ikOzTq72g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=orange; t=1712616862; x=1713283528; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:openpgp:blahblahblah:author:from:
  subject:date:to:cc:resent-date:resent-from:resent-to:resent-cc:
  in-reply-to:references:mime-version:content-type:
  content-transfer-encoding:message-id:mail-followup-to:openpgp:
  blahblahblah; bh=b3C+bitbbE/MKEdHI7gZB9s7p1z3WGTV1Ct0UMwuYrk=;
 b=ieWcDFnVK97/Y5mbkemOpOIXF4v4sjCisG0EKjo3gAakHRcIkqasJczcQQtgo1UFwoTmFkCR
  pcp7RYcUz+/0Bw==
Date: Tue, 09 Apr 2024 00:54:20 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org,
 Ganael LAPLANCHE <ganael.laplanche@martymac.org>,
 Jilles Tjoelker <jilles@stack.nl>
Subject: Re: [v2 PATCH] jobs: Allow monitor mode without a tty in
 non-interactive mode
Message-ID: <20240408225420.hz8nC3ly@steffen%sdaoden.eu>
In-Reply-To: <ZhJhpbIEe1RyBfk0@gondor.apana.org.au>
References: <dedaa3fa370ea9c4aeb1771b5568a7bef4065b04.1675113321.git.steffen@sdaoden.eu>
 <ZhJhpbIEe1RyBfk0@gondor.apana.org.au>
User-Agent: s-nail v14.9.24-612-g7e3bfac540
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

Hello.

Sorry for the late response.

Herbert Xu wrote in
 <ZhJhpbIEe1RyBfk0@gondor.apana.org.au>:
 |On Mon, Jan 30, 2023 at 10:15:40PM +0100, Steffen Nurpmeso wrote:
 |> This is a take-over of the FreeBSD bin/sh
 |> 
 |>   commit cd60e2c67d52e1f957841af19128c7227880743a
 |>   Author:     Jilles Tjoelker <jilles@FreeBSD.org>
 |>   AuthorDate: 2014-09-04 21:48:33 +0000
 |>   Commit:     Jilles Tjoelker <jilles@FreeBSD.org>
 |>   CommitDate: 2014-09-04 21:48:33 +0000
 |> 
 |>       sh: Allow enabling job control without a tty in non-interactive \
 |>       mode.
 |> 
 |>       If no tty is available, 'set -m' is still useful to put jobs \
 |>       in their own
 |>       process groups.
 ...
 |Thanks for the patch.  I've rewritten it to minimise the impact.

The patch is much smaller.

 |However, the end result should be fairly similar.
 |
 |Please test this and let me know if there are any issues.

Running the script with it has the desired result.

  ..
 --End of <ZhJhpbIEe1RyBfk0@gondor.apana.org.au>

Ciao, and greetings from Germany,

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
