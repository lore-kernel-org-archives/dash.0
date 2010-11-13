From: =?KOI8-R?B?z8zYx8Egy9LZ1sHOz9fTy8HR?= <olga.kryzhanovska@gmail.com>
Subject: Re: static vs. dynamic scoping
Date: Sun, 14 Nov 2010 00:54:28 +0100
Message-ID: <AANLkTimm=WL8xw7UxyaBVVzFUKxboCndc-Kv64OaZeQX@mail.gmail.com>
References: <4CD9C50D.5010305@redhat.com>
	<4CDF1DA7.9000109@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34342 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834Ab0KMXy3 (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 13 Nov 2010 18:54:29 -0500
Received: by iwn10 with SMTP id 10so5098811iwn.19
        for <dash@vger.kernel.org>; Sat, 13 Nov 2010 15:54:28 -0800 (PST)
In-Reply-To: <4CDF1DA7.9000109@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org, Eric Blake <eblake@redhat.com>

How is dynamic scoping in this case 'more useful'? Imagine function a
written by author A and function b written by author B, both loaded
into an application and each of them working independently, bound
together by an api spec.
Now function a uses typeset IFS="X" to set the field separator to "X"
via a local variable IFS. If function b now uses "read foo1 foo2 foo3"
to read a line of a database the concept of dynamic scoping *BITES*.
Suddenly function b no longer works as author B intended it. Lots of
surprise, lots of raised eyebrows by an unwanted interaction.
Static scoping is in this case much *SAFER* because IFS is reset in
function b to the (global) default.

The issue isn't new but the issues with dynamic scoping are one major
factor why there are so few shell function libraries: It is just hard
to write such a library without running afoul dynamic scoping.

Olga

On Sun, Nov 14, 2010 at 12:22 AM, Harald van Dijk <harald@gigawatt.nl> wrote:
> On 09/11/10 23:02, Eric Blake wrote:
>>
>> 2. User aspect:
>>   Is anyone aware of a script that intentionally uses the full power of
>> dynamic scoping available through 'local' which would break if scoping
>> switched to static?
>
> FWIW, some scripts use "local IFS" to reset IFS to a sane value, and have
> the shell take care of restoring it afterwards. This works with ksh's
> typeset, but because of the static scoping only so long as no other shell
> functions get called, or those other shell functions also take the effort to
> handle IFS correctly. In the scripts I have been able to find, other shell
> functions do get called, but they themselves set IFS too. Still, it may be
> worth keeping in mind, if only to serve as one of the few examples of when
> dynamic scoping would have been slightly more useful.
> --
> To unsubscribe from this list: send the line "unsubscribe dash" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
      ,   _                                    _   ,
     { \/`o;====-    Olga Kryzhanovska   -====;o`\/ }
.----'-/`-/     olga.kryzhanovska@gmail.com   \-`\-'----.
 `'-..-| /       http://twitter.com/fleyta     \ |-..-'`
      /\/\     Solaris/BSD//C/C++ programmer   /\/\
      `--`                                      `--`
