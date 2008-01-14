From: Lucas Nussbaum <lucas@lucas-nussbaum.net>
Subject: output redirections
Date: Mon, 14 Jan 2008 12:46:04 +0100
Message-ID: <20080114114604.GA12318@xanadu.blop.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from xanadu.blop.info ([80.248.208.235]:46007 "EHLO xanadu.blop.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167AbYANMNy (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 14 Jan 2008 07:13:54 -0500
Received: from localhost ([127.0.0.1] helo=xanadu.blop.info)
	by xanadu.blop.info with smtp (Exim 4.63)
	(envelope-from <lucas@lucas-nussbaum.net>)
	id 1JENlJ-0008Au-Tz
	for dash@vger.kernel.org; Mon, 14 Jan 2008 12:45:54 +0100
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi,

I rebuilt all packages in Debian in a chroot using dash as /bin/sh,
which uncovered quite a lot of problems in build scripts.
One of the problems is about output redirection.

I understand that:
  command &>/dev/null
is a bashism. (with dash, it forks a subshell)

the "common" replacement is:
  command >/dev/null 2>&1
Which works fine with dash. However, I couldn't find any reference to
">&1" in the posix standard. Is it really posix-compliant? Shouldn't we
use instead:
   command >/dev/null 2>/dev/null

Thank you,
-- 
| Lucas Nussbaum
| lucas@lucas-nussbaum.net   http://www.lucas-nussbaum.net/ |
| jabber: lucas@nussbaum.fr             GPG: 1024D/023B3F4F |
