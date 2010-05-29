From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: [PATCH 4/4] [VAR] Replace cmdenviron with localvars
Date: Sat, 29 May 2010 15:45:55 +0200
Message-ID: <20100529134554.GA63742@stack.nl>
References: <20100526105948.GA26352@gondor.apana.org.au>
 <E1OHELi-0006sy-Nn@gondolin.me.apana.org.au>
 <20100526223723.GB5679@stack.nl>
 <20100527035141.GB5323@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:53739 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757272Ab0E2Np5 (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 29 May 2010 09:45:57 -0400
Content-Disposition: inline
In-Reply-To: <20100527035141.GB5323@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org, pape@smarden.org

On Thu, May 27, 2010 at 01:51:41PM +1000, Herbert Xu wrote:
>     In order to ensure that local still works, it is now a special
>     built-in.

Although there are reasons to do this (a 'local' function containing
'command local' would not work, and export, readonly and ksh93's typeset
are special as well), consensus seems to be for local to be a regular
builtin. posh's local was special for a short time, but this was then
reverted.

Nevertheless, it is very nice to have IFS=: read ... working again.

-- 
Jilles Tjoelker
