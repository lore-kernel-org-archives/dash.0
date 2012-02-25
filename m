From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: [PATCH] var.c: check for valid variable name before printing in
 "export -p"
Date: Sat, 25 Feb 2012 16:09:11 +0100
Message-ID: <20120225150911.GB8575@stack.nl>
References: <1329216528-8462-1-git-send-email-harald@redhat.com>
 <20120225073636.GA19041@gondor.apana.org.au>
 <20120225143004.GA8575@stack.nl>
 <20120225143155.GA31891@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:59266 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756697Ab2BYPJN (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 25 Feb 2012 10:09:13 -0500
Content-Disposition: inline
In-Reply-To: <20120225143155.GA31891@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: harald@redhat.com, dash@vger.kernel.org

On Sun, Feb 26, 2012 at 01:31:55AM +1100, Herbert Xu wrote:
> On Sat, Feb 25, 2012 at 03:30:04PM +0100, Jilles Tjoelker wrote:

> > Most shells pass the environment variable through, such as bash,
> > zsh, ksh93 and most ash derivatives. However, the original Bourne
> > shell and pdksh/mksh do not.

> Do you know of any genuine uses of such environment variables?

No, but I know that I do not know. I recommend noting the (small)
potential for breakage in the changelog. In a large body of software,
subtle features are often depended on somewhere, be it inadvertently.

-- 
Jilles Tjoelker
