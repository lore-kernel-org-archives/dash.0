From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [BUG] regression in builtin echo
Date: Thu, 1 Sep 2016 22:18:30 +0200
Message-ID: <3efcd42c-e20b-3506-3d62-69b85c027ef4@gigawatt.nl>
References: <CAKkO-EgCkv48unwXBjN1JdjSNx3_D1yCZQhde7WJedOFRUDaGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------21ED68BE76733C1204AB08E2"
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter1-k0683s008.csv-networks.nl ([92.48.231.157]:53739
        "EHLO mailfilter1-k0683s008.csv-networks.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751020AbcIAWTG (ORCPT
        <rfc822;dash@vger.kernel.org>); Thu, 1 Sep 2016 18:19:06 -0400
In-Reply-To: <CAKkO-EgCkv48unwXBjN1JdjSNx3_D1yCZQhde7WJedOFRUDaGg@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Luigi Tarenga <luigi.tarenga@gmail.com>, dash@vger.kernel.org

This is a multi-part message in MIME format.
--------------21ED68BE76733C1204AB08E2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/09/16 10:13, Luigi Tarenga wrote:
> hi,
> I just find a problem in the dash distributed with arch linux.
> I didn't tested from dash source but the bug can be easily
> checked:
>
> dash 0.5.9-1
>
> $ echo one two three
> one two three
> $
> $ echo -n one two three
> one$

Yikes.

> with -n option it stop after printing one more parameter...
> do you have the same problem or it's caused by a patch in arch?

That's caused by <http://www.spinics.net/lists/dash/msg00942.html>, not 
by Arch. It's scary that this has gone totally unnoticed for more than a 
year.

While the original code implementing the echo command was overly 
complicated, the simplified version does not do the right thing, as you 
noticed.

Here's another attempt at a simplified implementation.

> Luigi

--------------21ED68BE76733C1204AB08E2
Content-Type: text/x-patch;
 name="echo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="echo.patch"

diff --git a/src/bltin/printf.c b/src/bltin/printf.c
index 9673e10..b7b6d68 100644
--- a/src/bltin/printf.c
+++ b/src/bltin/printf.c
@@ -447,16 +447,20 @@ echocmd(int argc, char **argv)
 	nonl = *++argv ? equal(*argv, "-n") : 0;
 	argv += nonl;
 
-	do {
-		int c;
+	if (*argv) {
+		for (;;) {
+			if (print_escape_str("%s", NULL, NULL, *argv))
+				return 0;
+
+			if (!*++argv)
+				break;
+
+			out1c(' ');
+		}
+	}
 
-		if (likely(*argv))
-			nonl += print_escape_str("%s", NULL, NULL, *argv++);
-		if (nonl > 0)
-			break;
+	if (!nonl)
+		out1c('\n');
 
-		c = *argv ? ' ' : '\n';
-		out1c(c);
-	} while (*argv);
 	return 0;
 }

--------------21ED68BE76733C1204AB08E2--
