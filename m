From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: EXIT trap handling in subshells broken
Date: Fri, 17 Jan 2020 22:58:42 +0000
Message-ID: <a7c19de3-b34c-6ef1-b116-1f16cbad76f4@gigawatt.nl>
References: <c1a9c062-0917-d3f3-8826-811b5a4fd802@gigawatt.nl>
 <20200117101532.jlddos2uctne5xk7@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.gigawatt.nl ([51.68.198.76]:60974 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbgAQW7c (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 17 Jan 2020 17:59:32 -0500
In-Reply-To: <20200117101532.jlddos2uctne5xk7@gondor.apana.org.au>
Content-Language: en-GB
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: DASH shell mailing list <dash@vger.kernel.org>

On 17/01/2020 10:15, Herbert Xu wrote:
> On Mon, Jan 06, 2020 at 09:57:20PM +0000, Harald van Dijk wrote:
>>
>> The problem is not limited to redirections:
>>
>>    f() { (trap "echo \$var" EXIT); }
>>    var=bad
>>    var=ok f
>>
>> This prints "bad", when it should print "ok". Here, the local variable is
>> dropped not in main(), but during the unwind process.
> 
> This works fine for me with the latest git tree.  This is because
> reset has now been split into exitreset and reset and variables
> are only reset in reset() which is only called if exitshell is
> not happening.
> 
> As if we're in a subshell we will never take the reset() path
> I don't think we need to do anything here at all.

Ah, right, forgot about that. That change also altered the behaviour of

   trap "echo foo=\$foo" EXIT
   f() {
     local foo=bar
     exit
   }
   f

though, which printed foo= in released versions of dash since at least 
as far back as 0.5.1, and prints foo= in current versions of bash and 
zsh. It now prints foo=bar. That is defensible and also what some other 
shells do, but I'm not sure it's intended.

(Combined with some other changes I have, the behaviour stops being 
defensible, but I suspect that is nothing that affects dash.)

Cheers,
Harald van Dijk
