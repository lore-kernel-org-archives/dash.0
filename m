From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: [PATCH] var.c: check for valid variable name before printing in
 "export -p"
Date: Sat, 25 Feb 2012 15:30:04 +0100
Message-ID: <20120225143004.GA8575@stack.nl>
References: <1329216528-8462-1-git-send-email-harald@redhat.com>
 <20120225073636.GA19041@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:65263 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756641Ab2BYOkH (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 25 Feb 2012 09:40:07 -0500
Content-Disposition: inline
In-Reply-To: <20120225073636.GA19041@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: harald@redhat.com, dash@vger.kernel.org

On Sat, Feb 25, 2012 at 06:36:36PM +1100, Herbert Xu wrote:
> On Tue, Feb 14, 2012 at 10:48:48AM +0000, harald@redhat.com wrote:
> > From: Harald Hoyer <harald@redhat.com>

> > "export -p" prints all environment variables, without checking if the
> > environment variable is a valid dash variable name.

> > IMHO, the only valid usecase for "export -p" is to eval the output.

> Thanks a lot for the report and patch.

> I'd prefer to fix this up at entry into the shell rather than
> when we print out the variables.  So how about this patch?

Such a change would change other things than just "set" and "export -p".
It would also not propagate environment variables with invalid names to
child processes. For example:

env -i not-a-name=1 PATH="$PATH" dash -c env | grep not-a-name

Most shells pass the environment variable through, such as bash, zsh,
ksh93 and most ash derivatives. However, the original Bourne shell and
pdksh/mksh do not.

I think it is best to pass them through so that executing a utility with
and without the shell are as similar as possible (most versions of
make(1) assume this is the case by skipping the shell if the command is
simple enough) and particularly for dash for historical/compatibility
reasons.

I did something similar to the OP's patch in FreeBSD (SVN r223183):
"set" and "export -p" skip variables with invalid names.

Note that this problem cannot occur with "readonly -p" because only
variables with a proper name can be marked read-only.

-- 
Jilles Tjoelker
