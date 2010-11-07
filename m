From: Jim Meyering <jim@meyering.net>
Subject: sensible "local" support?
Date: Sun, 07 Nov 2010 14:17:16 +0100
Message-ID: <871v6xclyb.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:47776 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752471Ab0KGNRZ (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 7 Nov 2010 08:17:25 -0500
Received: from mx.meyering.net (unknown [82.230.74.64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 797599400E5
	for <dash@vger.kernel.org>; Sun,  7 Nov 2010 14:17:18 +0100 (CET)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi Herbert,

Would you be open to the idea of making dash's "local" work more
like the scope modifier that its name implies than like a separate
command in which assignments have different semantics?

To be clear, "local" is not standardized, so the change I'm advocating
would not be a bug fix ;-)  However, it would make dash align with
bash and zsh, and imho, with common sense.

Here's what I mean:

Currently, variable assignments like var=$other_var
require no quotes around the RHS.  That's covered by POSIX.
However, when you want to reduce the scope of that "var"
and use "local var=$other_var", you have subtly changed
semantics in dash, (but not with bash or zsh).
The local-using assignment appears to work, but evokes
a "bad variable name" warning and causes failure:

This works fine:

    $ dash -c 'f() { b="1 1"; z=$b; echo "$z"; }; f'
    1 1

However with "local" on the latter assignment, it fails:

    $ dash -c 'f() { b="1 1"; local z=$b; echo "$z"; }; f'
    local: 1: 1: bad variable name
    1
    [Exit 1]

Regards,

Jim

PS, this started when I noticed FreeBSD 8.1's /bin/sh doing something
odd with local and IFS, and on that basis decided to eliminate it from
the list of candidate shells used for running coreutils tests.  Then I
noticed that dash did the same thing.  I don't want to disqualify dash,
so am hoping to minimize fragmentation in how shells treat "local".

Actually, here's a much better way to demonstrate the problem:
(this is using 016b529d2b114efc6cd91fe4e3e4767ba615870a, the latest
from the dash.git repository):

    $ ./dash -c 'f() { b="1 x=3"; local z=$b; echo "z=<$z> x=<$x>"; }; f'
    z=<1> x=<3>

That makes it clear that the part of $b's value after the first token
is being treated as additional arguments to "local".
