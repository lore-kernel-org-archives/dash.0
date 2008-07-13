From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Mac OS X support patch
Date: Sat, 12 Jul 2008 18:26:11 -0700
Message-ID: <487959B3.1030301@zytor.com>
References: <E1KHq3f-0004Wb-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:59026 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbYGMB0U (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 12 Jul 2008 21:26:20 -0400
In-Reply-To: <E1KHq3f-0004Wb-00@gondolin.me.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: mmentovai@gmail.com, dash@vger.kernel.org

Herbert Xu wrote:
> H. Peter Anvin <hpa@zytor.com> wrote:
>> Mark Mentovai wrote:
>>> - open64 is not present although the stat64 family is, separate the
>>>   autoconf checks
>> This seems like the Wrong Thing anyway; the right thing should be to add 
>> whatever option (like -D_FILE_OFFSET_BITS=64 on Linux) to do 
>> *everything* using the full-sized offsets.
> 
> Actually there is a reason for this.  Not all open(2) calls in
> dash need large file support.  For example, doing it on a shell
> script or /dev/null makes no sense.  Only those dealing with user
> files (redirections) need large file support.
> 
> So that's we need to differentiate between open(2) calls on user
> files as opposed to those for dash itself.
> 

I'm not sure that that makes sense, however.  Unless you're hauling a 
*lot* of off_t's around the code, the incremental complexity is hardly 
worth it.

The *only* reason for the legacy 32-bit off_t mode is because it is an 
ABI change, it is necessary to prevent application/library interface 
breakage.

FWIW, klibc doesn't even implement the LFS64 APIs, nor does it implement 
the legacy 32-bit off_t mode in any way.

	-hpa
