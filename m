Received: from mx.sdf.org (mx.sdf.org [205.166.94.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EAF3B4E83
	for <dash@vger.kernel.org>; Tue, 26 May 2026 21:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.166.94.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832319; cv=none; b=WA/qV0XqrcmUnlRxpztBgW7CElt4kuK7FTH0Xu7WBgFe0y5byI7fMoX+HjFwgeIgj+WDwyxeMq6uZzcZ15F20HBF2PGrZdI3yghRfrdYo39cD8d6OCdnfbri7tFvNr+soQ22F7lS0LeRsr9Ojg/Gxceb5AZ/+xTzSXGB0LKePhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832319; c=relaxed/simple;
	bh=HJ7yR2i8AMFwOWxLxXJ2p+s8I4gddc9wNa4FV1Icj7c=;
	h=Date:From:To:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tTZEOcQkXgOuiuIq6TzFRSeEvAv9bRux3l23H0prsNBBNoCt2ld6PE1AO35ItNjNiGrGto3GoZgFyeBjaiRjCqduysHOs4Dat3xh8A2kd9UmueY4NX4UUbq8au1mD3FRxGiC5XWR+kzzXW2QlN1kTOSXqCaoMjH8aZdavtBhhLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stien.dev; spf=none smtp.mailfrom=stien.dev; arc=none smtp.client-ip=205.166.94.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stien.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=stien.dev
Received: from HQ (pool-99-244-140-233.cpe.net.cable.rogers.com [99.244.140.233])
	(authenticated (0 bits))
	by mx.sdf.org (8.18.1/8.14.3) with ESMTPSA id 64QLp7Vh006924
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
	Tue, 26 May 2026 21:51:10 GMT
Date: Tue, 26 May 2026 18:51:07 -0300
From: Sebastien Peterson-Boudreau <seb@stien.dev>
To: dash@vger.kernel.org, seb@stien.dev
Message-ID: <ahYVy6WxQoNnb7ym@HQ>
Mail-Followup-To: dash@vger.kernel.org
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Sebastien Peterson-Boudreau <seb@stien.dev>
To: dash@vger.kernel.org
Cc: Sebastien Peterson-Boudreau <seb@stien.dev>
Subject: [PATCH] Use literal > and < characters
Date: Tue, 26 May 2026 18:48:09 -0300
Message-ID: <20260526214815.29877-2-seb@stien.dev>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <af6gLe2f_jlMCofg@gondor.apana.org.au>
References: <af6gLe2f_jlMCofg@gondor.apana.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

\*[...] is groff(1) specific syntax, whereas \*(XX is the standard
troff(1) syntax.  Furthermore, groff_mdoc(1) lists the literal
characters `>' and `<' as preferred over the Gt and Lt strings,
which are only defined for compatibility with legacy documents.
NetBSD also uses the literal characters for their sh(1) manual
page (changed in commit 30b9dfc8813e15031a13fc2fc85094b81c71e2b7).
---
Let me know if there is an issue with signing -- as you can see, I'm
using a new email.
 src/dash.1 | 58 +++++++++++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/src/dash.1 b/src/dash.1
index dbc34c9..8e1306f 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -197,7 +197,7 @@ operand and the positional parameters ($1, $2, etc.)
 set from the remaining argument operands.
 .It Fl C Em noclobber
 Don't overwrite existing files with
-.Dq \*[Gt] .
+.Dq > .
 .It Fl e Em errexit
 If not interactive, exit immediately if any untested command fails.
 The exit status of a command is considered to be
@@ -268,9 +268,9 @@ operators (their meaning is discussed later).
 Following is a list of operators:
 .Bl -ohang -offset indent
 .It "Control operators:"
-.Dl &  &&  \&(  \&)  \&;  ;; | || \*[Lt]newline\*[Gt]
+.Dl &  &&  \&(  \&)  \&;  ;; | || <newline>
 .It "Redirection operators:"
-.Dl \*[Lt]  \*[Gt]  \*[Gt]|  \*[Lt]\*[Lt]  \*[Gt]\*[Gt]  \*[Lt]&  \*[Gt]&  \*[Lt]\*[Lt]-  \*[Lt]\*[Gt]
+.Dl <  >  >|  <<  >>  <&  >&  <<-  <>
 .El
 .Ss Quoting
 Quoting is used to remove the special meaning of certain characters or
@@ -298,7 +298,7 @@ and backslash
 .Pq \e .
 The backslash inside double quotes is historically weird, and serves to
 quote only the following characters:
-.Dl $  `  \*q  \e  \*[Lt]newline\*[Gt] .
+.Dl $  `  \*q  \e  <newline> .
 Otherwise it remains literal.
 .Ss Reserved Words
 Reserved words are words that have special meaning to the
@@ -391,25 +391,25 @@ is an optional number between 0 and 9, as in
 .Sq Bq 3 ) ,
 that refers to a file descriptor.
 .Bl -tag -width aaabsfiles -offset indent
-.It [n] Ns \*[Gt] file
+.It [n] Ns > file
 Redirect standard output (or n) to file.
-.It [n] Ns \*[Gt]| file
+.It [n] Ns >| file
 Same, but override the
 .Fl C
 option.
-.It [n] Ns \*[Gt]\*[Gt] file
+.It [n] Ns >> file
 Append standard output (or n) to file.
-.It [n] Ns \*[Lt] file
+.It [n] Ns < file
 Redirect standard input (or n) from file.
-.It [n1] Ns \*[Lt]& Ns n2
+.It [n1] Ns <& Ns n2
 Copy file descriptor n2 as stdin (or fd n1).
-.It [n] Ns \*[Lt]&-
+.It [n] Ns <&-
 Close standard input (or n).
-.It [n1] Ns \*[Gt]& Ns n2
+.It [n1] Ns >& Ns n2
 Copy file descriptor n2 as stdout (or fd n1).
-.It [n] Ns \*[Gt]&-
+.It [n] Ns >&-
 Close standard output (or n).
-.It [n] Ns \*[Lt]\*[Gt] file
+.It [n] Ns <> file
 Open file for reading and writing on standard input (or n).
 .El
 .Pp
@@ -417,7 +417,7 @@ The following redirection is often called a
 .Dq here-document .
 .Bl -item -offset indent
 .It
-.Li [n]\*[Lt]\*[Lt] delimiter
+.Li [n]<< delimiter
 .Dl here-doc-text ...
 .Li delimiter
 .El
@@ -431,9 +431,9 @@ subjected to parameter expansion, command substitution, and arithmetic
 expansion (as described in the section on
 .Dq Expansions ) .
 If the operator is
-.Dq \*[Lt]\*[Lt]-
+.Dq <<-
 instead of
-.Dq \*[Lt]\*[Lt] ,
+.Dq << ,
 then leading tabs in the here-doc-text are stripped.
 .Ss Search and Execution
 There are three types of commands: shell functions, builtin commands, and
@@ -567,7 +567,7 @@ Because pipeline assignment of standard input or standard output or both
 takes place before redirection, it can be modified by redirection.
 For example:
 .Pp
-.Dl $ command1 2\*[Gt]&1 | command2
+.Dl $ command1 2>&1 | command2
 .Pp
 sends both the standard output and standard error of command1
 to the standard input of command2.
@@ -698,7 +698,7 @@ Grouping commands together this way allows you to redirect
 their output as though they were one program:
 .\".Pp
 .Bd -literal -offset indent
-{ printf \*q hello \*q ; printf \*q world\\n" ; } \*[Gt] greeting
+{ printf \*q hello \*q ; printf \*q world\\n" ; } > greeting
 .Ed
 .Pp
 Note that
@@ -764,7 +764,7 @@ numeric.
 A parameter can also be denoted by a number or a special
 character as explained below.
 .Ss Positional Parameters
-A positional parameter is a parameter denoted by a number (n \*[Gt] 0).
+A positional parameter is a parameter denoted by a number (n > 0).
 The shell sets these initially to the values of its command line arguments
 that follow the name of the shell script.
 The
@@ -1627,19 +1627,19 @@ Character escape sequences are in backslash notation as defined in
 The characters and their meanings are as follows:
 .Bl -tag -width Ds -offset indent
 .It Cm \ea
-Write a \*[Lt]bell\*[Gt] character.
+Write a <bell> character.
 .It Cm \eb
-Write a \*[Lt]backspace\*[Gt] character.
+Write a <backspace> character.
 .It Cm \ef
-Write a \*[Lt]form-feed\*[Gt] character.
+Write a <form-feed> character.
 .It Cm \en
-Write a \*[Lt]new-line\*[Gt] character.
+Write a <new-line> character.
 .It Cm \er
-Write a \*[Lt]carriage return\*[Gt] character.
+Write a <carriage return> character.
 .It Cm \et
-Write a \*[Lt]tab\*[Gt] character.
+Write a <tab> character.
 .It Cm \ev
-Write a \*[Lt]vertical tab\*[Gt] character.
+Write a <vertical tab> character.
 .It Cm \e\e
 Write a backslash character.
 .It Cm \e Ns Ar num
@@ -2062,13 +2062,13 @@ True if the strings
 and
 .Ar \&s\&2
 are not identical.
-.It Ar \&s\&1 Cm \&\*[Lt] Ar \&s\&2
+.It Ar \&s\&1 Cm \&< Ar \&s\&2
 True if string
 .Ar \&s\&1
 comes before
 .Ar \&s\&2
 based on the ASCII value of their characters.
-.It Ar \&s\&1 Cm \&\*[Gt] Ar \&s\&2
+.It Ar \&s\&1 Cm \&> Ar \&s\&2
 True if string
 .Ar \&s\&1
 comes after
@@ -2380,7 +2380,7 @@ unless you are the superuser, in which case it defaults to
 .Dq #\  .
 .It Ev PS2
 The secondary prompt string, which defaults to
-.Dq \*[Gt]\  .
+.Dq >\  .
 .It Ev PS4
 Output before each line when execution trace (set -x) is enabled,
 defaults to
-- 
2.54.0

