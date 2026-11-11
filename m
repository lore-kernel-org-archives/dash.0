Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.9.28.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794386192;
	b=s6RaaUvDoVThby7KOlrlf8JEeWDDw2xDa7vgWF31vcHtI4yu87bPuKDXooOQhgDZLTgm
	 fjE2X95h6kiNuji7vJQ+ag64cNPYBvMxzUVft7YEelyg3ODkuB3WFQ67nYK8gBt2j488z
	 EbQO9/qgOxNrQktNbkylmXsIhHYSBnNr3SxqIeW5iSoZZlBtzqXzgPaa1tIjPuEma3yq5
	 e4yRdwvOMgrtsxU4e0aezAyVNSSffuIDs4S6W5cYZYQo/drqt2xWES5y4s5CPdX/wuw1z
	 C0u0m3VrFxduU57XWF/vGEZGxFncx433S42SeKMi+pwPmtcgs9pKpnyup5tWjUFBVyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794386192;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=UBNn+LYXzouI7nfjml3zrM+59Ynj+wIAIyABAQ+dTaA=;
	b=liRyTshLMy2hgakDK6nDxfpJ3fgKeSiYYGnNAZ+xg6oyg4+8CfBojFWQ6E21rINkBx44
	 cugriGK0/wJUOF4u88nja5S4/gX3EFuNG2rOnpsmDxDA+JXBMsAEPfX1E5iuvvf39MmkW
	 UpYlQKxT3ckSijRbgindB/08ZTSjgvjxujsSn+hKqzEJ3+3Hcee4dvACyWhY5JwGKm6Om
	 dhuqC5VbKJ3z9TOr2Q0ks0EjljWjSFQOJ/e3h0nOiRgqYQTjDIlSKyw2qIs/rNseobSSz
	 1//95rxikFOXQVAgdTCszaFTkqC7pTcvutER1HdYYlCz1BBeqBex6XldQjo131uY7Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mit.edu;
	spf=pass smtp.mailfrom=mit.edu;
	dkim=pass header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=Fo5lSTk9;
	arc=none smtp.remote-ip=18.9.28.11
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A545F606A31C
	for <dash@vger.kernel.org>; Wed, 11 Nov 2026 08:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A545F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=Fo5lSTk9
Received: from [192.168.9.110] (198-27-206-187.fiber.dynamic.sonic.net [198.27.206.187])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6AB8aPFs004328
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 11 Nov 2026 03:36:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1794386187; bh=UBNn+LYXzouI7nfjml3zrM+59Ynj+wIAIyABAQ+dTaA=;
	h=Message-ID:Date:MIME-Version:Subject:From:Content-Type;
	b=Fo5lSTk9KLK/4/CQgd+1yyYIEYSWWTRh+Bf2cRtj2k+dGYfkyPKnCF4pFEhikVanu
	 RojXy9lL6JXiXc4GSvTEvs/3IRkgS/gQ3r9DOO64DoVgfqLk6QJU1U05i6EfAtRvVV
	 YwA/HG08OaitukSWAeb7WKkRYH8RTQNpU/ezHlEJIznE6e6yn9JQJ9/zaxUA+7KSK0
	 qM2Nu2AEB8jAMNel5qDaeteZZ4QzrdFh1H3AAc+kWQlEMCH6mnLNzFm96rKoGCvXjQ
	 97PRssxMBOBr1GrzrJnnn1WDSMHGLi6amqzUnaoY3A2fVP1BmZiRkSNga3vlm1V2u5
	 6RbWM5l+V///g==
Message-ID: <6e24ef04-bdbe-4d7c-9ed4-993735c2439e@mit.edu>
Date: Wed, 11 Nov 2026 00:36:25 -0800
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
Subject: Re: [PATCH] var: Call setlocale when LC variables are set
To: Herbert Xu <herbert@gondor.apana.org.au>,
        Vladimir Kudrya <vladimir.csp@gmail.com>
Cc: dash@vger.kernel.org
References: <ai1MN3hk3ihI7FBf@gondor.apana.org.au>
Content-Language: en-US
From: "Anders Kaseorg" <andersk@mit.edu>
In-Reply-To: <ai1MN3hk3ihI7FBf@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/13/26 05:25, Herbert Xu wrote:
> @@ -101,6 +108,11 @@ struct var varinit[] = {
>   	{ 0,	VSTRFIXED|VTEXTFIXED|VUNSET,	"TERM\0",	0 },
>   	{ 0,	VSTRFIXED|VTEXTFIXED|VUNSET,	"HISTSIZE\0",	sethistsize },
>   #endif
> +	{ 0,	VSTRFIXED|VTEXTFIXED|VFULL|VUNSET, "LC_ALL\0",	changelocale },
> +	{ 0,	VSTRFIXED|VTEXTFIXED|VFULL|VUNSET, "LC_COLLATE\0", changelocale },
> +	{ 0,	VSTRFIXED|VTEXTFIXED|VFULL|VUNSET, "LC_CTYPE\0", changelocale },
> +	{ 0,	VSTRFIXED|VTEXTFIXED|VFULL|VUNSET, "LC_NUMERIC\0", changelocale },
> +	{ 0,	VSTRFIXED|VTEXTFIXED|VFULL|VUNSET, "LANG\0",	changelocale },

When one of these variables is unset, setvareq() drops VFULL from the 
flags here:

		else if ((vp->flags & VSTRFIXED))
			bits = VSTRFIXED;

So the setlocale() call is unexpectedly skipped.

> @@ -299,8 +324,8 @@ out_free:
>   	vp->text = s;
>   	vp->flags = flags;
>   
> -	if (vp->func && (flags & VNOFUNC) == 0)
> -		(*vp->func)(varnull(s));
> +	if (!(flags & VNOFUNC))
> +		varfunc(vp);

Since vp->text was already freed above, this leads to a use-after-free.

> @@ -536,8 +561,8 @@ poplocalvars(void)
>   				ckfree(vp->text);
>   			vp->flags = lvp->flags;
>   			vp->text = lvp->text;
> -			if (vp->func && !(vp->flags & VNOFUNC))
> -				(*vp->func)(varnull(vp->text));
> +			if (!(vp->flags & VNOFUNC))
> +				varfunc(vp);

Here as well: since vp->text was already freed above, this leads to a 
use-after-free.

Reproduction:

   $ export LANG=C.UTF-8
   $ dash -c 'x=ëë; LC_ALL=C; echo ${#x}; unset LC_ALL; echo ${#x}; 
LC_ALL=C; echo ${#x}'
   4
   2
   2

(Expected 4 2 4.)

Anders

