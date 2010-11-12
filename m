From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: [PATCH] Improved LINENO support
Date: Fri, 12 Nov 2010 22:29:32 +0100
Message-ID: <20101112212932.GB57806@stack.nl>
References: <4CD85E90.6000308@gigawatt.nl>
 <20101110220008.GC17871@stack.nl>
 <4CDD8481.1060306@gigawatt.nl>
 <4CDD8908.9010206@redhat.com>
 <4CDD9095.5070106@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:56651 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932214Ab0KLV3e (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 12 Nov 2010 16:29:34 -0500
Content-Disposition: inline
In-Reply-To: <4CDD9095.5070106@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org, Eric Blake <eblake@redhat.com>

On Fri, Nov 12, 2010 at 08:07:41PM +0059, Harald van Dijk wrote:
> must not write to test-7 and test2-8. It may write to test-1 and 
> test2-1, or it may write to test-8 and test2-8. Perhaps even to test-7 
> and test2-7. Again, though, LINENO must be the same in both expansions. 
> So for dash, the problem doesn't change: storing the line number of each 
> word, rather than each command, makes it very hard to get LINENO right.

Hmm, I hadn't thought of that. I considered a LINENO that points to the
affected word most useful and easiest to implement (also because FreeBSD
sh's LINENO works this way).

So some more ideas:

A per-command LINENO does not require adding the number to all of the
node types. Only node types that are commands that perform expansions
need it: NCMD, NREDIR, NBACKGND, NSUBSHELL, NFOR, NCASE.

NFOR and NCASE may be wrapped in an NREDIR node to hold the line number.
This simplifies the code a bit at the cost of some extra memory usage.

A further simplification might be removing the redirect field from
NBACKGND and NSUBSHELL and putting any redirect in an additional NREDIR
node inside the NBACKGND/NSUBSHELL (so that the file is opened in the
child process and job control works correctly). However, NREDIR,
NBACKGND and NSUBSHELL are compatible types so it does not seem to gain
much.

What about making the lineno an element of the redirection list like
NTO? This minimizes changes to eval.c but perhaps it is too contrived.

Second idea: use a per-word LINENO but somehow ensure it is the same for
all words in a command. I think this is wrong, but perhaps I'm wrong.

-- 
Jilles Tjoelker
