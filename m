From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: 'return' from subshell in function doesn't
Date: Sun, 8 Mar 2020 15:19:01 +0000
Message-ID: <71fc6831-8193-e977-3437-6181dc79842b@gigawatt.nl>
References: <S1726267AbgCHLof/20200308114435Z+1505@vger.kernel.org>
 <9b3a55fb-df00-8ac3-7a1e-b60e24aa2970@gmx.net>
 <98ce2d03-e647-48b2-e4dd-3ceb810f2b24@gigawatt.nl>
 <4d8123c9-33e4-a525-930f-37bce1cb9d77@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.gigawatt.nl ([51.68.198.76]:32792 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbgCHPVO (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 8 Mar 2020 11:21:14 -0400
In-Reply-To: <4d8123c9-33e4-a525-930f-37bce1cb9d77@gmx.net>
Content-Language: en-GB
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Dirk Fieldhouse <fieldhouse@gmx.net>, DASH mailing list <dash@vger.kernel.org>

On 08/03/2020 14:40, Dirk Fieldhouse wrote:
> On 08/03/20 13:44, Harald van Dijk wrote:
>> Subshells work by starting a new process. The parent process waits for
>> the subshell to finish and acts on its exit status. The child process
>> has very little ways to influence its parent process other than that,
>> and the parent process might not even still be running by the time the
>> child process gets to the return statement.
> 
> What the conforming implementation has to do shouldn't be of concern to
> the shell programmer, especially since a subshell may, but need not, be
> created implicitly in a pipeline; in particular any subshell processes
> are transparent to the shell programmer ($! "shall expand to the same
> value as that of the current shell").

I think you meant $$ there, but this is the difference between theory 
and practice. In theory, the standard is perfect, and shell internals 
are irrelevant, we can just look at what the standard says. In practice, 
unfortunately, the standard is not perfect and there are numerous cases 
where the standard is either ambiguous or contradicts implementations, 
and where this is deemed a defect in the standard rather than in the 
implementations. It need not even be because what the standard specifies 
is unreasonable, it can just be because the what the standard specifies 
is unintended.

>                                       What POSIX says presumably means
> that the implementation should wait for any subprocesses, threads or
> whatever spawned in the course of executing a function to complete
> (subject to &) before continuing to execute the next command. If the
> calling script process or some spawned thread of control gets killed
> before the return can be executed, that's just an exception, the sort of
> thing that traps exist for.

Sure, for the parent process, but for the child process it leaves 
questions unanswered such as what the expected output would be of:

   f() {
     (kill -9 $$; return; echo hello)
   }
   f
   echo bye

This cannot print 'bye', but should it print 'hello'? The 'return' 
statement cannot return from 'f' if the main process is killed, so would 
the subshell just continue execution with the command after 'return'?

I would argue that even if you disagree that the behaviour should be 
unspecified in your original example, it should still be unspecified in 
mine.

> However, as your interpretation seems to have been widely made by shell
> implementations, is it necessary to abandon the behaviour currently
> specified in favour of a more pragmatic specification?

I suspect so. There is a case I forgot about though:

   f() (
     return 0
     echo bug
   )
   f

This should not print 'bug', and does not in any shell I can think to 
test. By your interpretation of the standard, this is currently 
specified. By mine, it would be unspecified, but I would agree that it 
should be fine for the whole function to be defined using a () compound 
command, and to contain a return statement directly inside it.

The same problem applies to the 'break' and 'continue' statements too:

   for var in x y z
   do
     echo $var
     (break)
   done

This prints x, y, and z in all shells, the 'break' statement in the 
subshell does not cause the loop to terminate. Some shells additionally 
print a warning or error message such as "break: not in a loop". Here 
again, presumably the intent of the standard is not that the 'break' 
statement should cause the loop to terminate. It is not something that 
shells do, and it is not something that is reasonable for shells to 
implement.

This is looking like a giant can of worms I'm not sure I'm ready to see 
opened. :)

Cheers,
Harald van Dijk
