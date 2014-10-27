From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] [BUILTIN] cd: support drive letters on Cygwin
Date: Mon, 27 Oct 2014 11:40:10 +0800
Message-ID: <20141027034010.GA5128@gondor.apana.org.au>
References: <1413226757-4311-1-git-send-email-eblake@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:40847 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbaJ0DkR (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 26 Oct 2014 23:40:17 -0400
Content-Disposition: inline
In-Reply-To: <1413226757-4311-1-git-send-email-eblake@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: dash@vger.kernel.org

On Mon, Oct 13, 2014 at 06:59:17PM +0000, Eric Blake wrote:
> The Cygwin platform supports DOS style drive-letter paths such
> as "C:\\dir", even though the preferred form is a POSIX-style
> "/cygdrive/c/dir".  This can be seen by doing things such as
> chdir("c:") (which succeeds) followed by getcwd(NULL, 0) (which
> returns the normalized "/cygdrive/c").  However, dash was trying
> to perform local manipulations on the argument to 'cd' prior to
> calling into libc, in order to update the state of $PWD and
> friends; these manipulations were assuming that the user meant
> to change to a relative subdirectory of the current location,
> as in './c:', instead of honoring the drive letter.  None of
> the other dash builtins take a filename and manipulate it to
> affect shell state (some, like 'test', take a file name, but as
> stat("c:") works just fine, there is no need to normalize).
> 
> This patch has no impact outside of cygwin; on cygwin, it takes
> advantage of a native function call to canonicalize any
> incoming name into preferred form before updating shell state.
> 
> Pre-patch:
> $ dash -c 'cd c: && echo $PWD'
> dash: 1: cd: can't cd to c:
> 
> Post-patch:
> $ dash -c 'cd c: && echo $PWD'
> /cygdrive/c
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Patch applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
