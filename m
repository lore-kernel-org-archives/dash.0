From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Subject: [PATCH] dash: man pages: fix formatting
Date: Wed, 24 Jun 2020 02:54:25 +0000
Message-ID: <20200624025425.GA30926@rhi.hi.is>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387985AbgFXDE2 (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 23 Jun 2020 23:04:28 -0400
Received: from outpost.hi.is (outpost.hi.is [IPv6:2a00:c88:4000:1650::165:166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FB0C061573
        for <dash@vger.kernel.org>; Tue, 23 Jun 2020 20:04:27 -0700 (PDT)
Received: from inpost.hi.is (inpost.hi.is [IPv6:2a00:c88:4000:1650::165:62])
        by outpost.hi.is (8.14.7/8.14.7) with ESMTP id 05O2sV4j023475
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <dash@vger.kernel.org>; Wed, 24 Jun 2020 02:54:31 GMT
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by inpost.hi.is (8.14.7/8.14.7) with ESMTP id 05O2sQXV022126
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <dash@vger.kernel.org>; Wed, 24 Jun 2020 02:54:26 GMT
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id 05O2sQ4o030965
        for <dash@vger.kernel.org>; Wed, 24 Jun 2020 02:54:26 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id 05O2sP77030964
        for dash@vger.kernel.org; Wed, 24 Jun 2020 02:54:25 GMT
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

  Fix formatting according to the output of "mandoc -Tlint".

Overview:

  Start each sentence on a new line.

  Protect a punctuation mark in a macro call with '\&'.

  Trim trailing space.

  Add a missing comma in a row of words.

  Use an en-dash instead of '--' if there is space around it.
  An em-dash is used without space around it.

  Comment out ".Pp" macros that do nothing.

  Split long sentences after a punctuation mark.

  Remove a "-width ..." for a ".Bl -item" macro, as it has no influence

Details:

mandoc: ./src/bltin/echo.1:69:38: WARNING: new sentence, new line
mandoc: ./src/bltin/echo.1:75:35: WARNING: new sentence, new line
mandoc: ./src/bltin/printf.1:205:12: WARNING: skipping empty macro: No
mandoc: ./src/bltin/printf.1:284:28: STYLE: whitespace at end of input line
mandoc: ./src/bltin/printf.1:288:20: STYLE: whitespace at end of input line
mandoc: ./src/bltin/printf.1:293:28: STYLE: whitespace at end of input line
mandoc: ./src/bltin/printf.1:353:31: WARNING: new sentence, new line
mandoc: ./src/bltin/printf.1:74:2: STYLE: useless macro: Tn
mandoc: ./src/bltin/printf.1:111:2: STYLE: useless macro: Tn
mandoc: ./src/bltin/printf.1:116:2: STYLE: useless macro: Tn
mandoc: ./src/bltin/printf.1:279:2: STYLE: useless macro: Tn
mandoc: ./src/bltin/printf.1:334:2: WARNING: unusual Xr punctuation: none before vis(3)
mandoc: ./src/bltin/printf.1:334:2: WARNING: unusual Xr order: vis(3) after printf(9)
mandoc: ./src/bltin/printf.1:348:2: STYLE: useless macro: Tn
mandoc: ./src/bltin/printf.1:333:6: STYLE: referenced manual not found: Xr printf 9
mandoc: ./src/bltin/printf.1:334:6: STYLE: referenced manual not found: Xr vis 3
mandoc: ./src/bltin/test.1:46:16: WARNING: skipping empty macro: Cm
mandoc: ./src/bltin/test.1:105:5: STYLE: useless macro: Tn
mandoc: ./src/dash.1:1180:58: WARNING: new sentence, new line
mandoc: ./src/dash.1:1186:13: STYLE: whitespace at end of input line
mandoc: ./src/dash.1:1194:38: WARNING: new sentence, new line
mandoc: ./src/dash.1:1200:35: WARNING: new sentence, new line
mandoc: ./src/dash.1:1474:71: WARNING: new sentence, new line
mandoc: ./src/dash.1:1783:62: WARNING: new sentence, new line
mandoc: ./src/dash.1:2061:22: WARNING: new sentence, new line
mandoc: ./src/dash.1:2311:54: WARNING: new sentence, new line
mandoc: ./src/dash.1:2315:63: WARNING: new sentence, new line
mandoc: ./src/dash.1:37:2: WARNING: prologue macros out of order: Dt after Os
mandoc: ./src/dash.1:87:2: STYLE: useless macro: Tn
mandoc: ./src/dash.1:94:2: STYLE: useless macro: Tn
mandoc: ./src/dash.1:343:2: STYLE: useless macro: Tn
mandoc: ./src/dash.1:442:17: STYLE: verbatim "--", maybe consider using \(em
mandoc: ./src/dash.1:466:2: STYLE: useless macro: Tn
mandoc: ./src/dash.1:581:34: STYLE: verbatim "--", maybe consider using \(em
mandoc: ./src/dash.1:583:25: STYLE: verbatim "--", maybe consider using \(em
mandoc: ./src/dash.1:585:43: STYLE: verbatim "--", maybe consider using \(em
mandoc: ./src/dash.1:595:11: STYLE: verbatim "--", maybe consider using \(em
mandoc: ./src/dash.1:618:29: STYLE: verbatim "--", maybe consider using \(em
mandoc: ./src/dash.1:697:2: WARNING: skipping paragraph macro: Pp before Bd
mandoc: ./src/dash.1:1344:2: STYLE: useless macro: Tn
mandoc: ./src/dash.1:1420:2: WARNING: skipping paragraph macro: Pp before Bd
mandoc: ./src/dash.1:1434:2: WARNING: skipping paragraph macro: Pp before Bd
mandoc: ./src/dash.1:1556:2: STYLE: useless macro: Tn
mandoc: ./src/dash.1:1587:2: STYLE: useless macro: Tn
mandoc: ./src/dash.1:1746:2: STYLE: useless macro: Tn
mandoc: ./src/dash.1:1875:5: STYLE: useless macro: Tn
mandoc: ./src/dash.1:1525:2: WARNING: skipping paragraph macro: Pp before It
mandoc: ./src/dash.1:2182:2: WARNING: skipping paragraph macro: Pp before It
mandoc: ./src/dash.1:2247:2: WARNING: sections out of conventional order: Sh ENVIRONMENT
mandoc: ./src/dash.1:2323:11: WARNING: skipping -width argument: Bl -item
mandoc: ./src/dash.1:2347:31: STYLE: consider using OS macro: Nx
mandoc: ./src/dash.1:92:6: STYLE: referenced manual not found: Xr ksh 1 (2 times)
mandoc: ./src/dash.1:253:6: STYLE: referenced manual not found: Xr emacs 1
mandoc: ./src/dash.1:2253:9: STYLE: referenced manual not found: Xr passwd 4
mandoc: ./src/dash.1:2330:6: STYLE: referenced manual not found: Xr csh 1

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 src/bltin/echo.1   |  6 +++--
 src/bltin/printf.1 | 13 ++++++-----
 src/bltin/test.1   |  2 +-
 src/dash.1         | 57 +++++++++++++++++++++++++++-------------------
 4 files changed, 45 insertions(+), 33 deletions(-)

diff --git a/src/bltin/echo.1 b/src/bltin/echo.1
index fbc7fb4..4d1890f 100644
--- a/src/bltin/echo.1
+++ b/src/bltin/echo.1
@@ -66,13 +66,15 @@ and
 may be given.
 .Pp
 If any of the following sequences of characters is encountered during
-output, the sequence is not output.  Instead, the specified action is
+output, the sequence is not output.
+Instead, the specified action is
 performed:
 .Bl -tag -width indent
 .It Li \eb
 A backspace character is output.
 .It Li \ec
-Subsequent output is suppressed.  This is normally used at the end of the
+Subsequent output is suppressed.
+This is normally used at the end of the
 last argument to suppress the trailing newline that
 .Nm
 would otherwise output.
diff --git a/src/bltin/printf.1 b/src/bltin/printf.1
index 3873173..409d434 100644
--- a/src/bltin/printf.1
+++ b/src/bltin/printf.1
@@ -202,7 +202,7 @@ and
 formats, or the maximum number of characters to be printed
 from a string
 .Sm off
-.Pf ( Cm b No ,
+.Pf ( Cm b Ns \&,
 .Sm on
 .Cm B
 and
@@ -281,16 +281,16 @@ value is the 1\-, 2\-, or 3\-digit
 octal number
 .Ar num .
 .It Cm \e^ Ns Ar c
-Write the control character 
+Write the control character
 .Ar c .
 Generates characters `\e000' through `\e037`, and `\e177' (from `\e^?').
 .It Cm \eM\- Ns Ar c
-Write the character 
+Write the character
 .Ar c
 with the 8th bit set.
 Generates characters `\e241' through `\e376`.
 .It Cm \eM^ Ns Ar c
-Write the control character 
+Write the control character
 .Ar c
 with the 8th bit set.
 Generates characters `\e000' through `\e037`, and `\e177' (from `\eM^?').
@@ -330,7 +330,7 @@ exits 0 on success, 1 on failure.
 .Sh SEE ALSO
 .Xr echo 1 ,
 .Xr printf 3 ,
-.Xr printf 9
+.Xr printf 9 ,
 .Xr vis 3
 .Sh STANDARDS
 The
@@ -350,5 +350,6 @@ to floating-point and
 then back again, floating-point precision may be lost.
 .Pp
 Hexadecimal character constants are restricted to, and should be specified
-as, two character constants.  This is contrary to the ISO C standard but
+as, two character constants.
+This is contrary to the ISO C standard but
 does guarantee detection of the end of the constant.
diff --git a/src/bltin/test.1 b/src/bltin/test.1
index 42435fb..03abce8 100644
--- a/src/bltin/test.1
+++ b/src/bltin/test.1
@@ -43,7 +43,7 @@
 .Nm test
 .Ar expression
 .Nm \&[
-.Ar expression Cm ]
+.Ar expression Cm \&]
 .Sh DESCRIPTION
 The
 .Nm test
diff --git a/src/dash.1 b/src/dash.1
index 32f6ac0..ff02237 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -33,8 +33,8 @@
 .\"	@(#)sh.1	8.6 (Berkeley) 5/4/95
 .\"
 .Dd January 19, 2003
-.Os
 .Dt DASH 1
+.Os
 .Sh NAME
 .Nm dash
 .Nd command interpreter (shell)
@@ -439,7 +439,7 @@ instead of
 then leading tabs in the here-doc-text are stripped.
 .Ss Search and Execution
 There are three types of commands: shell functions, builtin commands, and
-normal programs -- and the command is searched for (by name) in that order.
+normal programs \(en and the command is searched for (by name) in that order.
 They each are executed in a different way.
 .Pp
 When a shell function is executed, all of the shell positional parameters
@@ -578,11 +578,11 @@ the preceding AND-OR-list.
 .Pp
 Note that unlike some other shells, each process in the pipeline is a
 child of the invoking shell (unless it is a shell builtin, in which case
-it executes in the current shell -- but any effect it has on the
+it executes in the current shell \(en but any effect it has on the
 environment is wiped).
-.Ss Background Commands -- &
+.Ss Background Commands \(en &
 If a command is terminated by the control operator ampersand (&), the
-shell executes the command asynchronously -- that is, the shell does not
+shell executes the command asynchronously \(en that is, the shell does not
 wait for the command to finish before executing the next command.
 .Pp
 The format for running a command in background is:
@@ -592,7 +592,7 @@ The format for running a command in background is:
 If the shell is not interactive, the standard input of an asynchronous
 command is set to
 .Pa /dev/null .
-.Ss Lists -- Generally Speaking
+.Ss Lists \(en Generally Speaking
 A list is a sequence of zero or more commands separated by newlines,
 semicolons, or ampersands, and optionally terminated by one of these three
 characters.
@@ -615,7 +615,7 @@ of the first command is nonzero.
 and
 .Dq ||
 both have the same priority.
-.Ss Flow-Control Constructs -- if, while, for, case
+.Ss Flow-Control Constructs \(en if, while, for, case
 The syntax of the if command is
 .Bd -literal -offset indent
 if list
@@ -694,7 +694,7 @@ Builtin commands grouped into a (list) will not affect the current shell.
 The second form does not fork another shell so is slightly more efficient.
 Grouping commands together this way allows you to redirect
 their output as though they were one program:
-.Pp
+.\".Pp
 .Bd -literal -offset indent
 { printf \*q hello \*q ; printf \*q world\\n" ; } \*[Gt] greeting
 .Ed
@@ -1177,13 +1177,14 @@ mechanism was used or because the argument is a single dash.
 The
 .Fl P
 option causes the physical directory structure to be used, that is, all
-symbolic links are resolved to their respective values.  The
+symbolic links are resolved to their respective values.
+The
 .Fl L
 option turns off the effect of any preceding
 .Fl P
 options.
 .It Xo echo Op Fl n
-.Ar args... 
+.Ar args...
 .Xc
 Print the arguments on the standard output, separated by spaces.
 Unless the
@@ -1191,13 +1192,15 @@ Unless the
 option is present, a newline is output following the arguments.
 .Pp
 If any of the following sequences of characters is encountered during
-output, the sequence is not output.  Instead, the specified action is
+output, the sequence is not output.
+Instead, the specified action is
 performed:
 .Bl -tag -width indent
 .It Li \eb
 A backspace character is output.
 .It Li \ec
-Subsequent output is suppressed.  This is normally used at the end of the
+Subsequent output is suppressed.
+This is normally used at the end of the
 last argument to suppress the trailing newline that
 .Ic echo
 would otherwise output.
@@ -1417,7 +1420,7 @@ and
 and the option
 .Op c ,
 which requires an argument.
-.Pp
+.\".Pp
 .Bd -literal -offset indent
 while getopts abc: f
 do
@@ -1431,7 +1434,7 @@ shift `expr $OPTIND - 1`
 .Ed
 .Pp
 This code will accept any of the following as equivalent:
-.Pp
+.\".Pp
 .Bd -literal -offset indent
 cmd \-acarg file file
 cmd \-a \-c arg file file
@@ -1471,7 +1474,8 @@ will continue to print the old name for the directory.
 The
 .Fl P
 option causes the physical value of the current working directory to be shown,
-that is, all symbolic links are resolved to their respective values.  The
+that is, all symbolic links are resolved to their respective values.
+The
 .Fl L
 option turns off the effect of any preceding
 .Fl P
@@ -1522,7 +1526,7 @@ variables.
 With the
 .Fl p
 option specified the output will be formatted suitably for non-interactive use.
-.Pp
+.\".Pp
 .It Xo printf Ar format
 .Op Ar arguments  ...
 .Xc
@@ -1780,9 +1784,11 @@ If options are given, it sets the specified option
 flags, or clears them as described in the section called
 .Sx Argument List Processing .
 As a special case, if the option is -o or +o and no argument is
-supplied, the shell prints the settings of all its options.  If the
-option is -o, the settings are printed in a human-readable format; if
-the option is +o, the settings are printed in a format suitable for
+supplied, the shell prints the settings of all its options.
+If the option is -o,
+the settings are printed in a human-readable format;
+if the option is +o,
+the settings are printed in a format suitable for
 reinput to the shell to affect the same option settings.
 .Pp
 The third use of the set command is to set the values of the shell's
@@ -2058,7 +2064,8 @@ operator has higher precedence than the
 operator.
 .It times
 Print the accumulated user and system times for the shell and for processes
-run from the shell.  The return status is 0.
+run from the shell.
+The return status is 0.
 .It Xo trap
 .Op Ar action Ar signal ...
 .Xc
@@ -2179,7 +2186,7 @@ the current limit is displayed.
 Limits of an arbitrary process can be displayed or set using the
 .Xr sysctl 8
 utility.
-.Pp
+.\".Pp
 .It umask Op Ar mask
 Set the value of umask (see
 .Xr umask 2 )
@@ -2308,11 +2315,13 @@ children of the shell, and is used in the history editing modes.
 .It Ev HISTSIZE
 The number of lines in the history buffer for the shell.
 .It Ev PWD
-The logical value of the current working directory.  This is set by the
+The logical value of the current working directory.
+This is set by the
 .Ic cd
 command.
 .It Ev OLDPWD
-The previous logical value of the current working directory.  This is set by
+The previous logical value of the current working directory.
+This is set by
 the
 .Ic cd
 command.
@@ -2320,7 +2329,7 @@ command.
 The process ID of the parent process of the shell.
 .El
 .Sh FILES
-.Bl -item -width HOMEprofilexxxx
+.Bl -item
 .It
 .Pa $HOME/.profile
 .It
-- 
2.27.0
