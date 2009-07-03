From: Oleg Verych <olecom@gmail.com>
Subject: Re: Parameter expansion fails when assigning a local variable
Date: Sat, 4 Jul 2009 00:14:27 +0300
Message-ID: <8499950a0907031414j3aa1198ao90e21ded824c0b34@mail.gmail.com>
References: <A612847CFE53224C91B23E3A5B48BAC73AEC8A9FE8@xmail3.se.axis.com>
	 <20090622085729.GA22431@gondor.apana.org.au>
	 <0906282220250.1491@somehost>
	 <20090629004750.GA2019@gondor.apana.org.au>
	 <0906291823520.16266@somehost>
	 <20090630013807.GA13339@gondor.apana.org.au>
	 <0906301817190.14361@somehost>
	 <8499950a0907010042l6a9bb4das1c32f4e5c97e5dc@mail.gmail.com>
	 <0907021846440.25311@somehost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:44464 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756707AbZGCVO0 (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 3 Jul 2009 17:14:26 -0400
Received: by fg-out-1718.google.com with SMTP id e12so181764fga.17
        for <dash@vger.kernel.org>; Fri, 03 Jul 2009 14:14:27 -0700 (PDT)
In-Reply-To: <0907021846440.25311@somehost>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Cristian Ionescu-Idbohrn <cristian.ionescu-idbohrn@axis.com>
Cc: dash@vger.kernel.org

2009/7/2 Cristian Ionescu-Idbohrn
[...]
>> UNIX SHELL Quote Tutorial
>> Written by Bruce Barnett
>> http://www.grymoire.com/Unix/Quote.html
>>
>> Sh - the Bourne Shell
>> http://www.grymoire.com/Unix/Sh.html
>
> Is this just good advice (thanks for that, by the way)?

You're welcome. But somehow it doesn't work. You have problem of not
understanding, how shell works. This is not a bug in dash.

> Any particular part of the tutorial, you, advertise that offers some sort
> of recipe on to how to solve the problem at hand (read it but did not
> find anything relevant referring to this particular dash bug)?

<http://www.grymoire.com/Unix/Sh.html>:
(optional)* Shell basics
(optional)* Meta-characters and Filename expansion
* Finding the executable
* Quoting with the Bourne Shell
(optional)* Nested quotations
(optional)* Strong versus weak quoting
(optional)* Quoting over several lines
(optional)* Mixing quotation marks
(optional)* Quotes within quotes - take two
(optional)* Placing variables within strings
* Variables
* A subtle point

"Whitespace (spaces, tabs or newlines) terminate the value." Please,
do not confuse 'whitespace' on input (script itself) with 'whitespace'
in the variable. For shell this

>        v="$@"

must be the same as
v=$*
v="$*"
v=$@
because whitespace inside parameters of $* or $@ does not "terminate
the value". Thus no need of quoting of anything, like in case of usual
command processing (* Finding the executable).

So why do you need `v=$*` anyway? Do you understand, that "$@" is
useful only in parameter list *for* a command ('executable' in the
tutorial), so it gets all parameters whitespace-untouched by the
shell?

> I've found a problem with expanding $@.
> If I declare a local variable and assigns the expanded positional parameters:
>        local v="$@"

Here *is* such case -- a command gets executed with a parameter list
handled by the shell, so goto "* Finding the executable", please, to
find out once again, what it does there.

Finally, find some info about why some shells, but not classic
`/bin/sh` or dash, have `[[` command with some special subtle
functionality, altering "* Finding the executable". Maybe this will
make the point clear.
-- 
sed 'sed && sh + olecom = love'  <<  ''
-o--=O`C
 #oo'L O
<___=E M
