From: Seb <sbb@tuxfamily.org>
Subject: Re: exec command and error checking
Date: Tue, 28 Jan 2014 14:40:56 +0100
Message-ID: <20140128144056.ac2c1804a662b66678acfdab@tuxfamily.org>
References: <CAEmTpZGqBfdBQDnmw-TozGTXpUxShCC=rWObhaP4zmKFJu4jUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:49698 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754199AbaA1NlE (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 28 Jan 2014 08:41:04 -0500
In-Reply-To: <CAEmTpZGqBfdBQDnmw-TozGTXpUxShCC=rWObhaP4zmKFJu4jUw@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: =?UTF-8?B?0JzQsNGA0Log0JrQvtGA0LXQvdCx0LXRgNCz?= <socketpair@gmail.com>
Cc: dash@vger.kernel.org

Le Tue, 28 Jan 2014 18:16:23 +0600
=D0=9C=D0=B0=D1=80=D0=BA =D0=9A=D0=BE=D1=80=D0=B5=D0=BD=D0=B1=D0=B5=D1=80=
=D0=B3 a =C3=A9crit:

> $ exec 9<no_such_file && echo TEST
> dash: 1: cannot open no_such_file: No such file

As previously said, POSIX specifies that the built-in redirection
errors cause the shell to exit. See:

  http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.h=
tml#tag_18_20
  http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.h=
tml#tag_18_08_01
 =20
> $ exec 9<no_such_file || echo TEST
> dash: 2: cannot open no_such_file: No such file
>=20
> So, I cannot test this operation without using $?

You can use the file tests:

 if [ -f no_such_file -a -r no_such_file ]; then
   exec 9<no_such_file
 else
   echo TEST
 fi

or a subshell:

 if ( exec 9<no_such_file ) 2>/dev/null; then
   exec 9<no_such_file
 else
   echo TEST
 fi

++
Seb.
