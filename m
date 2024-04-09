Received: from smtp.ouvaton.coop (smtp.ouvaton.coop [194.36.166.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FE012A173
	for <dash@vger.kernel.org>; Tue,  9 Apr 2024 10:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.36.166.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657844; cv=none; b=tAFvhunzYLiVHvTifUCywNp8+BYfwHlkF/8jDazRhs/Xhltm33Go0maT0pFbeZFaz+xcNqLO9suHJdcz0l6i3iPS36gOj2OsYKYvZRkGhaGZMJogju43/JCOMdpUI+QG3r/faEqA3f68DkDbRHge83H3VtRiWa6hd2zHSJqTxwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657844; c=relaxed/simple;
	bh=HWxbs867PGIA8seUgtuSKiCLercBzXMOog2/dac9nx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U2AZfxsfBtJkar6qf7SNwCCXWXc0Whe2f0c4wqXYA4yQSDTuNhBd/KyfPcBK28w8jbdGynSinHuBej6h5IECAaKvF8AQFCgMmQxmMQKhDKI4wh0k5HaR7XcGD/fQuVxIGwps38MeCw56EKJJxV4wZIstpGaptRyxgWJX83iqBWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martymac.org; spf=pass smtp.mailfrom=martymac.org; arc=none smtp.client-ip=194.36.166.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martymac.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=martymac.org
Received: from [192.168.1.5] (82-65-236-134.subs.proxad.net [82.65.236.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ouvalternc.octopuce.fr (Postfix) with ESMTPSA id DEFDA24FB0;
	Tue,  9 Apr 2024 12:11:43 +0200 (CEST)
Message-ID: <50a0e01b-eaae-4de8-a1ee-fc380b33d6f6@martymac.org>
Date: Tue, 9 Apr 2024 12:11:43 +0200
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] jobs: Allow monitor mode without a tty in
 non-interactive mode
Content-Language: en-US, fr
To: Steffen Nurpmeso <steffen@sdaoden.eu>,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org, Jilles Tjoelker <jilles@stack.nl>
References: <dedaa3fa370ea9c4aeb1771b5568a7bef4065b04.1675113321.git.steffen@sdaoden.eu>
 <ZhJhpbIEe1RyBfk0@gondor.apana.org.au>
 <20240408225420.hz8nC3ly@steffen%sdaoden.eu>
From: Ganael Laplanche <ganael.laplanche@martymac.org>
In-Reply-To: <20240408225420.hz8nC3ly@steffen%sdaoden.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/24 00:54, Steffen Nurpmeso wrote:

Hello Herbert, Steffen,

> Running the script with it has the desired result.

Sorry for the delay. Indeed, I can confirm it works like a charm:

$ cat test_pgid.sh
set -m
(
   sleep 1
) &
i=$!
echo "Main shell has: $(ps -o pid,pgid $$)"
echo "Sub-shell has: $(ps -o pid,pgid $i)"
wait $i

$ dash test_pgid.sh &
$ Main shell has:   PID  PGID
80074 80074
Sub-shell has:   PID  PGID
86666 86666
[1] + Done                       (sleep 1)
[1]   Done                    dash test_pgid.sh

As a consequence, fpsync[1] can now be started in the background, great!

Thanks a lot to both of you :)

Cheers,

Ganael.

[1] https://www.fpart.org/fpsync/

-- 
Ganael LAPLANCHE <ganael.laplanche@martymac.org>
http://www.martymac.org | http://contribs.martymac.org
FreeBSD: martymac <martymac@FreeBSD.org>, http://www.FreeBSD.org
