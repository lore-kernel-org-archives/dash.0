From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: Bug in man page
Date: Fri, 14 Mar 2014 13:09:19 +0100
Message-ID: <20140314120919.GA5792@stack.nl>
References: <B9BC530A-2542-409D-AA48-2B9E3B7906A1@vandijke.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:52483 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753722AbaCNMPr (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 14 Mar 2014 08:15:47 -0400
Content-Disposition: inline
In-Reply-To: <B9BC530A-2542-409D-AA48-2B9E3B7906A1@vandijke.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jeroen van Dijke <jeroen@vandijke.net>
Cc: dash@vger.kernel.org

On Sun, Mar 09, 2014 at 12:11:43PM +0100, Jeroen van Dijke wrote:
> There seems to be a bug in the dash man page, at least in 0.5.7. It
> reads:

>             Precision:
>                     An optional period, `.', followed by an optional
> digit string giving a precision which specifies the number of digits
> to appear after the decimal point, for e and f formats, or the maximu=
m
> number of *characters* to be printed from a string (b and s formats);
> if the digit string is missing, the precision is treated as zero;

> dash behaves cuts to the number of bytes

> $ length=3D10; printf "%.${length}s\n" "eeeeeeeeeeeeeeeeeeeeeeeee"
> eeeeeeeeee
> $ length=3D10; printf "%.${length}s\n" "=C3=AB=C3=AB=C3=AB=C3=AB=C3=AB=
=C3=AB=C3=AB=C3=AB=C3=AB=C3=AB=C3=AB=C3=AB=C3=AB=C3=AB=C3=AB=C3=AB=C3=AB=
=C3=AB=C3=AB=C3=AB=C3=AB=C3=AB=C3=AB=C3=AB=C3=AB=E2=80=9D
> =C3=AB=C3=AB=C3=AB=C3=AB=C3=AB

> The  POSIX specification (2008) says:

> precision Gives the minimum number of digits to appear for the d, o,
> i, u, x, or X conversion specifiers (the field is padded with leading
> zeros), the number of digits to appear after the radix character for
> the e and f conversion specifiers, the maximum number of significant
> digits for the g conversion specifier; or the maximum number of
> *bytes* to be written from a string in the s conversion specifier. Th=
e
> precision shall take the form of a ( '.' ) followed by a decimal digi=
t
> string; a null digit string is treated as zero.

> So it seems to me that =E2=80=9Ccharacters=E2=80=9D should be changed=
 to =E2=80=9Cbytes=E2=80=9D.

Indeed, and the same applies to the field width. This behaviour may not
be the most useful, but it is standard and widely implemented.

Likewise, the sequences \num (in the format string) and \0num (in
arguments for %b) generate bytes, not characters.

On another note, the format string is said to be a "character string";
this may be a C'ism (meaning that it is not a wide character string).

Note that a "byte" in POSIX terminology is a "character" in C standard
terminology. I think the former is less ambiguous in general and should
be the preferred term in man pages where a unit of 8 bits is referred
to. A POSIX "character" may be more than one byte long.

--=20
Jilles Tjoelker
