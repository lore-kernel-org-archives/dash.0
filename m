From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: How to inherent non-zero exit status using pipe? (dash)
Date: Thu, 12 Aug 2010 21:15:40 -0400
Message-ID: <20100813011540.GA21450@gondor.apana.org.au>
References: <4C62AAF1.4060103@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:33749 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760528Ab0HMBPp (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 12 Aug 2010 21:15:45 -0400
Content-Disposition: inline
In-Reply-To: <4C62AAF1.4060103@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: pengyu.ut@gmail.com, dash@vger.kernel.org

Eric Blake <eblake@redhat.com> wrote:
>
> Generally not possible using only POSIX constructs (bash's 'set -o
> pipefail' and '${PIPESTATUS[@]}' are extensions).  But what you _can_ do
> is play with exec to be able to propagate non-zero status from a
> particular portion of a pipeline through a temporary variable or file:
> 
> $ exec 3>&1 # duplicate original stdout
> $ result=$(
>  exec 4>&1 >&3 3>&- # move cmd subst stdout, and restore original
>  { ./main.sh; echo $? >&4 # run command, and record its status
>  } | head -n 3)
> $ echo $? # status from head
> $ echo $result # status from ./main.sh
> $ exec 3>&-

Another way is to use fifos.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
