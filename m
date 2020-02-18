From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: Bizarre interaction bug involving bash w/ lastpipe + Almquist
 'wait'
Date: Tue, 18 Feb 2020 21:59:37 +0000
Message-ID: <f2a928d6-4feb-d123-23b4-17c8edfeda2f@gigawatt.nl>
References: <10e3756b-5e8f-ba00-df0d-b36c93fa2281@inlv.org>
 <5461.1581043287@jinx.noi.kre.to>
 <2b436500-671b-b143-a4bb-2230f157e1b7@gigawatt.nl>
 <CAK1hOcO_S_T=5SWJ0jpZWxDYwdUFqJisw_nC+JysnQvZ6XUuKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.gigawatt.nl ([51.68.198.76]:55634 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgBRWBa (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 18 Feb 2020 17:01:30 -0500
In-Reply-To: <CAK1hOcO_S_T=5SWJ0jpZWxDYwdUFqJisw_nC+JysnQvZ6XUuKw@mail.gmail.com>
Content-Language: en-US
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: Robert Elz <kre@munnari.oz.au>, Martijn Dekker <martijn@inlv.org>, busybox <busybox@busybox.net>, DASH shell mailing list <dash@vger.kernel.org>, Jilles Tjoelker <jilles@stack.nl>, Bug reports for the GNU Bourne Again SHell <bug-bash@gnu.org>

On 18/02/2020 16:46, Denys Vlasenko wrote:
> On Sat, Feb 8, 2020 at 7:41 PM Harald van Dijk <harald@gigawatt.nl> wrote:
>> If NetBSD sh
>> manages to avoid this pattern, and assuming NetBSD sh is not still
>> susceptible to one of those race conditions
> 
> Please let us know what you discovered.

Okay, please take a look. I hope I managed to avoid race conditions in 
the test shell script.

test1.sh:

   i=1
   while test "$i" -lt 100000
   do
     printf "%d\r" "$i"
     "$@" test2.sh
     i=$((i + 1))
   done

test2.sh

   trap 'kill $!; exit 0' TERM
   { kill $$; exec sleep 1000; } &
   wait $!

To run:

   sh test1.sh $shell

For instance:

   sh test1.sh busybox ash

test1.sh will repeatedly run test2.sh and increment and print a counter 
variable to display progress.

test2.sh will immediately exit, in a complicated way, if all goes well. 
It may sleep for 1000s or fail to clean up its background process if 
something goes wrong.

On my system, I see:

   bash 5.0.11        - sleeps after a while
   bosh 2019-11-11    - sleeps after a while
   busybox 1.31.1 ash - ok
   dash 0.5.10.2      - ok
   dash (current)     - sleeps immediately
   fbsh 12.1          - ok *
   gwsh (current)     - leaves subprocesses
   ksh 93v            - sleeps after a while
   ksh 2020.0.0       - sleeps after a while
   mksh 57            - sleeps after a while
   nbsh (current)     - sleeps after a while *
   pdksh 5.2.14       - leaves subprocesses + sleeps after a while
   posh 0.13.1        - ok
   yash               - ok
   zsh                - sleeps after a while

* Because of the way I was running FreeBSD sh and NetBSD sh on qemu, I 
could not easily check what happens to the subprocesses.

I think that confirms that NetBSD sh does have a problem with a race 
condition, but that many shells have that same problem. It also tells me 
that there is another different problem in my shell that I should look at.

Cheers,
Harald van Dijk
