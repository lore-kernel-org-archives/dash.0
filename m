Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D27013A244
	for <dash@vger.kernel.org>; Wed, 18 Sep 2024 21:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726693515; cv=none; b=B4WQKgIiCMM/L9J7B72TLgu9h/Fl+Xf+5IWW4Oy3prZZ7NqC5HGtUbIltxijpT+TYOaLgtdnby3H3lv2H7iMZxoDVfHh+PZ2DKtf0jkyDHNIeL5leER6PKuSWtuDIdqj4dn+vS5o1cl0G6Pgk/bkv1RL/JntA3pIxrKXnoSqwYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726693515; c=relaxed/simple;
	bh=b0Q26dT6FVJhu3EFEX5CNhzNepS4gkg1I2PnY3sgNMU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWLSfwzvhkHnzpP6SRi803cmcjgYsAHV94enquXVTqC7wVrIm8/B3yiSgx18LIt/TdEf8d3oQLSMzIUWeC2SgjT2vTepk0FXOEgNQdTLfqhpZw6eB7GZv6sIh4nFVuYJpMTUwPMaFWWY0n6y+ljFDlVieNyYcaPpUkXqA8O8S+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=pass smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=FQZ7ZeXe; dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=52q3+7pN; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="FQZ7ZeXe";
	dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="52q3+7pN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1726693507; x=1727360173; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:mail-followup-to:openpgp:blahblahblah:
  mime-version:content-type:content-transfer-encoding:author:from:subject:
  date:to:cc:resent-author:resent-date:resent-from:resent-sender:resent-to:
  resent-cc:resent-reply-to:resent-message-id:in-reply-to:references:
  mime-version:content-type:content-transfer-encoding:content-disposition:
  content-id:content-description:message-id:mail-followup-to:openpgp:
  blahblahblah; bh=aDsNi/L5Ndv9wfGsxatoqXMoxDS63bT0FYg28IU7Kwg=;
 b=FQZ7ZeXeu+N0hsNpl2SLkdv1kIphYtDob/5gMRskHxTyIKXEc4k7MZpZN3922WhmKAyM2NNb
  zGyxKWFNWIKlwxoT2c8v6sXv5J00iaqyGOTf8T/cDCr0i4kfF4S8jal5J/AA0ZfzPI5m7hr1t4
  ESqEePrSBmKiX8LtQSdkZlxOvp0bu9K+AFSqZRnjZFeiYqMa3HxUmprJWHkuumxJzcxgtObP/+
  d8a1q531uTNWc6OaGEOqRfR9in77G9+HYXfBozkd6BY+1NoOQWU4taozNGYC8W0H18Mc6vU8X0
  vdBOV5oR1zxUwbzP8Z4tM0J6WN5+IpgX5CbWaCq6GnERXXzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=orange; t=1726693507; x=1727360173; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:mail-followup-to:openpgp:blahblahblah:
  mime-version:content-type:content-transfer-encoding:author:from:subject:
  date:to:cc:resent-author:resent-date:resent-from:resent-sender:resent-to:
  resent-cc:resent-reply-to:resent-message-id:in-reply-to:references:
  mime-version:content-type:content-transfer-encoding:content-disposition:
  content-id:content-description:message-id:mail-followup-to:openpgp:
  blahblahblah; bh=aDsNi/L5Ndv9wfGsxatoqXMoxDS63bT0FYg28IU7Kwg=;
 b=52q3+7pN+ivTUCEaK26/gbxW0HJSqoorl/8kAUUfYxFaDTunwPrXh2oIW/Y16DkQfoafsI9e
  7Ps9LRNW9IkJCA==
Date: Wed, 18 Sep 2024 23:05:06 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: =?utf-8?B?T8SfdXo=?= <oguzismailuysal@gmail.com>
Cc: dash@vger.kernel.org, busybox@busybox.net, bug-bash@gnu.org,
 Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: Re: Question on $IFS related differences (Was: Question on
 $@ vs $@$@)
Message-ID: <20240918210506.9rRUe2TG@steffen%sdaoden.eu>
In-Reply-To: <CAH7i3Lq9xQnnkAO7cd5XZEsV4jY+Va6uWqjw3yaMi=A3mdh83g@mail.gmail.com>
References: <20240918011443.AVR6sOQ3@steffen%sdaoden.eu>
 <CAH7i3Lq9xQnnkAO7cd5XZEsV4jY+Va6uWqjw3yaMi=A3mdh83g@mail.gmail.com>
Mail-Followup-To: =?utf-8?B?T8SfdXo=?= <oguzismailuysal@gmail.com>,
 dash@vger.kernel.org, busybox@busybox.net, bug-bash@gnu.org,
 Steffen Nurpmeso <steffen@sdaoden.eu>
User-Agent: s-nail v14.9.25-608-ge479530e8d
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

O=C4=9Fuz wrote in
 <CAH7i3Lq9xQnnkAO7cd5XZEsV4jY+Va6uWqjw3yaMi=3DA3mdh83g@mail.gmail.com>:
 |On Wed, Sep 18, 2024 at 4:19=E2=80=AFAM Steffen Nurpmeso <steffen@sdaoden=
.eu> \
 |wrote:
 |>
 |
 |It boils down to this:

In this case, ok .. i have not spent time trying to vaporise it.
I haved added this standalone thing to my tests.

 |  f(){ echo $#;}; set "" "" ""; IFS=3Dx; f $*
 |
 |bash, NetBSD and FreeBSD sh, and ksh88 all agree and print 2. pdksh
 |prints 3 but mksh and oksh print 1. dash, ksh93, yash, and zsh print
 |0.

I am totally surprised they all swallow this code, there is no
separating whitespace in between the ; and the } which closes the
function -- isn't that invalid syntax even??

 --End of <CAH7i3Lq9xQnnkAO7cd5XZEsV4jY+Va6uWqjw3yaMi=3DA3mdh83g@mail.gmail\
 .com>

Thanks a lot for the impetus!

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
