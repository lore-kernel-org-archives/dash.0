Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82FB3C17
	for <dash@vger.kernel.org>; Wed, 20 Aug 2025 00:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.205.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755650465; cv=none; b=hoxPahUV9VIM7ZMbd8iG2c5V11QW9YBlHSMqmS0w3FJ3DiVz0GkFrLP6hmJnN6nGrKCymc4QOcox/tJMK9MhW/ye3rH2vkT4kT8PXUiZt4StWptVjN2iVsXSW/zjsL5/L61Y8US7uh0EEwa/g3I9737N6eO8vXd6MT/UIpAsbOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755650465; c=relaxed/simple;
	bh=NopvjrGOjel+E/ImEFlRvcRYORPLcnAj5HMePfU2kaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qHNdfOeKUg8Z0bSXL3j7K0kha1R8oLDlN2sOqPWKGbBj9MS4TmxbfxIHGH/sXXYbc+v9Qbl/lK0BobSwuoLTRLo1AbjOKpJhnw6h0XV0N9bivqCnpQLzhcgfXcyr+yAgWaFMd62qXP1Qh1Mq5nFy1zoV924Gx58IFmBhWUMAdlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=1POknJzh; arc=none smtp.client-ip=93.188.205.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="1POknJzh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1755650050;
	bh=NopvjrGOjel+E/ImEFlRvcRYORPLcnAj5HMePfU2kaY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=1POknJzhXra1NlPELylQhL6VlRBWlgD/JQtRvpoqmXHdd49dHDtkmIV2QLi1CoWDi
	 G207IuV/hRii6gvpdX9UGEEFtUmAtjA9App3f24hHd5HqaHxkd90J3q3MemJ1evqnd
	 VKvfTFePCDQFpIVAUQNR7l+zr//mdm7G5TiRlK/dtgqsdMwcSLkzZet58S8WyICfNj
	 oiWGezZ6hvpe5U1ImqWKhNgHV3s95iNAgt6NaXK1E1FfW0xxsWKRT3X2vB9HzQbYw9
	 ylMLXr/4lPAWWedNj3u4ZK44F7MbfquNcpHa3BT5rorUsJWQ3xqg0IkadKp6tFuiq6
	 RBgZsqESRKXsg==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id 09A821F93D;
	Wed, 20 Aug 2025 03:34:10 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.177.185.211])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Wed, 20 Aug 2025 03:34:09 +0300 (MSK)
Received: from [10.198.30.115] (unknown [10.198.30.115])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4c66rL5sCzz1J9kb;
	Wed, 20 Aug 2025 03:33:38 +0300 (MSK)
Message-ID: <024b5e9f-6112-4224-b095-f7e54b8971b4@astralinux.ru>
Date: Wed, 20 Aug 2025 03:33:32 +0300
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: RuPost Desktop
Subject: Re: [PATCH] left shift of negative value do_binop
 src/arith_yacc.c:111:12
Content-Language: ru
To: Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org
References: <1abb4964-b5ee-42d8-bbb8-959594d61665@astralinux.ru>
 <e79e39bc-02b8-4ad7-ba03-7e4d00061c3e@astralinux.ru>
 <3a37b273-3da1-45f6-a303-3c0796bd0532@gigawatt.nl>
From: Aleksander Ushakov <aushakov@astralinux.ru>
In-Reply-To: <3a37b273-3da1-45f6-a303-3c0796bd0532@gigawatt.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: aushakov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 64 0.3.64 96c1edcdaeab4cf6c1fd6858be74d3893179d628, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, new-mail.astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;astralinux.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 195652 [Aug 19 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/08/19 23:05:00 #27677346
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1


01/08/25 00:50, Harald van Dijk wrote:
> On 31/07/2025 19:49, Aleksander Ushakov wrote:
>> There is a fix of the problem:
>>
>> diff --git a/src/arith_yacc.c b/src/arith_yacc.c
>> index 1a087c3..e23060d 100644
>> --- a/src/arith_yacc.c
>> +++ b/src/arith_yacc.c
>> @@ -108,7 +108,9 @@ static intmax_t do_binop(int op, intmax_t a, 
>> intmax_t b)
>>          case ARITH_SUB:
>>                  return a - b;
>>          case ARITH_LSHIFT:
>> -               return a << b;
>> +               if (a < 0)
>> +                       yyerror("left shift of negative value");
>> +               return (intmax_t)a << b;
>>          case ARITH_RSHIFT:
>>                  return a >> b;
>>          case ARITH_LT:
> If other major shells already issued an error here, this change would 
> look fine (except again incomplete -- there is a lot more potential to 
> trigger sanitizer messages in this file), but as other major shells 
> accept this, I think dash should continue to accept this too.
> 
> Cheers,
> Harald van Dijk

Well, if we take bash with UBSAN instrumentation and try to use a 
similar command with a negative number shift to the left, then at least 
we won't get a sanitizer error. Yes, you can remove the message that 
this shift is invalid, but it is still UB to perform this shift 
according to the C standard. I mean, a check should be added here so as 
not to trigger UBSAN, as it is done in bash.
