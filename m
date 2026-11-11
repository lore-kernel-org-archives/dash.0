Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.9.28.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794424639;
	b=mmeJ1Hu9ICqX8G5bEg8grk5Bk9+Tu411G81iP0IfHMZsqdFuJUgNp6+bGNlYd1e1PGjO
	 CohbetnoGFhjOg4ljEes2PVhwyUFdNGL5bRP3eNwO0uDAjV7AIVqJpBRzEn/R5VqW/aFO
	 N5vy+npKOWnUj324H8gcr9ZoGs7fe05bUwn7tHBO4TJjtlGLtEJG9I1hgmAuuh+OY1mxz
	 h8XobFJIkZnTYAA3zrNqlowvEylHrjzQQNuK2i36KzjFmm5AHY+5QbhicqPEB21hViEmi
	 2EWZBIcjhDCeyx9jeB6uukbyFV+XXyxJMekkEQYXaoCie8N5TK8TFAlbI5hF8c/GNig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794424639;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=W1QqAEyTm3PVrhPxQA90C35MS1lTSxixgV1K7vTlA4M=;
	b=whIXMSCBWhQAr8CNPjYE+3yCz7fPZRelw0rFwRvOXFr9bkFrPmP6puPCGgbCSyCo99RS
	 Klj9E69zNh9oajTXBMXe4HTAwGSlj3VCER2gbLRFxgi+1Sb1v6zjUT9Qtz9La/9HgPu9e
	 BiVCsMcjEZVY58ZZkWxG6ShqYeHFHU+lds0Y98CEhnsuusiF4S4tR+jkKMwNkbf289TtW
	 1W5K9pX5F4Lbqi2xERKJVMhwzlLP4KI2pEmlNPN/SSLbbiLtiOrEFnTJVYO1cVbImw8F0
	 FOUbK0Mpvv9pYiw9UryHJO27ZussSNHutrgGqPnTOnc/S7x3qhz9FPTlLJVAb3OLQhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mit.edu;
	spf=pass smtp.mailfrom=mit.edu;
	dkim=pass header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=pKiy7DBF;
	arc=none smtp.remote-ip=18.9.28.11
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C65606A321
	for <dash@vger.kernel.org>; Wed, 11 Nov 2026 19:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6C65606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=pKiy7DBF
Received: from [192.168.9.110] (198-27-206-187.fiber.dynamic.sonic.net [198.27.206.187])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6ABJH2pO029583
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 11 Nov 2026 14:17:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1794424625; bh=W1QqAEyTm3PVrhPxQA90C35MS1lTSxixgV1K7vTlA4M=;
	h=Message-ID:Date:MIME-Version:Subject:From:Content-Type;
	b=pKiy7DBF0uwtpFw5IKyMm8rsO3eDtrSQiUAJw4hZxfST3fDXd7yCLxfnqh8ECIY9c
	 TKeTYEnwgHNoTowklxEfQIJoSiWwmlkBvN+3axVp5xbS3P7pHkLukmL/PcH9KsxQDu
	 42OlPs44DrfcgjasYaCytz8Hm1Bo0hHVEY0oMw/h0NOBdPBt4F/e61xLzBXSGxjoLJ
	 E4olNSkxOkM9KC/UwxeMugKZJIYEZWFOj+4bPLUcwM9AF98xes67I6C3xhrOmyjvGr
	 QZYm/ZPJnIV23oK4SBaJCqGV84V3txNeT0s769kNOYuqP/0rRBq+xVLfRTyoSiwMIB
	 /bxr9/D8cTdZw==
Message-ID: <670746ca-9adc-4023-859b-1ea9b8c2decd@mit.edu>
Date: Wed, 11 Nov 2026 11:17:02 -0800
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Post: <mailto:dash@vger.kernel.org>
List-Help: <mailto:dash+help@vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
List-Owner: <mailto:dash+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] expand: Drop incorrect CTLESC cast in argstr
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: j.daubert@posteo.de, Dash <dash@vger.kernel.org>
References: <df9d5e861c3fc9bf6754fecc113616c1@posteo.de>
 <aPeKvExPB1HluHly@gondor.apana.org.au>
 <c6f2b0db-e5e3-483c-aeb2-eaabb574112a@mit.edu>
 <avRFkg95wTMWt9i8@gondor.apana.org.au>
Content-Language: en-US
From: "Anders Kaseorg" <andersk@mit.edu>
In-Reply-To: <avRFkg95wTMWt9i8@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/26 02:38, Herbert Xu wrote:
> CTLESC needs to be cast to char when it's compared against a char
> value.  However, when it is compared against an integer that was
> promoted from signed char, it must not be cast.
> 
> Reported-by: Anders Kaseorg <andersk@mit.edu>
> Fixes: 6c44f4ee0c2b ("parser: Add support for multi-byte characters")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/src/expand.c b/src/expand.c
> index 7ebb841..b0f6cf8 100644
> --- a/src/expand.c
> +++ b/src/expand.c
> @@ -372,7 +372,7 @@ addquote:
>   			ml = (mb >> 8) - 2;
>   			if (flag & (QUOTES_ESC | EXP_MBCHAR)) {
>   				length = (mb >> 8) + (mb & 0xff);
> -				if (c == (char)CTLESC)
> +				if (c == CTLESC)
>   					startloc += length;
>   				break;
>   			}

Tested-by: Anders Kaseorg <andersk@mit.edu>

Works for me, thanks.

Anders

