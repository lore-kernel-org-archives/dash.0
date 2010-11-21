From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] [PARSER] Remove backslash before } in double-quotes in
 variable
Date: Sun, 21 Nov 2010 10:35:34 -0600
Message-ID: <20101121163534.GB18740@burratino>
References: <20101119135406.GA24391@gondor.apana.org.au>
 <4CE71991.3020108@gigawatt.nl>
 <20101121134222.GC17293@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51061 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754477Ab0KUQfp (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 21 Nov 2010 11:35:45 -0500
Received: by gwb20 with SMTP id 20so889229gwb.19
        for <dash@vger.kernel.org>; Sun, 21 Nov 2010 08:35:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101121134222.GC17293@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>

Hi,

Jilles Tjoelker wrote:

> The backslash prevents the closing brace from terminating the
> substitution, therefore it should be removed.

Thanks!

>   printf "%s\n" ${$+\}} ${$+"\}"} "${$+\}}"
> should print } three times, without backslashes.

Thanks especially for the example.  The standard makes these all
clear, even the second one (which motivates the check against varnest
rather than dqvarnest).  For what it's worth, I like the patch.

Regards,
Jonathan
