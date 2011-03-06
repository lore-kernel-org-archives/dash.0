From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: [PATCH] Allow == as synonym for = in test
Date: Sun, 06 Mar 2011 18:01:11 -0500 (EST)
Message-ID: <E1PwMwp-0001iy-B5@fenris.runbox.com>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <dash-owner@vger.kernel.org>
Received: from aibo.runbox.com ([87.238.52.70]:58725 "EHLO aibo.runbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754934Ab1CFXYk convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Sun, 6 Mar 2011 18:24:40 -0500
Received: from [10.9.9.130] (helo=fenris.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.50)
	id 1PwMwp-0006nV-R2
	for dash@vger.kernel.org; Mon, 07 Mar 2011 00:01:11 +0100
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: dwheeler@dwheeler.com

From: David A. Wheeler <dwheeler@dwheeler.com>

The following patch adds support for "==" as a synonym for "=" (is-string-equal) in test, including the documentation and comment changes to note it.

Why add this?
* Many current shell scripts use "==" instead of "=" to determine if strings are equal (as reported by https://wiki.ubuntu.com/DashAsBinSh and other places).  Bash, ksh, and probably other shells already support this, which is why its use is so common.
* Using "==" makes it slightly clearer that this is an equality test and not an assignment (since "=" is used elsewhere in shell for assignment).  Note that this is consistent with C, C++, and many other languages.
* A trivial amount of code is needed to implement it.

This isn't required by POSIX, but "test" in dash already supports tests not in POSIX.  I think it'd be useful to add one that's already in common use.

Signed-off-by: David A. Wheeler <dwheeler@dwheeler.com>

diff --git a/src/bltin/test.1 b/src/bltin/test.1
index 42435fb..56f8163 100644
--- a/src/bltin/test.1
+++ b/src/bltin/test.1
@@ -193,6 +193,12 @@ True if the strings
 and
 .Ar \&s\&2
 are identical.
+.It Ar \&s\&1 Cm \&=\&= Ar \&s\&2
+True if the strings
+.Ar \&s\&1
+and
+.Ar \&s\&2
+are identical (this is a synonym for \&=).
 .It Ar \&s\&1 Cm \&!= Ar \&s\&2
 True if the strings
 .Ar \&s\&1
diff --git a/src/bltin/test.c b/src/bltin/test.c
index 7888f38..5a581ed 100644
--- a/src/bltin/test.c
+++ b/src/bltin/test.c
@@ -31,7 +31,7 @@
        unary-operator ::= "-r"|"-w"|"-x"|"-f"|"-d"|"-c"|"-b"|"-p"|
                "-u"|"-g"|"-k"|"-s"|"-t"|"-z"|"-n"|"-o"|"-O"|"-G"|"-L"|"-S";

-       binary-operator ::= "="|"!="|"-eq"|"-ne"|"-ge"|"-gt"|"-le"|"-lt"|
+       binary-operator ::= "="|"=="|"!="|"-eq"|"-ne"|"-ge"|"-gt"|"-le"|"-lt"|
                        "-nt"|"-ot"|"-ef";
        operand ::= <any legal UNIX file name>
 */
@@ -113,6 +113,7 @@ static struct t_op {
        {"-L",  FILSYM, UNOP},
        {"-S",  FILSOCK,UNOP},
        {"=",   STREQ,  BINOP},
+       {"==",  STREQ,  BINOP},
        {"!=",  STRNE,  BINOP},
        {"<",   STRLT,  BINOP},
        {">",   STRGT,  BINOP},

