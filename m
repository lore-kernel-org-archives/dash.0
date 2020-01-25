From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: Alias/heredoc/cmdsubst regression
Date: Sat, 25 Jan 2020 16:33:01 +0000
Message-ID: <792fe64c-dc44-f862-832c-5eaa82aa108c@gigawatt.nl>
References: <40db0aa1-195b-f29e-5068-01fa101affd9@inlv.org>
 <8b48cd04-b85f-1086-55c8-8e17800f5693@gigawatt.nl>
 <f40ce455-afd8-05f4-e594-4395bb2a8ed0@gigawatt.nl>
 <1484376d-fec8-cb48-9de0-13301273a560@inlv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.gigawatt.nl ([51.68.198.76]:48724 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgAYQeB (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 25 Jan 2020 11:34:01 -0500
In-Reply-To: <1484376d-fec8-cb48-9de0-13301273a560@inlv.org>
Content-Language: en-US
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Martijn Dekker <martijn@inlv.org>, DASH shell mailing list <dash@vger.kernel.org>

On 25/01/2020 16:26, Martijn Dekker wrote:
> Op 25-01-20 om 02:38 schreef Harald van Dijk:
>>    alias BEGIN='{' END='}'
>>    : <<EOF &&
>>    $(echo hi)
>>    EOF
>>    BEGIN
>>    echo ok
>>    END
>>
>> This has been failing for longer. This prints "Syntax error: "(" 
>> unexpected" since at least 0.5.1.
> 
> Interesting. For me, this one prints (on dash 0.5.7 until current):
> testalias2.sh: 5: testalias2.sh: {: not found
> ok
> testalias2.sh: 7: testalias2.sh: Syntax error: "}" unexpected

Oops! That is what it prints for me too and dash has done so since 0.5.1 
(except for the line numbers in the error messages). I got the "Syntax 
error: "(" unexpected" on another test, was typing up an e-mail, noticed 
my test was overly complicated, simplified it, verified that it still 
failed since 0.5.1, but forgot to update the error message in my mail. 
Sorry for the confusion.

Cheers,
Harald van Dijk
