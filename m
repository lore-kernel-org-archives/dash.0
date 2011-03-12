From: Brian Koropoff <bkoropoff@gmail.com>
Subject: Re: [PATCH 3/3] Port to HP-UX
Date: Sat, 12 Mar 2011 15:54:43 -0800
Message-ID: <1299974083.3797.7.camel@gemini>
References: <1295413636.4278.28.camel@gemini>
	 <1295414162.6486.5.camel@gemini>
	 <20110310122636.GE10824@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58656 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753684Ab1CLXyh (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 12 Mar 2011 18:54:37 -0500
Received: by pwi15 with SMTP id 15so677057pwi.19
        for <dash@vger.kernel.org>; Sat, 12 Mar 2011 15:54:37 -0800 (PST)
In-Reply-To: <20110310122636.GE10824@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org

AC_CHECK_FUNC just checks that the symbol exists in libc, so it
succeeds.  _LARGEFILE64_SOURCE is necessary to get the system headers to
give you function prototypes, but it doesn't affect the configure test.

-- Brian

On Thu, 2011-03-10 at 20:26 +0800, Herbert Xu wrote:
> On Wed, Jan 19, 2011 at 05:16:02AM +0000, Brian Koropoff wrote:
> >
> >  - HP-UX needs _LARGEFILE64_SOURCE to be defined for open64()
> >    and friends to be available.  This seems to be safe to
> >    define everywhere, so do so.
> 
> Shouldn't this go into configure.ac? In fact, how can your patch
> have any effect if configure.ac doesn't detect open64 in the
> first place?
> 
> The rest looks OK.
> 
> Thanks,


