From: Martijn Dekker <martijn@inlv.org>
Subject: [BUG] 'trap' is not quite POSIX compliant
Date: Sat, 13 Feb 2016 16:45:21 +0100
Message-ID: <56BF4F91.7080105@inlv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from kahlil.inlv.org ([37.59.109.123]:58339 "EHLO kahlil.inlv.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbcBMPpY (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 13 Feb 2016 10:45:24 -0500
Received: from breedzicht.local (inlv.demon.nl [212.238.240.159])
	(authenticated bits=0)
	by kahlil.inlv.org (8.14.9/8.14.4) with ESMTP id u1DFjLrf004682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <dash@vger.kernel.org>; Sat, 13 Feb 2016 16:45:22 +0100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

The 'trap' command in dash is not compliant with POSIX. According to the
spec, both '-' and any unsigned decimal integer should be accepted as an
argument meaning 'unset this trap'; dash only accepts '-'.
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_28

I did testing on all other POSIX shells I know of with this little script:

	trap 'echo BYYYE' EXIT
	trap "$1" EXIT

This script will either produce 'BYYYE' or output a "command not found"
error message, depending on whether $1 was accepted as an argument for
unsetting the trap.

None of the shells are technically compliant: they only interpret an
unsigned decimal integer up to a certain value as 'unset this trap'; a
value exceeding that is interpreted as a command.

Interestingly, that maximum value differs slightly between shells. So
far, I've found:
- dash and Busybox ash do not accept any.
- bash, yash, pdksh, mksh/lksh, FreeBSD /bin/sh, and AT&T ksh "AJM 93u+
2012-08-01" accept up to 31.
- AT&T ksh "M 1993-12-28 s+" accepts up to 32.
- zsh 4.3.11, zsh 5.1.1 and zsh 5.2-dev-1 (current git) on my Mac accept
up to 33.
- zsh 5.0.2 on FreeBSD accepts up to 34.

For compatibility purposes it might seem wise to follow the majority of
implementations, accepting up to 31.

By the way, dash and zsh, as well as bash in non-POSIX mode, also accept
the counterintuitive and non-POSIX-compliant form "trap EXIT" to unset
the trap, but other shells don't: bash (POSIX), yash and ksh93 produce
an error, while mksh/lksh silently ignore that form. What a mess...

- M.
