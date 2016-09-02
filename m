From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Parameter expansion, patterns and fnmatch
Date: Fri, 2 Sep 2016 22:29:28 +0800
Message-ID: <20160902142928.GA13022@gondor.apana.org.au>
References: <20160902140437.GA12639@gondor.apana.org.au>
 <6f39229b-7196-afd9-8e8f-3db1c33bf80a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:38054 "EHLO
        helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932129AbcIBO3j (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 2 Sep 2016 10:29:39 -0400
Content-Disposition: inline
In-Reply-To: <6f39229b-7196-afd9-8e8f-3db1c33bf80a@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: Harald van Dijk <harald@gigawatt.nl>, olof@ethup.se, dash@vger.kernel.org

On Fri, Sep 02, 2016 at 09:25:15AM -0500, Eric Blake wrote:
>
> >> This also affects
> >>
> >>     case [a in [?) echo ok ;; *) echo bad ;; esac
> >>
> >> which should print ok.
> > 
> > Even ksh prints bad here.
> 
> So ksh is also buggy.

Good luck writing a script with an unquoted [ expecting it to be
portable :)
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
