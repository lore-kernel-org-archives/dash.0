From: Kris Maglione <maglione.k@gmail.com>
Subject: Re: Job control bug in revision 3800d4934391b,
Date: Fri, 28 May 2010 20:00:58 -0400
Message-ID: <20100529000058.GB11940@jg.home>
References: <20100528153423.GA3885@jg.home> <20100528224334.GA26879@gondor.apana.org.au> <20100528225321.GA11940@jg.home> <20100528231039.GA27140@gondor.apana.org.au> <20100528234049.GA27455@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64711 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753543Ab0E2ABD (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 28 May 2010 20:01:03 -0400
Received: by vws9 with SMTP id 9so1679127vws.19
        for <dash@vger.kernel.org>; Fri, 28 May 2010 17:01:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100528234049.GA27455@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org

On Sat, May 29, 2010 at 09:40:49AM +1000, Herbert Xu wrote:
>On Sat, May 29, 2010 at 09:10:39AM +1000, Herbert Xu wrote:
>> On Fri, May 28, 2010 at 07:01:25PM -0400, Kris Maglione wrote:
>> >
>> > That's interesting. I've had three users complain about it so far. strace 
>> > is attached.
>> 
>> Thanks, I have reproduced it here now.  It looks like it only
>> happens occasionally on my system.
>
>I think this patch should fix it, but please do test it as I
>can only rarely reproduce this on my machine.

Yes, this fixes it for me.

Thank you,
-- 
Kris Maglione

If you don't think carefully, you might think that programming is just
typing statements in a programming language.
	--Ward Cunningham

