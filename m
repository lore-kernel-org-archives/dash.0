From: Stephane Chazelas <stephane.chazelas@gmail.com>
Subject: Re: [bug?] echo -n does not work as described
Date: Thu, 12 Nov 2015 21:24:45 +0000
Message-ID: <20151112212445.GA12431@chaz.gmail.com>
References: <5643F1B2.5050207@sanitarium.net>
 <56440406.7000201@redhat.com>
 <56440A1E.8070701@sanitarium.net>
 <56440B7A.4040508@sanitarium.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35497 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291AbbKLVYs (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 12 Nov 2015 16:24:48 -0500
Received: by wmdw130 with SMTP id w130so4856996wmd.0
        for <dash@vger.kernel.org>; Thu, 12 Nov 2015 13:24:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <56440B7A.4040508@sanitarium.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Kevin Korb <kmk@sanitarium.net>
Cc: Eric Blake <eblake@redhat.com>, dash@vger.kernel.org

2015-11-11 22:46:02 -0500, Kevin Korb:
[...]
> >>> NOTE: your shell may have its own version of echo, which
> >>> usually super=E2=80=90 sedes the version described here. Please r=
efer
> >>> to your shell's docu=E2=80=90 mentation for details about the opt=
ions
> >>> it supports.
> >=20
> >> By the way, 'echo -n' is non-portable, and POSIX says you should=20
> >> use 'printf' instead.
>=20
> If dash refuses to supply a compatible version of echo then dash must
> not include a builtin version of echo.  If dash didn't have a broken
> embedded version of echo I wouldn't have a problem.
[...]

To clarify, a few things, sh and the POSIX/Unix utilities like C
nowadays is a language that has a (well several) standard that
defines it, and several existing implementations of interpreters
that interpret that language.

Among the most recognised specifications, we have POSIX and
Unix. Both specifications have now been merged. To simplify, the
Unix spec is like the POSIX spec but where a few optional parts
are required.

So basically we have the POSIX syntax for sh and utilities and
the Unix syntax.

In the POSIX syntax, the behaviour for:

echo -n whatever

is unspecified. That means that a POSIX conformant script, or a
script written to be portable to POSIX conformant systems must
not call echo with a first argument that may be -n. We're told
to use printf instead there:

printf %s "$var"
instead of
echo -n "$var"

Same goes for any argument that contains backslash character.

In the Unix syntax however, the behaviour of echo is clearly
specified.

echo -n whatever

is required to output "-n whatever<newline>", so your dash is
both POSIX and Unix conformant in that regard.

The builtin echo of bash, by default is neither POSIX nor Unix
conformant unless both the xpg_echo and posix (that one enabled
when called as sh) options have been enabled.

More details at:

http://unix.stackexchange.com/questions/65803/why-is-printf-better-than=
-echo

In short, don't use echo.

--=20
Stephane
