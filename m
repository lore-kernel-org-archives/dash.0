From: Martijn Dekker <martijn@inlv.org>
Subject: [BUG] test: -gt: unexpected operator
Date: Mon, 13 Jul 2015 01:30:18 +0200
Message-ID: <55A2F88A.4090908@inlv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from grey-smtp-cloud6.xs4all.net ([194.109.24.45]:56748 "EHLO
	grey-smtp-cloud6.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751200AbbGLXhg (ORCPT
	<rfc822;dash@vger.kernel.org>); Sun, 12 Jul 2015 19:37:36 -0400
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

I found a bug in dash that affects checking the exit status of '[' or
'test' for failure.

After feeding an illegal number to 'test -t', 'test' will not accept any
operator (or at least not -gt or -lt) for the next invocation.

Confirmed in dash 0.5.7, 0.5.8 and current git version.

$ [ -t 12323454234578326584376438 ]
src/dash: 7: [: Illegal number: 12323454234578326584376438
$ [ "$?" -gt 1 ] && echo error
src/dash: 8: [: -gt: unexpected operator
$ [ "$?" -gt 1 ] && echo error
error
$ test -t 12323454234578326584376438
src/dash: 10: test: Illegal number: 12323454234578326584376438
$ test "$?" -gt 1 && echo error
src/dash: 11: test: -gt: unexpected operator
$ test "$?" -gt 1 && echo error
error
$ test -t 12323454234578326584376438
src/dash: 13: test: Illegal number: 12323454234578326584376438
$ test 2 -gt 1
src/dash: 14: test: -gt: unexpected operator
$ test 2 -gt 1
$ test -t 12323454234578326584376438
src/dash: 16: test: Illegal number: 12323454234578326584376438
$ test 2 -lt 1
src/dash: 17: test: -lt: unexpected operator
$ test 2 -lt 1
$

Thanks,

- Martijn
