From: Damian Wrobel <dwrobel@ertelnet.rybnik.pl>
Subject: Re: Inconsistent behaviour between 'jobs' and 'echo "$(jobs)"'
Date: Tue, 20 Jan 2015 18:01:10 +0100
Message-ID: <54BE89D6.7040101@ertelnet.rybnik.pl>
References: <54BD4691.7050906@ertelnet.rybnik.pl> <20150120084438.GA751@ein.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp.ertel.com.pl ([62.182.231.178]:32493 "EHLO
	smtp.ertel.com.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952AbbATRBM (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 20 Jan 2015 12:01:12 -0500
In-Reply-To: <20150120084438.GA751@ein.free.fr>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Seb <sbb@tuxfamily.org>

On 01/20/2015 09:44 AM, Seb wrote:
> On Mon, Jan 19, 2015 at 07:01:53PM +0100, Damian Wrobel wrote:
>
> Hello,
>
>> I'm observing an inconsistent behaviour between:
>>   jobs
>> and
>>   echo "$(jobs)"
>
> It's because the command is ran in a sub-shell, where there is indeed no
> running job.
>
> Bash has a special mechanism to handle this and get the current shell
> context returned, that's why you may feel some inconsistency here (like
> I myself did :)

There is an application usage [1] where this case is specifically mentioned with 
a suggestion that: "For this reason, jobs is generally implemented as a shell 
regular built-in."

I basically planned to use the following construction to kill all running jobs:

$ kill $(jobs -p)

Now it looks that even the following doesn't work in a dash:

$ jobs -p | xargs kill

I would prefer not to code something like the following:

$ jobs -p >/tmp/jobs-$$ && kill $(cat /tmp/jobs-$$); rm /tmp/jobs-$$


Have a nice day,
Damian

[1] http://pubs.opengroup.org/onlinepubs/9699919799/utilities/jobs.html

>
> ++
> Seb.
>
>
>

