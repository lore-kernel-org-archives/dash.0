Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4B85786E
	for <dash@vger.kernel.org>; Sat,  6 Apr 2024 23:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712445235; cv=none; b=S/Y8kyq/jKXb67qcvV0I3/3JiIsd/GyCQPglpLESNrQEDc4aX1abo8TnHsqxe7RGaqagMhH13ol0uLk5XedMQSAO7aL52bYPQssUtpxWWUoOmFCI8dAslyo0sEBIm4nNjjoje0PfnlQ037ZXUQ7S2LgSueHhahUfIZtcSunYZ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712445235; c=relaxed/simple;
	bh=J5Hlo9MKaukZzQ5n1Ng7NJjmKBrZF1jJpFksLhWYOb0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References; b=UPDqd4evv83eE+aDXODhFVN2uOCEle+soYKz0lXsQzAM4dQPiy1gZb50w+/KfrKDWyBjPaj6Xxb4ADyM2Lw8wrXjZzwpGoi5U4i4em7qaT0haUYdxN5C39G1J3rjevPNHb3/vZd/AnRbLCEEatTurXdMc71SMI2/C7kF4ZsUEoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=none smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=k9e99MFp; dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=KqKq8XIB; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="k9e99MFp";
	dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="KqKq8XIB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1712444825; x=1713111491; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:openpgp:blahblahblah:author:from:
  subject:date:to:cc:resent-date:resent-from:resent-to:resent-cc:
  in-reply-to:references:mime-version:content-type:
  content-transfer-encoding:message-id:mail-followup-to:openpgp:
  blahblahblah; bh=VJiOmxeapTKMpK7VED+TppfzcXa2epJhe75pQy+yoik=;
 b=k9e99MFpNl3R8agSyj254neblcdjum5hC2pJs8d5WFZmlHu8rFTVrY0ulE8RTzSQiMPxkGA+
  kSZxVgv57D1lzpUGdZ7hYTH2LH9JKgfNr+LNA4R+m0UGb/8KLXM+QkX+XDJ3D4lIqpLwhoteQI
  sFUkNe8LJIAMVNdeY31DZYR2jRlZ8VoiS3UmwnF9L+l7Rb72XB8Xt58uFEjvE4c1sVmIKAKmj/
  AcVIJ6jRd8xI6aR2BPD4ipprDVf8ZVWDYCZGWCDyGvsuOhF0VAKTnPln1pSs3SwKlNtsNW7aqY
  +ZvsqMw6fgGDT1CAADX0eNycdqYZhgr3WtIok6nE4ETHUtZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=orange; t=1712444825; x=1713111491; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:openpgp:blahblahblah:author:from:
  subject:date:to:cc:resent-date:resent-from:resent-to:resent-cc:
  in-reply-to:references:mime-version:content-type:
  content-transfer-encoding:message-id:mail-followup-to:openpgp:
  blahblahblah; bh=VJiOmxeapTKMpK7VED+TppfzcXa2epJhe75pQy+yoik=;
 b=KqKq8XIBUHy29fwhBNxZuSkq3PM7fRYeUQ/yPaU1LQ8BfzPsieFjwoC5JO+AQkOH4S+2KhUt
  gxmK3I3wIsQIBA==
Date: Sun, 07 Apr 2024 01:07:04 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org,
 Ganael Laplanche <ganael.laplanche@martymac.org>,
 Jilles Tjoelker <jilles@stack.nl>
Subject: Re: [PATCH] Allow enabling job control without a tty in
 non-interactive mode..
Message-ID: <20240406230704.Tr-SBJb2@steffen%sdaoden.eu>
In-Reply-To: <ZhD4JcqNct+rmxca@gondor.apana.org.au>
References: <dedaa3fa370ea9c4aeb1771b5568a7bef4065b04.1675113321.git.steffen@sdaoden.eu>
 <ZhD4JcqNct+rmxca@gondor.apana.org.au>
User-Agent: s-nail v14.9.24-612-g7e3bfac540
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

Herbert Xu wrote in
 <ZhD4JcqNct+rmxca@gondor.apana.org.au>:
 |On Mon, Jan 30, 2023 at 10:15:40PM +0100, Steffen Nurpmeso wrote:
 |> This is a take-over of the FreeBSD bin/sh
 |> 
 |>   commit cd60e2c67d52e1f957841af19128c7227880743a
 |>   Author:     Jilles Tjoelker <jilles@FreeBSD.org>
 |>   AuthorDate: 2014-09-04 21:48:33 +0000
 |>   Commit:     Jilles Tjoelker <jilles@FreeBSD.org>
 |>   CommitDate: 2014-09-04 21:48:33 +0000
 |> 
 |>       sh: Allow enabling job control without a tty in non-interactive \
 |>       mode.
 |> 
 |>       If no tty is available, 'set -m' is still useful to put jobs \
 |>       in their own
 |>       process groups.
 |
 |I don't see why dash needs this.  Please keep in mind that one
 |of the primary goals of dash it to be minimal.

Isn't that standardized answer a bit misplaced for that patch?
It was about Ganael Laplanche having problems with creating
process groups in backgrounded jobs (2023-01-12):

  The problem is when the main script is started *in the
  background*. Can your test script successfully be run in the
  background with dash if $JOBMON is not empty ? I think you'll
  face the same problem as I do.

  I could not find Jilles' commit (cd60e2c) equivalent in dash
  code, so I presume enabling job control without a tty in
  non-interactive mode is just not possible with dash, am I right

And i stated that another indirection fixes that problem and he
then said

  It is not clear for me why that extra fork fixes the problem,
  but it works, thanks!

  Unfortunately, my initial goal is to get a new process group for
  later children processes, but FreeBSD's sh (as well as dash)
  requires 'set -m' to be executed from the first process [1]. The
  extra fork breaks that requirement.  The following example shows
  that the new process' PGID remains the same as the initial
  shell:

which let me baffled

  Thanks for this information, that i did not expect.
  Indeed .. it seems no new process group is used for the child
  shell.  That thoroughly i have not looked.

and

  So i think i am out of ideas except doing what Jilles suggested
[Tjoelker]
  in the message, enwrapping the inner thing with sh -c '..'.  And
  that seems to work a bit as

and Ganael ended (without the patch) like

  Yes, I am afraid it's the only syntax that works (but it is not
  very convenient).

etc. etc. etc.

Full stop.

Please consider this script:

  cat > t.sh <<'_EOT'
  set -m
  (
  sleep 1
  ) &
  i=$!
  set +m
  echo >&2 "inner Main shell has: $(ps -o pid,pgid $$)"
  echo >&2 "inner Sub-shell has: $(ps -o pid,pgid $i)"
  wait $i
  _EOT

Current dash:

  #?0|kent:dash.git$ dash t.sh </dev/null >.X 2>&1 &
  [3] 28719
  #?0|kent:dash.git$
^RETURN

  [3]+  Stopped                 dash t.sh < /dev/null > .X 2>&1
  #?0|kent:dash.git$ fg
  dash t.sh < /dev/null > .X 2>&1

Patched dash:

  #?0|kent:dash.git$ src/dash t.sh </dev/null >.X 2>&1 &
  [3] 28749
  #?0|kent:dash.git$
^RETURN
  [3]   Done                    src/dash t.sh < /dev/null > .X 2>&1

Comparison:

  #?0|kent:dash.git$ bash t.sh </dev/null >.X 2>&1 &
  [3] 28766
  #?0|kent:dash.git$
^RETURN
  [3]   Done                    bash t.sh < /dev/null > .X 2>&1

A nice Sunday everybody!
Ciao from Germany,

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
