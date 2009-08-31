From: Eric Blake <ebb9@byu.net>
Subject: Re: bugs in cd
Date: Mon, 31 Aug 2009 14:08:40 +0000 (UTC)
Message-ID: <loom.20090831T160451-196@post.gmane.org>
References: <loom.20090714T212706-910@post.gmane.org> <20090831121822.GC7311@gondor.apana.org.au> <4A9BC0BF.30608@byu.net> <20090831125653.GA8262@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:52050 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929AbZHaOJF (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 31 Aug 2009 10:09:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1Mi7ZA-0002JN-F1
	for dash@vger.kernel.org; Mon, 31 Aug 2009 16:09:04 +0200
Received: from l3-128-170-36-102.l-3com.com ([128.170.36.102])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Mon, 31 Aug 2009 16:09:04 +0200
Received: from ebb9 by l3-128-170-36-102.l-3com.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Mon, 31 Aug 2009 16:09:04 +0200
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Herbert Xu <herbert <at> gondor.apana.org.au> writes:

> > In other words, if CDPATH is "/", then you should not append any
> > additional <slash> characters, such that you end up checking for the
> > existence of "/foo", not "//foo".
> 
> Fair enough.  However, I noticed that they haven't fixed up PATH
> to do the same thing.

Most likely an unintentional oversight.  But to make sure, I've created a 
defect report:

http://austingroupbugs.net/view.php?id=139

https://www.opengroup.org/sophocles/show_mail.tpl?
CALLER=index.tpl&source=L&listname=austin-group-l&id=12720

[the former link may require free registration with the Austin group Mantis 
tracker; the latter is the public email summary generated from my edits]

> Since we use the same function for PATH and CDPATH, I'm not going
> to make any changes until POSIX becomes consistent in this respect.

Fair enough; I'll keep you posted when the Austin group rules on my report.

-- 
Eric Blake



