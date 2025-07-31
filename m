Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7826620B22
	for <dash@vger.kernel.org>; Thu, 31 Jul 2025 21:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753998665; cv=none; b=Ik9LTRXO9973rxI0r5du0px8aSvT7NogjGhn/uI914Tu8K3hEBYb2UH+387kveRP5kGIlo12pOtvRX44KYbg0SyBmk7W0cOnZefCb9Bo50/FH/hB5hsaJ4HrcVpWjTlWiA01QGW3DQcH7+3QzvESZBixEXc5tPN/uoImWDZFcQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753998665; c=relaxed/simple;
	bh=OkYiUxVo6Ja+2LnTIiuPrgYhBRxl56bfh7Z7SxCq6xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=osGc+2AHWbJG5ILAQ20EiUeDT5dOTnmzEVUvG2T1j68zQtQ9B0E3Ys8zPf4C1GE84BtEeHXHc07f8ZJxYCoCXOCNdrUCyKLRvTfUXsRGQrc2Mn3se8FADP1muVLf9yjxGmOD4fr9d2/P3mW/9SAPDINNfh2o9t7/a2trriSJ8qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=WlN/bU71; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="WlN/bU71"
Received: from [192.168.178.21] (unknown [31.94.68.113])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id 15970140;
	Thu, 31 Jul 2025 22:51:01 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 15970140
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1753998661;
	bh=KFphw5oWMellJRdg/NPT/DNrmu+0eIbwq3bxeNIGZK4=; l=1086;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=WlN/bU71MOLEgS1A/EtUVelIOBMVwWhmS9Rs8M6mBe6bh8BfkWWpF5Ugx1ApxYfkx
	 CgPQOCo/X3fab+Y1r/c6CSGGkv/gUYjscXb1m2kEveZU8tsVP0Op2/s4F5paon/186
	 ev1ij7V+mEd+PDtPg/OXD5hkNGzgnArBv5UI3g1w=
Message-ID: <3a37b273-3da1-45f6-a303-3c0796bd0532@gigawatt.nl>
Date: Thu, 31 Jul 2025 22:50:59 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] left shift of negative value do_binop
 src/arith_yacc.c:111:12
Content-Language: en-GB
To: Aleksander Ushakov <aushakov@astralinux.ru>, dash@vger.kernel.org
References: <1abb4964-b5ee-42d8-bbb8-959594d61665@astralinux.ru>
 <e79e39bc-02b8-4ad7-ba03-7e4d00061c3e@astralinux.ru>
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <e79e39bc-02b8-4ad7-ba03-7e4d00061c3e@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31/07/2025 19:49, Aleksander Ushakov wrote:
> There is a fix of the problem:
> 
> diff --git a/src/arith_yacc.c b/src/arith_yacc.c
> index 1a087c3..e23060d 100644
> --- a/src/arith_yacc.c
> +++ b/src/arith_yacc.c
> @@ -108,7 +108,9 @@ static intmax_t do_binop(int op, intmax_t a, 
> intmax_t b)
>          case ARITH_SUB:
>                  return a - b;
>          case ARITH_LSHIFT:
> -               return a << b;
> +               if (a < 0)
> +                       yyerror("left shift of negative value");
> +               return (intmax_t)a << b;
>          case ARITH_RSHIFT:
>                  return a >> b;
>          case ARITH_LT:
If other major shells already issued an error here, this change would 
look fine (except again incomplete -- there is a lot more potential to 
trigger sanitizer messages in this file), but as other major shells 
accept this, I think dash should continue to accept this too.

Cheers,
Harald van Dijk
