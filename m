From: Heiko Gerstung <heiko@am-anger-1.de>
Subject: Re: Dashhh
Date: Thu, 17 Nov 2011 21:40:21 +0100
Message-ID: <4EC57135.2030609@am-anger-1.de>
References: <4EC53397.2030005@am-anger-1.de> <4EC54ABA.6050607@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:58831 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250Ab1KQUkX (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 17 Nov 2011 15:40:23 -0500
In-Reply-To: <4EC54ABA.6050607@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: dash@vger.kernel.org

Am 17.11.11 18:56, schrieb Eric Blake:
> On 11/17/2011 09:17 AM, Heiko Gerstung wrote:
>> What this tiny patch does:
>> - shift does not return a critical error when no arguments are left, it simply does nothing
> This came up in the Austin Group (the folks in charge of POSIX), and the
> consensus there was that dash is compliant (POSIX says that the problem
> is with the script, not the shell, if you call shift with too few
> positional parameters set; and that you should rewrite your script to
> avoid tickling unspecified behavior).
>
> http://austingroupbugs.net/view.php?id=459
Thanks for providing the link. I disagree with POSIX ;-) in this 
respect. Since shift often deals with user input (parameters provided 
when invoking a script) it is not really foreseeable if a certain number 
of parameters exists when shift comes to the party. I will try to 
rewrite my scripts, but it is a PITA to do so (as all of us most 
probably know) and if it is not really a POSIX violation to allow it, I 
see no benefit from not allowing it. But hey, that's just me.

>
>> - "[[" works exactly as "["
> Wrong.  [[ is NOT exactly like [.  And the Austin Group is currently
> considering a proposal to add [[ to the shell (if that is done, then
> dash will HAVE to implement it as specified by POSIX; but the jury's
> still out on whether the proposal will be accepted):
>
> http://austingroupbugs.net/view.php?id=375
Yep, Stefano already pointed that out. My mistake!

>> - "==" works like "="
> That same Austin Group proposal is also talking about adding [ a == b ];
> this particular addition is much less controversial than the [[
> addition, so it is likely that the proposal will be split and each
> separate addition individually balloted for inclusion.
I hope they accept it. Really a no-ressource-consuming, no existing 
script breaking thing and therefore a worthwhile addition IMHO.
>> - the variable FUNCNAME contains the name of the currently running shell function or nothing (when not inside a function)
> That's fluff - POSIX doesn't speak either way, and dash prefers to be as
> light as possible when POSIX doesn't require it, so I'm not sure if
> you'll get any enthusiastic response on this front.
I do not expect any enthusiastic responses, but I consider this a 
valuable addition for debugging large scripts with lots of functions 
usage. I have no problem if you think it's fluff, nobody is forced to 
use something she/he doesn't like.

One more thing I'd like to add is something like $SECONDS, but maybe 
with a little bit more resolution (maybe $RUNTIME representing the 
amount of milliseconds  since script invocation). Fluff as you probably 
would say ;-), but it would give me a good idea where in my (larger) 
scripts I am doing something that costs a lot of time.

Thank you for your interesting comments, that was exactly what I was 
hoping for! Got me thinking and I already have a few nice ideas how to 
rewrite parts of my scripts.

Regards,
   Heiko
