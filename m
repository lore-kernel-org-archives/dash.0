From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Parameter expansion, patterns and fnmatch
Date: Sat, 3 Sep 2016 21:05:06 +0800
Message-ID: <20160903130506.GA19749@gondor.apana.org.au>
References: <20160902140437.GA12639@gondor.apana.org.au>
 <6f39229b-7196-afd9-8e8f-3db1c33bf80a@redhat.com>
 <20160902142928.GA13022@gondor.apana.org.au>
 <dd9729a1-ce0d-8549-b52a-9d205740858c@redhat.com>
 <20160902145153.GA13458@gondor.apana.org.au>
 <b25fbf0a-1b36-24d4-9a6c-7d8a9d8dd894@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:52336 "EHLO
        helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753180AbcICNF7 (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 3 Sep 2016 09:05:59 -0400
Content-Disposition: inline
In-Reply-To: <b25fbf0a-1b36-24d4-9a6c-7d8a9d8dd894@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Eric Blake <eblake@redhat.com>, olof@ethup.se, dash@vger.kernel.org

On Sat, Sep 03, 2016 at 02:03:28PM +0200, Harald van Dijk wrote:
> >>>>
> >>>>>>This also affects
> >>>>>>
> >>>>>>    case [a in [?) echo ok ;; *) echo bad ;; esac
>
> We're talking about something that dash has had code to handle for
> >10 years, that's been documented by dash as supported for >10
> years, and now that it turns out there's a flaw in the code where
> dash does not behave as documented and as clearly intended by the
> code, it's POSIX's fault?

dash has never worked this way.  What's worse is that your patch
changes dash's behaviour in a way that is inconsistent with every
shell out there except bash.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
