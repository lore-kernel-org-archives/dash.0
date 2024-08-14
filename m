Received: from munnari.OZ.AU (munnari.OZ.AU [202.29.151.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164BA1B32AD
	for <dash@vger.kernel.org>; Wed, 14 Aug 2024 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.29.151.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723645900; cv=none; b=E3ydVPm8toZs1YfVcet5M/eFpl8oguvu4et+YgsNtiW0hbAPIkia3Jkc3TsoqipauXKUmIvVF7OBq2jrNO19LHtedE8JJLjPH/z5q7hRpQQ2QmKBJornLa93bSEgTRu7qN1iOIBLK/mb4dg/LoXUasLBalIF0tAa25RdQVjGNgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723645900; c=relaxed/simple;
	bh=Vl7UvVDWUzVlOjXjzxbUdkJ8ChghXNSW9gOjB1iWu6I=;
	h=From:To:cc:Subject:In-Reply-To:References:Mime-Version:
	 Content-Type:Date:Message-ID; b=n7wScJSOG8ZFDEYpFHJ7PA5KSXCW44M2Uenbo5w4/L+nL6j3UNNMJh+vHzo6UF6s0t5qWUJ2gA+f3GYHoroEinT1g/ixxn1z7cs81e7trPc0+UVOH07GhUhpGIZsGIPupnAEogIqDOCNU984lEZ4XiI7f1bWaSIuDxVpWUZFtzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=munnari.OZ.AU; spf=fail smtp.mailfrom=munnari.OZ.AU; arc=none smtp.client-ip=202.29.151.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=munnari.OZ.AU
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=munnari.OZ.AU
Received: from jacaranda.noi.kre.to (localhost [IPv6:0:0:0:0:0:0:0:1]) by munnari.OZ.AU with ESMTP
	id 47EEKiLa028017; Wed, 14 Aug 2024 21:20:45 +0700 (+07)
Received: from jacaranda.noi.kre.to (localhost [127.0.0.1])
	by jacaranda.noi.kre.to (8.16.1/8.14.2) with ESMTP id 47EEKdVG014045;
	Wed, 14 Aug 2024 21:20:39 +0700 (+07)
From: Robert Elz <kre@munnari.OZ.AU>
To: Marc Chantreux <mc@unistra.fr>
cc: dash@vger.kernel.org, busybox@busybox.net, bug-bash@gnu.org,
        Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: Re: Question on $@ vs $@$@
In-Reply-To: <ZrxzCOnZv-HffFuB@prometheus>
References: <ZrxzCOnZv-HffFuB@prometheus> <20240814004525.A7mNIdWf@steffen%sdaoden.eu> <ZrwTnBvk8_2mdQUS@wooledge.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Aug 2024 21:20:39 +0700
Message-ID: <17108.1723645239@jacaranda.noi.kre.to>

    Date:        Wed, 14 Aug 2024 11:04:08 +0200
    From:        Marc Chantreux <mc=40unistra.fr>
    Message-ID:  <ZrxzCOnZv-HffFuB=40prometheus>

  =7C I'm really currious: do you see another one ?

The case he was asking about is when =24=23 is 0 (no positional params se=
t)
and whether =22=24=40=24=40=22 should result in =22=22 (1 arg) or nothing=
 (0 args).

Upon rereading POSIX, while I am sure that the intent would be to
make that unspecified, just as =22=24=40=24X=22 is, when X is unset or nu=
ll,
but I'm not convinced that the wording actually does.

As was quoted from POSIX (this time from the new standard, though I
believe this is unchanged, it remains XCU 2.5.2 (the '=40' expansion desc=
r)):

    however, if the expansion is embedded within a word which contains on=
e
    or more other parts that expand to a quoted null string, these null
    string(s) shall still produce an empty field,

which I am not sure actually applies in the relevant case, as neither =24=
=40
expansion produced a quoted null string, they both produce nothing (when
there are no parameters, which is the only time this is relevant).

So, I am not sure that this exception is relevant, and if it isn't, then
the exception to the exception

    except that if the other parts are all within the same double-quotes
    as the '=40', it is unspecified whether the result is zero fields
    or one empty field.

cannot apply either.   That would mean that perhaps =22=24=40=24=40=22 mi=
ght be
specified to produce nothing.   However, as ksh93 makes =22=22 from this
expansion, and so probably ksh88 might have done as well (I don't have
a ksh88 to test it) and as the standard was originally based upon ksh88
if a clarification were added, it would probably be to change the
wording (somehow) so the =22=24=40=24=40=22 case is also explicitly unspe=
cified.

kre

