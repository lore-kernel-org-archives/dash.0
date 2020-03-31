From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: Bug#953421: dash: Resident Set Size growth is unbound (memory
 leak) on an infinite shell loop
Date: Tue, 31 Mar 2020 22:04:13 +0100
Message-ID: <fbccd6fb-b1b8-97a2-be1c-afa7a2fc879b@gigawatt.nl>
References: <158376996556.31988.8584094104007124674.reportbug@ec2-34-240-101-198.eu-west-1.compute.amazonaws.com>
 <CACujMDPfs5mJs8CVaxqM6wkCRANYQ71wTUkvHiNvOg+MPSTECQ@mail.gmail.com>
 <07ce01d605f3$103f1610$30bd4230$@gmail.com>
 <a2efaae8-db1b-39ae-d7c2-8d119a4f14d4@gigawatt.nl>
 <083501d6078f$afb4fc80$0f1ef580$@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.gigawatt.nl ([51.68.198.76]:41176 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727937AbgCaVEP (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 31 Mar 2020 17:04:15 -0400
In-Reply-To: <083501d6078f$afb4fc80$0f1ef580$@gmail.com>
Content-Language: en-US
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Vitaly Zuevsky <vitaly.zuevsky@gmail.com>, 'Andrej Shadura' <andrew@shadura.me>, 953421@bugs.debian.org, dash@vger.kernel.org
Cc: 'Debian Bug Tracking System' <submit@bugs.debian.org>

Hi Vitaly,

On 31/03/2020 20:07, Vitaly Zuevsky wrote:
> I must have confused two concepts: waited process in OS -vs- waited job inside shell interpreter. I am trying to see how it work in practice:
> 
> # true & false &
> #
> [2] + Done(1)                    false
> [1] + Done                       true
> # wait 2
> # echo $?
> 127
> 
> As we preserve job exit codes, I would expect wait command to read them and free associated jobtab slots. In above example I expect to see 1 in place of 127. What do I miss here?

There are two problems here. The first is that waiting for jobs involves 
the % symbol. wait 2 always means "wait for process 2", never "wait for 
job 2". To wait for job 2, the syntax is "wait %2". The second problem 
is that as soon as you see that "[2] + Done(1)", the job has been 
removed the job table already, so "wait %2" no longer works after that. 
The blank line (except for the #) indicates that you pressed Return at 
that point. In interactive shells, jobs are checked for completion and 
removed from the job table automatically when prompting for input. Since 
it was practically impossible to press Return before the "true" and 
"false" commands had finished, when the next prompt would have been 
shown, the jobs were cleaned up. If you had typed "wait %2" before 
pressing Return, it would have worked and the subsequent "echo $?" would 
have printed "1".

> Many thanks for your help.
> 
> Best,
> Vitaly
