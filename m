From: Jason Miller <jason@milr.com>
Subject: command lookup and POSIX
Date: Fri, 7 Mar 2014 11:43:19 -0800
Message-ID: <20140307194318.GA2317@home.jasonmmiller.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from fed1rmfepi108.cox.net ([68.230.241.139]:46384 "EHLO
	fed1rmfepi108.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbaCGVny (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 7 Mar 2014 16:43:54 -0500
Received: from fed1rmimpo210 ([68.230.241.161]) by fed1rmfepo102.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20140307194352.TGBM3107.fed1rmfepo102.cox.net@fed1rmimpo210>
          for <dash@vger.kernel.org>; Fri, 7 Mar 2014 14:43:52 -0500
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Reading this:

http://pubs.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html#tag_02_09_01_01

Any built-in other than the special built-ins, or listed in the table
there should not be run unless it is present in the PATH.

dash however doesn't follow that:

PS1="% " dash

    % PATH=
    % /usr/bin/which [
    /usr/bin/which: no [ in ()
    % [ -x f ]
    % 

Of course I can't find a single shell that follows this, even when
enabling its respective strict POSIX mode.  I'm guessing it was added to
prevent changes in behaviors of existing scripts as shells add more
builtins.

However, changing dash to comply also seems of dubious value since there
are many shell scripts out there that depend on common built-ins not
listed in POSIX.

However DASH claims POSIX compliance so I thought I would at least
mention it now that I found it.

-Jason
