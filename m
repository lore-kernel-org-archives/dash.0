From: Dave Gordon <david.s.gordon@intel.com>
Subject: Re: [bug-diffutils] bug#24116: [platform-testers] new snapshot
 available: diffutils-3.3.50-0353
Date: Fri, 5 Aug 2016 15:09:03 +0100
Message-ID: <7564725e-88c1-a66e-9891-d96d56585c13@intel.com>
References: <CA+8g5KEOBs=AtZoBZw7CJ5wW8=Yw88KrvjJK1PeEqK3uj_1wEg@mail.gmail.com>
 <9C56E56C-4D31-46AB-AC75-1AA8A759BF4D@gmail.com>
 <CA+8g5KGack9X8ByfoJEtbQHj-44iG6bvQ0yhguVqQ4vqZh4geA@mail.gmail.com>
 <2e1ea9a1-278e-8979-023b-72f77d677f5f@intel.com>
 <90e016d1-e0be-83c8-d0ee-ecb5665318ef@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:8228 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753776AbcHEOJG (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 5 Aug 2016 10:09:06 -0400
In-Reply-To: <90e016d1-e0be-83c8-d0ee-ecb5665318ef@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: 24116@debbugs.gnu.org, dash@vger.kernel.org

On 05/08/16 14:13, Harald van Dijk wrote:
> On 5-8-2016 14:46, Dave Gordon wrote:
>> On 01/08/16 01:36, Jim Meyering wrote:
>>> On Sun, Jul 31, 2016 at 10:17 AM, Assaf Gordon <assafgordon@gmail.com>
>>> wrote:
>>>> Hello Jim
>>>>
>>>>> On Jul 31, 2016, at 03:08, Jim Meyering <jim@meyering.net> wrote:
>>>>>
>>>>> diffutils snapshot:
>>>>>  http://meyering.net/diff/diffutils-3.3.50-0353.tar.xz
>>>>
>>>> The "colors" test seems to succeed on Fedora/CentOS/SUSE systems (of
>>>> various versions), but fail on others (Ubuntu, Debian, FreeBSD, Mac
>>>> OS X).
>>>>
>>>> Attached are logs from 3 systems. From a cursory look it seems the
>>>> exact same failure, but I haven't looked deeper.
>>>> No other test failures found, but I'll have more results later today.
>>>
>>> Hi Assaf,
>>> Thank you for all the speedy testing.
>>> I've looked into the failure on a Debian system for which /bin/sh is
>>> dash 0.5.8-2.2.
>>> dash's printf builtin handles \e differently -- that's easy to work
>>> around: use \033, which *is* portable.
>>> More surprising is that this generates no output:
>>>
>>>   dash -c 'f() { local t=$(printf '\''\t\t'\''); printf "$t"; }; f'
>>>
>>> I.e., piping it into wc -c prints 0.
>>> With bash, it prints the expected pair of TAB bytes.
>>> I found that I could work around this nonsensical behavior by hoisting
>>> the "tab=..." definition up/out of those two functions, or by adding
>>> standard-says-never-necessary double quotes like this:
>>>
>>>   dash -c 'f() { local t="$(printf '\''\t\t'\'')"; printf "$t"; }; f'
>>>
>>> However, I prefer not to work around it here (and in every other test
>>> script where this comes up), and will insulate all of our test scripts
>>> by rejecting any shell with that misbehavior, so plan to adjust
>>> init.sh to select another shell when it finds this flaw.
>>>
>>> On second thought, I will make the local change now, and sleep on the
>>> idea of making init.sh reject dash.
>>> Done in the attached patch.
>>
>> No, that's definitely a dash(1) bug, and quite a serious one. Here's a
>> variant that makes it more obvious:
>>
>> # Define our test string, without too much complicated quoting
>> $ X='f() { local t=$(printf "abc"); printf "$t"; }; f'
>> $ bash -c "$X" | hd
>> 00000000  61 62 63                                          |abc|
>> 00000003
>> $ dash -c "$X" | hd
>> 00000000  61 62 63                                          |abc|
>> 00000003
>> # As expected, we get the same result from bash(1) and dash(1).
>>
>> # Now try a different test string:
>> $ X='f() { local t=$(printf "a\tc"); printf "$t"; }; f'
>> $ bash -c "$X" | hd
>> 00000000  61 09 63                                          |a.c|
>> 00000003
>> $ dash -c "$X" | hd
>> 00000000  61                                                |a|
>> 00000001
>> # Wibble! dash(1) has truncated the string at the TAB :(
>>
>> # In fact it's worse that that
>> $ X='f() { local t=$(printf "a\tc=d"); printf "$t+$c"; }; f'
>> $ bash -c "$X" | hd
>> 00000000  61 09 63 3d 64 2b                                 |a.c=d+|
>> 00000006
>> $ dash -c "$X" | hd
>> 00000000  61 2b 64                                          |a+d|
>> 00000003
>>
>> What dash(1) appears to have done is silently take the TAB as
>> the terminator of the containing double-quoted string, AND of
>> the containing $() construct, as well as a whitespace, so that
>> the "c=d" is taken as the next argument to the 'local' builtin.
>>
>> I suspect this unexpected termination of the inner quoted-string
>> could be quite exploitable!
>
> This gets reported relatively frequently. The local command is
> non-standard but a common extension in shells. In the shells that
> provide it, it gets treated the same, syntax-wise, as the standard
> export command, including in dash.
>
> Unfortunately, POSIX currently requires the export command to not have
> any magic quoting, and any POSIX-conforming shell will make
>
>     a="b c=d"
>     export a=$a
>
> set a to b, and c to d. Not so with bash, but that's because bash simply
> isn't POSIX-conforming, even if invoked as sh.
>
> POSIX will require special quoting rules for the export command in the
> future, similar to what bash does today. When it does, dash is likely to
> change to match that, and the local command will likely be changed to
> work the same way.
>
> Right now, though, since the special quoting behaviour is non-standard,
> this is a bug in the script unless the script is explicitly stated to
> work only with specific shells. If the script is meant to be portable,
> even if only across shells that provide the local command, quoting
> $(...) is the right thing to do.
>
> Alternatively:
>
>     local a
>     a=$(...)
>
> should work too, including in dash. Since a=$(...) is not an argument to
> any command here, since it's the shell syntax that says it's an
> assignment rather than the semantics of a particular command, field
> splitting won't happen here.
>
> Cheers,
> Harald van Dijk

Hi,

thanks for the explanation :) I had devised a few more tests and
realised that dash is applying word-splitting after substitution,
as would be expected for ordinary external commands e.g.

$ X="256 if=foo"
$ dd bs=$X
dd: failed to open ‘foo’: No such file or directory

where one would always expect to write bs="$X" with quotes if one wanted 
to ensure that it was taken as a single parameter and without quotes if 
one wanted it to be broken into multiple words.

It was just a surprise to find this (rather than bash's implicit
quoting) applying to dash builtin commands!

Another variant that does work, this time by escaping rather than 
quoting the TAB, and deferring conversion of '\t' into a TAB until after 
the word-splitting:

$ X='f() { local t=$(printf a\\\\tc=d); printf "$t+$c"; }; f'
$ bash -c "$X" | hd
00000000  61 09 63 3d 64 2b                                 |a.c=d+|
00000006
$ dash -c "$X" | hd
00000000  61 09 63 3d 64 2b                                 |a.c=d+|
00000006

Cheers,
.Dave.
