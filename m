From: Cristian Ionescu-Idbohrn <cristian.ionescu-idbohrn@axis.com>
Subject: Re: [PATCH] [EVAL] with set -e exit the shell if a subshell exits
 non-zero
Date: Mon, 28 Jun 2010 09:22:47 +0200 (CEST)
Message-ID: <1006280909240.5913@somehost>
References: <20100614095603.27834.qmail@728ec0bb900c60.315fe32.mid.smarden.org> <20100628070231.GA26558@gondor.apana.org.au>
Reply-To: dash@vger.kernel.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <dash-owner@vger.kernel.org>
Received: from miranda.se.axis.com ([193.13.178.8]:59184 "EHLO
	miranda.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751Ab0F1HWv (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 28 Jun 2010 03:22:51 -0400
Received: from traianus.se.axis.com (traianus.se.axis.com [10.94.24.46])
	by miranda.se.axis.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id o5S7Mnio017038
	for <dash@vger.kernel.org>; Mon, 28 Jun 2010 09:22:49 +0200
Received: from localhost (localhost [127.0.0.1])
	by traianus.se.axis.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o5S7MnIR026069
	for <dash@vger.kernel.org>; Mon, 28 Jun 2010 09:22:49 +0200
In-Reply-To: <20100628070231.GA26558@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On Mon, 28 Jun 2010, Herbert Xu wrote:

> On Mon, Jun 14, 2010 at 09:56:03AM +0000, Gerrit Pape wrote:
> > Example:
> >
> > $ dash -c 'set -e; (false); echo here'
> > here
> >
> > With this commit, dash exits 1 before echo.
> >
> > The bug was reported by Stefan Fritsch through
> >  http://bugs.debian.org/514863
> >
> > Signed-off-by: Gerrit Pape <pape@smarden.org>
>
> I'm not convinced that this change is necessary.  I've run some
> tests and bash/pdksh both behave like dash, while ksh93 behaves
> in the way you suggest.
>
> Has bash's behaviour changed recently (I'm using an ancient
> version)?

bash 3.2.39 and 4.0.37 are behaving as dash without the suggested
patch.  Still.  What is the correct behaviour?  That should be the
essential matter IMO, not what others do.  So, why should this fail:

	$ dash -c 'set -e; false; echo here'

and this succeed?

	$ dash -c 'set -e; (false); echo here'

The subshell returns exit code 1, and errexit is set.  Why does dash
ignore that exit code in the later case?


Cheers,

-- 
Cristian
