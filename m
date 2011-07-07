From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 4/4] [MAIN] Optimize dash -c "command" to avoid a fork
Date: Thu, 7 Jul 2011 16:22:53 +0800
Message-ID: <20110707082253.GA18209@gondor.apana.org.au>
References: <20110410071734.GA16736@elie> <20110410073649.GD17649@elie> <20110707034833.GC16157@gondor.apana.org.au> <20110707042753.GA7684@elie> <20110707045719.GA16810@gondor.apana.org.au> <20110707055602.GA17215@gondor.apana.org.au> <20110707074856.GC11514@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:45154 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384Ab1GGIW6 (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 7 Jul 2011 04:22:58 -0400
Content-Disposition: inline
In-Reply-To: <20110707074856.GC11514@elie>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: dash@vger.kernel.org, Jilles Tjoelker <jilles@stack.nl>, Drake Wilson <drake@begriffli.ch>, Reuben Thomas <rrt@sc3d.org>

On Thu, Jul 07, 2011 at 02:48:56AM -0500, Jonathan Nieder wrote:
>
> By the way, is the pungetc() call needed?  I tried to provoke
> misbehavior using here documents and reading from the terminal but
> didn't manage to come up with a relevant scenario.

It's probably not needed.  I didn't touch it in order to minimise
the changes.

> mksyntax #include-s parser.h, so after a "make clean":
> 
> 	gcc -include ../config.h -DBSD=1 -DSHELL -DIFS_BROKEN  -g -Os -Wall -o mksyntax mksyntax.c
> 	In file included from mksyntax.c:43:0:
> 	parser.h:37:19: fatal error: token.h: No such file or directory
> 
> The following (on top) fixes it here.

Oops, does this patch fix it?

diff --git a/src/Makefile.am b/src/Makefile.am
index 05ed70a..a552087 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -12,7 +12,8 @@ AM_CFLAGS_FOR_BUILD = -g -O2 $(COMMON_CFLAGS)
 AM_CPPFLAGS_FOR_BUILD = $(COMMON_CPPFLAGS)
 
 COMPILE_FOR_BUILD = \
-	$(CC_FOR_BUILD) $(AM_CPPFLAGS_FOR_BUILD) $(CPPFLAGS_FOR_BUILD) \
+	$(CC_FOR_BUILD) $(DEFAULT_INCLUDES) $(AM_CPPFLAGS_FOR_BUILD) \
+	$(CPPFLAGS_FOR_BUILD) \
 	$(AM_CFLAGS_FOR_BUILD) $(CFLAGS_FOR_BUILD) 
 
 bin_PROGRAMS = dash
@@ -31,12 +32,12 @@ dash_SOURCES = \
 	show.h system.h trap.h var.h
 dash_LDADD = builtins.o init.o nodes.o signames.o syntax.o
 
-HELPERS = mkinit mksyntax mknodes mksignames
+HELPERS = mkinit mknodes mksignames
 
 BUILT_SOURCES = builtins.h nodes.h syntax.h token.h token_vars.h
 CLEANFILES = \
 	$(BUILT_SOURCES) $(patsubst %.o,%.c,$(dash_LDADD)) \
-	$(HELPERS) builtins.def
+	$(HELPERS) mksyntax builtins.def
 
 man_MANS = dash.1
 EXTRA_DIST = \
@@ -65,5 +66,8 @@ syntax.c syntax.h: mksyntax
 signames.c: mksignames
 	./$^
 
+mksyntax: mksyntax.c token.h
+	$(COMPILE_FOR_BUILD) -o $@ $<
+
 $(HELPERS): %: %.c
 	$(COMPILE_FOR_BUILD) -o $@ $<

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
