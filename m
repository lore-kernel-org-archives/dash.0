From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: dash tested against ash testsuite: 17 failures
Date: Tue, 11 Oct 2016 00:30:04 +0200
Message-ID: <d86f0a53-b1e7-827f-15bf-adc8c52986ea@gigawatt.nl>
References: <CAK1hOcMma=uH2R=vWX1Z6r2xf9PcW7MPSEPYOk76Zn97LD-7Jw@mail.gmail.com>
 <7d291bb2-a968-471d-d2a0-87adfd0bc38d@inlv.org>
 <20161010215116.GA78485@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from home.gigawatt.nl ([83.163.3.213]:55004 "EHLO home.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751321AbcJJWaL (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 10 Oct 2016 18:30:11 -0400
In-Reply-To: <20161010215116.GA78485@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>, Martijn Dekker <martijn@inlv.org>
Cc: dash@vger.kernel.org

On 10-10-16 23:51, Jilles Tjoelker wrote:
> On Sat, Oct 08, 2016 at 09:42:12PM +0200, Martijn Dekker wrote:
>> Op 01-10-16 om 19:17 schreef Denys Vlasenko:
>>> ash-vars/var_unbackslash.tests
>
>> ITYM ash-vars/var_unbackslash1.tests
>
>>>     echo Forty two:$\
>>>     (\
>>>     (\
>>>     42\
>>>     )\
>>>     )
>>>     dash says: Syntax error: Missing '))'
>
>> Yes, but it's not clear to me that it shouldn't.
>
>> Hmm... maybe this is indeed a bug:
>> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_02_01
>> "A <backslash> that is not quoted shall preserve the literal value of
>> the following character, with the exception of a <newline>. If a
>> <newline> follows the <backslash>, the shell shall interpret this as
>> line continuation. The <backslash> and <newline> shall be removed before
>> splitting the input into tokens. Since the escaped <newline> is removed
>> entirely from the input and is not replaced by any white space, it
>> cannot serve as a token separator."
>
>> So, unless I'm misreading this, it looks like backslashes need to be
>> parsed before *any* other kind of lexical analysis.
>
> Yes, for <backslash><newline> sequences that are not quoted.
>
> For example, <single-quote><backslash><newline><single-quote> contains
> two characters between the quotes, not zero.

Ah, right, I missed that exception. Note that it only applies to 
single-quoted strings. In double-quoted strings, backslash-newline 
should be removed just as when unquoted.

Cheers,
Harald van Dijk
