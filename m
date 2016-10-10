From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: dash tested against ash testsuite: 17 failures
Date: Mon, 10 Oct 2016 23:51:16 +0200
Message-ID: <20161010215116.GA78485@stack.nl>
References: <CAK1hOcMma=uH2R=vWX1Z6r2xf9PcW7MPSEPYOk76Zn97LD-7Jw@mail.gmail.com>
 <7d291bb2-a968-471d-d2a0-87adfd0bc38d@inlv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mailout05.stack.nl ([131.155.140.202]:58438 "EHLO
        mailout.stack.nl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752232AbcJJWQG (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 10 Oct 2016 18:16:06 -0400
Content-Disposition: inline
In-Reply-To: <7d291bb2-a968-471d-d2a0-87adfd0bc38d@inlv.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Martijn Dekker <martijn@inlv.org>
Cc: dash@vger.kernel.org

On Sat, Oct 08, 2016 at 09:42:12PM +0200, Martijn Dekker wrote:
> Op 01-10-16 om 19:17 schreef Denys Vlasenko:
> > ash-glob/glob2.tests:
> >     Evidently, dash supports \f -> ^L escape.
> >     This test uses \f as invalid backslash escape,
> >     hence differences.

> The test uses the "echo" builtin, which is very very unportable and
> explicitly not standardised by POSIX for this case. A test failure based
> on a difference in how "echo" interprets backslash escapes is not really
> relevant. Use printf instead.

> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/echo.html#tag_20_37_16
> "It is not possible to use echo portably across all POSIX systems unless
> both -n (as the first argument) and escape sequences are omitted."

True, but dash seems to be the only common one in the Linux/BSD world to
recognize so many backslash escape sequences in echo (without the
thoroughly non-standard -e option or special configuration). FreeBSD's
/bin/echo knows \c if it is final but shell builtins are more commonly
used than /bin/echo.

In some sense, it seems like this behaviour is there just to force
applications to be POSIX-compliant. I think it may be causing more
trouble than it is worth.

> > ash-misc/echo_write_error.tests
> >     EPIPE errors in echo are not reported

> They're reported as an I/O error in echo. While that is not as specific,
> it's still accurate. I don't really see a problem.

The dash code I have, git revision
afe0e0152e4dc12d84be3c02d6d62b0456d68580, returns exit status 1 but does
not write an error message to standard error. This is definitely a bug.

The error message's wording is unspecified, though.

> > ash-misc/func2.tests
> >     $((i++)) not supported

> This is not required by POSIX. Use $((i+=1)) instead.
> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_04
> "The sizeof() operator and the prefix and postfix "++" and "--"
> operators are not required."

> > ash-misc/local1.tests
> >     Doesn't unset as described:
> >         local a
> >         # the above line unsets $a
> >         echo "A2:'$a'"

> >From the dash man page:
> "When a variable is made local, it inherits the initial value and
> exported and readonly flags from the variable with the same name in the
> surrounding scope, if there is one.  Otherwise, the variable is
> initially unset."

> Looks to me like dash behaves as advertised. Local variables aren't
> standardised so implementations are free to do as they please.

> (This is an interesting difference though, one I wasn't aware of until now.)

This is not the first time I heard about it but I am not convinced it
needs changing.

> > ash-misc/shift1.tests
> >     "shift N" fails if fewer than N argv[i] exists
> >     (likely not a bug, but bash does it differently)

> POSIX explicitly allows either behaviour:
> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_26_14
> "If the n operand is invalid or is greater than "$#", this may be
> considered a syntax error and a non-interactive shell may exit; if the
> shell does not exit in this case, a non-zero exit status shall be
> returned. Otherwise, zero shall be returned."

> Cross-platform scripts must check that the operand is less than or equal
> than $# before invoking 'shift'.

Yes.

> > ash-redir/redir.tests
> >     echo errors due to closed stdout are not reported

> Again, they are in fact reported but as an I/O error. My response would
> be the same as for ash-misc/echo_write_error.tests above.

Same bug as above: no diagnostic is written.

> > ash-redir/redir3.tests
> >     "echo foo >&9" correctly says "9: Bad file descriptor"
> >     and exitcode is 2 (in bash, it is 1).

> Not a bug, IMO. POSIX simply says: "A failure to open or create a file
> shall cause a redirection to fail" but does not specify with what exit
> status it should fail. Any non-zero exit status < 128 should be fine.

Yes, and I think an exit status of 2 is slightly more useful if the
utility is one that uses status 1 for a "false" result and statuses
greater than 1 for real errors, while of the same usefulness if the
utility is one that uses statuses greater than 0 for errors.

> > ash-redir/redir7.tests
> > ash-redir/redir8.tests
> >     uni\x81code filename is not found by uni?code glob pattern.

> dash does not support unicode; AFAIK, this is a design choice (I'm not a
> developer).

This is actually caused by some level of Unicode support -- a simple
bytes=characters matcher would accept this. This Unicode support is in
libc's fnmatch() and rejects the invalid byte sequence.

What to do with this invalid byte sequence is an interesting question.
POSIX is not helpful since it does not consider this case.

In FreeBSD sh, I have decided that ? and bracket expressions can only
match valid characters, while * and literals can match any byte
sequence. One reason for this is the (somewhat simplistic)
implementation of ${var#word}, etc. which find the shortest or longest
matching part by repeated matching and should definitely take a full
character for ? if one exists.

> > ash-signals/reap1.tests
> >     Builtins never wait for children. This loop will not ever stop:
> >     sleep 1 &
> >     PID=$!
> >     while kill -0 $PID >/dev/null 2>&1; do
> >         true
> >     done

> Interesting bug.

> The behaviour seems to depend on the presence of a 'while' loop.
> Executed manually without a loop, it behaves as expected:

> $ sleep 10 & PID=$!
> $ kill -0 $PID
> $ kill -0 $PID
> [...etc...]
> $ kill -0 $PID
> [1] + Done                       sleep 10
> $ kill -0 $PID
> dash: 11: kill: No such process

> Executed with a loop it's infinite even in an interactive shell, but
> only the first time around:

> $ sleep 10 & PID=$!
> $ while kill -0 $PID; do :; done
> ^C
> [1] + Done                       sleep 10
> $ while kill -0 $PID; do :; done
> dash: 15: kill: No such process

> Strange behaviour and certainly looks like a rather obscure bug.

This is because dash only checks for terminated child processes at
certain points, such as when waiting for a process or printing a prompt.
For example, placing 'sleep 1' within the loop will make it work, since
the wait for the foreground process will also collect the background
process's status.

Interestingly, I already did something about this in FreeBSD sh for the
case where this may cause unbounded accumulation of zombies, but not
this case, where kill keeps succeeding indefinitely.

Note that allowing kill to fail with [ESRCH] "No such process"
inherently creates the possibility of signalling an unrelated new
process, so it should be avoided if possible.

> > ash-signals/savetrap.tests
> >     `trap` does not work as expected

> Again, the SIG prefix is not required to be supported in POSIX (see above).

> Unfortunately, according to POSIX, the feature that a subshell
> containing only a single "trap" command with no operands inherits the
> parent shell's traps so that they can be stored like save_traps=$(trap),
> is optional! Hence this can't be considered a bug in dash, although I'd
> certainly like to submit it as a feature request.

> POSIX:
> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_28

For clarification, this is in XCU 2.14 Special Built-In Utilities, trap.

> "When a subshell is entered, traps that are not being ignored shall be
> set to the default actions, except in the case of a command substitution
> containing only a single trap command, when the traps need not be
> altered. Implementations may check for this case using only lexical
> analysis [...]."

The next paragraph puts additional requirements on implementations that
do not implement the this check, which likewise ensure that "$(trap)"
expands to the current traps and not always an empty string.

On another note, the quoted part seems broken. It specifies that the
traps be not only printed but completely inherited, and therefore the
EXIT trap (if any) also executed after printing the traps.

> Only bash, yash, AT&T ksh93 and busybox ash currently support this
> optional feature. This makes it extremely inconvenient to store the
> output of 'trap' in a variable in a cross-platform manner.

> (In my cross-platform shell library, modernish, which offers stack-based
> traps, I've had to implement a workaround involving the atomic,
> parallel-proof creation of a temporary file. Since 'mktemp' isn't
> cross-platform either, that has been an interesting exercise involving
> output redirection under 'set -C' in a subshell.)

Practically, that is still needed.

FreeBSD sh also supports the useful meaning of $(trap).

> > ash-signals/sigint1.tests
> >     trap "exit 0" SIGINT - does not like name "SIGINT". "INT" works.

> Not a bug. The SIG prefix is an optional extension. Only "INT" without
> the prefix is mandated by POSIX.
> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_28
> "The condition can be EXIT, 0 (equivalent to EXIT), or a signal
> specified using a symbolic name, without the SIG prefix, as listed in
> the tables of signal names in the <signal.h> header defined in XBD
> Headers; for example, HUP, INT, QUIT, TERM. Implementations may permit
> names with the SIG prefix or ignore case in signal names as an extension."

> > ash-signals/signal4.tests
> >     trap "echo Trapped" BADNAME TERM - abort seeing BADNAME.
> >     bash complains, but sets the trap for the second signal.

> I don't see how this is a bug.

POSIX is not entirely clear but there is some text in XCU 1.4 Utility
Description Defaults CONSEQUENCES OF ERRORS that suggests subsequent
operands should continue to be processed after an erroring operand,
which is almost ubiquitously followed by utilities such as cp, mv, rm,
find and ls. However, the same section also says that "Default" means
any changes to the process state are unspecified.

In FreeBSD sh (SVN r199641), I considered it most sensible to continue
processing subsequent signal names (returning exit status 1 later).

> > ash-signals/signal8.tests
> >     "kill %1" in non-interactive shell does not find
> >     previously backgrounded task.

> Not a bug. '%1' is a job control job ID, but in a non-interactive shell
> there's no job control. Either 'set -m' to turn on job control first
> (and deal with extra terminal clutter), or just use "$!" to kill by PID.

In my reading of POSIX, there is nothing that makes the %job notation
depend on 'set -m'. However, the description of %job operands in kill
requires a signal to be sent to a background process group, which does
not exist if 'set -m' was not in effect when the job was created.

An obvious generalization is to send the signal to each process in the
job if 'set -m' was not in effect when it was created.

The %1 syntax avoids process ID reuse issues but unfortunately it cannot
usually be used if there are multiple background jobs since it may be
unclear when a job number becomes available for reuse.

> > ash-vars/var-utf8-length.tests
> >     ${#VAR} counts unicode chars in bash

> dash does not support unicode; AFAIK, this is a design choice (I'm not a
> developer).

That may be but it does cause a non-compliance when the entire system
wants to support UTF-8.

> > ash-vars/var_unbackslash.tests
> >     b=-$a-\t-\\-\"-\`-\--\z-\*-\?-
> >     b="-$a-\t-\\-\"-\`-\--\z-\*-\?-"
> >     b='-$a-\t-\\-\"-\`-\--\z-\*-\?-'
> >     b1=$b
> >     "b1=$b"
> >     You can imagine... not everything went well here...

> Again, this is probably down to legitimate differences in the
> notoriously unportable "echo" builtin. Test this using printf instead.

Seems like it.

> > ash-vars/var_unbackslash.tests

> ITYM ash-vars/var_unbackslash1.tests

> >     echo Forty two:$\
> >     (\
> >     (\
> >     42\
> >     )\
> >     )
> >     dash says: Syntax error: Missing '))'

> Yes, but it's not clear to me that it shouldn't.

> Hmm... maybe this is indeed a bug:
> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_02_01
> "A <backslash> that is not quoted shall preserve the literal value of
> the following character, with the exception of a <newline>. If a
> <newline> follows the <backslash>, the shell shall interpret this as
> line continuation. The <backslash> and <newline> shall be removed before
> splitting the input into tokens. Since the escaped <newline> is removed
> entirely from the input and is not replaced by any white space, it
> cannot serve as a token separator."

> So, unless I'm misreading this, it looks like backslashes need to be
> parsed before *any* other kind of lexical analysis.

Yes, for <backslash><newline> sequences that are not quoted.

For example, <single-quote><backslash><newline><single-quote> contains
two characters between the quotes, not zero.

-- 
Jilles Tjoelker
