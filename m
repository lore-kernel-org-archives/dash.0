From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: read() builtin doesn't read integer value /proc files (but
 bash's does)
Date: Fri, 3 Sep 2010 23:25:05 +0200
Message-ID: <20100903212504.GA86276@stack.nl>
References: <AANLkTinTd+29=8EkiTKptoE8nnVphcQ_TW=ezS99LmWw@mail.gmail.com>
 <AANLkTi=ZcNYJKCO_FM0RpJndwAgtzTU_C8J=9BsfmdAk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:54082 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754079Ab0ICVZH (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 3 Sep 2010 17:25:07 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=ZcNYJKCO_FM0RpJndwAgtzTU_C8J=9BsfmdAk@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Steve Schnepp <steve.schnepp@gmail.com>
Cc: dash@vger.kernel.org, 595063@bugs.debian.org

On Thu, Sep 02, 2010 at 05:02:55PM +0200, Steve Schnepp wrote:
> 2010/9/1 Steve Schnepp <steve.schnepp@gmail.com>:
> > conforming to POSIX isn't a realistic option, would it be possible to
> > have a workaround that doesn't involve an external tool like cat(1) ?

> Hi, I just hacked & attached a little patch away to be able to solve
> this case.
> Feel free to reply with your comments.

> NB: I just targeted dash-0.5.5.1, but it might apply to any version.

This patch assumes that the file descriptor is discarded afterwards (its
position does not matter). Therefore the very common construct
  while read x; do
    ...
  done
stops working.

A possible fix is to check first if the input supports seeking. If it
does, use the buffering and at the end of the line seek backwards for
the number of bytes remaining in the buffer. If it does not, read one
byte at a time.

-- 
Jilles Tjoelker
