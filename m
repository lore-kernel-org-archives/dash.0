Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BD119B5A7
	for <dash@vger.kernel.org>; Sat,  4 Oct 2025 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759579912; cv=none; b=Ys8MZOkAGiavZpkulZKFXveTAjffol5ITVkhkw0wJ89/LnHjuBLXfWSIc40GbSE0G9ruEI/fWuwafyDKLqt/NFlzw0oevwniIjsRKdFFfJxL58yxb0Sg5ZciTMnBNq0jOSIkJwKPT4eP3ctMKhpnzRjFORgZeBOos9wt/XLUB2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759579912; c=relaxed/simple;
	bh=kZBLpSrtlNrWsEWrj1GlcBkOKu/Wihit1xpVZ2N6y9k=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rF/ZKU/z7UDi2cSSegzejGKSp2pHC1oF+t8gUcvSKSy58KF/EzAoPMtAf/oJ6GFUcoQ6NEiR8nRtImNaA1C2Srhir+lV7c8sMbAyhu+qzDnMAgPshcnh9ytpnnvAcfKfQULK2l346NZlTCZJR7FBWQv3SlM+KktzWIdnr8vYnAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=IRy7Gh9G; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="IRy7Gh9G"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 86B85240027
	for <dash@vger.kernel.org>; Sat,  4 Oct 2025 14:11:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1759579907; bh=YXVWlwyj4KRaASpVo9AfXCi+yyxnDRIdXj82ZfpfwJU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Sender:From;
	b=IRy7Gh9GsrQSWWPwGbiuf1Tq/j52gWeYgnL47HkpnC4h8fGBxi5i9LDNTnLSHOw2y
	 OrZXTRJm5linQiCNGxHKWF6k0+w4hFmifKSoo4vJQM3Jl+n61G9krHWnCGqDJyF6H8
	 uMvDk0gehu2ZT4lqwB91PkiZu86LMm1+bhsCQpknSJiezGFZZBlDbcpIuBBdHYwUct
	 jbf3fxvRlSVfGBRylXitDPgIx6dF3Se1qI2EXzUKao/yxsckqHxxJWldI4uXDRpcpG
	 NSbxeXtqxyT9p2qMoZQG5ec3X4fykO8akIRYU4DUG2uQz/2Ff+8qgD29HPdeJlPYk+
	 lrYhPMCgLCHig==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cf4C71mHTz6tsf
	for <dash@vger.kernel.org>; Sat,  4 Oct 2025 14:11:47 +0200 (CEST)
Received: from juergen by jue.fritz.box with local (Exim 4.98.2)
	(envelope-from <juergen@jue.fritz.box>)
	id 1v5174-000000007n1-3iaD
	for dash@vger.kernel.org;
	Sat, 04 Oct 2025 14:11:46 +0200
Date: Sat, 04 Oct 2025 12:11:47 +0000
From: Juergen Daubert <j.daubert@posteo.de>
To: dash@vger.kernel.org
Subject: bash 0.5.13: breaks buiding of inetutils
Message-ID: <aOEPAl49li-HH7ou@jue>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender:  Juergen Daubert <j.daubert@posteo.de>

I'm using dash 0.5.13 with the two patches 

  [PATCH] expand: Fix off-by-one bug in expmeta
  [PATCH] expand: Fix typo in pmatch for wildcard search

as /bin/sh and get the folling breaking while building 
GNU inetutils:

...
make[2]: Entering directory '/tmp/inetutils/src/inetutils-2.6/src'
  CC       hostname.o
  CC       traceroute.o
  CC       inetd.o
<command-line>: error: expected expression before '/' token
inetd.c:166:31: note: in expansion of macro 'PATH_INETDPID'
  166 | static const char *pid_file = PATH_INETDPID;
      |                               ^~~~~~~~~~~~~
<command-line>: error: 'var' undeclared here (not in a function)
inetd.c:193:36: note: in expansion of macro 'PATH_INETDPID'
  193 |    "override pidfile (default: \"" PATH_INETDPID "\")",
      |                                    ^~~~~~~~~~~~~
<command-line>: error: 'run' undeclared here (not in a function)
inetd.c:193:36: note: in expansion of macro 'PATH_INETDPID'
  193 |    "override pidfile (default: \"" PATH_INETDPID "\")",
      |                                    ^~~~~~~~~~~~~
<command-line>: error: 'inetd' undeclared here (not in a function); did you mean 'int'?
inetd.c:193:36: note: in expansion of macro 'PATH_INETDPID'
  193 |    "override pidfile (default: \"" PATH_INETDPID "\")",
      |                                    ^~~~~~~~~~~~~
inetd.c:193:50: error: expected '}' before string constant
  193 |    "override pidfile (default: \"" PATH_INETDPID "\")",
      |                                                  ^~~~~
inetd.c:192:3: note: to match this '{'
  192 |   {"pidfile", 'p', "PIDFILE", OPTION_ARG_OPTIONAL,
      |   ^
inetd.c: In function 'main':
<command-line>: error: expected expression before '/' token
inetd.c:1955:33: note: in expansion of macro 'PATH_INETDCONF'
 1955 |       config_files[0] = newstr (PATH_INETDCONF);
      |                                 ^~~~~~~~~~~~~~
<command-line>: error: expected expression before '/' token
inetd.c:1956:33: note: in expansion of macro 'PATH_INETDDIR'
 1956 |       config_files[1] = newstr (PATH_INETDDIR);
      |                                 ^~~~~~~~~~~~~
make[2]: *** [Makefile:2440: inetd.o] Error 1


Note: dash 0.5.12 works as expected with inetutils. 


Greetings
Juergen

