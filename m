From: Jilles Tjoelker <jilles@stack.nl>
Subject: debian patches to exit with code 127 for nonexistent/directory
 scripts
Date: Sat, 5 Jun 2010 18:06:51 +0200
Message-ID: <20100605160651.GA60028@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:63029 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933617Ab0FEQGy (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 5 Jun 2010 12:06:54 -0400
Received: from turtle.stack.nl (turtle.stack.nl [IPv6:2001:610:1108:5010::132])
	by mx1.stack.nl (Postfix) with ESMTP id 5EC6B35A83E
	for <dash@vger.kernel.org>; Sat,  5 Jun 2010 18:06:51 +0200 (CEST)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Debian's dash package has some local changes which cause an exit with
code 127, as required by POSIX, if a script (passed with dash
<filename>) cannot be opened or cannot be read because it is a
directory.

Unfortunately, these patches also affect the . builtin (if the pathname
contains a slash) and use EXEXIT, which means such errors always cause
the shell to exit, even in interactive mode or if the builtin's
specialness has been disabled using command.

% dash
$ . ./nonexistent
.: 1: Can't open ./nonexistent
zsh: exit 127   dash
%

% dash -c 'command . ./nonexistent; echo continued'

Note: Do not compare this with bash. Bash deliberately does not follow
POSIX XCU 2.8.1 Consequences of Shell Errors if not in POSIX mode, and
even in POSIX mode trying to source a nonexistent dot script (without
slash in the pathname) fails to abort the shell.

Note 2: POSIX seems unclear about what 'command .' should do, but is
very clear that failure to find/read a dot script shall not cause an
interactive shell to exit.

-- 
Jilles Tjoelker
