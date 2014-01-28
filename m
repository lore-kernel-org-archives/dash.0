From: Guido Berhoerster <gber@opensuse.org>
Subject: Re: exec command and error checking
Date: Tue, 28 Jan 2014 14:17:59 +0100
Message-ID: <20140128131759.GA17217@hal.lan>
References: <CAEmTpZGqBfdBQDnmw-TozGTXpUxShCC=rWObhaP4zmKFJu4jUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from multivac.heapoverflow.de ([78.47.51.218]:33374 "EHLO
	multivac.heapoverflow.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbaA1N1m (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 28 Jan 2014 08:27:42 -0500
Received: from localhost (localhost [127.0.0.1])
	by multivac.heapoverflow.de (Postfix) with ESMTP id 6300320628
	for <dash@vger.kernel.org>; Tue, 28 Jan 2014 14:18:03 +0100 (CET)
Received: from hal.lan (p5DC59457.dip0.t-ipconnect.de [93.197.148.87])
	by multivac.heapoverflow.de (Postfix) with ESMTPSA id 4C1872024C
	for <dash@vger.kernel.org>; Tue, 28 Jan 2014 14:18:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAEmTpZGqBfdBQDnmw-TozGTXpUxShCC=rWObhaP4zmKFJu4jUw@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

* =D0=9C=D0=B0=D1=80=D0=BA =D0=9A=D0=BE=D1=80=D0=B5=D0=BD=D0=B1=D0=B5=D1=
=80=D0=B3 <socketpair@gmail.com> [2014-01-28 13:16]:
> $ dpkg -l | fgrep dash
> ii  dash                                   0.5.7-2ubuntu2
>                 POSIX-compliant shell
>=20
> $ exec 9<no_such_file && echo TEST
> dash: 1: cannot open no_such_file: No such file
>=20
> $ exec 9<no_such_file || echo TEST
> dash: 2: cannot open no_such_file: No such file
>=20
> So, I cannot test this operation without using $?

No, exec is a special built in and POSIX specifies that
=2E..if a redirection error occurs (see Consequences of Shell
Errors), the shell shall exit with a value in the range 1-125

dash correctly exits with exit status of 2 as it should. ksh93,
mksh, and pdksh do the same.

> in BASH this works as expected (even in sh mode)

That's either a bug or an intended deviation from the POSIX
standard, you'll have to ask on the bug-bash list about that.
--=20
Guido Berhoerster
