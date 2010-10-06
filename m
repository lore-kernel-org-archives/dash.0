From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] [OPTIONS] Use exit status 127 when the script to run does
 not exist
Date: Wed, 6 Oct 2010 05:04:20 -0500
Message-ID: <20101006100420.GA361@burratino>
References: <20100605160651.GA60028@stack.nl>
 <20100614095451.26362.qmail@43559bb7971308.315fe32.mid.smarden.org>
 <20100628065326.GA25667@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61047 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755093Ab0JFKHq (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 6 Oct 2010 06:07:46 -0400
Received: by iwn5 with SMTP id 5so9553188iwn.19
        for <dash@vger.kernel.org>; Wed, 06 Oct 2010 03:07:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100628065326.GA25667@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Gerrit Pape <pape@smarden.org>, dash@vger.kernel.org, "Krzysztof A. Sobiecki" <sobkas@gmail.com>

Currently dash uses exit status 2 to report failure to run a
script named on the command line that does not exist:

 $ sh nonexistent
 sh: Can't open nonexistent
 $ echo $?
 2

According to SUSv3 and SUSv4[1], the exit code should be 127.

So check errno when opening a command_file during argument
processing and exit(127) when it is ENOENT.  This check is in the
argument processing code to avoid collateral damage to code paths
that read scripts (such as the dot builtin).  Other errors (such
as EACCESS) while opening the command_file will still result in
an exit code of 2.

[1] http://www.opengroup.org/onlinepubs/9699919799/utilities/sh.html#tag_20_117_14

Reported-by: Clint Adams <schizo@debian.org>
Fixes: http://bugs.debian.org/548743
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Herbert Xu wrote:

> This is wrong.  You're creating exactly the problem that Jilles
> was talking about where dot(1) is returning 127.  This code should
> be moved to procargs, which runs only for the "sh script" case.

Makes sense.  How does this look?

It still ignores attempts to run "sh directory"; see the next
patch for that.

 src/options.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/src/options.c b/src/options.c
index 6f381e6..5667b68 100644
--- a/src/options.c
+++ b/src/options.c
@@ -37,6 +37,7 @@
 #include <stdlib.h>
 
 #include "shell.h"
+#include "main.h"
 #define DEFINE_OPTIONS
 #include "options.h"
 #undef DEFINE_OPTIONS
@@ -156,7 +157,13 @@ procargs(int argc, char **argv)
 		if (*xargv)
 			goto setarg0;
 	} else if (!sflag) {
-		setinputfile(*xargv, 0);
+		if (setinputfile(*xargv, INPUT_NOFILE_OK) < 0) {
+			if (errno == ENOENT) {
+				exitstatus = 127;
+				exerror(EXEXIT, "Can't open %s", *xargv);
+			}
+			sh_error("Can't open %s", *xargv);
+		}
 setarg0:
 		arg0 = *xargv++;
 		commandname = arg0;
-- 
1.7.2.3

