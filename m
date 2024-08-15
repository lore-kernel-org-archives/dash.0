Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CA978C73
	for <dash@vger.kernel.org>; Thu, 15 Aug 2024 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723747752; cv=none; b=ox41HfuM/thjEWlqZhyxVopQhRebhEE9pWi239y7eJIGuj8jeuwe6Vym27YyO+JYzQb9T55sdUvBYiwCXVn2ZbhVhyaLB++NEuOD/9foAm4HJfqeFXdCGSh7e1gwJMOnAul8V4AavguV7u22vzvYEA+eSmhdwxmBeMVnunzonNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723747752; c=relaxed/simple;
	bh=XAYCDl432FJDr4mEGzw/xkqc/N7aSznvfo7Xe+d3X4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References; b=hoivhaJWzdpX24w3LRwOCSDqIvzhyVJBUA8g93p+WUJO2tzg9AXvsbnYm9xTo3wh1K+J2iUUZLAmTRVXLFIPR8P7py7p7EkJgfW0xZ1UhsDDJ3Q51IOeFqR/XINBHi4EdrfcozCIS+8kjnUzLJmcIj9ELVih2ahZJfH1yL4pZY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=pass smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=K0AX1JWH; dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=hyz8rOv6; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="K0AX1JWH";
	dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="hyz8rOv6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1723747739; x=1724414405; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:mail-followup-to:openpgp:blahblahblah:
  author:from:subject:date:to:cc:resent-author:resent-date:resent-from:
  resent-sender:resent-to:resent-cc:resent-reply-to:resent-message-id:
  in-reply-to:references:mime-version:content-type:
  content-transfer-encoding:content-disposition:content-id:
  content-description:message-id:mail-followup-to:openpgp:blahblahblah;
 bh=ayrNVUN5jiuuO0WnnSFIuTf3GBSibU5rkk59oHG3qfk=;
 b=K0AX1JWHu21jGx06/XQmgC5zMZFgledMgZRzKD4cUqed2ZBFV02CGnPfjqIvqskPKmyT9wKm
  LDXAAEzstReTevzZoq8s3drYDzXSDzWtEFfSuvx61g9T5POv6FmCRgXnW28ApdNjrcuwPIwqVP
  kl1WFZcFk5st5rD8kBF8Kngax1/sqBV/vYHRGM0PeCBJMlGCVAExpmA5rcG0f5/RzgWqh1G6oz
  9qHRY6v8SOJiEsdI4gCxjKlUR5Vy69Jjf6t0fPo3+E6FWuYvUfBIo9Akl+dacbeEI+luhxea40
  oFGUCFFFsMa8eUIHOJn+/GqsuAkKl4IuSY+vW9jG/K34R+mQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=orange; t=1723747739; x=1724414405; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:mail-followup-to:openpgp:blahblahblah:
  author:from:subject:date:to:cc:resent-author:resent-date:resent-from:
  resent-sender:resent-to:resent-cc:resent-reply-to:resent-message-id:
  in-reply-to:references:mime-version:content-type:
  content-transfer-encoding:content-disposition:content-id:
  content-description:message-id:mail-followup-to:openpgp:blahblahblah;
 bh=ayrNVUN5jiuuO0WnnSFIuTf3GBSibU5rkk59oHG3qfk=;
 b=hyz8rOv6LXge5+3KNwU2TD80RPc5wnEtgTG/BmHQnsAKvlT6LQIDcMqXm8b8Dmkw8FsLLkVv
  Z5/GYGwPdsPxBA==
Date: Thu, 15 Aug 2024 20:48:58 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: Chet Ramey <chet.ramey@case.edu>
Cc: dash@vger.kernel.org, busybox@busybox.net, bug-bash@gnu.org,
 Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: Re: Question on $@ vs $@$@
Message-ID: <20240815184858.r5T_UQnM@steffen%sdaoden.eu>
In-Reply-To: <20240814200534.Vh3Eu_Md@steffen%sdaoden.eu>
References: <20240814004525.A7mNIdWf@steffen%sdaoden.eu>
 <1bba673e-5ab9-4263-9d88-124854793b4b@case.edu>
 <20240814200534.Vh3Eu_Md@steffen%sdaoden.eu>
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

Unfortunately i have to add one thing to this thread..

Steffen Nurpmeso wrote in
 <20240814200534.Vh3Eu_Md@steffen%sdaoden.eu>:
 |Chet Ramey wrote in
 | <1bba673e-5ab9-4263-9d88-124854793b4b@case.edu>:
 ||On 8/13/24 8:45 PM, Steffen Nurpmeso wrote:
 ||> I include bug-bash even though i think bash is correct, but there
 ||> lots of people of expertise are listening, so, thus.
 ||> Sorry for cross-posting, nonetheless.
 ||> Given this snippet (twox() without argument it is)
 ||> 
 ||>    one() { echo "$# 1<$1>"; }
 ||>    two() { one "$@"; }
 ||>    twox() { one "$@$@"; }
 ||>    two
 ||>    two x
 ||>    twox
 ||>    twox x
 | ...
 ||When, as in this case, the result would be split if the double quotes
 ||weren't there, $@ within double quotes expands to nothing if there are
 ||no positional parameters, no matter how many times it appears.
 |
 |As was shown there is standard wording which makes this case
 |explicitly unspecified.  Thanks for pointing this out.  I should
 |have reread the standard first (that particular wording is hard to
 |grasp for me).
 ...

In fact Geoff Clare (who we all deserve thanks, together with Don
Cragun, for continued ISO C compiler support for the BSD socket
interface we all use in at least POSIX environments, it is
undefined anywhere else!, and more) sees this differently:

  The standard clearly requires "$@$@" to generate zero fields if
  there are no positional parameters. The quoted text "if the
  expansion is embedded within a word which contains one or more
  other parts that expand to a quoted null string, ..." does not
  apply because there are no other parts that expand to a quoted
  null string. (The second $@ is not a candidate for being such
  a part because "the expansion of '@' shall generate zero
  fields".)

  If this does not match existing behaviour in some shells, we
  could consider making it unspecified, but the first step should
  be to alert the maintainers of those shells to the issue and
  find out whether they are willing to change their shell to
  comply with the standard.

So please any shell maintainer listening here, please feel
alerted.

(P.S.: regarding

  > I'd still love to know what the script's intent is.

It will be a test.  My MUA does not yet apply word splitting for
unquoted variable expansions, and while going that road, there was
a pitfall.)

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
