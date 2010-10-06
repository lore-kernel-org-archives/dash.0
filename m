From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] [INPUT] Catch attempts to run a directory as a script
Date: Wed, 06 Oct 2010 06:18:05 -0600
Message-ID: <4CAC68FD.4040602@redhat.com>
References: <20100605160651.GA60028@stack.nl> <20100614095451.26362.qmail@43559bb7971308.315fe32.mid.smarden.org> <20100628065326.GA25667@gondor.apana.org.au> <20101006100420.GA361@burratino> <20101006100804.GB361@burratino> <20101006102930.GA6573@gondor.apana.org.au> <20101006105531.GB475@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:13801 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755615Ab0JFMSR (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 6 Oct 2010 08:18:17 -0400
In-Reply-To: <20101006105531.GB475@burratino>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Herbert Xu <herbert@gondor.hengli.com.au>, Gerrit Pape <pape@smarden.org>, dash@vger.kernel.org, "Krzysztof A. Sobiecki" <sobkas@gmail.com>, Jari Aalto <jari.aalto@cante.net>

On 10/06/2010 04:55 AM, Jonathan Nieder wrote:
>>> But POSIX makes it clear enough that in "sh command_file",
>>> command_file is supposed to be a file, not a directory.  So
>>> diagnose this with an error message and exit with status 2.
> [...]
>> Is this required by POSIX? If not this is simply making dash
>> bigger for no good reason.
>
> Not clear.  I suppose POSIX usually doesn't require anything when the
> caller screws up.

POSIX requires that input files to bash shall be text files; directories 
do not qualify for this.
http://www.opengroup.org/onlinepubs/9699919799/utilities/sh.html
"The input file shall be a text file, except that line lengths shall be 
unlimited. "

However, that is a requirement on the user, not the shell; so running 
'sh /' is a constraint violation by the user, and leaves behavior up to 
the shell.

> Under OPERANDS[2]: if the path contains a slash, all the standard says
> is "the implementation attempts to read that file".  If the path does
> not contain a slash and the file is not in the working directory, the
> implementation _may_ perform a search as described in "Command Search
> and Execution".

It's more than just MAY; it's a requirement:
http://www.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_01_01

"If the command name contains at least one <slash>, the shell shall 
execute the utility in a separate utility environment with actions 
equivalent to calling the execve() function...

"If the execve() function fails due to an error equivalent to the 
[ENOEXEC] error, the shell shall execute a command equivalent to having 
a shell invoked with the command name as its first operand"

>
> During that search, after execve() fails, "if the executable file is
> not a text file, the shell _may_ bypass this command execution. In
> this case, it shall write an error message, and shall return an exit
> status of 126." (emphasis mine).

But yes, that same section is clear that for both command searches along 
PATH for a word without slash, and for a direct command with a slash, if 
execve() fails with ENOEXEC (as it does for directories), then it is 
optional whether the shell bypasses attempts to read the file because it 
was not a text file.

On the other hand, in Linux, execve(".",...) fails with EACCES, as 
permitted by the standard:

http://www.opengroup.org/onlinepubs/9699919799/functions/execve.html
"[EACCES] ...or the new process image file is not a regular file and the 
implementation does not support execution of files of its type."

And since EACCES is not the same class as ENOEXEC, there is no 
requirement for the shell to attempt to execute the same file.  So, 
rather than stat()ing the argument in advance and checking for S_ISDIR, 
it seems like it would be simpler to check after the execve() attempt 
for EACCES and blindly set $? to 126 in that case (since you already 
have to check for ENOEXEC).

> So this behavior is allowed as an optional subset of an optional
> behavior.  That may have guided the bash implementors:
>
>   $ bash directory
>   directory: directory: is a directory
>   $ echo $?
>   126
>
> It's probably not required.

Additionally, the standard REQUIRES that 'sh -c "exec /"' shall fail 
with status 126:

http://www.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#exec
"If command is found, but it is not an executable utility, the exit 
status shall be 126."

Right now, dash gets this wrong:

dash -c 'exec .'; echo $?
exec: 1: /: Permission denied
2

And since you already have the code in dash to detect failure to 'exec' 
a directory, you should be able to reuse that code when detecting 
failure to run a directory as a script, as in 'dash .'.

[Hmm, bash also gets it wrong:
bash -c 'exec .'; echo $?
bash: line 0: exec: .: not found
127
even though . should always be found]

-- 
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org
