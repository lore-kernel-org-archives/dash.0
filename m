From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: [PATCH 2/2] histedit: Remove non-glibc fallback code
Date: Thu, 4 Aug 2016 17:59:08 +0200
Message-ID: <20160804155908.GA94936@stack.nl>
References: <20160804055411.23558-1-somasissounds@gmail.com>
 <20160804055411.23558-2-somasissounds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:63487 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758737AbcHDQAa (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 4 Aug 2016 12:00:30 -0400
Content-Disposition: inline
In-Reply-To: <20160804055411.23558-2-somasissounds@gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Kylie McClain <somasissounds@gmail.com>
Cc: dash@vger.kernel.org, Kylie McClain <somasis@exherbo.org>

On Thu, Aug 04, 2016 at 01:54:11AM -0400, Kylie McClain wrote:
> From: Kylie McClain <somasis@exherbo.org>

> This fallback code seems to go back the import of the repository back
> in 2005, it fails on musl libc, and there aren't any comments
> explaining why this difference is needed. Regardless, any
> compatibility ifdefs should probably be checking macros defined on
> systems that need a different code path, rather than just having
> fallback code for non-glibc.

Setting optreset is required on FreeBSD and NetBSD which do not
recognize setting optind to 0. POSIX specifies neither of these methods
to reset getopt().

However, removing the dependency on this feature is simple. The shell
already features a function nextopt() that can be used to parse options
and is automatically set up for builtins.

From 23da600dcff616662a93f307420d9142598e2cae Mon Sep 17 00:00:00 2001
From: Jilles Tjoelker <jilles@stack.nl>
Date: Thu, 4 Aug 2016 17:51:12 +0200
Subject: [PATCH 1/2] [HISTEDIT] Stop depending on getopt reset feature.

Instead, use our own nextopt() function.
---
 src/histedit.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/src/histedit.c b/src/histedit.c
index 94465d7..ec45065 100644
--- a/src/histedit.c
+++ b/src/histedit.c
@@ -214,13 +214,8 @@ histcmd(int argc, char **argv)
 	if (argc == 1)
 		sh_error("missing history argument");
 
-#ifdef __GLIBC__
-	optind = 0;
-#else
-	optreset = 1; optind = 1; /* initialize getopt */
-#endif
 	while (not_fcnumber(argv[optind]) &&
-	      (ch = getopt(argc, argv, ":e:lnrs")) != -1)
+	      (ch = nextopt(":e:lnrs")) != '\0')
 		switch ((char)ch) {
 		case 'e':
 			editor = optionarg;
-- 
2.9.2

-- 
Jilles Tjoelker
