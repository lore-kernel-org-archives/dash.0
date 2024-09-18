Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4727F4405
	for <dash@vger.kernel.org>; Wed, 18 Sep 2024 01:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726622876; cv=none; b=F5x9pIY4GOb9gIwYNgttMNkrOpOxzzAtWzZvgmOphHpEweU9YV7Mnbmg1uLWJQCGEcv1aVye0LGtqKMfEC6fe34IgQyDVMYxtuTIkdzvST6cZuA9PJrfplfGK+83ATrF5iqLWO1cUS2ipfd6mQBqUMwFOlZeVfkWuU179dSefro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726622876; c=relaxed/simple;
	bh=aw5BeoNYPRwtmKzMTyQHQ7iqMoFYcO0u1BRd9Nl8/rw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GEsX0KrySAMNqQSgqhEqoJFuuHebbiBZ5JKZwsHgEHZAxk+h4K5rKLVL5fmrsKdQHoEJYVYmKzgIBQ2LYpjo2OXDFIT6AAi/uViP1VMCnK33Dv3E1CFba3P/9AoGbyIpU4bMOg9mD5N+aTmQHJgLLT3ekm0TlIOIeAWiQdN4RSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=pass smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=EtkY1sDg; dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=thOsWluk; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="EtkY1sDg";
	dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="thOsWluk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1726622322; x=1727288988; h=date:author:from:to:cc:subject:
  message-id:mail-followup-to:openpgp:blahblahblah:author:from:subject:date:
  to:cc:resent-author:resent-date:resent-from:resent-sender:resent-to:
  resent-cc:resent-reply-to:resent-message-id:in-reply-to:references:
  mime-version:content-type:content-transfer-encoding:content-disposition:
  content-id:content-description:message-id:mail-followup-to:openpgp:
  blahblahblah; bh=htF+rDwY3DxUmwNSMU3FGPfu+pTEklXfUHtIWHkRXDY=;
 b=EtkY1sDg4um1ewV4ntMVKeuRqt/ISiHlSklXC/Vox64t7M7u1cFW0YhtWqbaPWcEXZ1ApuHQ
  By44uoJ1fzm/29RcnHaJaxxwTcFuIEbdc4RB6BmDBbQHe75SQR1bNZ2pMylNqC6deDOVrWe4Bn
  U4Wt3qqw/AfcEj697ma5NfgotWxeaPsfSYAyBnKUsY3/nTg9MivG1KILywg0/Ao1u0Pn9upazv
  oJ+Vfabv5drfydELdoKPQKz3EgF0GNWux1DTArP/PVdMW4bCHsCAg5R0IbHjUgcPRUvH1H1mSD
  N5z4bqY33IWgPxlE1jskkUF7c8tc3W3Sogr9TpUqdQFNeo9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=orange; t=1726622322; x=1727288988; h=date:author:from:to:cc:subject:
  message-id:mail-followup-to:openpgp:blahblahblah:author:from:subject:date:
  to:cc:resent-author:resent-date:resent-from:resent-sender:resent-to:
  resent-cc:resent-reply-to:resent-message-id:in-reply-to:references:
  mime-version:content-type:content-transfer-encoding:content-disposition:
  content-id:content-description:message-id:mail-followup-to:openpgp:
  blahblahblah; bh=htF+rDwY3DxUmwNSMU3FGPfu+pTEklXfUHtIWHkRXDY=;
 b=thOsWlukTWN4sNiP3tvDnqeTEFQTzGZLIYbXLMmYbai588aItFoPuKVUMGAX++1CJaUbRMPa
  0gs+Hh6ILnYKBA==
Date: Wed, 18 Sep 2024 03:14:43 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: dash@vger.kernel.org, busybox@busybox.net, bug-bash@gnu.org
Cc: Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: Question on $IFS related differences (Was: Question on $@ vs
 $@$@)
Message-ID: <20240918011443.AVR6sOQ3@steffen%sdaoden.eu>
Mail-Followup-To: dash@vger.kernel.org, busybox@busybox.net,
 bug-bash@gnu.org, Steffen Nurpmeso <steffen@sdaoden.eu>
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

Hello.

I am terribly sorry to be here once again; i already mentioned on
bug-bash@ the problem with IFS being reverse solidus that dash
(and myself) has (have).
I came back to this for my one again, and i stumble over one
additional difference in behaviour in between (myself and) bash,
dash and busybox sh.

We are still here, and this snippet gives identical results for
all, my MUA included,

  a() {
    echo $#,1=$1,2=$2,3=$3,4=$4,5=$5,6=$6,"$*",$*,
  }
  set -- '' '' ''
  IFS=' '; echo "$*"$* $*; a "$*"$* $*;unset IFS

ie, via "cat -vet":

    $
  1,1= ,2=,3=,4=,5=,6=,  , ,$

*However*, if we change IFS to : in the above:

  a() {
    echo $#,1=$1,2=$2,3=$3,4=$4,5=$5,6=$6,"$*",$*,
  }
  set -- '' '' ''
  IFS=':'; echo "$*"$* $*; a "$*"$* $*;unset IFS

then we get different behaviour for bash on the one side, dash and
busybox sh on the next, and myself on the third.  bash 5.2.32 says

  ::   $
  4,1=  ,2=,3=,4=,5=,6=,:::::,     ,$

whereas the ashs say

  ::$
  1,1=  ,2=,3=,4=,5=,6=,::,  ,$

and i say the same as for SPC except that : is in place of SPC:

  ::$
  1,1= ,2=,3=,4=,5=,6=,::, ,$

I really would like to finally get a nice mind map on what is
going on everywhere.

Thank you very much in advance,
Ciao (and good night),

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
