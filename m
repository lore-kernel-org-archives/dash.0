From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: "fc -l" broken between v0.5.5.1 and v0.5.6
Date: Sun, 8 Aug 2010 15:17:32 +0200
Message-ID: <20100808131732.GB83966@stack.nl>
References: <AANLkTi=7L7EC0xuBF4fqBksFAMAmjEiCc5VgAj75Hg=h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:49460 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753986Ab0HHNRd (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 8 Aug 2010 09:17:33 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=7L7EC0xuBF4fqBksFAMAmjEiCc5VgAj75Hg=h@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Wez Furlong <kingwez@gmail.com>
Cc: dash@vger.kernel.org

On Mon, Jul 26, 2010 at 10:17:43AM -0700, Wez Furlong wrote:
> When building with libedit, I get the following behavior:

> % ./src/dash -E
> $ fc -l
> fc: 1: history number -16 not found (internal error)
> $

> dialling back to v0.5.5.1:

> % ./src/dash -E
> $ fc -l
>     1 fc -l
> $

> It's totally invisible to me the cause of this regression, otherwise I
> would have also included a patch!

> This occurs on both darwin and centos 5.3.

> Let me know if I can provide more information,

Please bisect this to find the commit that introduced the problem. See
git help bisect  or
http://www.kernel.org/pub/software/scm/git/docs/git-bisect-lk2009.html .

-- 
Jilles Tjoelker
