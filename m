From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: Some utf-8 characters are cut in the middle on redirections
Date: Sun, 8 Aug 2010 14:21:28 +0200
Message-ID: <20100808122128.GB83441@stack.nl>
References: <1281211542.6631.49.camel@alkis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:56261 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753583Ab0HHMVa (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 8 Aug 2010 08:21:30 -0400
Content-Disposition: inline
In-Reply-To: <1281211542.6631.49.camel@alkis>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Alkis Georgopoulos <alkisg@gmail.com>
Cc: dash@vger.kernel.org

On Sat, Aug 07, 2010 at 11:05:42PM +0300, Alkis Georgopoulos wrote:
> $ touch ??
> $ echo 1 > ??
> $ ls
> ?  ??
> $ ls | hexdump -C
> 00000000  cf 0a cf 81 0a

> dash "cut" the "0x81" from the "0xcf81" representation of the Greek
> character rho, and so it created another file named "0xcf".

> This only happens for a few utf-8 characters, not for all of them.
> Relevant bug report:
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=532302

This bug is fixed in git commit f8231aea37e921492fc7fbd972385ab5b90e8627
which is not in any dash release yet.

The patch should apply to older dash versions also.

-- 
Jilles Tjoelker
