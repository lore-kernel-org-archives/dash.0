From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: [BUG] regression in builtin echo
Date: Fri, 2 Sep 2016 17:24:59 +0200
Message-ID: <20160902152459.GC87540@stack.nl>
References: <3efcd42c-e20b-3506-3d62-69b85c027ef4@gigawatt.nl>
 <20160902131439.GA12162@gondor.apana.org.au>
 <20160902141631.GA87540@stack.nl>
 <20160902141912.GA12739@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:23748 "EHLO mx1.stack.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932367AbcIBPZE (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 2 Sep 2016 11:25:04 -0400
Content-Disposition: inline
In-Reply-To: <20160902141912.GA12739@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Harald van Dijk <harald@gigawatt.nl>, luigi.tarenga@gmail.com, dash@vger.kernel.org

On Fri, Sep 02, 2016 at 10:19:12PM +0800, Herbert Xu wrote:
> On Fri, Sep 02, 2016 at 04:16:31PM +0200, Jilles Tjoelker wrote:

> > Unlike Harald van Dijk's patch, the above patch breaks \c. Per POSIX
> > (XSI option), \c shall cause all characters following it in the
> > arguments to be ignored (so not only in the argument where \c occurs).
> > For example:
> >   echo 'a\cb' c; echo d
> > shall write "ad" followed by a newline.

> Works for me:

> $ build/src/dash -c "echo 'a\cb' c; echo d"
> ad
> $ 

> AFAICS my patch doesn't change \c handling at all.  When we hit
> \c print_escape_str will return 0x100, which guarantees that we
> hit the berak.

You are right. The code is very tricky and my analysis without running
the code was wrong.

I think developing a shell is hard enough already without making the
code so tricky, though.

-- 
Jilles Tjoelker
