From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Parameter expansion, patterns and fnmatch
Date: Fri, 2 Sep 2016 22:51:53 +0800
Message-ID: <20160902145153.GA13458@gondor.apana.org.au>
References: <20160902140437.GA12639@gondor.apana.org.au>
 <6f39229b-7196-afd9-8e8f-3db1c33bf80a@redhat.com>
 <20160902142928.GA13022@gondor.apana.org.au>
 <dd9729a1-ce0d-8549-b52a-9d205740858c@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:60564 "EHLO
        helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752384AbcIBOwD (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 2 Sep 2016 10:52:03 -0400
Content-Disposition: inline
In-Reply-To: <dd9729a1-ce0d-8549-b52a-9d205740858c@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: Harald van Dijk <harald@gigawatt.nl>, olof@ethup.se, dash@vger.kernel.org

On Fri, Sep 02, 2016 at 09:49:53AM -0500, Eric Blake wrote:
> On 09/02/2016 09:29 AM, Herbert Xu wrote:
> > On Fri, Sep 02, 2016 at 09:25:15AM -0500, Eric Blake wrote:
> >>
> >>>> This also affects
> >>>>
> >>>>     case [a in [?) echo ok ;; *) echo bad ;; esac
> >>>>
> >>>> which should print ok.
> >>>
> >>> Even ksh prints bad here.
> >>
> >> So ksh is also buggy.
> > 
> > Good luck writing a script with an unquoted [ expecting it to be
> > portable :)
> 
> [ '' ] || echo empty
> 
> There, I just wrote a portable script with unquoted [ portably
> interpreted as itself and not as a bracket filename expansion pattern.

dash handles that just fine.  We're not talking about a lone [
in file expansion context here.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
