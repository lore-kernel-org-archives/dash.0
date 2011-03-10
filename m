From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 2/3] Port to AIX
Date: Thu, 10 Mar 2011 20:25:12 +0800
Message-ID: <20110310122512.GD10824@gondor.apana.org.au>
References: <1295413636.4278.28.camel@gemini> <1295414149.6486.4.camel@gemini>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:41046 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022Ab1CJMZP (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 10 Mar 2011 07:25:15 -0500
Content-Disposition: inline
In-Reply-To: <1295414149.6486.4.camel@gemini>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Brian Koropoff <bkoropoff@gmail.com>
Cc: dash@vger.kernel.org

On Wed, Jan 19, 2011 at 05:15:49AM +0000, Brian Koropoff wrote:
> - AIX lacks a WCOREDUMP macro.  It's just used to
>   append "(core dumped)" to the crash message, so
>   #ifdef around it.
> 
> - For some reason, the nl program on AIX defaults
>   to not printing line numbers ("-b n"), even though
>   the spec says it should default to "-b t".
>   Explicitly pass "-b a" for good measure in mkbuiltins.
> 
> Signed-off-by: Brian Koropoff <bkoropoff@gmail.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
