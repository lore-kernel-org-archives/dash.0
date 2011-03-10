From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] Reset exit status before sourcing a file.
Date: Thu, 10 Mar 2011 21:27:06 +0800
Message-ID: <20110310132706.GG10824@gondor.apana.org.au>
References: <1299068573-581-1-git-send-email-screwtape@froup.com> <20110302204233.GB21150@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:43259 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120Ab1CJN1N (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 10 Mar 2011 08:27:13 -0500
Content-Disposition: inline
In-Reply-To: <20110302204233.GB21150@elie>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Tim Allen <screwtape@froup.com>, dash@vger.kernel.org

On Wed, Mar 02, 2011 at 08:42:34PM +0000, Jonathan Nieder wrote:
> Tim Allen wrote:
> 
> > The POSIX specification for the dot command[1] states:
> >
> >     EXIT STATUS
> >         Returns the value of the last command executed, or a zero exit
> >         status if no command is executed.
> > 
> > If an empty file is sourced, then "no command is executed"
> 
> I agree.  Looking through "git log --patch src/main.c", though, I find
> v0.5.3~42 (Do not clobber exit status in dotcmd., 2005-03-03), which
> appears to have been meant to take care of the following case:
> 
> 	$ cat printstatus.sh
> 	echo $?
> 	$ false
> 	$ . ./printstatus.sh
> 	1
> 
> I wonder if the following on top might help (imitating evalcmd)?

Patch applied.  Thanks a lot!

Of course this does rely on evaltree actually setting exitstatus,
which it doesn't always do due to oversights.

For example, evalpipe doesn't set exitstatus if the pipeline
is backgrounded.  Amusingly pdksh seems to share this bug.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
