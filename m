From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: job control (Re: dash race)
Date: Tue, 29 Apr 2008 22:04:37 +0800
Message-ID: <E1JqqRh-0005R5-00@gondolin.me.apana.org.au>
References: <20080427114917.GN24008@flower.upol.cz>
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:42487 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750901AbYD2OEm (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 29 Apr 2008 10:04:42 -0400
In-Reply-To: <20080427114917.GN24008@flower.upol.cz>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Oleg Verych <olecom@flower.upol.cz>
Cc: gladkov.alexey@gmail.com, dash@vger.kernel.org

Oleg Verych <olecom@flower.upol.cz> wrote:
> [...]
>> >Also, `ps` && `kill` is better implementation of job control. dash's
>> >interactivity isn't a good one, so what reason is behind shell's job
>> >control after all?
>> 
>> I don't understand this.
> 
> You don't understand, that `wait` and job control is interactive shell
> features adopted from Korn Shell?

I use this construct all the time in my scripts so I certainly
consider this to be a grave bug in dash :)

Unfortunately I'm awfully busy right now but I'll try to reproduce
it once I get a chance.  If anyone can get me a patch before then
it'd be much appreciated :)

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
