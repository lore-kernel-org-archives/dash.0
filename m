From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] [MAIN] Optimize dash -c "command" to avoid a fork
Date: Thu, 7 Jul 2011 02:48:56 -0500
Message-ID: <20110707074856.GC11514@elie>
References: <20110410071734.GA16736@elie>
 <20110410073649.GD17649@elie>
 <20110707034833.GC16157@gondor.apana.org.au>
 <20110707042753.GA7684@elie>
 <20110707045719.GA16810@gondor.apana.org.au>
 <20110707055602.GA17215@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33967 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735Ab1GGHtC (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 7 Jul 2011 03:49:02 -0400
Received: by iyb12 with SMTP id 12so641424iyb.19
        for <dash@vger.kernel.org>; Thu, 07 Jul 2011 00:49:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110707055602.GA17215@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org, Jilles Tjoelker <jilles@stack.nl>, Drake Wilson <drake@begriffli.ch>, Reuben Thomas <rrt@sc3d.org>

Herbert Xu wrote:

> OK, what about this patch?

Neat.  Let's see:

> --- a/src/parser.c
> +++ b/src/parser.c
[...]
> @@ -210,6 +210,7 @@ list(int nlflag)
>  				parseheredoc();
>  			else
>  				pungetc();		/* push back EOF on input */
> +			tokpushback++;
>  			return n1;
>  		default:
>  			if (nlflag == 1)

This means to push back the TEOF instead of calling pgetc again and
again.  Should be safe.

By the way, is the pungetc() call needed?  I tried to provoke
misbehavior using here documents and reading from the terminal but
didn't manage to come up with a relevant scenario.

> --- a/src/parser.h
> +++ b/src/parser.h
> @@ -34,6 +34,8 @@
>   *	@(#)parser.h	8.3 (Berkeley) 5/4/95
>   */
>  
> +#include "token.h"

mksyntax #include-s parser.h, so after a "make clean":

	gcc -include ../config.h -DBSD=1 -DSHELL -DIFS_BROKEN  -g -Os -Wall -o mksyntax mksyntax.c
	In file included from mksyntax.c:43:0:
	parser.h:37:19: fatal error: token.h: No such file or directory

The following (on top) fixes it here.
---
 src/parser.c |    1 +
 src/parser.h |   11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/parser.c b/src/parser.c
index 6de27629..9c0ef606 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -40,6 +40,7 @@
 
 #include "shell.h"
 #include "parser.h"
+#include "token.h"
 #include "nodes.h"
 #include "expand.h"	/* defines rmescapes() */
 #include "exec.h"	/* defines find_builtin() */
diff --git a/src/parser.h b/src/parser.h
index 2875cce6..8735890e 100644
--- a/src/parser.h
+++ b/src/parser.h
@@ -34,8 +34,6 @@
  *	@(#)parser.h	8.3 (Berkeley) 5/4/95
  */
 
-#include "token.h"
