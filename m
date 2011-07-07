From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] [MAIN] Optimize dash -c "command" to avoid a fork
Date: Thu, 7 Jul 2011 03:37:03 -0500
Message-ID: <20110707083703.GA21365@elie>
References: <20110410071734.GA16736@elie>
 <20110410073649.GD17649@elie>
 <20110707034833.GC16157@gondor.apana.org.au>
 <20110707042753.GA7684@elie>
 <20110707045719.GA16810@gondor.apana.org.au>
 <20110707055602.GA17215@gondor.apana.org.au>
 <20110707074856.GC11514@elie>
 <20110707082253.GA18209@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59820 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754908Ab1GGIhN (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 7 Jul 2011 04:37:13 -0400
Received: by iwn6 with SMTP id 6so647363iwn.19
        for <dash@vger.kernel.org>; Thu, 07 Jul 2011 01:37:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110707082253.GA18209@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org, Jilles Tjoelker <jilles@stack.nl>, Drake Wilson <drake@begriffli.ch>, Reuben Thomas <rrt@sc3d.org>

Herbert Xu wrote:
> On Thu, Jul 07, 2011 at 02:48:56AM -0500, Jonathan Nieder wrote:

>> mksyntax #include-s parser.h, so after a "make clean":
>> 
>> 	gcc -include ../config.h -DBSD=1 -DSHELL -DIFS_BROKEN  -g -Os -Wall -o mksyntax mksyntax.c
>> 	In file included from mksyntax.c:43:0:
>> 	parser.h:37:19: fatal error: token.h: No such file or directory
>> 
>> The following (on top) fixes it here.
>
> Oops, does this patch fix it?

Yes, thanks!  Silly me, mistaking mksyntax for mktokens...

The following works, too.
---
diff --git i/src/Makefile.am w/src/Makefile.am
index 05ed70a1..de193dd4 100644
--- i/src/Makefile.am
+++ w/src/Makefile.am
@@ -65,5 +65,7 @@ syntax.c syntax.h: mksyntax
 signames.c: mksignames
 	./$^
 
+mksyntax: token.h
+
 $(HELPERS): %: %.c
 	$(COMPILE_FOR_BUILD) -o $@ $<
-- 
