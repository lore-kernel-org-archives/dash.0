From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: Bug#953421: dash: Resident Set Size growth is unbound (memory
 leak) on an infinite shell loop
Date: Sun, 29 Mar 2020 20:06:31 +0100
Message-ID: <a2efaae8-db1b-39ae-d7c2-8d119a4f14d4@gigawatt.nl>
References: <158376996556.31988.8584094104007124674.reportbug@ec2-34-240-101-198.eu-west-1.compute.amazonaws.com>
 <CACujMDPfs5mJs8CVaxqM6wkCRANYQ71wTUkvHiNvOg+MPSTECQ@mail.gmail.com>
 <07ce01d605f3$103f1610$30bd4230$@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.gigawatt.nl ([51.68.198.76]:38068 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727606AbgC2TI6 (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 29 Mar 2020 15:08:58 -0400
In-Reply-To: <07ce01d605f3$103f1610$30bd4230$@gmail.com>
Content-Language: en-US
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Vitaly Zuevsky <vitaly.zuevsky@gmail.com>, 'Andrej Shadura' <andrew@shadura.me>, 953421@bugs.debian.org, dash@vger.kernel.org
Cc: 'Debian Bug Tracking System' <submit@bugs.debian.org>

Hi Vitaly,

On 29/03/2020 18:54, Vitaly Zuevsky wrote:
> I have now fixed this bug locally.
> 
> The leak is in jobtab array (jobs.c). I concluded that the most logical approach would be eliminating inconsistency between makejob() and dowait() functions. My fix in a forked repo:
> 
> https://salsa.debian.org/psvz-guest/dash/-/commit/5e3ea90cb3355d1308c482661a471883d36af5e7

This change is incorrect. The reason dash keeps on allocating memory is 
because dash needs to keep on allocating memory. Consider this script:

   set -- $(seq 1 100)
   for i
   do
     : &
     sleep .1
   done
   for i
   do
     wait %$i
   done

This is a valid script and works fine in dash. Your change breaks this 
by not keeping the jobs around long enough, and I hope this test script 
shows that there is no way to keep the jobs around long enough but by 
allocating ever more memory.

Your change makes it impossible to keep track of the background 
process's status, but if you do not care about that anyway, you can 
avoid the increasing memory use without modifying dash by launching a 
background process without including it in the current shell's job 
table, by launching it from a subshell:

   while true
   do
     (true &)
     sleep .1
   done

Cheers,
Harald van Dijk
