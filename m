Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51AB4A1A
	for <dash@vger.kernel.org>; Tue, 27 Aug 2024 00:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724718505; cv=none; b=h1st5/B5G0nmwMAKu8hAZrLBDJVL2PpI3RUGhNbiUmdGjXznYyra3FPDfnv1PnJhIiRuQBHqdSiFG2ThzibZXuWA7OKDbWTgQcjDTfZQicHWCPhxIW+4l2to26Rfc9Kfypmp0hK9LX14I4wC/cvMjMhB+Kj8eqMt1zm87o7sIck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724718505; c=relaxed/simple;
	bh=ljH/iubztHu1I5fXEho9VJm4PyIiDe8VKOUSVTiWugE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References; b=J2Mi8efw6LB45ElwiHDhef5ZZzRrF1QUYhnT4vUW2e7CzODuXj35kP/kaTZlnDzBYSBU66iNjP9ACkajqDURyxkOjeUM4PvwdnBjOvEwwYwXmx2ASoKSQ/LOeQ0BCm/cQpNN2zZf13tg7Q/76jg51GI+wt3M4M491cnlWZwR2Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=pass smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=kTboEF92; dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=dCxytmPG; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="kTboEF92";
	dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="dCxytmPG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1724718492; x=1725385158; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:mail-followup-to:openpgp:blahblahblah:
  author:from:subject:date:to:cc:resent-author:resent-date:resent-from:
  resent-sender:resent-to:resent-cc:resent-reply-to:resent-message-id:
  in-reply-to:references:mime-version:content-type:
  content-transfer-encoding:content-disposition:content-id:
  content-description:message-id:mail-followup-to:openpgp:blahblahblah;
 bh=X3wHfDdDXxdj8DDBGf6ZnLzF9ECGVlXRtIO7ZVxhtxA=;
 b=kTboEF92LGdiunYhAnf9woxVS8OYfQBDGH07K/RyykLctUS3W+FlkRX+knUX0V6AxemcTxiB
  Ne4eP3y0IsTGV6vOUk18I+H4gwqc7A5Gv7u7brdpL84jVN1QTEhnVxXS5KxOwaQC4nG8YI0XXb
  DhvT/14jGh++mmCKfCGKebLcZO+6FFuMiiSdrdHe6GdIO/py5QMeo5sCn4U+r2W8xirVzYojce
  Ti0W6ZvzLdpK1TE4310THh9OE/E5dmuIjgfK3kRMmOJrxzrxoM7JVyGg1VmjuuFMZTxFgX1x/V
  Q8/gjFTQXMT1evWCV1ykMdGwTgPsi0aluxM19ZfZFxrz5QXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=orange; t=1724718492; x=1725385158; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:mail-followup-to:openpgp:blahblahblah:
  author:from:subject:date:to:cc:resent-author:resent-date:resent-from:
  resent-sender:resent-to:resent-cc:resent-reply-to:resent-message-id:
  in-reply-to:references:mime-version:content-type:
  content-transfer-encoding:content-disposition:content-id:
  content-description:message-id:mail-followup-to:openpgp:blahblahblah;
 bh=X3wHfDdDXxdj8DDBGf6ZnLzF9ECGVlXRtIO7ZVxhtxA=;
 b=dCxytmPG6b0tMGEvncbrN9DZxyDtafiEwFPYpOVPkZJqlCAVo7I2Mx0rZfYQKnsWf7D9p9o1
  YYG4Y4wN1W9JCw==
Date: Tue, 27 Aug 2024 02:28:09 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: alex xmb sw ratchev <fxmbsw7@gmail.com>
Cc: dash@vger.kernel.org, busybox@busybox.net,
 bug-bash <bug-bash@gnu.org>, Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: Re: Question on $@ vs $@$@
Message-ID: <20240827002809.UTh0pE75@steffen%sdaoden.eu>
In-Reply-To: <CAALKErGQcz=LS=xC544fXf9OywVmU32s1R-wSKzVTiavQTHZ6Q@mail.gmail.com>
References: <20240814004525.A7mNIdWf@steffen%sdaoden.eu>
 <CAALKErGQcz=LS=xC544fXf9OywVmU32s1R-wSKzVTiavQTHZ6Q@mail.gmail.com>
Mail-Followup-To: alex xmb sw ratchev <fxmbsw7@gmail.com>,
 dash@vger.kernel.org, busybox@busybox.net, bug-bash <bug-bash@gnu.org>,
 Steffen Nurpmeso <steffen@sdaoden.eu>
User-Agent: s-nail v14.9.25-599-g5c75a327b2
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

alex xmb sw ratchev wrote in
 <CAALKErGQcz=LS=xC544fXf9OywVmU32s1R-wSKzVTiavQTHZ6Q@mail.gmail.com>:
 |try
 |
 |${@@Q}
 |
 |and
 |
 |${*@Q}
 |
 |greets

I try to avoid using non-portable shell stuff.
I do not think these would be understood by the ash shell variants
(and ksh) which had results other than bash.

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
