From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] Revert "Eliminated global exerrno."
Date: Thu, 7 Oct 2010 16:34:10 -0500
Message-ID: <20101007213410.GA13464@burratino>
References: <20101006100804.GB361@burratino>
 <20101006102930.GA6573@gondor.apana.org.au>
 <20101006105531.GB475@burratino>
 <4CAC68FD.4040602@redhat.com>
 <20101007010241.GB1276@burratino>
 <20101007010458.GD1276@burratino>
 <20101007025649.GA14649@gondor.apana.org.au>
 <20101007033518.GB2285@burratino>
 <20101007041406.GA15529@gondor.apana.org.au>
 <20101007043715.GA15658@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:52357 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972Ab0JGVhd (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 7 Oct 2010 17:37:33 -0400
Received: by qyk29 with SMTP id 29so605665qyk.19
        for <dash@vger.kernel.org>; Thu, 07 Oct 2010 14:37:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101007043715.GA15658@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Eric Blake <eblake@redhat.com>, Gerrit Pape <pape@smarden.org>, dash@vger.kernel.org, "Krzysztof A. Sobiecki" <sobkas@gmail.com>, Jari Aalto <jari.aalto@cante.net>

Herbert Xu wrote:

> 	sh -c 'trap "exec nosuchfile" EXIT; exit 3'; echo $?
> 
> This makes dash exit with 127 instead of 3 as it does now.
> 
> AFAIK the wording of POSIX is such that we should return 3, however,
> it does seem that every other shell exits with 127.

On 'exec':

 "If exec is specified with command, it shall replace the shell with
 command without creating a new process."		(1)

 "If command is specified, exec shall not return to the shell; rather,
 the exit status of the process shall be the exit status of the program
 implementing command, which overlaid the shell. If command is not
 found, the exit status shall be 127. If command is found, but it is
 not an executable utility, the exit status shall be 126. If a
 redirection error occurs (see Consequences of Shell Errors ), the
 shell shall exit with a value in the range 1-125. Otherwise, exec
 shall return a zero exit status."			(2)

On 'exit':

 "...
 A trap on EXIT shall be executed before the shell terminates, except
 when the exit utility is invoked in that trap itself, in which case
 the shell shall exit immediately."			(3)

 "The exit status [of the exit utility -jrn] shall be n, if specified.
 Otherwise, the value shall be the exit value of the last command
 executed, or zero if no command was executed. When exit is executed in
 a trap action, the last command is considered to be the command that
 executed immediately preceding the trap action."	(4)

The passage (3) seems to mean that "exit" triggers an EXIT trap
(except, to avoid having to deal with recursion, when the "exit"
occurs within an EXIT trap).  Then the exec builtin is invoked,
resulting (according to (2)) in an exit(127) without returning to the
shell.

So I think the proposed behavior fits the spec.

Regards,
Jonathan
