From: Seb <sbb@tuxfamily.org>
Subject: Re: exec command and error checking
Date: Tue, 28 Jan 2014 15:42:46 +0100
Message-ID: <20140128154246.88cce1619f1cb3bdff457930@tuxfamily.org>
References: <CAEmTpZGqBfdBQDnmw-TozGTXpUxShCC=rWObhaP4zmKFJu4jUw@mail.gmail.com>
	<20140128144056.ac2c1804a662b66678acfdab@tuxfamily.org>
	<20140128140523.GB17217@hal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:59052 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755151AbaA1Omz (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 28 Jan 2014 09:42:55 -0500
Received: from ed.bebop.lan (unknown [88.181.135.123])
	by smtp4-g21.free.fr (Postfix) with SMTP id A5F284C8097
	for <dash@vger.kernel.org>; Tue, 28 Jan 2014 15:42:46 +0100 (CET)
In-Reply-To: <20140128140523.GB17217@hal.lan>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Le Tue, 28 Jan 2014 15:05:23 +0100
Guido Berhoerster a =C3=A9crit:

> >  [...]
> >  if ( exec 9<no_such_file ) 2>/dev/null; then
> >    exec 9<no_such_file
> >  else
> >    echo TEST
> >  fi
>=20
> That's generally a bad idea since it is racy, if no_such_file is
> removeded in between the test and actual exec your script will
> still exit.=20

In this case, it will break however, so an half-solution is still
better than no solution at all. Plus you can never be sure a file
will remain available for the life-time of a program, especially in
shell where it must often be accessed by a sequency of different
executables. In this regard, shell progamming is mostly racy, and
the best you can do is to ensure the target exists before dealing
with it, isn't it?

> Also, do no use test -a if you care about portability,
> it's an XSI extension and marked obsolescent.

Indeed. Thanks for pointing this. :)

++
Seb.
