From: Alex Waite <alexqw85@gmail.com>
Subject: dash and ANSI escape sequences
Date: Tue, 18 Feb 2014 12:54:29 +0100
Message-ID: <ldvhl7$ns2$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:45613 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754110AbaBRMKJ (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 18 Feb 2014 07:10:09 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcsd-dash@m.gmane.org>)
	id 1WFjUz-0005mF-3m
	for dash@vger.kernel.org; Tue, 18 Feb 2014 13:10:05 +0100
Received: from 141.44.98.41 ([141.44.98.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Tue, 18 Feb 2014 13:10:05 +0100
Received: from alexqw85 by 141.44.98.41 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Tue, 18 Feb 2014 13:10:05 +0100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

I come here in search of someone who understands dash/portable scriptin=
g=20
better than I do. Today, my Google-foo is failing me.

I am in the process of cleaning up someone else's semi-portable shell=20
script (originally written on FreeBSD). The original script uses colors=
,=20
in the form of

echo -e "\e[1;32mpassed\e[0m"

"echo" should be avoided in general and any option passed to "echo" is=20
non-portable. In bash, I can easily port this to printf

printf '%b' "\x1b[32;1mpassed\x1b[0m\n"

However, this approach does not work in dash. I have read both the echo=
=20
and printf sections of the dash manual, and it seems that both "\e" and=
=20
"\x" are unsupported. Using "%b" allows additional backslash-escape=20
sequences, but only \c and \0.

I know the purpose of dash is to provide an efficient POSIX compliant=20
shell. Is there really no POSIX compliant way to use color? It seems=20
so... 80s. Dash's manpage does state that it supports "backslash=20
notation as defined in ANSI X3.159-1989 (=93ANSI C89=94)", but I can't =
find=20
a copy of ANSI C89 online to confirm whether it includes display=20
attributes. ANSI C89 is old, but still... too old for color?

Am I somehow missing some hidden functionality in printf, or is there=20
really no POSIX compliant method of printing colors, or is Dash simply=20
incomplete with its POSIX support in this regard?

Any insight is most appreciated.

---Alex

