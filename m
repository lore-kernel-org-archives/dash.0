From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: getopts doesn't properly update OPTIND when called from function
Date: Mon, 1 Jun 2015 14:29:05 +0800
Message-ID: <20150601062905.GB10460@gondor.apana.org.au>
References: <20150529025809.GA16240@gondor.apana.org.au>
 <5567FE11.8060103@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:40787 "EHLO
	helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbbFAG3S (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 1 Jun 2015 02:29:18 -0400
Content-Disposition: inline
In-Reply-To: <5567FE11.8060103@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: martijn@inlv.org, dash@vger.kernel.org

On Fri, May 29, 2015 at 07:50:09AM +0200, Harald van Dijk wrote:
> 
> But the test script in this thread does invoke getopts with
> parameters that are the same in all invocations, and without
> modifying OPTIND. I don't see anything else in the normative
> sections that would make the result undefined or unspecified either.
> I do think the script is valid, and the results in dash should match
> those of other shells.

The bash behaviour makes it impossible to call shell functions
that invoke getopts while in the middle of an getopts loop.

IMHO the dash behaviour makes a lot more sense since a function
always brings with it a new set of parameters.  That plus the
fact that this behaviour has been there since day one makes me
reluctant to change it since the POSIX wording is not all that
clear.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
