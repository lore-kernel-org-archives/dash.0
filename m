From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [PATCH] Improved LINENO support
Date: Fri, 12 Nov 2010 20:07:41 +0059
Message-ID: <4CDD9095.5070106@gigawatt.nl>
References: <4CD85E90.6000308@gigawatt.nl> <20101110220008.GC17871@stack.nl> <4CDD8481.1060306@gigawatt.nl> <4CDD8908.9010206@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from 541F7301.cm-5-8b.dynamic.ziggo.nl ([84.31.115.1]:45533 "HELO
	boostbox.lionra.local" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1752967Ab0KLTGr (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 12 Nov 2010 14:06:47 -0500
In-Reply-To: <4CDD8908.9010206@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Eric Blake <eblake@redhat.com>, Jilles Tjoelker <jilles@stack.nl>

On 12/11/10 19:35, Eric Blake wrote:
> On 11/12/2010 11:17 AM, Harald van Dijk wrote:
>>    (
>>      :
>>      :
>>      :
>>      :
>>      :
>>    )>test-$LINENO
>>
>> should write to file test-1, not test-7, even though the only word is on
>> line 7. bash gets this wrong, pdksh gets this almost right.
>
> Umm - there was more than one word in that example (each : in the
> subshell is a word).  But I agree that the subshell command itself
> started on line 1, but the word containing $LINENO is on line 7.

That was because it was a poor example. I meant to use comments, but 
forgot to change this before posting. I haven't checked if they count as 
words in SUS, but they don't in the dash source code.

> There are _so many_ variations on what this example would do that it's
> hard to say that any one version is definitively correct.  In general,
> the standard tends to favor the ksh93 interpretation of things; but on
> your example, it touches the file test-6 (not test-7 nor test-1).
 >
> All I can see in the standard is:
>
> "Set by the shell to a decimal number representing the current
> sequential line number (numbered starting with 1) within a script or
> function before it executes each command."
>
> with no hint as to whether LINENO auto-increments over the number of
> newlines encountered while parsing that command.

You may be right. SUS doesn't really specify whether "current" refers to 
the first or the last line number of a command. test-1 and test-7 are 
equally defensible, so I was too quick to say that bash gets this wrong. 
I hope you agree, though, that test-6 is iffy, and for my other example:

   echo $LINENO \
     $LINENO

two identical numbers must be printed. SUS only requires and only allows 
LINENO to be set before a command is executed, so once it is set, it is 
set for both expansions. Given that,

   (
     #
     #
     #
     #
     #
   )>test-$LINENO \
   >>test2-$LINENO

must not write to test-7 and test2-8. It may write to test-1 and 
test2-1, or it may write to test-8 and test2-8. Perhaps even to test-7 
and test2-7. Again, though, LINENO must be the same in both expansions. 
So for dash, the problem doesn't change: storing the line number of each 
word, rather than each command, makes it very hard to get LINENO right.
