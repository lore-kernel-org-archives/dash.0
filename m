From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] [INPUT] Catch attempts to run a directory as a script
Date: Wed, 6 Oct 2010 05:55:31 -0500
Message-ID: <20101006105531.GB475@burratino>
References: <20100605160651.GA60028@stack.nl>
 <20100614095451.26362.qmail@43559bb7971308.315fe32.mid.smarden.org>
 <20100628065326.GA25667@gondor.apana.org.au>
 <20101006100420.GA361@burratino>
 <20101006100804.GB361@burratino>
 <20101006102930.GA6573@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59256 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295Ab0JFK6y (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 6 Oct 2010 06:58:54 -0400
Received: by gxk9 with SMTP id 9so2372812gxk.19
        for <dash@vger.kernel.org>; Wed, 06 Oct 2010 03:58:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101006102930.GA6573@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Gerrit Pape <pape@smarden.org>, dash@vger.kernel.org, "Krzysztof A. Sobiecki" <sobkas@gmail.com>, Jari Aalto <jari.aalto@cante.net>

Herbert Xu wrote:
> On Wed, Oct 06, 2010 at 05:08:04AM -0500, Jonathan Nieder wrote:

>> But POSIX makes it clear enough that in "sh command_file",
>> command_file is supposed to be a file, not a directory.  So
>> diagnose this with an error message and exit with status 2.
[...]
> Is this required by POSIX? If not this is simply making dash
> bigger for no good reason.

Not clear.  I suppose POSIX usually doesn't require anything when the
caller screws up.

Jari Aalto quoted the DESCRIPTION section[1] (and some similar
passages):

>    The sh utility is a command language interpreter that shall
>    execute commands read from a command line string, the standard
> >> input, or a specified file. 

I don't find that alone very convincing.

Under OPERANDS[2]: if the path contains a slash, all the standard says
is "the implementation attempts to read that file".  If the path does
not contain a slash and the file is not in the working directory, the
implementation _may_ perform a search as described in "Command Search
and Execution".

During that search, after execve() fails, "if the executable file is
not a text file, the shell _may_ bypass this command execution. In
this case, it shall write an error message, and shall return an exit
status of 126." (emphasis mine).

So this behavior is allowed as an optional subset of an optional
behavior.  That may have guided the bash implementors:

 $ bash directory
 directory: directory: is a directory
 $ echo $?
 126

It's probably not required.

[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?msg=10;bug=548687
[2] http://www.opengroup.org/onlinepubs/9699919799/utilities/sh.html#tag_20_117_05
