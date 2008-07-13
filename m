From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Mac OS X support patch
Date: Sun, 13 Jul 2008 09:07:23 +0800
Message-ID: <E1KHq3f-0004Wb-00@gondolin.me.apana.org.au>
References: <48782307.8020900@zytor.com>
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:51230 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751167AbYGMBHb (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 12 Jul 2008 21:07:31 -0400
In-Reply-To: <48782307.8020900@zytor.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: mmentovai@gmail.com, dash@vger.kernel.org

H. Peter Anvin <hpa@zytor.com> wrote:
> Mark Mentovai wrote:
>> - open64 is not present although the stat64 family is, separate the
>>   autoconf checks
> 
> This seems like the Wrong Thing anyway; the right thing should be to add 
> whatever option (like -D_FILE_OFFSET_BITS=64 on Linux) to do 
> *everything* using the full-sized offsets.

Actually there is a reason for this.  Not all open(2) calls in
dash need large file support.  For example, doing it on a shell
script or /dev/null makes no sense.  Only those dealing with user
files (redirections) need large file support.

So that's we need to differentiate between open(2) calls on user
files as opposed to those for dash itself.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
