Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C19420B0F
	for <dash@vger.kernel.org>; Wed, 14 Aug 2024 20:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723665942; cv=none; b=Wgr2nrVl9t0pNsEF8MTdFIojTHUR9e9r7EofJAsZC0/5rF/SY6ik5BP1Dy58JIu6kPsOCiomDp6Sn5bYU2PXCpQAVRi8HqgUwmAw2ouUJ4mZygREHNPDQIRPem8gQ4qvKJO0HpS3DAVdkbb6F/hmjGmd0J+aDwgI4mos0iAIB5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723665942; c=relaxed/simple;
	bh=QygrsROvsm0L052Y0sPzT1pN4SDvd48pWiEja1PPRNs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References; b=q0CKmUykX47mCyMbU9lW2C0O9Wen8ikM8KadmL8q0VU/ui98BgHduIm7rJFInWNRKnO2uVS8qdbSSM0ZUn8R0jsXEhRT45wMJEySZrIEODrcHnLG+LpJeksfMEsG62ZC9ipoKGtJ69ssfljVCjZ1j+2dA5dxu4XQRXGbROz/dho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=pass smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=QhoORypa; dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=MFYhZltn; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="QhoORypa";
	dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="MFYhZltn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1723665934; x=1724332600; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:mail-followup-to:openpgp:blahblahblah:
  author:from:subject:date:to:cc:resent-author:resent-date:resent-from:
  resent-sender:resent-to:resent-cc:resent-reply-to:resent-message-id:
  in-reply-to:references:mime-version:content-type:
  content-transfer-encoding:content-disposition:content-id:
  content-description:message-id:mail-followup-to:openpgp:blahblahblah;
 bh=Ht3er/ZSiJF+3QXMVDq5BJjzAWeVY+4JXV7RIGdVfFs=;
 b=QhoORypaM4YNvSI2Aq33r0WpqK2sgbrtb8L6ICdRsTPjgPHDWGKLpH9lBlmbDj8KsghrLdof
  RS1l3Qg1QjN0mjTu2maWAy/rN3wa+5za5yK54MNxKqWAFaUA33u+Xr4oNaw6sLZ8+F1udhUeuP
  PzoP15k+Ddj1nzdtzVoSqTcEM+Ccw2yi8UadAcz6PItiqMlIlbEV8ZLCqJU0tt+qDLBypuqcon
  yZoEoBCNKJ4fQ74oVEYSdbhzZz6OG1wyLs+NYgysJZXPSnmgPmWFZGxKGl+D0kKk5AIoBya78q
  7NMIcRud6wo7Ra+Mz12yrw25NoPFNtxIXC3RyqX6UPqOOnCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=orange; t=1723665934; x=1724332600; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:mail-followup-to:openpgp:blahblahblah:
  author:from:subject:date:to:cc:resent-author:resent-date:resent-from:
  resent-sender:resent-to:resent-cc:resent-reply-to:resent-message-id:
  in-reply-to:references:mime-version:content-type:
  content-transfer-encoding:content-disposition:content-id:
  content-description:message-id:mail-followup-to:openpgp:blahblahblah;
 bh=Ht3er/ZSiJF+3QXMVDq5BJjzAWeVY+4JXV7RIGdVfFs=;
 b=MFYhZltnhnevMWfYn9fBRkvYcd1Z78SmauxDFYcNkMLHwvZ0X7pLjcmpifl6iyjKvjKk02XV
  FtLeKUnnFkobBw==
Date: Wed, 14 Aug 2024 22:05:34 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: Chet Ramey <chet.ramey@case.edu>
Cc: dash@vger.kernel.org, busybox@busybox.net, bug-bash@gnu.org,
 Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: Re: Question on $@ vs $@$@
Message-ID: <20240814200534.Vh3Eu_Md@steffen%sdaoden.eu>
In-Reply-To: <1bba673e-5ab9-4263-9d88-124854793b4b@case.edu>
References: <20240814004525.A7mNIdWf@steffen%sdaoden.eu>
 <1bba673e-5ab9-4263-9d88-124854793b4b@case.edu>
Mail-Followup-To: Chet Ramey <chet.ramey@case.edu>, dash@vger.kernel.org,
 busybox@busybox.net, bug-bash@gnu.org,
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

Hello.

I only respond to this to reduce the noise.

Chet Ramey wrote in
 <1bba673e-5ab9-4263-9d88-124854793b4b@case.edu>:
 |On 8/13/24 8:45 PM, Steffen Nurpmeso wrote:
 |> I include bug-bash even though i think bash is correct, but there
 |> lots of people of expertise are listening, so, thus.
 |> Sorry for cross-posting, nonetheless.
 |> Given this snippet (twox() without argument it is)
 |> 
 |>    one() { echo "$# 1<$1>"; }
 |>    two() { one "$@"; }
 |>    twox() { one "$@$@"; }
 |>    two
 |>    two x
 |>    twox
 |>    twox x
 ...
 |When, as in this case, the result would be split if the double quotes
 |weren't there, $@ within double quotes expands to nothing if there are
 |no positional parameters, no matter how many times it appears.

As was shown there is standard wording which makes this case
explicitly unspecified.  Thanks for pointing this out.  I should
have reread the standard first (that particular wording is hard to
grasp for me).
And yes, i think bash is doing the more sensitive thing here, as
the standard says that "@" shall expand to zero, and zero plus
zero makes zero for me.

Thank you, and sorry for the noise.

Ciao,

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
