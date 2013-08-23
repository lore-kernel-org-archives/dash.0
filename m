From: Roy <roytam@gmail.com>
Subject: Re: [PATCH] implement privmode support in dash
Date: Fri, 23 Aug 2013 22:23:45 +0800
Message-ID: <op.w19wxvoqdyj81a@roy-xp.roytam.ath.cx>
References: <20130822175936.GA1260@google.com> <52166DA8.1000201@gigawatt.nl>
 <20130822203500.GA21467@stack.nl>
 <CAJ_zFkJEb02d8Xs=RcWnRT7JbgDUYiAwMUUc3WFAfXr1ZN-0DQ@mail.gmail.com>
 <87txig63f4.fsf@shannon.wxcvbn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:48054 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754921Ab3HWOYA convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Fri, 23 Aug 2013 10:24:00 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcsd-dash@m.gmane.org>)
	id 1VCsHM-0008Si-N4
	for dash@vger.kernel.org; Fri, 23 Aug 2013 16:23:56 +0200
Received: from 183179237179.ctinets.com ([183.179.237.179])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Fri, 23 Aug 2013 16:23:56 +0200
Received: from roytam by 183179237179.ctinets.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Fri, 23 Aug 2013 16:23:56 +0200
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: oss-security@lists.openwall.com

On Fri, 23 Aug 2013 19:40:31 +0800, "J=C3=A9r=C3=A9mie Courr=C3=A8ges-A=
nglas" =20
<jca+dash@wxcvbn.org> wrote:

>
> Also,
>
> Tavis Ormandy <taviso@google.com> writes:
>
> [...]
>
>>> Apart from that, it is better to check the return value from setuid=
()
>>> and similar functions. In particular, some versions of Linux may fa=
il
>>> setuid() for [EAGAIN], leaving the process running with the same
>>> privileges.
>>
>> I don't think this is true anymore, but I have no strong objection t=
o
>> adding it, so long as it's noted that bash and pdksh do not do this.
>
> Just for reference, from mksh:
>

[snip]

BTW it is just changed in cvs. Log message:

Commit ID:	10052176CB912FE954B
CVSROOT:	/cvs
Module name:	src
Changes by:	tg@herc.mirbsd.org	2013/08/23 14:07:41
UTC

Modified files:
	distrib/special/mksh: Makefile
	bin/mksh       : Build.sh Makefile check.t misc.c mksh.1 sh.h

Log message:
SECURITY: Unbreak =E2=80=9Cset +p=E2=80=9D, broken by OpenBSD ksh chang=
e.

TODO: I am seriously considering following Chet and changing
the way this works, by explicitly dropping privs unless the
shell is run with -p. Every other shell does it like mksh,
except Heirloom sh, which on the other hand doesn=E2=80=99t know any
explicit set -p or set +p (though it doesn=E2=80=99t know set +foo
for any foo either).

=E2=94=8C=E2=94=80=E2=94=80=E2=94=A4 QUESTION: Do we need the ability t=
o do this:
=E2=94=82 tg@blau:~ $ ./suidmksh -p -c 'whoami; set +p; whoami'
=E2=94=82 root
=E2=94=82 tg

If not, I=E2=80=99m seriously considering to drop set =C2=B1p as well,
only parse -p on the command line, with +p being the default,
and dropping FPRIVILEGED.

Thanks to RT for noticing and jilles for initial follow-up
discussion, as well as Chet Ramey for doing the sane/secure
thing instead of following Debian.

To generate a diff of this changeset, execute the following commands:
cvs -R rdiff -kk -upr1.71 -r1.72 src/distrib/special/mksh/Makefile
cvs -R rdiff -kk -upr1.645 -r1.646 src/bin/mksh/Build.sh
cvs -R rdiff -kk -upr1.124 -r1.125 src/bin/mksh/Makefile
cvs -R rdiff -kk -upr1.630 -r1.631 src/bin/mksh/check.t
cvs -R rdiff -kk -upr1.214 -r1.215 src/bin/mksh/misc.c
cvs -R rdiff -kk -upr1.320 -r1.321 src/bin/mksh/mksh.1
cvs -R rdiff -kk -upr1.668 -r1.669 src/bin/mksh/sh.h

