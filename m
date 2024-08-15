Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB7881AC1
	for <dash@vger.kernel.org>; Thu, 15 Aug 2024 21:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723757629; cv=none; b=nlRZgMXu4ifcmbmpuDzYFZkidO0xbRpD4bIzTK7yOzpav49e1AAF37p6qmb+1V5Je4tQWKT/ceDCg8sYLuTNZqhHETiUKKx2popTreF5jfcKBPK1QUZDZFxjTZXJBMnaCoOcyHn2leEGzpVlWcHqCCxOyB2qYKVf6gKBghPvNpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723757629; c=relaxed/simple;
	bh=yRf+tccohaOW6SC4jRg2ZO2nkEUUGMy967VZ/J7axGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References; b=ln0vQJVVOFXQfqk3rqAZ4eyR86QgOg2VntPhtW66qIq2woyAss8SpLSdJPMpvvfffxf7wkgD9Viful4S6tkMU74OPJwEgqB3J8nMhrkBk4nx57Kq7bBPwf93gsAGkaX4uAK4Ckq3Rap6uMylg6AvX/r7pevnbGBWffOvVi5M6bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=pass smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=QIKDJQJY; dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=1sXUJBDK; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="QIKDJQJY";
	dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="1sXUJBDK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1723757623; x=1724424289; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:mail-followup-to:openpgp:blahblahblah:
  author:from:subject:date:to:cc:resent-author:resent-date:resent-from:
  resent-sender:resent-to:resent-cc:resent-reply-to:resent-message-id:
  in-reply-to:references:mime-version:content-type:
  content-transfer-encoding:content-disposition:content-id:
  content-description:message-id:mail-followup-to:openpgp:blahblahblah;
 bh=HTKAgtimtgMAa3+TZ8v0c8Nf2ujB+WknOqtdIqEyPfY=;
 b=QIKDJQJYOn5b8zZptr0E6964M2OaXUMPnNciW/asXiRGgj+fQrjb8f+XmaT+TRwEKz3HMhjG
  iazO0Y+WEeN+kajB9Q2yp+xrMsq8cf6QFKy/0yySe44fWRy8HMcHz2bwFbYzvBZju6DxcKHv3D
  30MYIU6mr+loVUNjUNT0ZnJ4k9s4W8xNMGWGiDUt2bgHPZsfowHnL55h2yOTeZlMw9xBuk3Fm6
  PyySVAKj4w66Y/SCppQ5LjfTZ9K0sMQTx4yMTzLNuSSkxZ888+mqQ7YyygwhujFGq9nv6NkeNu
  d6m3w3AC0Yh7gO+kvCRjAeRx4G84BIAEEnMMIR194UF/TRnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=orange; t=1723757623; x=1724424289; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:mail-followup-to:openpgp:blahblahblah:
  author:from:subject:date:to:cc:resent-author:resent-date:resent-from:
  resent-sender:resent-to:resent-cc:resent-reply-to:resent-message-id:
  in-reply-to:references:mime-version:content-type:
  content-transfer-encoding:content-disposition:content-id:
  content-description:message-id:mail-followup-to:openpgp:blahblahblah;
 bh=HTKAgtimtgMAa3+TZ8v0c8Nf2ujB+WknOqtdIqEyPfY=;
 b=1sXUJBDKFdlIzeGXmnMg/ZQvy976wc7ON8XR5seK/L7zBj3q/dMQ0epmMH3ImSSKL/mEC+v3
  3tE7hYiFpZRaDA==
Date: Thu, 15 Aug 2024 23:33:42 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: dash@vger.kernel.org, busybox@busybox.net, bug-bash@gnu.org
Cc: Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: Re: Question on $@ vs $@$@
Message-ID: <20240815213342.t6-hdjZT@steffen%sdaoden.eu>
In-Reply-To: <20240815184858.r5T_UQnM@steffen%sdaoden.eu>
References: <20240814004525.A7mNIdWf@steffen%sdaoden.eu>
 <1bba673e-5ab9-4263-9d88-124854793b4b@case.edu>
 <20240814200534.Vh3Eu_Md@steffen%sdaoden.eu>
 <20240815184858.r5T_UQnM@steffen%sdaoden.eu>
Mail-Followup-To: dash@vger.kernel.org, busybox@busybox.net,
 bug-bash@gnu.org, Steffen Nurpmeso <steffen@sdaoden.eu>
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

One more, please.
(And please excuse this still copies bug-bash.)

Steffen Nurpmeso wrote in
 <20240815184858.r5T_UQnM@steffen%sdaoden.eu>:
 |Steffen Nurpmeso wrote in
 | <20240814200534.Vh3Eu_Md@steffen%sdaoden.eu>:
 ||Chet Ramey wrote in
 || <1bba673e-5ab9-4263-9d88-124854793b4b@case.edu>:
 |||On 8/13/24 8:45 PM, Steffen Nurpmeso wrote:
 |||> I include bug-bash even though i think bash is correct, but there
 |||> lots of people of expertise are listening, so, thus.
 |||> Sorry for cross-posting, nonetheless.
 ...
 |In fact Geoff Clare (who we all deserve thanks, together with Don
 |Cragun, for continued ISO C compiler support for the BSD socket
 |interface we all use in at least POSIX environments, it is
 |undefined anywhere else!, and more) sees this differently:
 |
 |  The standard clearly requires "$@$@" to generate zero fields if
 |  there are no positional parameters. The quoted text "if the
 |  expansion is embedded within a word which contains one or more
 |  other parts that expand to a quoted null string, ..." does not
 |  apply because there are no other parts that expand to a quoted
 |  null string. (The second $@ is not a candidate for being such
 |  a part because "the expansion of '@' shall generate zero
 |  fields".)
 |
 |  If this does not match existing behaviour in some shells, we
 |  could consider making it unspecified, but the first step should
 |  be to alert the maintainers of those shells to the issue and
 |  find out whether they are willing to change their shell to
 |  comply with the standard.
 |
 |So please any shell maintainer listening here, please feel
 |alerted.

I have extended the test a bit, and i also see word split
differences.  Call me idiotic, but .. there seems some state
machinery bug in dash / busybox sh, maybe.

So if i save the code below into a file named t.sh, and if i run
"sh t.sh", then i only get the "$@$@" differences this thread is
about.  But if i run "sh t.sh X" then i get an additional

  1,1=ja "da du $j" ich,2=,3=,4=,5=,6=,7=,8=,9=,                                                 | 5,1=ja,2="da,3=du,4=$j",5=ich,6=,7=,8=,9=,
  .. 5,1=ja "da du $j" ichja "da du $j" ichja,2="da,3=du,4=$j",5=ich,6=,7=,8=,9=,                | .. 13,1=ja,2="da,3=du,4=$j",5=ichja,6="da,7=du,8=$j",9=ichja,

difference in between dash+ (left) and bash (right).
Now i am looking for too long on these, but can anyone reproduce
this on another machine?  I *can* reproduce it on an AlpineLinux
[edge] vserver.  Ie

  sh t.sh > .A
  bash t.sh > .B
  diff -u .A .B > .D1
  sh t.sh X > .A
  bash t.sh X > .B
  diff -u .A .B > .D2

(Must be said that diffutils diff(1) gives different hunks than
busybox diff, but that aside.)

  y() { echo ".. $#,1=$1,2=$2,3=$3,4=$4,5=$5,6=$6,7=$7,8=$8,9=$9,"; }
  x() { echo "$#,1=$1,2=$2,3=$3,4=$4,5=$5,6=$6,7=$7,8=$8,9=$9,"; y "$@$@"$@; }
  i='ja "da du $j" ich' j=recur

  if [ $# -eq 1 ]; then
  echo =1=
  x ja "da du $j" ich
  x ja:"da du $j":ich
  x $i
  x "$i"
  eval x $i
  eval x "$i"
  x ''
  eval x ''
  echo =2=
  IFS=: x ja "da du $j" ich
  IFS=: x ja:"da du $j":ich
  IFS=: x $i
  IFS=: x "$i"
  IFS=: eval x $i
  IFS=: eval x "$i"
  IFS=: x ''
  IFS=: eval x ''
  fi
  echo =3=
  IFS=': ' x ja "da du $j" ich
  IFS=': ' x ja:"da du $j":ich
  IFS=': ' x $i
  IFS=': ' x "$i"
  IFS=': ' eval x $i
  IFS=': ' eval x "$i"
  IFS=': ' x ''
  IFS=': ' eval x ''
  if [ $# -eq 1 ]; then
  echo =4=
  i=
  x $i
  x "$i"
  eval x $i
  eval x "$i"
  fi

Ciao!

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
