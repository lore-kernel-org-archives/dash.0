From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Bug#501566: dash: details of redirection/duplication in manpage
 are reversed
Date: Wed, 12 Nov 2014 10:13:25 +0800
Message-ID: <20141112021325.GA23715@gondor.apana.org.au>
References: <20141111141911.GC4343@chaz.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:42378 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753700AbaKLCN2 (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 11 Nov 2014 21:13:28 -0500
Content-Disposition: inline
In-Reply-To: <20141111141911.GC4343@chaz.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Stephane Chazelas <stephane.chazelas@gmail.com>
Cc: dash@vger.kernel.org

Stephane Chazelas <stephane.chazelas@gmail.com> wrote:
> 2014-11-11 14:23:21 +0100, Stephen Shirley:
> [...]
>> "[n1]>&n2    Redirect standard output (or n1) to n2."
>> 
>> It doesn't cover the case where n2 is later changed, and how n1 does
>> not follow this, but it's the simplest fix i see.
> [...]
> 
> That's ambiguous.
> 
> Maybe:
> 
> [n1]>&n2    Redirect standard output (or fd n1) to the same "open
>            file description" as on fd n2.
> 
> [n1]>&n2    Redirect standard output (or fd n1) to the same
>            resource as open on fd n2.
> 
> [n1]>&n2    Copy fd n2 as stdout (or fd n1)
> 
> ?

Stephane, please keep the cc list in future list replies as
otherwise people may miss your messages since not everyone is
subscribed and even those subscribed may filter out messages
not addressed to them directly.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
