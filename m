From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: /bin/dash -c != /bin/bash -c with pgrep
Date: Tue, 24 Jan 2012 13:43:42 -0600
Message-ID: <20120124194342.GC2956@burratino>
References: <4F1ED38A.1050401@ruggedcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50895 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123Ab2AXTnz (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 24 Jan 2012 14:43:55 -0500
Received: by ggnb1 with SMTP id b1so2179961ggn.19
        for <dash@vger.kernel.org>; Tue, 24 Jan 2012 11:43:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F1ED38A.1050401@ruggedcom.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Richard Retanubun <richardretanubun@ruggedcom.com>
Cc: dash@vger.kernel.org

Hi Richard,

Richard Retanubun wrote:

> /bin/dash -c "pgrep -f /usr/sbin/atftpd"; echo $?
> -vs-
> /bin/bash -c "pgrep -f /usr/sbin/atftpd"; echo $?
>
> The dash version returns the PID of the grep itself and thus always succeeds.
> The bash version works as expected.

As the pgrep(1) manual explains, the running pgrep or pkill process
will never report itself as a match.  However, when running pgrep
through dash, it reports the process id of the shell executing pgrep,
while the bash version and recent dash versions optimize "sh -c
'single command'" to

	sh -c 'exec pgrep -f /usr/sbin/atftpd'

so there is no shell process left to report.

If that "exec" is specified explicitly, the result is the same in both
shells.

Hope that helps,
Jonathan
