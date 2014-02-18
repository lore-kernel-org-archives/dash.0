From: Guido Berhoerster <gber@opensuse.org>
Subject: Re: dash and ANSI escape sequences
Date: Tue, 18 Feb 2014 14:11:32 +0100
Message-ID: <20140218131132.GA30525@hal.lan>
References: <ldvhl7$ns2$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from multivac.heapoverflow.de ([78.47.51.218]:38750 "EHLO
	multivac.heapoverflow.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755084AbaBRNLj (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 18 Feb 2014 08:11:39 -0500
Received: from localhost (localhost [127.0.0.1])
	by multivac.heapoverflow.de (Postfix) with ESMTP id 36F1B20B12
	for <dash@vger.kernel.org>; Tue, 18 Feb 2014 14:11:36 +0100 (CET)
Received: from hal.lan (p5B29F8A4.dip0.t-ipconnect.de [91.41.248.164])
	by multivac.heapoverflow.de (Postfix) with ESMTPSA id 6024820287
	for <dash@vger.kernel.org>; Tue, 18 Feb 2014 14:11:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ldvhl7$ns2$1@ger.gmane.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

* Alex Waite <alexqw85@gmail.com> [2014-02-18 13:10]:
> I come here in search of someone who understands dash/portable
> scripting better than I do. Today, my Google-foo is failing me.
>=20
> I am in the process of cleaning up someone else's semi-portable
> shell script (originally written on FreeBSD). The original script
> uses colors, in the form of
>=20
> echo -e "\e[1;32mpassed\e[0m"
>=20
> "echo" should be avoided in general and any option passed to "echo"
> is non-portable. In bash, I can easily port this to printf
>=20
> printf '%b' "\x1b[32;1mpassed\x1b[0m\n"
>=20
> However, this approach does not work in dash. I have read both the
> echo and printf sections of the dash manual, and it seems that both
> "\e" and "\x" are unsupported. Using "%b" allows additional
> backslash-escape sequences, but only \c and \0.
>=20
> I know the purpose of dash is to provide an efficient POSIX
> compliant shell. Is there really no POSIX compliant way to use
> color? It seems so... 80s. Dash's manpage does state that it
> supports "backslash notation as defined in ANSI X3.159-1989 (=E2=80=9C=
ANSI
> C89=E2=80=9D)", but I can't find a copy of ANSI C89 online to confirm
> whether it includes display attributes. ANSI C89 is old, but
> still... too old for color?
>=20
> Am I somehow missing some hidden functionality in printf, or is
> there really no POSIX compliant method of printing colors, or is
> Dash simply incomplete with its POSIX support in this regard?

dash, POSIX, or C89 have nothing to do with colors, it depends on
your terminal whether it interprets certain escape sequences as
color attributes.
You can print arbitrary bytes in a portable way (i.e. as
specified by POSIX) by using octal notation, e.g. escape is 033
in octal:

printf "\033[1;32mpassed\033[0m\n"
--=20
Guido Berhoerster
