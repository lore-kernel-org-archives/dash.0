From: Richard H Lee <ricardohenrylee@gmail.com>
Subject: Re: Command parsing problem and tracefile
Date: Fri, 08 Jun 2012 22:20:37 +0100
Message-ID: <4FD26CA5.6090602@gmail.com>
References: <4FD22F1B.3090208@gmail.com> <20120608171730.GG10380@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:41574 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753651Ab2FHVUk (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 8 Jun 2012 17:20:40 -0400
Received: by wibhj8 with SMTP id hj8so954262wib.1
        for <dash@vger.kernel.org>; Fri, 08 Jun 2012 14:20:39 -0700 (PDT)
In-Reply-To: <20120608171730.GG10380@burratino>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: dash@vger.kernel.org

Hi Jonathan,

On 08/06/12 18:17, Jonathan Nieder wrote:
> Thanks for writing.  Who is setting _pkg_config to 'pkg-config
> --static', what are they trying to do, and can it be done another way?

I'm compiling mplayer2. I'm basically running ./configure 
--enable-static . I assume without the --enable-static flag the 
configure script sets _pkg_config to just 'pkg-config' .

I want to try and statically compile it as there is a bug with one of 
the libraries. So I'm planning to compile a modified libav library first 
and then compile mplayer2 statically against them. I guess I could do it 
dynamically, but then I would have modified libraries floating around my 
system.

> This doesn't look like a dash-specific phenomenon.  I get the same
> result with
>
> 	$ "pkg-config --static" foo bar
> 	dash: 1: pkg-config --static: not found
>
> which looks right to me.  (You can test with 'CONFIG_SHELL=/bin/ksh
> ksh ./configure'.)

[Note: I don't think CONFIG_SHELL is used here as the configure script 
is not autotools generated.]

It didn't occur to me to try other shells. I get the same error with 
bash. It makes me wonder why it occurs on three different shells? Is 
this defined behaviour? Or they just happen to share the same parsing 
code/algorithm.

I also tried running the following script:
<<EOF
#!/bin/sh
_pkg_config='pkg-config --static'
if $_pkg_config --exists --print-errors libavutil ; then
   echo success
fi
EOF

Which does print out 'success' (replace libavutil with any other 
pkg-config library you have installed). I get the feeling, some sort of 
flag was set that changes the parsing behaviour in the configure script.

>> I would like to get some more info as to what in going on. IIRC, I
>> saw in show.c, there was some sort for tracefile that dash to dump
>> to. How do I enable this?
>
> "dash -o debug" after a compile with DEBUG enabled.  Though "dash -x"
> tends to be more helpful if you are debugging a shell script rather
> than trying to find a bug in dash itself.

 From shell.h:
define DEBUG=1 to compile in debugging ('set -o debug' to turn on)
define DEBUG=2 to compile in and turn on debugging.
When debugging is on, debugging info will be written to ./trace and a 
quit signal will generate a core dump.

This is exactly what I was looking for.

As to compiling with DEBUG enabled, how would I do this?
I couldn't see any reference in dash's ./configure --help (nor any clear 
reference in the configure file itself).


Thanks,

Richard
