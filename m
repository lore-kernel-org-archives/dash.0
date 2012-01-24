From: Richard Retanubun <richardretanubun@ruggedcom.com>
Subject: Re: /bin/dash -c != /bin/bash -c with pgrep
Date: Tue, 24 Jan 2012 15:53:02 -0500
Message-ID: <4F1F1A2E.5020103@ruggedcom.com>
References: <4F1ED38A.1050401@ruggedcom.com> <20120124194342.GC2956@burratino> <4F1F11C8.9000200@ruggedcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail2.ruggedcom.com ([204.50.148.11]:32078 "EHLO
	mail2.ruggedcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756446Ab2AXUzf (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 24 Jan 2012 15:55:35 -0500
In-Reply-To: <4F1F11C8.9000200@ruggedcom.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: "dash@vger.kernel.org" <dash@vger.kernel.org>

On 24/01/12 03:17 PM, Richard Retanubun wrote:
> On 24/01/12 02:43 PM, Jonathan Nieder wrote:
>> Hi Richard,
>>
>> Richard Retanubun wrote:
>>
>>> /bin/dash -c "pgrep -f /usr/sbin/atftpd"; echo $?
>>> -vs-
>>> /bin/bash -c "pgrep -f /usr/sbin/atftpd"; echo $?
>>>
>>> The dash version returns the PID of the grep itself and thus always=
 succeeds.
>>> The bash version works as expected.
>>
>> As the pgrep(1) manual explains, the running pgrep or pkill process
>> will never report itself as a match.  However, when running pgrep
>> through dash, it reports the process id of the shell executing pgrep=
,
>> while the bash version and recent dash versions optimize "sh -c
>> 'single command'" to
>>
>> 	sh -c 'exec pgrep -f /usr/sbin/atftpd'
>>
>> so there is no shell process left to report.
>>
>> If that "exec" is specified explicitly, the result is the same in bo=
th
>> shells.
>>
>> Hope that helps,
>> Jonathan
> It sure does, thanks a lot Jonathan.
>
> As an addendum, I find using "pgrep -x atftpd" in this case also yiel=
ds the
> expected output in both shell.
>
> Thanks for your time.
>
> -- RR --
Sorry, one more question to clarify, which "recent dash versions" have =
the optimization?

Debian changelog from wheezy (0.5.7-2) says this:

0005-SHELL-Disable-sh-c-...diff: back out the optimization
that makes dash -c "script" avoid a fork().  It caused
several packages to fail to build from source (thx St=E9phane Glondu, c=
loses: #642922).

So it used to, but does not currently?

-- Richard
