From: "Oleg Verych" <olecom@gmail.com>
Subject: Re: output redirections
Date: Mon, 14 Jan 2008 18:08:46 +0100
Message-ID: <8499950a0801140908i426b3d53s4fd76d589d6a1140@mail.gmail.com>
References: <20080114114604.GA12318@xanadu.blop.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:54186 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbYANRIt (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 14 Jan 2008 12:08:49 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1266550fkz.5
        for <dash@vger.kernel.org>; Mon, 14 Jan 2008 09:08:47 -0800 (PST)
In-Reply-To: <20080114114604.GA12318@xanadu.blop.info>
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Lucas Nussbaum <lucas@lucas-nussbaum.net>
Cc: dash@vger.kernel.org

On 1/14/08, Lucas Nussbaum <lucas@lucas-nussbaum.net> wrote:
> Hi,
>
> I rebuilt all packages in Debian in a chroot using dash as /bin/sh,
> which uncovered quite a lot of problems in build scripts.
> One of the problems is about output redirection.
>
> I understand that:
>   command &>/dev/null
> is a bashism. (with dash, it forks a subshell)
>
> the "common" replacement is:
>   command >/dev/null 2>&1
> Which works fine with dash. However, I couldn't find any reference to
> ">&1" in the posix standard. Is it really posix-compliant? Shouldn't we
> use instead:
>    command >/dev/null 2>/dev/null

|2.7.6 Duplicating an Output File Descriptor
|...If word evaluates to one or more digits, the file descriptor
denoted by n,...

http://www.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html#tag_02_07_06

It's a very usual practice, btw. But on large scale it's not too flexible
and very feature-limited. It would be even less flexible, if two file names
were a must to specify. It's generally one more (quite heavy) open() syscall.
Check this.

strace /bin/dash -c 'echo >/dev/null 2>/dev/null'
strace /bin/dash -c 'echo >/dev/null 2>&1'

-- 
-o--=O`C
  #oo'L O
<___=E M
