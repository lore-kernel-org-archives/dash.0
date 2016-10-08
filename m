From: Martijn Dekker <martijn@inlv.org>
Subject: Re: dash tested against ash testsuite: 17 failures
Date: Sat, 8 Oct 2016 21:42:12 +0200
Message-ID: <7d291bb2-a968-471d-d2a0-87adfd0bc38d@inlv.org>
References: <CAK1hOcMma=uH2R=vWX1Z6r2xf9PcW7MPSEPYOk76Zn97LD-7Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from kahlil.inlv.org ([37.59.109.123]:53808 "EHLO kahlil.inlv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751729AbcJHU2S (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 8 Oct 2016 16:28:18 -0400
Received: from breedzicht.local ([145.15.244.33])
        (authenticated bits=0)
        by kahlil.inlv.org (8.14.9/8.14.4) with ESMTP id u98JgC5A027347
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
        for <dash@vger.kernel.org>; Sat, 8 Oct 2016 21:42:13 +0200
In-Reply-To: <CAK1hOcMma=uH2R=vWX1Z6r2xf9PcW7MPSEPYOk76Zn97LD-7Jw@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Op 01-10-16 om 19:17 schreef Denys Vlasenko:
> ash-glob/glob2.tests:
>     Evidently, dash supports \f -> ^L escape.
>     This test uses \f as invalid backslash escape,
>     hence differences.

The test uses the "echo" builtin, which is very very unportable and
explicitly not standardised by POSIX for this case. A test failure based
on a difference in how "echo" interprets backslash escapes is not really
relevant. Use printf instead.

http://pubs.opengroup.org/onlinepubs/9699919799/utilities/echo.html#tag_20_37_16
"It is not possible to use echo portably across all POSIX systems unless
both -n (as the first argument) and escape sequences are omitted."

> ash-misc/echo_write_error.tests
>     EPIPE errors in echo are not reported

They're reported as an I/O error in echo. While that is not as specific,
it's still accurate. I don't really see a problem.

> ash-misc/func2.tests
>     $((i++)) not supported

This is not required by POSIX. Use $((i+=1)) instead.
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_04
"The sizeof() operator and the prefix and postfix "++" and "--"
operators are not required."

> ash-misc/local1.tests
>     Doesn't unset as described:
>         local a
>         # the above line unsets $a
>         echo "A2:'$a'"

From the dash man page:
"When a variable is made local, it inherits the initial value and
exported and readonly flags from the variable with the same name in the
surrounding scope, if there is one.  Otherwise, the variable is
initially unset."

Looks to me like dash behaves as advertised. Local variables aren't
standardised so implementations are free to do as they please.

(This is an interesting difference though, one I wasn't aware of until now.)

> ash-misc/shift1.tests
>     "shift N" fails if fewer than N argv[i] exists
>     (likely not a bug, but bash does it differently)

POSIX explicitly allows either behaviour:
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_26_14
"If the n operand is invalid or is greater than "$#", this may be
considered a syntax error and a non-interactive shell may exit; if the
shell does not exit in this case, a non-zero exit status shall be
returned. Otherwise, zero shall be returned."

Cross-platform scripts must check that the operand is less than or equal
than $# before invoking 'shift'.

> ash-redir/redir.tests
>     echo errors due to closed stdout are not reported

Again, they are in fact reported but as an I/O error. My response would
be the same as for ash-misc/echo_write_error.tests above.

> ash-redir/redir3.tests
>     "echo foo >&9" correctly says "9: Bad file descriptor"
>     and exitcode is 2 (in bash, it is 1).

Not a bug, IMO. POSIX simply says: "A failure to open or create a file
shall cause a redirection to fail" but does not specify with what exit
status it should fail. Any non-zero exit status < 128 should be fine.

> ash-redir/redir7.tests
> ash-redir/redir8.tests
>     uni\x81code filename is not found by uni?code glob pattern.

dash does not support unicode; AFAIK, this is a design choice (I'm not a
developer).

> ash-signals/reap1.tests
>     Builtins never wait for children. This loop will not ever stop:
>     sleep 1 &
>     PID=$!
>     while kill -0 $PID >/dev/null 2>&1; do
>         true
>     done

Interesting bug.

The behaviour seems to depend on the presence of a 'while' loop.
Executed manually without a loop, it behaves as expected:

$ sleep 10 & PID=$!
$ kill -0 $PID
$ kill -0 $PID
[...etc...]
$ kill -0 $PID
[1] + Done                       sleep 10
$ kill -0 $PID
dash: 11: kill: No such process

Executed with a loop it's infinite even in an interactive shell, but
only the first time around:

$ sleep 10 & PID=$!
$ while kill -0 $PID; do :; done
^C
[1] + Done                       sleep 10
$ while kill -0 $PID; do :; done
dash: 15: kill: No such process

Strange behaviour and certainly looks like a rather obscure bug.

> ash-signals/savetrap.tests
>     `trap` does not work as expected

Again, the SIG prefix is not required to be supported in POSIX (see above).

Unfortunately, according to POSIX, the feature that a subshell
containing only a single "trap" command with no operands inherits the
parent shell's traps so that they can be stored like save_traps=$(trap),
is optional! Hence this can't be considered a bug in dash, although I'd
certainly like to submit it as a feature request.

POSIX:
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_28
"When a subshell is entered, traps that are not being ignored shall be
set to the default actions, except in the case of a command substitution
containing only a single trap command, when the traps need not be
altered. Implementations may check for this case using only lexical
analysis [...]."

Only bash, yash, AT&T ksh93 and busybox ash currently support this
optional feature. This makes it extremely inconvenient to store the
output of 'trap' in a variable in a cross-platform manner.

(In my cross-platform shell library, modernish, which offers stack-based
traps, I've had to implement a workaround involving the atomic,
parallel-proof creation of a temporary file. Since 'mktemp' isn't
cross-platform either, that has been an interesting exercise involving
output redirection under 'set -C' in a subshell.)

> ash-signals/sigint1.tests
>     trap "exit 0" SIGINT - does not like name "SIGINT". "INT" works.

Not a bug. The SIG prefix is an optional extension. Only "INT" without
the prefix is mandated by POSIX.
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_28
"The condition can be EXIT, 0 (equivalent to EXIT), or a signal
specified using a symbolic name, without the SIG prefix, as listed in
the tables of signal names in the <signal.h> header defined in XBD
Headers; for example, HUP, INT, QUIT, TERM. Implementations may permit
names with the SIG prefix or ignore case in signal names as an extension."

> ash-signals/signal4.tests
>     trap "echo Trapped" BADNAME TERM - abort seeing BADNAME.
>     bash complains, but sets the trap for the second signal.

I don't see how this is a bug.

> ash-signals/signal8.tests
>     "kill %1" in non-interactive shell does not find
>     previously backgrounded task.

Not a bug. '%1' is a job control job ID, but in a non-interactive shell
there's no job control. Either 'set -m' to turn on job control first
(and deal with extra terminal clutter), or just use "$!" to kill by PID.

> ash-vars/var-utf8-length.tests
>     ${#VAR} counts unicode chars in bash

dash does not support unicode; AFAIK, this is a design choice (I'm not a
developer).

> ash-vars/var_unbackslash.tests
>     b=-$a-\t-\\-\"-\`-\--\z-\*-\?-
>     b="-$a-\t-\\-\"-\`-\--\z-\*-\?-"
>     b='-$a-\t-\\-\"-\`-\--\z-\*-\?-'
>     b1=$b
>     "b1=$b"
>     You can imagine... not everything went well here...

Again, this is probably down to legitimate differences in the
notoriously unportable "echo" builtin. Test this using printf instead.

> ash-vars/var_unbackslash.tests

ITYM ash-vars/var_unbackslash1.tests

>     echo Forty two:$\
>     (\
>     (\
>     42\
>     )\
>     )
>     dash says: Syntax error: Missing '))'

Yes, but it's not clear to me that it shouldn't.

Hmm... maybe this is indeed a bug:
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_02_01
"A <backslash> that is not quoted shall preserve the literal value of
the following character, with the exception of a <newline>. If a
<newline> follows the <backslash>, the shell shall interpret this as
line continuation. The <backslash> and <newline> shall be removed before
splitting the input into tokens. Since the escaped <newline> is removed
entirely from the input and is not replaced by any white space, it
cannot serve as a token separator."

So, unless I'm misreading this, it looks like backslashes need to be
parsed before *any* other kind of lexical analysis.


I hope some of the above was useful.

- M.


