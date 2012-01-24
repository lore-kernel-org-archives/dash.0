From: Richard Retanubun <richardretanubun@ruggedcom.com>
Subject: Re: /bin/dash -c != /bin/bash -c with pgrep
Date: Tue, 24 Jan 2012 15:17:12 -0500
Message-ID: <4F1F11C8.9000200@ruggedcom.com>
References: <4F1ED38A.1050401@ruggedcom.com> <20120124194342.GC2956@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail2.ruggedcom.com ([204.50.148.11]:27764 "EHLO
	mail2.ruggedcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756471Ab2AXUTp (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 24 Jan 2012 15:19:45 -0500
In-Reply-To: <20120124194342.GC2956@burratino>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: "dash@vger.kernel.org" <dash@vger.kernel.org>

On 24/01/12 02:43 PM, Jonathan Nieder wrote:
> Hi Richard,
>
> Richard Retanubun wrote:
>
>> /bin/dash -c "pgrep -f /usr/sbin/atftpd"; echo $?
>> -vs-
>> /bin/bash -c "pgrep -f /usr/sbin/atftpd"; echo $?
>>
>> The dash version returns the PID of the grep itself and thus always succeeds.
>> The bash version works as expected.
>
> As the pgrep(1) manual explains, the running pgrep or pkill process
> will never report itself as a match.  However, when running pgrep
> through dash, it reports the process id of the shell executing pgrep,
> while the bash version and recent dash versions optimize "sh -c
> 'single command'" to
>
> 	sh -c 'exec pgrep -f /usr/sbin/atftpd'
>
> so there is no shell process left to report.
>
> If that "exec" is specified explicitly, the result is the same in both
> shells.
>
> Hope that helps,
> Jonathan
It sure does, thanks a lot Jonathan.

As an addendum, I find using "pgrep -x atftpd" in this case also yields the
expected output in both shell.

Thanks for your time.

-- RR --
