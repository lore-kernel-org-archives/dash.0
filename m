From: Dave Gordon <david.s.gordon@intel.com>
Subject: Re: [bug-diffutils] bug#24116: [platform-testers] new snapshot
 available: diffutils-3.3.50-0353
Date: Fri, 5 Aug 2016 13:46:56 +0100
Message-ID: <2e1ea9a1-278e-8979-023b-72f77d677f5f@intel.com>
References: <CA+8g5KEOBs=AtZoBZw7CJ5wW8=Yw88KrvjJK1PeEqK3uj_1wEg@mail.gmail.com>
 <9C56E56C-4D31-46AB-AC75-1AA8A759BF4D@gmail.com>
 <CA+8g5KGack9X8ByfoJEtbQHj-44iG6bvQ0yhguVqQ4vqZh4geA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:32341 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161249AbcHEMq6 (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 5 Aug 2016 08:46:58 -0400
In-Reply-To: <CA+8g5KGack9X8ByfoJEtbQHj-44iG6bvQ0yhguVqQ4vqZh4geA@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jim Meyering <jim@meyering.net>, Assaf Gordon <assafgordon@gmail.com>
Cc: 24116@debbugs.gnu.org, dash@vger.kernel.org

On 01/08/16 01:36, Jim Meyering wrote:
> On Sun, Jul 31, 2016 at 10:17 AM, Assaf Gordon <assafgordon@gmail.com> wrote:
>> Hello Jim
>>
>>> On Jul 31, 2016, at 03:08, Jim Meyering <jim@meyering.net> wrote:
>>>
>>> diffutils snapshot:
>>>  http://meyering.net/diff/diffutils-3.3.50-0353.tar.xz
>>
>> The "colors" test seems to succeed on Fedora/CentOS/SUSE systems (of various versions), but fail on others (Ubuntu, Debian, FreeBSD, Mac OS X).
>>
>> Attached are logs from 3 systems. From a cursory look it seems the exact same failure, but I haven't looked deeper.
>> No other test failures found, but I'll have more results later today.
>
> Hi Assaf,
> Thank you for all the speedy testing.
> I've looked into the failure on a Debian system for which /bin/sh is
> dash 0.5.8-2.2.
> dash's printf builtin handles \e differently -- that's easy to work
> around: use \033, which *is* portable.
> More surprising is that this generates no output:
>
>   dash -c 'f() { local t=$(printf '\''\t\t'\''); printf "$t"; }; f'
>
> I.e., piping it into wc -c prints 0.
> With bash, it prints the expected pair of TAB bytes.
> I found that I could work around this nonsensical behavior by hoisting
> the "tab=..." definition up/out of those two functions, or by adding
> standard-says-never-necessary double quotes like this:
>
>   dash -c 'f() { local t="$(printf '\''\t\t'\'')"; printf "$t"; }; f'
>
> However, I prefer not to work around it here (and in every other test
> script where this comes up), and will insulate all of our test scripts
> by rejecting any shell with that misbehavior, so plan to adjust
> init.sh to select another shell when it finds this flaw.
>
> On second thought, I will make the local change now, and sleep on the
> idea of making init.sh reject dash.
> Done in the attached patch.

No, that's definitely a dash(1) bug, and quite a serious one. Here's a 
variant that makes it more obvious:

# Define our test string, without too much complicated quoting
$ X='f() { local t=$(printf "abc"); printf "$t"; }; f'
$ bash -c "$X" | hd
00000000  61 62 63                                          |abc|
00000003
$ dash -c "$X" | hd
00000000  61 62 63                                          |abc|
00000003
# As expected, we get the same result from bash(1) and dash(1).

# Now try a different test string:
$ X='f() { local t=$(printf "a\tc"); printf "$t"; }; f'
$ bash -c "$X" | hd
00000000  61 09 63                                          |a.c|
00000003
$ dash -c "$X" | hd
00000000  61                                                |a|
00000001
# Wibble! dash(1) has truncated the string at the TAB :(

# In fact it's worse that that
$ X='f() { local t=$(printf "a\tc=d"); printf "$t+$c"; }; f'
$ bash -c "$X" | hd
00000000  61 09 63 3d 64 2b                                 |a.c=d+|
00000006
$ dash -c "$X" | hd
00000000  61 2b 64                                          |a+d|
00000003

What dash(1) appears to have done is silently take the TAB as
the terminator of the containing double-quoted string, AND of
the containing $() construct, as well as a whitespace, so that
the "c=d" is taken as the next argument to the 'local' builtin.

I suspect this unexpected termination of the inner quoted-string
could be quite exploitable!

.Dave.
