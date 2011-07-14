From: Rudolf Polzer <divverent@xonotic.org>
Subject: Bug: temporary assignments vs shell function
Date: Thu, 14 Jul 2011 10:34:56 +0200
Message-ID: <20110714083455.GA25362@div0.qc.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from rm.div0.qc.to ([94.23.21.40]:35579 "EHLO rm.div0.qc.to"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753328Ab1GNJI0 (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 14 Jul 2011 05:08:26 -0400
Received: from rpolzer by rm.div0.qc.to with local (Exim 4.69)
	(envelope-from <divverent@xonotic.org>)
	id 1QhHNo-0006kZ-8L
	for dash@vger.kernel.org; Thu, 14 Jul 2011 10:34:56 +0200
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi,

I noticed a little bug:

func()
{
	echo "Inside the shell function, foo is $foo"
}
foo=3Dfoo
foo=3Dbar func
echo "foo is now $foo"

will export foo=3Dbar in global scope (i.e. it affects the execution en=
vironment
after the function call).

This is inconsistent with calls to commands (both built-in and external=
). In
both cases, the variable assignment does not affect the execution envir=
onment
after the command.

In SUSv3, I only can find:

| If no command name results, variable assignments shall affect the cur=
rent
| execution environment. Otherwise, the variable assignments shall be e=
xported
| for the execution environment of the command and shall not affect the=
 current
| execution environment (except for special built-ins).

A shell function however isn't a "special built-in" and also counts as =
a
"command name", thus the last echo line really should output "foo is no=
w foo",
which it does in e.g. bash and the FreeBSD /bin/sh.

I tried this with current git master, too, and saw no difference, so I =
suppose
this bug is still open.

What makes this difficult, is that the execution environment of the fun=
ction is
the SAME as the execution environment of the rest of the script, as nei=
ther a
subshell nor a new process is spawned. In a way, this passage of SUSv3 =
can be
seen as contradictory: the execution environment of the command, and th=
e
current execution environment, are the same, and thus the assignment wo=
uld have
to both affect the current environment, and not affect it, at the same =
time
("Schr=F6dinger's Execution Environment").  Most other shells however r=
esolve
this in "some" way so that the called command sees the assignments, and=
 after
the command completes, the assignments are "undone", and I would like d=
ash to
do the same.

Best regards,

Rudolf Polzer
