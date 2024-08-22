Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F125EC5
	for <dash@vger.kernel.org>; Thu, 22 Aug 2024 22:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724365388; cv=none; b=c5dv5ZOoa7GNGiGl86ESYzPNM+ggzlxXqaR3xH1I6F8uJ1qZSDnsm6Or8Yny//tEBHfFG+yMii32P80OaJXafl4gQIeq15SwLZUYBZjYBrqD52V5JTnzf/Vb3Zlxg1an82WM8VHVoQAqaKnDsTaXcHPdGQ2VhjX1//xDqllZ/sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724365388; c=relaxed/simple;
	bh=tMET398meCWCSKP1d3ynKKzA8CboMjitHRQQufmq4yI=;
	h=Date:From:To:Subject:Message-ID; b=XtnK6V6T1iSZPP5VX5dqmzxLRiBJjO9pdPUa7ySy9IpQ7xkemjgFaquG0F+tduArPLreEluYjXaC3eCJATkv8gOLTGss0GNtxqchrePbKuBfUIX3esx2NdlzE0vv7JwtXlQKfFkuQVriWqGaGLB+DI9Tci8u/BW44wlgdLfAdi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=pass smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=kA00TNnm; dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=rQ+eNDtg; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="kA00TNnm";
	dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="rQ+eNDtg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1724365376; x=1725032042; h=date:author:from:to:subject:
  message-id:openpgp:blahblahblah:author:from:subject:date:to:cc:
  resent-author:resent-date:resent-from:resent-sender:resent-to:resent-cc:
  resent-reply-to:resent-message-id:in-reply-to:references:mime-version:
  content-type:content-transfer-encoding:content-disposition:content-id:
  content-description:message-id:mail-followup-to:openpgp:blahblahblah;
 bh=afPqFFZtyam5rGUFR62TIl2HYcj+6S0lIVLB1euWUPE=;
 b=kA00TNnm/0AMt3GQMOTG0jocH3cgXbJzhJsVXDfksG1K+R8xM2rtzLZ1S3w+FhE1dTadxPXG
  47LqknRcNMmQ9IzXoSlu2gEuQeXxuNzNjlTj+s23qEgYnhLgiRHklenR71oYfCXp05q5D2LAJH
  zoKEF9P657VS3fehcGRW3V/aE9JIIhHAizrAgOD6wALtH4u/coed52pmJNjTLhOBnZE+78/KJx
  RRF+/mCbVjX533EtWutk+nSrAEDxKA2W8jvCmd2WQiSjrTQoK1cQG6/3sEtN2wjeteJbwPiPrf
  8i+7758V4AufG0dwXRJs8ykCzrlSfe6/yBkyyFKcDHC/UHsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=orange; t=1724365376; x=1725032042; h=date:author:from:to:subject:
  message-id:openpgp:blahblahblah:author:from:subject:date:to:cc:
  resent-author:resent-date:resent-from:resent-sender:resent-to:resent-cc:
  resent-reply-to:resent-message-id:in-reply-to:references:mime-version:
  content-type:content-transfer-encoding:content-disposition:content-id:
  content-description:message-id:mail-followup-to:openpgp:blahblahblah;
 bh=afPqFFZtyam5rGUFR62TIl2HYcj+6S0lIVLB1euWUPE=;
 b=rQ+eNDtgDsq/ZSHQ60kmTaOs9kA5btbwx6TT9Fisss1T8pr5/aP2Ty+Aztat/vJjrCRELOGj
  wK3MUq4oo5VKAg==
Date: Fri, 23 Aug 2024 00:21:19 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: dash@vger.kernel.org
Subject: IFS bug (maybe)
Message-ID: <20240822222119.ijDODf_7@steffen%sdaoden.eu>
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

I still stick to that $IFS stuff, and see another difference for
dash (0.5.12) compared to bash and busybox sh:

  a() {
    echo $#,1=$1,2=$2,"$*",$*,
  }
  echo ,"$*"$* $*,
  set -- a b c
  echo ,"$*"$* $*,
  IFS=:;echo ,"$*"$* $*,;unset IFS
  echo 1
  echo "$*"$*; a $* "$*"
  echo 2
  IFS=:; echo "$*"$*; a $* "$*";
  echo 3
  IFS=; echo "$*"$*; a $* "$*";
  echo 4
  IFS= ; echo "$*"$*; a $* "$*";
  echo 5
  IFS="	"; echo "$*"$*; a $* "$*";
  echo 6
  IFS='
  '; echo "$*"$*; a $* "$*";
  echo 7
  IFS="\011"; echo "$*"$*; a $* "$*";
  echo 8
  IFS="\012"; echo "$*"$*; a $* "$*";

and that is

  @@ -27,8 +27,5 @@ a
   b
   c,a b c a b c,
   7
  -a\b\ca b c
  -4,1=a,2=b,a\b\c\a\b\c,a b c a b c,
  -8
  -a\b\ca b c
  -4,1=a,2=b,a\b\c\a\b\c,a b c a b c,
  +4,1=a,2=b,8
  +4,1=a,2=b,a
  \ No newline at end of file

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
