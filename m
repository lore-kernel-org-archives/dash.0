From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: getopts doesn't properly update OPTIND when called from function
Date: Fri, 29 May 2015 10:58:09 +0800
Message-ID: <20150529025809.GA16240@gondor.apana.org.au>
References: <5567990E.3090902@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:52999 "EHLO
	helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342AbbE2C6U (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 28 May 2015 22:58:20 -0400
Content-Disposition: inline
In-Reply-To: <5567990E.3090902@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: martijn@inlv.org, dash@vger.kernel.org

Harald van Dijk <harald@gigawatt.nl> wrote:
> That isn't the problem, not exactly anyway. The problem is that getopts 
> is required to keep internal state separately from the OPTIND variable 
> (a single integer is insufficient to track the progress when multiple 
> options are combined in a single word), and that internal state is 
> stored along with the positional parameters. The positional parameters 
> are saved just before a function call, and restored when the function 
> returns. The internal state of getopts should not be saved the same way. 
> It should probably just be global to dash.

I think the current behaviour is fine as far as POSIX is concerned.
It says:

http://pubs.opengroup.org/onlinepubs/9699919799/utilities/getopts.html

: APPLICATION USAGE

...

: Note that shell functions share OPTIND with the calling shell
: even though the positional parameters are changed. If the calling
: shell and any of its functions uses getopts to parse arguments,
: the results are unspecified.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
