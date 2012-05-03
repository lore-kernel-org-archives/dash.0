From: Marc Glisse <marc.glisse@inria.fr>
Subject: Re: wait and ctrl+Z
Date: Fri, 4 May 2012 00:28:17 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1205040022560.2988@laptop-mg.saclay.inria.fr>
References: <20120503215122.GA2885@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <dash-owner@vger.kernel.org>
Received: from mail4-relais-sop.national.inria.fr ([192.134.164.105]:42843
	"EHLO mail4-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756491Ab2ECW2T (ORCPT
	<rfc822;dash@vger.kernel.org>); Thu, 3 May 2012 18:28:19 -0400
In-Reply-To: <20120503215122.GA2885@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org

On Fri, 4 May 2012, Herbert Xu wrote:

> Marc Glisse <marc.glisse@inria.fr> wrote:
>> Hello,
>>
>> I noticed a strange behavior of "wait" when I suspend and resume a script.
>>
>> $ cat a.sh
>> #!/bin/dash
>> (sleep 7; echo blah) &
>> (sleep 7; echo bloh) &
>> wait ; echo coucou
>> $ ./a.sh
>> ^Z
>> zsh: suspended  ./a.sh
>> $ fg
>> [1]  + continued  ./a.sh
>> coucou
>> $ blah
>> bloh
>>
>> As you can see, the instruction after "wait" was executed immediatly on
>> resume, without waiting for the jobs.
>>
>> If I replace the ';' after "wait" by "&&" and do the same suspend+resume,
>> "coucou" is never printed.
>>
>> I am using dash version 0.5.7-3 in debian testing.
>
> That's normal as wait was interrupted by a signal.  If you want
> to wait even after an interruption, you should check the return
> value of wait.

Hello, and thanks for you answer.

I find that quite surprising. I re-read the posix description of wait, and 
my understanding is that the return value of wait should depend on what 
happened to the waited process (exit code, signal), not to wait itself. 
And other shells seem to agree.

Are you suggesting that wait should always be used in a loop? With what 
check exactly?


-- 
Marc Glisse
