Received: from mercurius.teckids.org (commu.teckids.org [91.184.37.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0194235045
	for <dash@vger.kernel.org>; Mon, 26 Jan 2026 21:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.184.37.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769462057; cv=none; b=Do3c8/RIxkcdre6vqhk+INoDj2YAQxT2dpmzxEN6IlJXoVl5eb9pfdVKeZAz+qOfBCmWqc7nTWwydWm4Zmlbn5cXFSk7x6jDQuVhERj0AQbtAXCJLge3bmRnoy3kipx4aQP57tMREhr5MOcFYdemKjBPPzWlZmKVEDgn+/gitd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769462057; c=relaxed/simple;
	bh=JvlJYCSRgQX4H4LwzEpXxUcraE9JPOc9Qj+HhRxV3uE=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=e6F/NgXuOhsVZQEQArAXmnJ4DhEn7f2mihvAvTlLI6mtZ4pax3qb3M0NrIYWiEOTUawmSeGedE0q5zOklH/84a18najFQa2o/j6gE6ltuQgJvXy2puKte705FR7N+ycEsnPaYL4/QxqAwffwrwWHJqRyVi14d2CuKvL1X6wNGdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mag-kekse.de; spf=pass smtp.mailfrom=mercurius.teckids.org; dkim=pass (1024-bit key) header.d=mag-kekse.de header.i=@mag-kekse.de header.b=WGBN9iLN; arc=none smtp.client-ip=91.184.37.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mag-kekse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mercurius.teckids.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mag-kekse.de header.i=@mag-kekse.de header.b="WGBN9iLN"
X-Envelope-From: <mirabilos@mag-kekse.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mag-kekse.de;
	s=dkim; t=1769461595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vZ0v05QsbnpXBVdSKtwZugTbyMG1ypLav5ahWBFFtJg=;
	b=WGBN9iLNSNMhqLbplIPoHHaLfJ3pq1lQ9FkznJ29tiTbks5DsrqMImZaA+FnIXDXk8JIqJ
	ZLi7uA5wAhJBEIvVraG2pUZ7lLUmpIevsbJEmMeVnfWZZZJEuZof42WkA4R6ZaQveM7te/
	YjurA/xoEYF0WXrN40yqLjcrNDqJLjI=
Received: from herc.mirbsd.org (caas.mirbsd.org [IPv6:2a02:a00:2000:6a::1])
	by mercurius.teckids.org (Postfix) with ESMTPSA id 6F8AF305F9E;
	Mon, 26 Jan 2026 22:06:35 +0100 (CET)
Date: Mon, 26 Jan 2026 21:06:31 +0000 (UTC)
From: mirabilos <mirabilos@mag-kekse.de>
X-X-Sender: tg@herc.mirbsd.org
To: Jari Aalto <jari.aalto.fi@gmail.com>
cc: Martijn Dekker <martijn@inlv.org>, Chet Ramey <chet.ramey@case.edu>, 
    dash@vger.kernel.org
Subject: =?utf-8?Q?Re=3A_your_$=28#=E2=80=A6=29_bugreport?=
Message-ID: <Pine.BSM.4.64L.2601262052451.32136@herc.mirbsd.org>
Content-Language: de-Zsym-DE-1901-u-em-text-rg-denw-tz-utc, en-Zsym-GB-u-cu-eur-em-text-fw-mon-hc-h23-ms-metric-mu-celsius-rg-denw-tz-utc-va-posix
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Jari,

thanks for tracking me down in IRC about this. Unfortunately,
a netsplit ate my answer. I=E2=80=99m writing from an eMail account that
*should* work with Googlemail, but I don=E2=80=99t use this for FOSS
communication normally.

13:15=E2=8E=9C<jaalto:#!/bin/mksh> ATTN: mksh maintainer, bug found in
     =E2=8E=9C    process substitution parsing () with comments
13:18=E2=8E=9C<jaalto:#!/bin/mksh> Also found in Bash (reported), Ksh (bug
     =E2=8E=9C    report in-progress), Dash (reported). See bug report at
     =E2=8E=9C    https://pastebin.com/4LD95GJS

(Also, ouch. Please do not capitalise any letter in =E2=80=9Cmksh=E2=80=9D,=
 TYVM.
If you absolutely must have something in title case, write it out
as =E2=80=9CMirBSD Korn Shell=E2=80=9D instead. See the FAQ.)


The thing is: the pr=C3=A6-POSIX accent-gravis-style command substitution
is not identical to the POSIX $(=E2=80=A6) comsub. For example, the user ma=
y
not use double quotes both outside and inside, as the results differ
between shells there (and yes, POSIX allows that, and it is good to
do so).

You cannot use an accent-gravis inside a string either, as it is
taken as the closing one:

$ PS2=3D'[PS2] '
$ echo foo`echo bar'`'baz`
[PS2]

The contents of $(=E2=80=A6) comsubs are parsed as full commands, using a
recursive parser, to avoid the pdksh bug of=E2=80=A6

 (mksh) $ echo $(case foo in bar) echo miau ;; esac)

(pdksh) $ echo $(case foo in bar) echo miau ;; esac)
pdksh: syntax error: `;;' unexpected

So, the closing parenthesis for POSIX-style comsubs is searched
for only at the top level of the expression inside. The docs
support this:

| With the $(commands) form, all characters following the open
| parenthesis to the matching closing parenthesis constitute the
| commands string.
|
| With both the backquoted and $(commands) forms, the commands string
| shall be tokenized (see [153]2.3 Token Recognition) and parsed [=E2=80=A6=
]

Token Recognition has:

| 9. If the current character is a '#', it and all subsequent characters
| up to, but excluding, the next <newline> shall be discarded as a
| comment.

And the accent-gravis-style comsubs have special rules:

| The search for the matching backquote shall be satisfied by the first
| unquoted non-escaped backquote; during this search, if a non-escaped
| backquote is encountered within a shell comment, a here-document, an
| embedded command substitution of the $(commands) form, or a quoted
| string, undefined results occur.

So, writing =E2=80=9C`#comment`=E2=80=9D, even if it works, is actually und=
efined, too.


Therefore, it=E2=80=99s not a bug, it=E2=80=99s expected behaviour.

bye,
//mirabilos
--=20
=E2=80=9ECool, /usr/share/doc/mksh/examples/uhr.gz ist ja ein Grund,
mksh auf jedem System zu installieren.=E2=80=9C
=09-- XTaran auf der OpenRheinRuhr, ganz begeistert
(EN: =E2=80=9C[=E2=80=A6]uhr.gz is a reason to install mksh on every system=
=2E=E2=80=9D)
