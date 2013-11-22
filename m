From: Seb <sbb@tuxfamily.org>
Subject: Re: sed script fails to run in dash
Date: Fri, 22 Nov 2013 20:20:20 +0100
Message-ID: <20131122202020.823e130b486def83e9ecbda5@tuxfamily.org>
References: <528F9E5E.4020807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:36974 "EHLO
	smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756150Ab3KVTVG (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 22 Nov 2013 14:21:06 -0500
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id EBC85CA9949
	for <dash@vger.kernel.org>; Fri, 22 Nov 2013 20:21:01 +0100 (CET)
In-Reply-To: <528F9E5E.4020807@gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Tormen <quickhelp@gmail.com>
Cc: dash@vger.kernel.org

Le Fri, 22 Nov 2013 19:11:42 +0100
Tormen a =C3=A9crit:

Hello,


> but also just this line:
>=20
>     sed -e 1$'{w/dev/stdout\n;d}' -i /tmp/x
>=20
> in a dash script will yield the error message:
>=20
>     sed: -e expression #1, char 2: unknown command: `$'
>=20
> But why ? :(

It seems dash strictly passes what you have given and which is
sed-speaking incorrect:

$ dash -c "strace sed -e 1$'{w/dev/stdout\n;d}' -i /tmp/x"
execve("/usr/bin/sed", ["sed", "-e", "1${w/dev/stdout\\n;d}", ...
                                      ^^^
Bash does not, and so passes something sed understands:

$ bash -c "strace sed -e 1$'{w/dev/stdout\n;d}' -i /tmp/x"
execve("/usr/bin/sed", ["sed", "-e", "1{w/dev/stdout \n;d}", ...
                                      ^^^
If you escape the "$" with bash, you will get your kitten back:

$ bash -c "sed -e 1\\$'{w/dev/stdout\n;d}' -i /tmp/x"
sed: -e expression #1, char 2: unknown command: `$'


Take care,
Seb.
