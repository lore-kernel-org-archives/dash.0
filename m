From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: [PATCH] Improved LINENO support
Date: Wed, 10 Nov 2010 23:00:08 +0100
Message-ID: <20101110220008.GC17871@stack.nl>
References: <4CD85E90.6000308@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:50905 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756882Ab0KJWAK (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 10 Nov 2010 17:00:10 -0500
Content-Disposition: inline
In-Reply-To: <4CD85E90.6000308@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org

On Mon, Nov 08, 2010 at 09:32:56PM +0059, Harald van Dijk wrote:
> This patch improves LINENO support by storing line numbers in the parse 
> tree, for commands as well as for function definitions. It makes LINENO 
> behaves properly when calling functions, and has the added benefit of 
> improved line numbers in error messages when the last-parsed command is 
> not the last-executed one. It removes the earlier LINENO support, and 
> instead sets LINENO from evaltree when a command is executed. I have 
> used it for a while, and have seen correct line numbers in basic testing 
> and in error messages in fairly large and complicated autoconf-generated 
> shell scripts. Does this look good enough to add to dash? If there are 
> any problems with it, please let me know, I will be happy to look at 
> this further.

What I was thinking of was adding a lineno field to narg instead of to
all command types. The lineno variable would then be set by expand.c. I
think that leads to a smaller patch and it should still give a sensible
value for almost all errors. Downside is a few more int-to-ascii
conversions. A few divisions is not that bad relative to other things
that are done but printf in modern libcs is bloated and slow and might
slow down things measurably.

FreeBSD's code subtracts the function's starting line number in the
parser rather than at run time. I wonder which is best. (FreeBSD
neglects to save and restore the value, so nested function definitions
may lead to incorrect line numbers, but that could be fixed.)

I think this patch will increase dash's code size at least a little,
which is always a consideration here. I can also look at getting this
into FreeBSD sh.

Thanks,
-- 
Jilles Tjoelker
