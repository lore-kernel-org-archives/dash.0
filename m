From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: build issues when using pcc
Date: Sun, 22 May 2011 11:46:05 -0500
Message-ID: <20110522164605.GA8654@elie>
References: <20110522123414.GD6142@port70.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52967 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747Ab1EVQqP (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 22 May 2011 12:46:15 -0400
Received: by iyb14 with SMTP id 14so4049288iyb.19
        for <dash@vger.kernel.org>; Sun, 22 May 2011 09:46:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110522123414.GD6142@port70.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Szabolcs Nagy <nsz@port70.net>
Cc: dash@vger.kernel.org

Hi,

Szabolcs Nagy wrote:

> hello i compiled dash with pcc and found two issues:
>
> src/output.h the outc macro is not standard c:

Thanks.  I tried and succeeded in reproducing this first one by
noticing that "gcc -pedantic" produces a warning.  It also produces
many other warnings --- for example, one about use of statement
expressions in src/error.h.  It might be nice to fix more of these.

> the following line
> < $builtins sed '/^#/d; /^$/d' > $temp
> should be
> < $builtins sed '/^#/d; /^ *$/d' > $temp
>
> so empty lines with spaces are dropped as well
> (allowed by the standard after the preprocessing pass)

What cpp do you use (so others can catch similar problems in the
future)?
 
Looking over the C standard, it seems that if cc -E were exactly
carrying out translation phases 1-4 (which it isn't :)) then we would
expect each comment to be transformed to a single space character.  So
this looks like a good fix for portability.

> (also it would be nice to include a configure script in
> the git repo,

No, it would not be nice.

> or don't use autoconf in the first place)

The nice things automake offers for dash are support for
cross-compilation, dependency detection using gcc -MD, and VPATH
builds.  I am a nobody, so my opinion does not mean much, but: I would
be very happy to use a plain makefile that can do those things, too.

In that imagined scheme, the configure script would stick to what it
is best at --- detecting information about the platform and
configuration.  The configure script output could go in a makefile
fragment that the makefile uses with an "include" directive (relying
on sane defaults when it is not present).  The git project is an
example of this (though missing features like cross-compilation and
VPATH builds).

I'd be happy to help out with that (as an alternate build system at
first).

Thanks and hope that helps.

-- >8 --
Subject: [OUTPUT] Make outc an inline function

As "gcc -pedantic" warns, ISO C forbids conditional expressions with
only one void side.  So the (needslow ?  slowpath() : fastpath) code
for outc in the !USE_GLIBC_STDIO case might not be portable.

More importantly, it's hard to read.  Rip it out and replace it
with an inline function which should generate the same code.

Reported-by: Szabolcs Nagy <nsz@port70.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Not even compile-tested.

 src/output.h |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/src/output.h b/src/output.h
index d123301..4632329 100644
--- a/src/output.h
+++ b/src/output.h
@@ -97,10 +97,21 @@ freestdout()
 #define OUTPUT_ERR 01		/* error occurred on output */
 
 #ifdef USE_GLIBC_STDIO
-#define outc(c, o)	putc((c), (o)->stream)
+static inline void outc(int ch, struct output *file)
+{
+	putc(ch, file->stream);
+}
 #define doformat(d, f, a)	vfprintf((d)->stream, (f), (a))
 #else
-#define outc(c, file)	((file)->nextc == (file)->end ? outcslow((c), (file)) : (*(file)->nextc = (c), (file)->nextc++))
+static inline void outc(int ch, struct output *file)
+{
+	if (file->nextc != file->end) {
+		*file->nextc = ch;
+		file->nextc++;
+		return;
+	}
+	outcslow(ch, file);
+}
 #endif
 #define out1c(c)	outc((c), out1)
 #define out2c(c)	outcslow((c), out2)
-- 
1.7.5.1
