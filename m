From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [v2 PATCH] redir: Clear saved redirections in subshell
Date: Fri, 17 Jan 2020 23:11:29 +0000
Message-ID: <dcff517b-8cb8-2be0-cd18-8b2679e03d75@gigawatt.nl>
References: <c1a9c062-0917-d3f3-8826-811b5a4fd802@gigawatt.nl>
 <20200117085124.ub53qala7c636owf@gondor.apana.org.au>
 <20200117095755.y6mwflmqqw7zeegh@gondor.apana.org.au>
 <20200117152825.ll4kge4ehy36xhxw@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.gigawatt.nl ([51.68.198.76]:32768 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729354AbgAQXMS (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 17 Jan 2020 18:12:18 -0500
In-Reply-To: <20200117152825.ll4kge4ehy36xhxw@gondor.apana.org.au>
Content-Language: en-GB
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: DASH shell mailing list <dash@vger.kernel.org>

On 17/01/2020 15:28, Herbert Xu wrote:
> On Fri, Jan 17, 2020 at 05:57:55PM +0800, Herbert Xu wrote:
>>
>> Something like this should fix the redir problem.  I'll address the
>> other issue in a subsequent patch.
> 
> Here is a new version that adds a forkreset hook to mkinit so
> that we do the clearing even when we enter a subshell without
> forking.

Yup, that's something I've had for a while for the same reason. I called 
it envreset since it's not only called after forking, but it's the same 
thing.

The clearing of redirlist is also what I ended up doing, except I did 
free the memory by adding a drop parameter to unwindredir and passing 
that on to popredir. That should not affect the user-visible behaviour.

Cheers,
Harald van Dijk
