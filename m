From: Martijn Dekker <martijn@inlv.org>
Subject: getopts doesn't properly update OPTIND when called from function
Date: Thu, 28 May 2015 20:54:07 +0200
Message-ID: <5567644F.3080909@inlv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from kahlil.inlv.org ([37.59.109.123]:36334 "EHLO kahlil.inlv.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752299AbbE1TEf (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 28 May 2015 15:04:35 -0400
Received: from breedzicht.local (inlv.demon.nl [212.238.240.159])
	(authenticated bits=0)
	by kahlil.inlv.org (8.14.9/8.14.4) with ESMTP id t4SIs7qh003022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <dash@vger.kernel.org>; Thu, 28 May 2015 20:54:08 +0200
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

I'm writing a shell function that extends the functionality of the
'getopts' builtin. For that to work, it is necessary to call the
'getopts' builtin from the shell function.

The POSIX standard specifies that OPTIND and OPTARG are global
variables, even though the positional parameters are local to the
function.[*] This makes it possible to call 'getopts' from a function by
simply passing the global positional parameters along by adding "$@".

My problem is that dash does not properly update the global OPTIND
variable when getopts is called from a function, which defeats my
function on dash. It updates the global OPTIND for the first option but
not for subsequent options, so OPTIND gets stuck on 3. (It does
accurately update the global OPTARG variable, though.)

I made a little test program that demonstrates this; see below the
footnote. It succeeds on bash, ksh93, pdksh, mksh, and yash, but not
(d)ash or zsh[*2].

The output of my test script seems consistent with the hypothesis that
OPTIND is reinitialized to 1 whenever a function is called. It should
only be initialized when the shell is initialized.

I suspect this is an old bug as other versions of ash, including Busybox
ash and NetBSD's /bin/sh, share it.

Thanks,

- Martijn

[*] The POSIX standard specifies:
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/getopts.html
"The shell variable specified by the name operand, OPTIND, and OPTARG
shall affect the current shell execution environment", which implies
that they are global variables.
    Confusingly, that same page also says: "The shell variables OPTIND
and OPTARG shall be local to the caller of getopts and shall not be
exported by default."
    But I believe that "caller" here means the program that calls
getopts, not the function; POSIX does not support function-local
variables. This interpretation is supported by the added phrase "... and
shall not be exported by default" and by the evidence that the majority
of popular shells pass my test script. Also, it is in fact global in
dash; after all, it does get updated just once...
    (Of course it should be possible to explicitly make OPTIND and
OPTARG local using the non-standard 'local' keyword.)

[*2] In zsh, OPTIND appears to be local to the function as the
positional parameters are, so in my test script OPTIND is stuck at 1. I
submitted a bug report to zsh-workers and a patch was posted in less
than an hour!

#### begin test script ####

#! /bin/sh

expect() {
    if [ "X$2" = "X$3" ]; then
        printf '%s: OK, got "%s"\n' "$1" "$2"
    else
        printf '%s: BUG: expected "%s", got "%s"\n' "$1" "$2" "$3"
        return 1
    fi
}

callgetopts() {
    getopts 'D:ln:vhL' opt "$@"
}

testfn() {
    expect OPTIND 1 "$OPTIND"

    callgetopts "$@"
    expect opt D "$opt"
    expect OPTARG 'test' "$OPTARG"

    callgetopts "$@"
    expect opt h "$opt"
    expect OPTARG '' "$OPTARG"

    callgetopts "$@"
    expect OPTIND 5 "$OPTIND"
    expect opt n "$opt"
    expect OPTARG 1 "$OPTARG"

    callgetopts "$@"
    expect OPTIND 5 "$OPTIND"

    callgetopts "$@"
    expect OPTIND 5 "$OPTIND"
}

testfn -D test -hn 1 test arguments

#### end test script ####

Output on dash 0.5.6 and current dash git version:

OPTIND: OK, got "1"
opt: OK, got "D"
OPTARG: OK, got "test"
opt: BUG: expected "h", got "D"
OPTARG: BUG: expected "", got "test"
OPTIND: BUG: expected "5", got "3"
opt: BUG: expected "n", got "D"
OPTARG: BUG: expected "1", got "test"
OPTIND: BUG: expected "5", got "3"
OPTIND: BUG: expected "5", got "3"

Expected output (on bash, *ksh*, yash):

OPTIND: OK, got "1"
opt: OK, got "D"
OPTARG: OK, got "test"
opt: OK, got "h"
OPTARG: OK, got ""
OPTIND: OK, got "5"
opt: OK, got "n"
OPTARG: OK, got "1"
OPTIND: OK, got "5"
OPTIND: OK, got "5"
