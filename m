From: Dirk Fieldhouse <fieldhouse@gmx.net>
Subject: Re: 'return' from subshell in function doesn't
Date: Sun, 8 Mar 2020 14:40:10 +0000
Message-ID: <4d8123c9-33e4-a525-930f-37bce1cb9d77@gmx.net>
References: <S1726267AbgCHLof/20200308114435Z+1505@vger.kernel.org>
 <9b3a55fb-df00-8ac3-7a1e-b60e24aa2970@gmx.net>
 <98ce2d03-e647-48b2-e4dd-3ceb810f2b24@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <dash-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:39125 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbgCHOkP (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 8 Mar 2020 10:40:15 -0400
In-Reply-To: <98ce2d03-e647-48b2-e4dd-3ceb810f2b24@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: DASH mailing list <dash@vger.kernel.org>
Cc: Harald van Dijk <harald@gigawatt.nl>

On 08/03/20 13:44, Harald van Dijk wrote:
> On 08/03/2020 12:35, Dirk Fieldhouse wrote:
>> POSIX
>> <https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.h=
tml#return>
>> says, and has since at least 2004:
>> "The return utility shall cause the shell to stop executing the current
>> function or dot script. If the shell is not currently executing a
>> function or dot script, the results are unspecified."
>> [...]
>> As POSIX refers to subshells explicitly elsewhere (eg 'exit') it's
>> difficult to believe that "subshell" was accidentally omitted from the
>> list of contexts that 'return' should return from, but implementation
>> behaviours consistently contradict the spec as written. Can they be mad=
e
>> conformant without breaking existing scripts?
>
> In the subshell, the shell should not be considered to still be
> executing a function or dot script. As such, the results should be
> unspecified, and any behaviour should be valid. The standard may be
> underspecified here, but any other interpretation is not reasonable.

Your argument here is essentially saying that the spec left out an
exception concerning subshells. If you read the spec without having
knowledge of existing shell internals, it's entirely reasonable (and IMO
desirable) to consider that a shell function is a lexical group, like a
script file, which is being executed as long as any command within the
function's defining compound command is running.

Otherwise the definition of a shell function would have to be limited to
certain types of compound command, ie excluding command substitution,
commands grouped with parentheses, asynchronous lists, and (under
implementation-specific circumstances) pipelines.

The behaviour that I expected is supported by
<https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html=
#tag_18_09_05>:

"A function is a user-defined name that is used as a simple command to
call a compound command with new positional parameters. ...

The compound-command shall be executed whenever the function name is
specified as the name of a simple command (see Command Search and
Execution). ... If the special built-in return ... is executed in the
compound-command, the function completes and execution shall resume with
the next command after the function call."

> Subshells work by starting a new process. The parent process waits for
> the subshell to finish and acts on its exit status. The child process
> has very little ways to influence its parent process other than that,
> and the parent process might not even still be running by the time the
> child process gets to the return statement.

What the conforming implementation has to do shouldn't be of concern to
the shell programmer, especially since a subshell may, but need not, be
created implicitly in a pipeline; in particular any subshell processes
are transparent to the shell programmer ($! "shall expand to the same
value as that of the current shell"). What POSIX says presumably means
that the implementation should wait for any subprocesses, threads or
whatever spawned in the course of executing a function to complete
(subject to &) before continuing to execute the next command. If the
calling script process or some spawned thread of control gets killed
before the return can be executed, that's just an exception, the sort of
thing that traps exist for.

However, as your interpretation seems to have been widely made by shell
implementations, is it necessary to abandon the behaviour currently
specified in favour of a more pragmatic specification?

/df

=2D-
London SW6
UK
