From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: Porting dash to OpenBSD
Date: Sun, 3 Jul 2011 22:54:59 +0200
Message-ID: <20110703205459.GA49026@stack.nl>
References: <223511309054739@web103.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:61075 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750973Ab1GCUzC (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 3 Jul 2011 16:55:02 -0400
Content-Disposition: inline
In-Reply-To: <223511309054739@web103.yandex.ru>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Mike Korbakov <mike-kmv@yandex.ru>
Cc: dash@vger.kernel.org

On Sun, Jun 26, 2011 at 06:18:59AM +0400, Mike Korbakov wrote:
> Unfortunatly, not all systems (like OpenBSD) has built-in texttools
> like nl, that makes it difficult to port dash, with minimum troubles.

> To reduce dependencies, I suggest using instead of nl other tools like
> awk or cat (as advised openbsd porters team).

> Building dash-0.5.6.1 was successfull with this patch:

> --- src/mkbuiltins.orig Sat Jun  5 13:34:23 2010
> +++ src/mkbuiltins      Sun Jun 26 02:36:23 2011
> @@ -84,7 +84,7 @@ cat <<\!
>   */
> 
>  !
> -sed 's/        -[a-z]*//' $temp2 | nl -v 0 | LC_COLLATE=C sort -u -k 3,3 |
> +sed 's/        -[a-z]*//' $temp2 | awk '{ print "  " FNR-1 "  " $0 }'  | LC_COLLATE=C sort -u -k 3,3 |
>  tr abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ |
>         awk '{  printf "#define %s (builtincmd + %d)\n", $3, $1}'
>  printf '\n#define NUMBUILTINS %d\n' $(wc -l < $temp2)

This looks reasonable. It works here (FreeBSD with somewhat hacked dash
source), leaving the resulting binary unchanged.

A minor nit: comparing with other awk invocations, it seems more usual
to use NR rather than FNR. They both do the same thing if there is only
one input file.

The nl utility has caused more portability problems already; the code in
master has different options. This is so even though nl is in SUSv4
under the XSI option. We already use awk so that should be safer.

-- 
Jilles Tjoelker
