From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [PATCH] parseheredoc: fix alias expansion: save and restore
 checkkwd
Date: Sat, 25 Jan 2020 16:17:56 +0000
Message-ID: <a31ce511-1dfa-0f73-d553-4f7af28db671@gigawatt.nl>
References: <40db0aa1-195b-f29e-5068-01fa101affd9@inlv.org>
 <8b48cd04-b85f-1086-55c8-8e17800f5693@gigawatt.nl>
 <f40ce455-afd8-05f4-e594-4395bb2a8ed0@gigawatt.nl>
 <0c506ff6-6da5-f117-b0b3-d3cf7cc008ed@inlv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.gigawatt.nl ([51.68.198.76]:48670 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgAYQS5 (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 25 Jan 2020 11:18:57 -0500
In-Reply-To: <0c506ff6-6da5-f117-b0b3-d3cf7cc008ed@inlv.org>
Content-Language: en-US
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Martijn Dekker <martijn@inlv.org>, DASH shell mailing list <dash@vger.kernel.org>

On 25/01/2020 12:19, Martijn Dekker wrote:
> Op 25-01-20 om 02:38 schreef Harald van Dijk:
>> On 25/01/2020 01:13, Harald van Dijk wrote:
>>> On 24/01/2020 23:48, Martijn Dekker wrote:
>>>> There is a regression involving alias expansion, a here-document, 
>>>> and a command substitution. The following worked fine until dash 
>>>> 0.5.8; it throws a syntax error as of dash 0.5.9.
>>>>
>>>> alias BEGIN='{' END='}'
>>>> BEGIN
>>>> cat <<eof
>>>> $(echo hi)
>>>> eof
>>>> END
>>>
>>> Nice find.
>>>
>>> When the newline after cat <<eof is seen, checkkwd is changed to 
>>> indicate that the shell is in a state where aliases can be expanded. 
>>> Then, parseheredoc() is called, which in turn calls readtoken1() to 
>>> parse the here-document. readtoken() re-sets checkkwd once it is 
>>> done, but readtoken1() does not, so normally this preserves the "can 
>>> expand aliases" state. However, nested command substitutions do reset 
>>> checkkwd, so things break.
>>>
>>> Until 0.5.8, parseheredoc() was called first, and only after that did 
>>> checkkwd get changed.
>>>
>>> Either parseheredoc() needs to save and restore checkkwd, or the code 
>>> calling parseheredoc() needs to ensure that it sets checkkwd as 
>>> appropriate afterwards.
> 
> Saving and restoring checkkwd in parseheredoc() seems the simplest and 
> the most future-proof, so here's a patch to do that.

I have now gone over the places where parseheredoc() is called.

The calls in list() are followed by a return statement. It does not 
matter what value checkkwd has afterwards, as no new command will be 
parsed, or at least not before checkkwd gets reset anyway.

The call in readtoken() under parsebackq only happens when a word 
containing a command substitution is being parsed. This can never be a 
valid alias name, so here too it does not matter what value checkkwd has 
afterwards. If checkkwd should be restored to make the code easier to 
understand, it should be restored to the value it had before the list() 
call, not the value it had before parseheredoc(), so this is something 
that cannot be done from within parseheredoc().

The only place where checkkwd being clobbered matters is at the start of 
readtoken(), under the "eat newlines" comment. This is very close to the 
place where CHKALIAS gets checked and it is possible to instead change 
the check to respect the already-saved value of checkkwd:

--- a/src/parser.c
+++ b/src/parser.c
@@ -734,7 +734,7 @@ top:
                 }
         }

-       if (checkkwd & CHKALIAS) {
+       if ((kwd | checkkwd) & CHKALIAS) {
                 struct alias *ap;
                 if ((ap = lookupalias(wordtext, 1)) != NULL) {
                         if (*ap->val) {

The value of checkkwd may have been clobbered by xxreadtoken() as well, 
not just by parseheredoc(), so this approach would handle that too. 
However, if a token is a newline, a valid keyword, or a valid alias 
name, then checkkwd is guaranteed not to get clobbered by xxreadtoken(), 
so it should make no difference in practice which earlier value of 
checkkwd gets used, and there should be no observable difference between 
your patch and mine.

Cheers,
Harald van Dijk
