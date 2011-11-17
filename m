From: Heiko Gerstung <heiko@am-anger-1.de>
Subject: Re: Dashhh
Date: Thu, 17 Nov 2011 21:07:15 +0100
Message-ID: <4EC56973.70504@am-anger-1.de>
References: <4EC53397.2030005@am-anger-1.de> <201111171821.58460.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:52054 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754203Ab1KQUHR (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 17 Nov 2011 15:07:17 -0500
In-Reply-To: <201111171821.58460.stefano.lattarini@gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
Cc: dash@vger.kernel.org

Hi Stefano,

thank you for your response, please find my comments inline ...

Am 17.11.11 18:21, schrieb Stefano Lattarini:
> Hello everybody.  Hope it's OK if I chime in for a couple of tangential
> issues... (I've no comments on the patch proper, as my knowledge of the
> dash internals is zero).
OK, anyway, all comments are appreciated!

>
> On Thursday 17 November 2011, Heiko Gerstung wrote:
>> Hi!
>> {...} ressources.
>>
>> In the course of porting ~200 shell scripts (small three liners and
>> a few big guys) from bash to dash, I ran into a few issues (surprise
>> surprise):
>>
>> 1. The usual "[[" and "==" stuff (pretty easy to change, thank
>>     you sed)
>> 2. shift returns with a critical error when no arguments are left
>>     (no really good solution found)
>> 3. $[] arithmetic stuff not working (OK, worked around that with bc)
>>
> You might instead use the shell built-in construct `$(( ))', which is
> mandated by POSIX, and which dash supports as well:
>
>    $ echo $((1 + 2 * 3))
>    7
>
> (In fact, I'm pretty sure the the use of `$[]' for arithmetic substitution
> has been deprecated in bash for a looong time now).
Good point, I already forgot about that. I replaced the few occurences 
of $[] with an (ugly) bc workaround, and using $((x)) is definitely the 
best solution. Thanks!
>
>> 4. The bash FUNCNAME variable was very valuable for debugging purposes
>> and is nonexistent in dash
>>
>> Now, since I solved point 1 and 3 by changing my code, all I did is creating
>> a very small patch to deal with point 2 and, since it is also not too
>> complicated, I added patches to deal with point 1 and 4 as well.
>>
> As for point (1), I'm quite opposed to "solving it", since the change
> you are proposing would reduce the usefulness of dash as a testbed to
> detect bashisms in shell scripts.
Well, although I agree that it would reduce the usefulness of dash as a 
testbed for bashisms, I would not see that this is dash's primary task. 
I tried to find a nice workaround for this, but did not get very far 
(and patching dash was much easier and solved my problem instantly).

> Also (and more importantly), if I'm not mistaken, `[[' as supported by
> bash and the Korn shells is not a mere builtin, but rather a "syntactical
> contruct", in that the shell parses and interpreters stuff enclosed into
> `[[ ... ]]'  differently:
>
>   ## Quoting rules are different ##
>
>   $ a="x y"; [[ -n $a ]]&&  echo ok
>   ok
>   $ a="x y"; [ -n $a ]&&  echo ok
>   bash: [: x: binary operator expected
>   # Do this in an empty directory.
>   $ touch foo
>   $ a='*'; [ $a = foo ]&&  echo ok
>   ok
>   $ a='*'; [[ $a = "*" ]]&&  echo ok
>   ok
>
>   ## Operators and redirections: ">" is "greater than" in   ##
>   ## `[[', but is the usual redirection operator inside `[' ##
>
>   # Do this in an empty directory.
>   $ [[ 1>  2 ]]; echo status = $?; ls -l
>   status = 1
>   total 0
>   $ [ 1>  2 ]; echo $?; ls -l
>   status = 0
>   total 0
>   -rw-r--r-- 1 stefano stefano 0 Nov 17 18:13 2
I see, another good point! I personally did not run into the differences 
and used [[ and [ as aliases for each other. But I agree that in the 
light of the different behavior of the two I would prefer to either 
declare [[ a syntax error (like dash does) or to implement the different 
behavior. Will remove that!
>> I call this the dashhh (dash: Heiko's Hack) and although I browsed
>> the mailing list archives and found out that the shift issue has not
>> been accepted as a worthwhile change for dash and people are still
>> discussing about "==", I decided that I at least want to show you my
>> patch.
>>
>> If anyone wants to try this: Please remember that this of course is no
>> longer dash (it is dashhh).
>>
>> I can understand the reasoning behind the relucatance of the dash crew
>> to apply any of those changes to the main codebase.
>> For me it is not so important that dash is fully POSIX compliant
>>
> But for many people, this is VERY important!
I know and I never wanted to question that. That's why I pointed out 
that for me it is not so important. I need a fast, powerful and 
ressource-friendly non-interactive shell for my scripts and dash is 
really kicking ass in this respect.

>
> (Still, it seems to me that your proposed changes would leave dash
> POSIX-compliant, so there's no need to venture into a discussion
> of the merits of POSIX-compatibility).
OK. Although I always thought that the POSIX standard defines a minimum 
feature set that should be shared among all shells out there. 
Nevertheless every shell has additions to POSIX and it has them for a 
reason. Someone needs the additional functions and features and chooses 
that specific shell for her/his task. I agree that a lot of shell 
scripts benefit a lot from relying on the fact that /bin/sh (whereever 
that points to on a system) provides that standardized minimum feature 
set. Great for installation scripts and for stuff that needs to run on a 
number of different platforms and there is no common set of shells for 
all of those platforms. And, of course, you never know if your chosen 
shell is installed on every single system that may be required to run 
your scripts on. Tons of good reasons for a POSIX compliant shell. But: 
Being stricly POSIX compliant does not prevent you from offering 
additions and enhancements for script authors who do not face one of the 
above described situations. I am one of them, so for me and my special 
set of applications, POSIX compliance is not required. I still do not 
see any other shell that offers the speed of dash while sharing its 
small footprint.

Best Regards,
  Heiko
>> [SNIP]
> Regards,
>    Stefano
> --
> To unsubscribe from this list: send the line "unsubscribe dash" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

