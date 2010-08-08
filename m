From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: No wildcard expansion with redirected filenames
Date: Sun, 8 Aug 2010 14:15:55 +0200
Message-ID: <20100808121555.GA83441@stack.nl>
References: <1281209661.6631.33.camel@alkis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:60098 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753723Ab0HHMZ3 (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 8 Aug 2010 08:25:29 -0400
Content-Disposition: inline
In-Reply-To: <1281209661.6631.33.camel@alkis>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Alkis Georgopoulos <alkisg@gmail.com>
Cc: dash@vger.kernel.org

On Sat, Aug 07, 2010 at 10:34:21PM +0300, Alkis Georgopoulos wrote:
> Isn't this supposed to work?

> $ touch file1
> $ echo 1 > file?
> $ ls file? 
> file?  file1

> I.e. dash actually created a file named 'file?' instead of globbing.

No, this is not supposed to work. POSIX says that a non-interactive
shell must not generate pathnames for a redirection; an interactive
shell may do so, provided there is exactly one match.

Dash is primarily meant as a non-interactive shell and wants to be as
small as possible, and therefore never generates pathnames for a
redirection.

-- 
Jilles Tjoelker
