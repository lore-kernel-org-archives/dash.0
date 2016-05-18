From: Svyatoslav Mishyn <juef@openmailbox.org>
Subject: man fixes
Date: Wed, 18 May 2016 12:07:28 +0300
Message-ID: <20160518090722.GA370@k8>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GID0FwUMdk1T2AWN"
Return-path: <dash-owner@vger.kernel.org>
Received: from mail2.openmailbox.org ([62.4.1.33]:42196 "EHLO
	mail2.openmailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbcERJHi (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 18 May 2016 05:07:38 -0400
Received: from localhost (unknown [130.180.220.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: juef@openmailbox.org)
	by mail2.openmailbox.org (Postfix) with ESMTPSA id 4DC4D105A98
	for <dash@vger.kernel.org>; Wed, 18 May 2016 11:07:31 +0200 (CEST)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

just found some typos and mdocml warnings.


-- 
https://www.juef.tk/

--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-man-fix-mandoc-warnings.patch"

From 745af83b0953eb16ab31ed67f26808665576a46e Mon Sep 17 00:00:00 2001
From: Svyatoslav Mishyn <juef@openmailbox.org>
Date: Fri, 13 May 2016 09:47:54 +0300
Subject: [PATCH 1/2] man: fix mandoc warnings

They are:
 * prologue macros out of order: Dt after Os
 * skipping paragraph macro: Pp before Bd
 * whitespace at end of input line
 * skipping empty macro: Cm
 * skipping paragraph macro: Pp before It
 * sections out of conventional order: Sh ENVIRONMENT
 * skipping -width argument: Bl -item
---
 src/dash.1 | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/src/dash.1 b/src/dash.1
index 832eae7..57e731a 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -32,9 +32,9 @@
 .\"
 .\"	@(#)sh.1	8.6 (Berkeley) 5/4/95
 .\"
-.Dd January 19, 2003
-.Os
+.Dd May 13, 2016
 .Dt DASH 1
+.Os
 .Sh NAME
 .Nm dash
 .Nd command interpreter (shell)
@@ -694,7 +694,6 @@ Builtin commands grouped into a (list) will not affect the current shell.
 The second form does not fork another shell so is slightly more efficient.
 Grouping commands together this way allows you to redirect
 their output as though they were one program:
-.Pp
 .Bd -literal -offset indent
 { printf \*q hello \*q ; printf \*q world\\n" ; } \*[Gt] greeting
 .Ed
@@ -1183,7 +1182,7 @@ option turns off the effect of any preceding
 .Fl P
 options.
 .It Xo echo Op Fl n
-.Ar args... 
+.Ar args...
 .Xc
 Print the arguments on the standard output, separated by spaces.
 Unless the
@@ -1417,7 +1416,6 @@ and
 and the option
 .Op c ,
 which requires an argument.
-.Pp
 .Bd -literal -offset indent
 while getopts abc: f
 do
@@ -1431,7 +1429,6 @@ shift `expr $OPTIND - 1`
 .Ed
 .Pp
 This code will accept any of the following as equivalent:
-.Pp
 .Bd -literal -offset indent
 cmd \-acarg file file
 cmd \-a \-c arg file file
@@ -1522,7 +1519,6 @@ variables.
 With the
 .Fl p
 option specified the output will be formatted suitably for non-interactive use.
-.Pp
 .It Xo printf Ar format
 .Op Ar arguments  ...
 .Xc
@@ -1814,7 +1810,7 @@ If n is greater than the number of positional parameters,
 .Ic shift
 will issue an error message, and exit with return status 2.
 .It test Ar expression
-.It \&[ Ar expression Cm ]
+.It \&[ Ar expression No \&]
 The
 .Ic test
 utility evaluates the expression and, if it evaluates
@@ -2176,7 +2172,6 @@ the current limit is displayed.
 Limits of an arbitrary process can be displayed or set using the
 .Xr sysctl 8
 utility.
-.Pp
 .It umask Op Ar mask
 Set the value of umask (see
 .Xr umask 2 )
@@ -2233,15 +2228,6 @@ will throw you into command VI command mode.
 Hitting
 .Aq return
 while in command mode will pass the line to the shell.
-.Sh EXIT STATUS
-Errors that are detected by the shell, such as a syntax error, will cause the
-shell to exit with a non-zero exit status.
-If the shell is not an
-interactive shell, the execution of the shell file will be aborted.
-Otherwise
-the shell will return the exit status of the last command executed, or
-if the exit builtin is used with a numeric argument, it will return the
-argument.
 .Sh ENVIRONMENT
 .Bl -tag -width MAILCHECK
 .It Ev HOME
@@ -2318,12 +2304,21 @@ command.
 The process ID of the parent process of the shell.
 .El
 .Sh FILES
-.Bl -item -width HOMEprofilexxxx
-.It
-.Pa $HOME/.profile
-.It
-.Pa /etc/profile
+.Bl -tag -width "$HOME/.profileXX" -compact
+.It Pa $HOME/.profile
+User's login profile.
+.It Pa /etc/profile
+System login profile.
 .El
+.Sh EXIT STATUS
+Errors that are detected by the shell, such as a syntax error, will cause the
+shell to exit with a non-zero exit status.
+If the shell is not an
+interactive shell, the execution of the shell file will be aborted.
+Otherwise
+the shell will return the exit status of the last command executed, or
+if the exit builtin is used with a numeric argument, it will return the
+argument.
 .Sh SEE ALSO
 .Xr csh 1 ,
 .Xr echo 1 ,
-- 
2.8.0


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0002-man-fix-a-typo.patch"

From 8a8a9d25a3a784c225d9fdb99c1b1eec5604c953 Mon Sep 17 00:00:00 2001
From: Svyatoslav Mishyn <juef@openmailbox.org>
Date: Fri, 13 May 2016 11:01:17 +0300
Subject: [PATCH 2/2] man: fix a typo

iff => if
---
 src/dash.1 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/dash.1 b/src/dash.1
index 57e731a..9ef14a8 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -606,10 +606,10 @@ and
 .Dq ||
 are AND-OR list operators.
 .Dq &&
-executes the first command, and then executes the second command iff the
+executes the first command, and then executes the second command if the
 exit status of the first command is zero.
 .Dq ||
-is similar, but executes the second command iff the exit status of the first
+is similar, but executes the second command if the exit status of the first
 command is nonzero.
 .Dq &&
 and
-- 
2.8.0


--GID0FwUMdk1T2AWN--
