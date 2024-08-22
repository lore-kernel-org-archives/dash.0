Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEF816C854
	for <dash@vger.kernel.org>; Thu, 22 Aug 2024 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724366174; cv=none; b=Kurxc0c83gV1mqjbsU93ya1F7K7l93WwS28ZHzIjAxGE/qF/OgV3fJ7dc9gF2PF2uT+fAuGQAFqW/ysWxnZYEhgG3uEeBDPWfTWMuOJ5uZ/BUj03FMiiEGGKpeg3vGoi0bcGGt6rZdkEU5VO7dOPfXKsyNR1bcp5vWjg9NkFB74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724366174; c=relaxed/simple;
	bh=lcUiD6sxf54VJYIUj2jz29fOhCorbzLhXP7CMsIUGk8=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References; b=EamkdGwAk1QqjIIv6DwnNBNOLIpdNu+37cwgrVjKLLHIASJnRYBmo36UQ4j2eWKQBMOpfBbgkLEYpCTrRegA7jRnPVW8L2tJujr87QvnqoFRDMvGVHbHsH6X4sW+o+ESbhofjHChkPbrUeje9+kKf6pC0sp0cUYrsT2Lv3d1UIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=pass smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=GxX2SmvN; dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=XE34caVz; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="GxX2SmvN";
	dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="XE34caVz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1724366167; x=1725032833; h=date:author:from:to:subject:
  message-id:in-reply-to:references:openpgp:blahblahblah:author:from:
  subject:date:to:cc:resent-author:resent-date:resent-from:resent-sender:
  resent-to:resent-cc:resent-reply-to:resent-message-id:in-reply-to:
  references:mime-version:content-type:content-transfer-encoding:
  content-disposition:content-id:content-description:message-id:
  mail-followup-to:openpgp:blahblahblah;
 bh=t41m1TZOclgmOwZePGombDYEjXNFbwNJPRrshsG2PSY=;
 b=GxX2SmvN0BnDn3d48081pd53/6BnSeFCJ40U4Vxs41hfdBpiCOnBl9DeIvuS5EEqHb70Wg1b
  fHzyBpMXmaovBkCz9ldyQnzsb/QFsWY60IXouae7S/Nd7tCWLH1dvF2V4bmiLu21dV1M/t/x85
  t2HaX6tLgOFsn4GQXF+e9hKwCUlzMAZUjMp++18qEVtJ86KlGHDYjspdW5/CZ3Egh5FeYy5EeG
  rV+r6vsKSI6xlsAoEIzqo3gPJ8kwc5FrqUXDpjuDh5QxHcESev8RQKE6ssP2HE0Cv0Xbq5NJjY
  Y3KhNMfzaytXBHQAv6Aw+TyYEH9OeuwO8B0W7+QpSwHkGjgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=orange; t=1724366167; x=1725032833; h=date:author:from:to:subject:
  message-id:in-reply-to:references:openpgp:blahblahblah:author:from:
  subject:date:to:cc:resent-author:resent-date:resent-from:resent-sender:
  resent-to:resent-cc:resent-reply-to:resent-message-id:in-reply-to:
  references:mime-version:content-type:content-transfer-encoding:
  content-disposition:content-id:content-description:message-id:
  mail-followup-to:openpgp:blahblahblah;
 bh=t41m1TZOclgmOwZePGombDYEjXNFbwNJPRrshsG2PSY=;
 b=XE34caVzp4Imdcuid0gFJNe+vAj0qydOGXTY97GYG6uSO+JkLz8VW/ojBkBlHIKJnXutZ+LR
  G8xnH8VXt3bzCA==
Date: Fri, 23 Aug 2024 00:36:05 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: dash@vger.kernel.org
Subject: Re: IFS bug (maybe)
Message-ID: <20240822223605.I-SOv1qq@steffen%sdaoden.eu>
In-Reply-To: <20240822222119.ijDODf_7@steffen%sdaoden.eu>
References: <20240822222119.ijDODf_7@steffen%sdaoden.eu>
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

Steffen Nurpmeso wrote in
 <20240822222119.ijDODf_7@steffen%sdaoden.eu>:
 |  IFS="\012"; echo "$*"$*; a $* "$*";
 ...
 |  -a\b\ca b c

(you all realize it is because of the bogus assumption that octal
is expanded within "" when setting $IFS; i have had $'', but
released dash etc do not support that yet, so i did that.)

  ...
 --End of <20240822222119.ijDODf_7@steffen%sdaoden.eu>

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
