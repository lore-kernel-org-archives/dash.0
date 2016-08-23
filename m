From: Zdenek Kaspar <zkaspar82@gmail.com>
Subject: Re: dash 0.5.9: break and continue bug
Date: Wed, 24 Aug 2016 00:24:19 +0200
Message-ID: <8b03873e-32d7-d450-9dfb-d9d6e4ac4632@gmail.com>
References: <c8a328b0-1ed7-cb35-5a9c-95b7f592cb9e@gmail.com>
 <377a8f04-2ecb-0171-7fb4-5baeacefab26@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34630 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755834AbcHWWYY (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 23 Aug 2016 18:24:24 -0400
Received: by mail-wm0-f43.google.com with SMTP id q128so30027966wma.1
        for <dash@vger.kernel.org>; Tue, 23 Aug 2016 15:24:21 -0700 (PDT)
In-Reply-To: <377a8f04-2ecb-0171-7fb4-5baeacefab26@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org

On 08/23/2016 10:41 PM, Harald van Dijk wrote:
> On 23/08/16 22:23, Zdenek Kaspar wrote:
>> Hi, I've noticed 0.5.9 does ignore break and continue statements, here
>> is simple reproducer:
>>
>>
>> one() {
>>     echo "  one"
>>     break
>> }
>>
>> two() {
>>     echo "  two"
>> }
>>
>> for i in 1 2
>> do
>>     echo "loop $i:"
>>     one
>>     two
>> done
>>
>>
>> dash-0.5.9:
>> $ dash dash-break-test
>> loop 1:
>>   one
>>   two
>> loop 2:
>>   one
>>   two
>>
>> dash-0.5.8-4.fc24.x86_64:
>> $ dash dash-break-test
>> loop 1:
>>   one
> 
> break and continue now need to appear in the loop directly, they cannot
> be wrapped in a function any more. Although this is a visible change in
> behaviour, it is intentional:
>   <https://www.mail-archive.com/dash%40vger.kernel.org/msg00929.html>
> 
> The standard is a bit unclear on how break and continue are meant to
> behave in these situations, as it refers to the "enclosing loop" without
> defining what counts and doesn't count as the enclosing loop, but the
> next version of the standard will make it clear that your script is not
> required to behave the way you expect:
>   <http://austingroupbugs.net/view.php?id=842>
> 
> That said, shells are still allowed to treat your script the way you
> expect.
> 
>> HTH, Z.

Kinda sucks it does not abort execution completely and write some error
message then, because this can do some damage...

Anyway, thanks Harald for pointing me to changed SPEC where this (new)
behaviour is explained.

THX, Z.
