From: Dirk Fieldhouse <fieldhouse@gmx.net>
Subject: Re: 'return' from subshell in function doesn't
Date: Mon, 9 Mar 2020 12:43:28 +0000
Message-ID: <320e79a9-0c93-8070-451b-ddc3b50b195e@gmx.net>
References: <S1726267AbgCHLof/20200308114435Z+1505@vger.kernel.org>
 <9b3a55fb-df00-8ac3-7a1e-b60e24aa2970@gmx.net>
 <98ce2d03-e647-48b2-e4dd-3ceb810f2b24@gigawatt.nl>
 <4d8123c9-33e4-a525-930f-37bce1cb9d77@gmx.net>
 <71fc6831-8193-e977-3437-6181dc79842b@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <dash-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:42531 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgCIMnd (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 9 Mar 2020 08:43:33 -0400
In-Reply-To: <71fc6831-8193-e977-3437-6181dc79842b@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: DASH mailing list <dash@vger.kernel.org>
Cc: Harald van Dijk <harald@gigawatt.nl>

On 08/03/20 15:19, Harald van Dijk wrote:
> On 08/03/2020 14:40, Dirk Fieldhouse wrote:
>> On 08/03/20 13:44, Harald van Dijk wrote:
>>> Subshells work by starting a new process. ...
>>
>> What the conforming implementation has to do shouldn't be of concern to
>> the shell programmer, especially since a subshell may, but need not, be
>> created implicitly in a pipeline; in particular any subshell processes
>> are transparent to the shell programmer ($! "shall expand to the same
>> value as that of the current shell").
>
> I think you meant $$ there, but this is the difference between theory
> and practice. In theory, the standard is perfect, and shell internals
> are irrelevant, we can just look at what the standard says. In practice,
> unfortunately, the standard is not perfect and there are numerous cases
> where the standard is either ambiguous or contradicts implementations,
> and where this is deemed a defect in the standard rather than in the
> implementations. It need not even be because what the standard specifies
> is unreasonable, it can just be because the what the standard specifies
> is unintended.

Yes obvs $$, thanks. If a supplier has to warrant conformance to the
standard they have a problem if what the standard says is universally
ignored. Something has to give. I think it's fair to say that
historically there has been convergence from both directions. But this
particular issue seems to have been a blind spot, perhaps because it
seems so obvious to the implementers who also work on the spec (we've
all been there).

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 What POSIX says presumably means
>> that the implementation should wait for any subprocesses, threads or
>> whatever spawned in the course of executing a function to complete
>> (subject to &) before continuing to execute the next command. If the
>> calling script process or some spawned thread of control gets killed
>> before the return can be executed, that's just an exception, the sort o=
f
>> thing that traps exist for.
>
> Sure, for the parent process, but for the child process it leaves
> questions unanswered such as what the expected output would be of:
>
>  =C2=A0 f() {
>  =C2=A0=C2=A0=C2=A0 (kill -9 $$; return; echo hello)
>  =C2=A0 }
>  =C2=A0 f
>  =C2=A0 echo bye

If you kill the shell (you're not supposed to know that kill only kills
some main process) you shouldn't expect any subsequent command to have
run. A better name for this f() is cut_off_the_branch_I_am_sitting_on().

> I would argue that even if you disagree that the behaviour should be
> unspecified in your original example, it should still be unspecified in
> mine.
>
>> However, as your interpretation seems to have been widely made by shell
>> implementations, is it necessary to abandon the behaviour currently
>> specified in favour of a more pragmatic specification?
>
> I suspect so. There is a case I forgot about though:
>
>  =C2=A0 f() (
>  =C2=A0=C2=A0=C2=A0 return 0
>  =C2=A0=C2=A0=C2=A0 echo bug
>  =C2=A0 )
>  =C2=A0 f
>
> This should not print 'bug', and does not in any shell I can think to
> test. By your interpretation of the standard, this is currently
> specified. By mine, it would be unspecified, but I would agree that it
> should be fine for the whole function to be defined using a () compound
> command, and to contain a return statement directly inside it.

+1. Apparently the consensus has been that 'return' in a subshell means
'exit'. But should someone write a test suite with a test case similar
to my original bar() against POSIX.1-2017 these implementations will all
fail to pass.

> The same problem applies to the 'break' and 'continue' statements too:
>
>  =C2=A0 for var in x y z
>  =C2=A0 do
>  =C2=A0=C2=A0=C2=A0 echo $var
>  =C2=A0=C2=A0=C2=A0 (break)
>  =C2=A0 done

As Stephane (instigator of the relevant defect report) pointed out, this
has been addressed in the 2017 text, so that your 'break' example is
unspecified behaviour (unenclosed break or continue). Of course similar
wording could have been used to restrict the specified behaviour of
'return' as well -- but wasn't.

> This is looking like a giant can of worms I'm not sure I'm ready to see
> opened. :)

Otherwise it would have been sorted out before and I wouldn't have
raised it!

This <https://www.austingroupbugs.net/view.php?id=3D1042> POSIX DR touches
on the same issue but doesn't come to grips with 'return'.

This <https://www.austingroupbugs.net/view.php?id=3D1247> DR identifies at
least one other case where an implicit subshell is used.

I suppose further discussion should be at austin-group-l?

regards
/df

=2D-
London SW6
UK
