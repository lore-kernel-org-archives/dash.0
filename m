From: Guido Berhoerster <guido+kernel.org@berhoerster.name>
Subject: test -nt/-ot behavior
Date: Sun, 21 Feb 2010 13:21:01 +0100
Message-ID: <20100221122100.GA9005@wopr.local.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from multivac.heapoverflow.de ([83.169.16.167]:49962 "EHLO
	multivac.heapoverflow.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086Ab0BUM2c (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 21 Feb 2010 07:28:32 -0500
Received: from wopr.local.invalid (p57B5AA9E.dip.t-dialin.net [87.181.170.158])
	by multivac.heapoverflow.de (Postfix) with ESMTPSA id A00D9A3F8515
	for <dash@vger.kernel.org>; Sun, 21 Feb 2010 13:18:28 +0100 (CET)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org


Hello,

The behavior of the test builtin's -nt and -ot operators differs
in an incompatible way from the behavior established by the
KornShell.

The -nt, -ot, and -ef operators of test originated from the
KornShell, they exist at least since ksh88. Their specified
behavior is as follows:

* file1 -nt file2 evaluates to true if only file1 exists or file1
  is newer than file2
* file1 -ot file2 evaluates to true if only file2 exists or file1
  is older than file2

This behavior is matched by the test builtin that is part of
bash, ksh93, pdksh 5.2.14, and the test utility that comes with
GNU coreutils.

Then there is the pdksh's test builtin in versions < 5.2.14 where
the -nt and -ot operators behaved differently until they got
"fixed" (it is listed in the changelog under bug fixes) in 1999
just before the last release 5.2.14. Here the behavior was as
follows:

* file1 -nt file2 evaluates to true if both file1 and file2 exist
  and file1 is newer than file2
* file1 -ot file2 evaluates to true if both file1 and file2 exist
  and file1 is older than file2

It has to be noted that the documented behavior of test in ksh93,
pdksh 5.2.14, bash, and GNU coreutils is not entirely correct,
rather than checking for the existence of a file they only check
if a stat on the file succeeds.

According to the posting of the ash sources on comp.sources.unix
in 1989 ash originally included a combined test/expr builtin and
a standalone version of the test command (which did not contain
-nt, -ot, and -ef). NetBSD apparently went with the latter as a
standalone utility and when ash was first ported to Linux in 1993
the "buggy" test builtin from pdksh was used (see the ash-0.2
source) and I suppose it was adopted for the later port that
became dash.  In 1994 NetBSD replaced its test utility with the
"buggy" version from pdksh, from there it went into OpenBSD and
in 1999 it was imported into FreeBSD.  The change that pdksh made
in 1999 was however never merged back into the standalone test
utility included in the BSDs or the builtin test contained in the
Linux ports of ash, however NetBSD and OpenBSD both contain ksh
versions derived from pdksh 5.2.14 in their base system resulting
in inconsistent behavior between /bin/test and the ksh builtin.

It should be noted that pdksh contains many other subtle
differences and is not really compatible to either ksh88 or
ksh93, the behavior introduced by the test builtin of earlier
pdksh versions is likely due to a misunderstanding of ksh88's
specified behavior which was later fixed.  So IMHO the
consequence for ash should be to either merge the fix from pdksh
or to drop -nt, -ot, and -ef altogether, I would prefer that
latter since I think silently changing the behavior in an
incompatible way is bad practice and these features are not
specified in POSIX anyway.

-- 
Guido Berhoerster
