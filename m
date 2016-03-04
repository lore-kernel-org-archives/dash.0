From: Martin Lucina <martin@lucina.net>
Subject: Dash commit 46d3c1a (in 0.5.8+) breaks BSD make
Date: Fri, 4 Mar 2016 15:06:35 +0100
Message-ID: <20160304140635.GB2457@nodbug.lucina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp.lucina.net ([62.176.169.44]:38214 "EHLO smtp.lucina.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751420AbcCDONG (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 4 Mar 2016 09:13:06 -0500
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: rumpkernel-users@freelists.org

Hi,

Commit 46d3c1a ([VAR] Sanitise environment variable names on entry)
restricts exported environment variables actually set by dash on entry to
those reported as valid by endofname(). While this is technically correct
and matches IEEE Std 1003.1, it breaks BSD make which uses '.' as a
separator in variables exported via the environment to a sub-make.

Upstream bug report: https://github.com/rumpkernel/rumprun/issues/38

I'm not sure what the correct fix is here. While we (rumprun) could
possibly patch our version of NetBSD make to not use '.' in exported names,
this problem would continue to hit other users of BSD-derived make.

Would the dash maintainers consider replacing 46d3c1a with a fix that
performs the name validity check at "export -p" time instead? If yes, I can
try my hand at a patch.

Based on my reading of reading of Std 1003.1 section 8.1...

    "Other characters may be permitted by an implementation; applications
    shall tolerate the presence of such names."

... preserving "invalid" but exported environment variables would still be
compliant behaviour.

Martin
