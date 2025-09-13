Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602522EC0AB
	for <dash@vger.kernel.org>; Sat, 13 Sep 2025 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757774130; cv=none; b=C0XDZ9Y8YoGaw/Dmo/UPiSOaNZtGAWNC0wBfP16OveNgegJeoZJK/gTzCGxDrgfZ37qPyhcDpQJbipxPrHuYPO0Vyn5F/dldU7hw+S2tkp35n/L2CS3arbelu4emKC/57o74Pj4kboy/iOf8+Rab7QRKIcbhlpSpwQkBIx5+Lmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757774130; c=relaxed/simple;
	bh=zb/qI0JHFuPFAfjPEN9lS6mX+aGNJjP5jov0iDZ3Eq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+cst2AHLGcR4eVH6p4Z40zF6sm9JvlV5y1Vf6E26r7roVu2m/qHPPOB4BR/UZ9ABySkEMopxUX6lb53MLZJ6/Bby1q/2R6npemh4oMangQl3f/wcMJc/5mdtKjhUgcM1c2DCI4gfmIa3PgkcNs3SvNkOhOZF24/ssfpnAg9iYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=RC31z4rS; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="RC31z4rS"
Received: from [192.168.178.21] (unknown [31.94.20.231])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id 1302891;
	Sat, 13 Sep 2025 15:29:32 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 1302891
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1757773772;
	bh=qKhGoYU2Qwv5kSThnaIwaIDVN5aCfYbFcG7sPVs35YU=; l=449;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RC31z4rS7Dgg2N3JsBavVP5gIYe6p0p0K6DYtxinPyxPw2N77bCuizQ3s46rB2vVW
	 pbLc5gbfTkzV8e9fagr7fyzlGaskVLmknp4ABm908ZGZs7S99W1zoY25pJu6WlNp+j
	 ZMcA5sc8wqJ/irAdiz4umsHuV1bY6tHVyMtXD5Xg=
Message-ID: <ddd331fe-b0cb-4575-9849-90a811df32fa@gigawatt.nl>
Date: Sat, 13 Sep 2025 15:29:30 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: I found multiple crash bugs in Dash v0.5.12-115-gb4ef25d
Content-Language: en-GB
To: Herbert Xu <herbert@gondor.apana.org.au>,
 Nathan Mills <the.true.nathan.mills@gmail.com>
Cc: DASH Mailing List <dash@vger.kernel.org>
References: <CALjJ9ccRuGV9fmydBvwzOua_om7QVoro-nSA-pv+9-nX1KLfGA@mail.gmail.com>
 <aMV6ZCrLe_v5XBJs@gondor.apana.org.au>
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <aMV6ZCrLe_v5XBJs@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/09/2025 15:06, Herbert Xu wrote:
> This is actualy harmless because memcmp will return non-zero if we
> read past the NUL character on the string p.  If there was a way
> to mark this as a false-positive it would be nice.

Are you sure this is a false positive? memcmp isn't required to stop 
reading once it sees NUL and typical implementations read multiple bytes 
at a time. Reading past the NUL may crash.

Cheers,
Harald van Dijk
