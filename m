From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] echo: fix octal escaping with \1...\7
Date: Mon, 31 Oct 2011 14:41:58 +1100
Message-ID: <20111031034146.GA19477@gondor.apana.org.au>
References: <1319579884-423-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:33828 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089Ab1JaDmD (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 30 Oct 2011 23:42:03 -0400
Content-Disposition: inline
In-Reply-To: <1319579884-423-1-git-send-email-vapier@gentoo.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: dash@vger.kernel.org

Mike Frysinger <vapier@gentoo.org> wrote:
> POSIX states that octal escape sequences should take the form \0num
> when using echo.  dash however additionally treats \num as an octal
> sequence.  This breaks some packages (like libtool) who attempt to
> use strings with these escape sequences via variables to execute sed
> (since sed ends up getting passed a byte instead of a literal \1).

OK this is a bit of problem.  From our conversation I had the
impression that you were referring to the lack of support of
escape codes, rather than unwanted support.

If it was the former I could easily add it if POSIX said so,
however, as this is an existing feature there may well be scripts
out there that depend on it.  So removing it is not an option
unless it is explicitly forbidden by POSIX.

In any case, scripts that rely on escape codes like this are
simply broken and should either be fixed to use printf or just
run with #!/bin/bash.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
