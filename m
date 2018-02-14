From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: dash bug: double-quoted "\" breaks glob protection for next char
Date: Wed, 14 Feb 2018 23:50:19 +0100
Message-ID: <5a9d8ab5-ec2d-8101-2853-ac3be6b0c4f6@gigawatt.nl>
References: <CAK1hOcPW_MZ5Nq-0z-aMMMgzZbOZYXD_9kkxz1w+U-HY+E4gbw@mail.gmail.com>
 <5e1ee06d-d1ca-6442-51de-786e2739d4df@gigawatt.nl>
 <297b41c4-0e15-e0d8-f088-d68acfcc3c0f@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from home.gigawatt.nl ([83.163.3.213]:34212 "EHLO home.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031852AbeBNWtg (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 14 Feb 2018 17:49:36 -0500
In-Reply-To: <297b41c4-0e15-e0d8-f088-d68acfcc3c0f@gigawatt.nl>
Content-Language: en-US
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Denys Vlasenko <vda.linux@googlemail.com>, Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org

On 2/14/18 10:44 PM, Harald van Dijk wrote:
> On 2/14/18 9:03 PM, Harald van Dijk wrote:
>> On 13/02/2018 14:53, Denys Vlasenko wrote:
>>> $ >'\zzzz'
>>> $ >'\wwww'
>>> $ dash -c 'echo "\*"'
>>> \wwww \zzzz
>>
>> [...]
>>
>> Currently:
>>
>> $ dash -c 'foo=a; echo "<${foo#[a\]]}>"'
>> <>
>>
>> This is what I expect, and also what bash, ksh and posh do.
>>
>> With your patch:
>>
>> $ dash -c 'foo=a; echo "<${foo#[a\]]}>"'
>> <a>
> 
> Does the attached look right as an alternative? It treats a quoted 
> backslash the same way as if it were preceded by CTLESC in _rmescapes. 
> It passes your test case and mine, but I'll do more extensive testing.

It causes preglob's string to potentially grow larger than the original. 
When called with RMESCAPE_ALLOC, that can be handled by increasing the 
buffer size, but preglob also gets called without RMESCAPE_ALLOC to 
modify a string in-place. That's never going to work with this approach. 
Back to the drawing board...

Cheers,
Harald van Dijk
