From: Jonathan Perkin <jperkin@joyent.com>
Subject: [PATCH] trap: Implement POSIX.1-2008 trap reset behaviour (#2)
Date: Mon, 7 Dec 2015 17:50:47 +0000
Message-ID: <20151207175047.GG735@joyent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34497 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932376AbbLGRuw (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 7 Dec 2015 12:50:52 -0500
Received: by wmvv187 with SMTP id v187so178439186wmv.1
        for <dash@vger.kernel.org>; Mon, 07 Dec 2015 09:50:51 -0800 (PST)
Received: from joyent.com (host86-144-234-20.range86-144.btcentralplus.com. [86.144.234.20])
        by smtp.gmail.com with ESMTPSA id lx4sm26276349wjb.5.2015.12.07.09.50.50
        for <dash@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 Dec 2015 09:50:50 -0800 (PST)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Clarifies a couple of issues with the previous patch, and expands on
the rationale in the commit message.  Sorry for the noise -- jperkin

POSIX.1-2008 for trap adds the following behaviour:

    If the first operand is an unsigned decimal integer, the shell shall
    treat all operands as conditions, and shall reset each condition to
    the default value.

The interpretation of this behaviour differs among other shells.  In the
case where the first operand is an invalid signo:

  bash-4.3.39(1), zsh-5.1.1:

    $ trap echo 1 2 3
    $ trap 100 1 2
    $ trap
    trap -- '100' SIGHUP
    trap -- '100' SIGINT
    trap -- 'echo' SIGQUIT

  mksh-51:

    $ trap echo 1 2 3
    $ trap 100 1 2
    mksh: trap: bad signal '100'
    $ trap
    trap -- echo QUIT

  ksh 93u+:

    $ trap echo 1 2 3
    $ trap 100 1 2
    ksh: trap: 100: bad trap
    $ trap
    trap -- echo QUIT
    trap -- echo INT
    trap -- echo HUP

As the standard does not appear to specify that the first operand must
be a valid signo for this behaviour to be triggered, we align with the
ksh behaviour:

    $ trap echo 1 2 3
    $ trap 100 1 2
    trap: 100: bad trap
    $ trap
    trap -- 'echo' HUP
    trap -- 'echo' INT
    trap -- 'echo' QUIT

As for the case of the first operand being a signal name:

  bash-4.3.39(1), mksh-51, ksh 93u+:

    $ trap echo 1 2 3
    $ trap HUP 2
    $ trap
    trap -- 'echo' SIGHUP
    trap -- 'HUP' SIGINT
    trap -- 'echo' SIGQUIT

  zsh-5.1.1:

    $ trap echo 1 2 3
    $ trap HUP 2
    $ trap
    trap -- echo QUIT

Here we go with the majority and a strict interpretation of the
standard, parsing it as a string rather than a signal:

    $ trap echo 1 2 3
    $ trap HUP 2
    $ trap
    trap -- 'echo' HUP
    trap -- 'HUP' INT
    trap -- 'echo' QUIT
---
 src/trap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/trap.c b/src/trap.c
index 82d4263..3dc1949 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -112,7 +112,7 @@ trapcmd(int argc, char **argv)
 		}
 		return 0;
 	}
-	if (!ap[1])
+	if ((!ap[1]) || (is_number(*ap)))
 		action = NULL;
 	else
 		action = *ap++;
-- 
2.4.9 (Apple Git-60)

-- 
Jonathan Perkin  -  Joyent, Inc.  -  www.joyent.com
