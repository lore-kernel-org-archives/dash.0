From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Reset exit status before sourcing a file.
Date: Wed, 2 Mar 2011 14:42:34 -0600
Message-ID: <20110302204233.GB21150@elie>
References: <1299068573-581-1-git-send-email-screwtape@froup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:49153 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754777Ab1CBUmk (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 2 Mar 2011 15:42:40 -0500
Received: by vxi39 with SMTP id 39so366564vxi.19
        for <dash@vger.kernel.org>; Wed, 02 Mar 2011 12:42:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1299068573-581-1-git-send-email-screwtape@froup.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Tim Allen <screwtape@froup.com>
Cc: dash@vger.kernel.org

Tim Allen wrote:

> The POSIX specification for the dot command[1] states:
>
>     EXIT STATUS
>         Returns the value of the last command executed, or a zero exit
>         status if no command is executed.
> 
> If an empty file is sourced, then "no command is executed"

I agree.  Looking through "git log --patch src/main.c", though, I find
v0.5.3~42 (Do not clobber exit status in dotcmd., 2005-03-03), which
appears to have been meant to take care of the following case:

	$ cat printstatus.sh
	echo $?
	$ false
	$ . ./printstatus.sh
	1

I wonder if the following on top might help (imitating evalcmd)?

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 src/main.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/main.c b/src/main.c
index b4c07e9..b38dc27 100644
--- a/src/main.c
+++ b/src/main.c
@@ -202,6 +202,7 @@ cmdloop(int top)
 	union node *n;
 	struct stackmark smark;
 	int inter;
+	int status = 0;
 	int numeof = 0;
 
 	TRACE(("cmdloop(%d) called\n", top));
@@ -235,6 +236,7 @@ cmdloop(int top)
 			job_warning = (job_warning == 2) ? 1 : 0;
 			numeof = 0;
 			evaltree(n, 0);
+			status = exitstatus;
 		}
 		popstackmark(&smark);
 
@@ -245,7 +247,7 @@ cmdloop(int top)
 		}
 	}
 
-	return 0;
+	return status;
 }
 
 
@@ -318,7 +320,6 @@ int
 dotcmd(int argc, char **argv)
 {
 	int status = 0;
-	exitstatus = 0;
 
 	if (argc >= 2) {		/* That's what SVR2 does */
 		char *fullname;
@@ -326,9 +327,8 @@ dotcmd(int argc, char **argv)
 		fullname = find_dot_file(argv[1]);
 		setinputfile(fullname, INPUT_PUSH_FILE);
 		commandname = fullname;
-		cmdloop(0);
+		status = cmdloop(0);
 		popfile();
-		status = exitstatus;
 	}
 	return status;
 }
-- 
1.7.4.1

