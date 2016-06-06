From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: jobs: Don't attempt to access job table for job %0
Date: Mon, 6 Jun 2016 19:57:06 +0800
Message-ID: <20160606115706.GA22138@gondor.apana.org.au>
References: <1449734374-23041-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:52443 "EHLO
	helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbcFFL5L (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 6 Jun 2016 07:57:11 -0400
Content-Disposition: inline
In-Reply-To: <1449734374-23041-1-git-send-email-tklauser@distanz.ch>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: dash@vger.kernel.org

On Thu, Dec 10, 2015 at 08:59:34AM +0100, Tobias Klauser wrote:
> If job %0 is (mistakenly) specified, an out-of-bounds access to the
> jobtab occurs in function getjob() if num = 0:
> 
> 	jp = jobtab + 0 - 1
> 
> Fix this by checking that the job number is larger than 0 before
> accessing the jobtab.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Patch applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
