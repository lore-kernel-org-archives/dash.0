From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: Bug#953421: dash: Resident Set Size growth is unbound (memory
 leak) on an infinite shell loop
Date: Mon, 30 Mar 2020 00:07:09 +0100
Message-ID: <432024ae-d29a-db65-0ec9-4f98bf0ca56c@gigawatt.nl>
References: <158376996556.31988.8584094104007124674.reportbug@ec2-34-240-101-198.eu-west-1.compute.amazonaws.com>
 <CACujMDPfs5mJs8CVaxqM6wkCRANYQ71wTUkvHiNvOg+MPSTECQ@mail.gmail.com>
 <07ce01d605f3$103f1610$30bd4230$@gmail.com>
 <a2efaae8-db1b-39ae-d7c2-8d119a4f14d4@gigawatt.nl>
 <20200329220706.GA13241@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.gigawatt.nl ([51.68.198.76]:38490 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727125AbgC2XJh (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 29 Mar 2020 19:09:37 -0400
In-Reply-To: <20200329220706.GA13241@stack.nl>
Content-Language: en-US
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: Vitaly Zuevsky <vitaly.zuevsky@gmail.com>, 'Andrej Shadura' <andrew@shadura.me>, 953421@bugs.debian.org, dash@vger.kernel.org, 'Debian Bug Tracking System' <submit@bugs.debian.org>

On 29/03/2020 23:07, Jilles Tjoelker wrote:
> On Sun, Mar 29, 2020 at 08:06:31PM +0100, Harald van Dijk wrote:
>> On 29/03/2020 18:54, Vitaly Zuevsky wrote:
>>> I have now fixed this bug locally.
> 
>>> The leak is in jobtab array (jobs.c). I concluded that the most
>>> logical approach would be eliminating inconsistency between
>>> makejob() and dowait() functions. My fix in a forked repo:
> 
>>> https://salsa.debian.org/psvz-guest/dash/-/commit/5e3ea90cb3355d1308c482661a471883d36af5e7
> 
>> This change is incorrect. The reason dash keeps on allocating memory is
>> because dash needs to keep on allocating memory. Consider this script:
> 
>>    set -- $(seq 1 100)
>>    for i
>>    do
>>      : &
>>      sleep .1
>>    done
>>    for i
>>    do
>>      wait %$i
>>    done
> 
>> This is a valid script and works fine in dash. Your change breaks this by
>> not keeping the jobs around long enough, and I hope this test script shows
>> that there is no way to keep the jobs around long enough but by allocating
>> ever more memory.
> 
> I agree that the change is incorrect, but I do not agree that this kind
> of script must leak memory. Per POSIX.1-2008 XCU 2.9.3.1 Asynchronous
> Lists, an implementation has additional ways to forget about jobs than
> just an appropriate completion of the wait utility: if another
> asynchronous job is started when $! was not referenced or if the number
> of known process IDs would exceed {CHILD_MAX} (which tends to be rather
> big, though).

That says the process ID need not be remembered, which makes sense: 
process IDs are a very limited resource on some systems. This reasoning 
does not apply to job IDs and I do not see any corresponding wording for 
those. Am I overlooking something?

Regardless, it does not leak memory. It continually uses more memory, 
but it is not a leak if the memory is still in use and can/will be freed 
when it is no longer needed. Memory used for jobs is released when the 
job is removed from the job table.

> POSIX does not seem to expect using %<jobid> in scripts like this; it
> seems highly fragile to me anyway (although $! has problems with process
> ID reuse).

In what way does it not seem to expect this? POSIX says "The job control 
job ID type of pid is only available on systems supporting the User 
Portability Utilities option" but does not appear to have any other 
relevant restrictions.

As for fragile, sure, but if a script is correct, it should be processed 
correctly by a shell.

> FreeBSD sh implements forgetting when $! was not referenced (and the job
> has terminated), but not the {CHILD_MAX} limit. This avoids the
> increasing memory usage in the example script.

See above for the note on process ID vs job ID.

>> Your change makes it impossible to keep track of the background process's
>> status, but if you do not care about that anyway, you can avoid the
>> increasing memory use without modifying dash by launching a background
>> process without including it in the current shell's job table, by launching
>> it from a subshell:
> 
>>    while true
>>    do
>>      (true &)
>>      sleep .1
>>    done
> 
> Certainly a good idea.
> 
> Another option may be to include regular invocations of the wait utility
> without parameters, although this is not suitable for all scripts.

A third option is invoking the 'jobs' command, possibly redirecting the 
output to /dev/null. When the 'jobs' command reports that any background 
job is done, that job is removed from the list of jobs the shell has to 
remembers.

Cheers,
Harald van Dijk
