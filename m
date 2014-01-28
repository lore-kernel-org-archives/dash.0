From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: exec command and error checking
Date: Tue, 28 Jan 2014 22:59:16 +0100
Message-ID: <20140128215916.GA59221@stack.nl>
References: <CAEmTpZGqBfdBQDnmw-TozGTXpUxShCC=rWObhaP4zmKFJu4jUw@mail.gmail.com>
 <20140128131759.GA17217@hal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:63756 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932247AbaA1WF5 (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 28 Jan 2014 17:05:57 -0500
Received: from snail.stack.nl (snail.stack.nl [IPv6:2001:610:1108:5010::131])
	by mx1.stack.nl (Postfix) with ESMTP id 207BF3592DB
	for <dash@vger.kernel.org>; Tue, 28 Jan 2014 22:59:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20140128131759.GA17217@hal.lan>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On Tue, Jan 28, 2014 at 02:17:59PM +0100, Guido Berhoerster wrote:
> * =D0=9C=D0=B0=D1=80=D0=BA =D0=9A=D0=BE=D1=80=D0=B5=D0=BD=D0=B1=D0=B5=
=D1=80=D0=B3 <socketpair@gmail.com> [2014-01-28 13:16]:
> > $ dpkg -l | fgrep dash
> > ii  dash                                   0.5.7-2ubuntu2
> >                 POSIX-compliant shell

> > $ exec 9<no_such_file && echo TEST
> > dash: 1: cannot open no_such_file: No such file

> > $ exec 9<no_such_file || echo TEST
> > dash: 2: cannot open no_such_file: No such file

> > So, I cannot test this operation without using $?

> No, exec is a special built in and POSIX specifies that
> ...if a redirection error occurs (see Consequences of Shell
> Errors), the shell shall exit with a value in the range 1-125

> dash correctly exits with exit status of 2 as it should. ksh93,
> mksh, and pdksh do the same.

Indeed, this is correct.

You can avoid the exit by prepending 'command':
$ command exec 9<no_such_file || echo TEST
dash: 1: cannot open no_such_file: No such file
TEST

> > in BASH this works as expected (even in sh mode)

> That's either a bug or an intended deviation from the POSIX
> standard, you'll have to ask on the bug-bash list about that.

The inconsistency appears to be in the behaviour on fatal errors in
interactive shells. Strictly speaking, POSIX seems to require that the
shell continue execution with the next command, setting $? to a non-zer=
o
value. Historically, behaviour has instead been to exit with a non-zero
status (if in a subshell) or return to the prompt with $? set to a
non-zero value (if in the top level shell). Dash implements the latter
and I think it is more useful.

Note that the two behaviours are indistinguishable if a single simple
command is entered.

--=20
Jilles Tjoelker
