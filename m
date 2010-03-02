From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Invalid signal used with trap causes dash to abort
Date: Tue, 2 Mar 2010 22:39:27 +0800
Message-ID: <20100302143927.GA4247@gondor.apana.org.au>
References: <A612847CFE53224C91B23E3A5B48BAC73EBD7D0507@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:47911 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753654Ab0CBOj3 (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 2 Mar 2010 09:39:29 -0500
Content-Disposition: inline
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC73EBD7D0507@xmail3.se.axis.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: "dash@vger.kernel.org" <dash@vger.kernel.org>

On Wed, Feb 24, 2010 at 10:23:34AM +0000, Peter Kjellerstedt wrote:
> Hi,
> 
> there seems to be a problem  with the trap implementation in dash
> (tested with 0.5.4 and 0.5.5.1). If I specify a signal which is not 
> supported, the shell unconditionally aborts. E.g., I had expected
> the following to print foo (like bash and zsh do):
> 
> # dash -c 'trap "echo trap executed" UNKNOWNSIGNAL || echo "foo"'
> trap: 1: UNKNOWNSIGNAL: bad trap
> 
> This means I cannot write a construct like the following to take 
> advantage of the ERR signal which is present in some shells:
> 
> trap "echo ERR trap executed" ERR 2>/dev/null || :
> 
> I also checked the POSIX documentation, and quoting from
> http://www.opengroup.org/onlinepubs/009695399/utilities/trap.html
> (exit status): "For both interactive and non-interactive shells, 
> invalid signal names [XSI] [Option Start] or numbers [Option End] 
> shall not be considered a syntax error and do not cause the shell 
> to abort."

I'll look into this.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
