From: Nico Huber <nico.h@gmx.de>
Subject: export statements and command substitution
Date: Sun, 24 Jul 2016 15:46:02 +0200
Message-ID: <5e6f29ec-418c-32f9-7754-5a4fe1f66577@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:61498 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752AbcGXNqe (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 24 Jul 2016 09:46:34 -0400
Received: from [192.168.4.129] ([130.180.109.134]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0MZ8fw-1bjx5G3OjU-00Kxfm for
 <dash@vger.kernel.org>; Sun, 24 Jul 2016 15:46:30 +0200
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi dash folks,

we stumbled over a little curiosity in dash's behavior when you combine
a variable assignment within an export statement with command sub-
stitution.

The following works fine in bash:
  $ export foo=$(echo foo bar)
  $ echo $foo
  foo bar
dash, however, applies field splitting and thus takes `bar` as a second
variable name:
  $ export foo=$(echo foo bar)
  $ echo $foo
  foo
which can easily be fixed by adding double quotes:
  $ export foo="$(echo foo bar)"
  $ echo $foo
  foo bar

I know bash shouldn't be the reference so I had a look at [1]. It
states:
 "If a command substitution occurs inside double-quotes, field
  splitting and pathname expansion shall not be performed on the
  results of the substitution."
Which one could read as field splitting should take place if you don't
supply double quotes. But in present shells variable assignments seem
to be an exception.

And even dash doesn't apply field splitting on a simple assignment:
  $ foo=$(echo foo bar)
  $ echo $foo
  foo bar

That's at least inconsistent and, IMO, the export statement should have
the same semantics (i.e. not requiring double quotes) as things can get
quite nasty if you think of evaluations like:
  $ export foo=$(echo bar bar=foo)
  $ echo $foo
  bar
  $ echo $bar
  foo

Best regards,
Nico

[1]
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_03
